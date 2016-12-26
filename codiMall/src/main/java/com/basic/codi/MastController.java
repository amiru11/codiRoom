package com.basic.codi;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.basic.board.BoardDTO;
import com.basic.mast.MastService;
import com.basic.member.MemberDTO;

@Controller
@RequestMapping(value="/mast")
public class MastController {

	@Autowired
	private MastService mastService;
	
	
	
	
	@RequestMapping(value="/mastIndex")
	public String mastIndex(HttpSession session){
		String path="";
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		if(memberDTO !=null && memberDTO.getMember_level() == 0 ){
			path="/mast/mastIndex";
		}else{
			path="redirect:/";
		}
		return path;
	}
	
	@RequestMapping(value="/mastProductList", method=RequestMethod.GET)
	public String mastProductListG(HttpServletRequest request,Model model) {
		HttpSession session =request.getSession();
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {		
			Map<String,Object> map = new HashMap<>();
			map.put("curPage", 1);
			map.put("perPage", 10);
			map.put("sel", 1);
			map.put("mtpSel", 1);
			map.put("kind_num", null);
			map.put("productSelect_num", null);
			map.put("product_num", null);
			map.put("productEach_color", null);
			map.put("productSize_size", null);
			model.addAttribute("list", mastService.mastProductList(map, model));
			path = "/mast/mastProductList";
		} else {
			path = "redirect:/";
		}
		return path;
	}
	

	@RequestMapping(value="/mastProductList", method=RequestMethod.POST)
	public String mastProductListP(HttpServletRequest request, @RequestParam(defaultValue="1") int sel,@RequestParam(defaultValue="1")int mtpSel,
			@RequestParam(defaultValue="1")int curPage,@RequestParam(defaultValue="10")int perPage,@RequestParam(required=false)int[] kind_num,
			@RequestParam(required=false)int[] productSelect_num,
			@RequestParam(required=false)int[] product_num,
			@RequestParam(required=false)String[] productEach_color,
	@RequestParam(required=false)String[] productSize_size,Model model) {
		HttpSession session =request.getSession();
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			System.out.println("mast controller prollist post");
			System.out.println("sel---"+sel);
			System.out.println("mtpSel---"+mtpSel);
			System.out.println("curPage---"+curPage);
			System.out.println("perPage---"+perPage);
			System.out.println("kind_num---"+kind_num);
			System.out.println("productSelect_num---"+productSelect_num);
			System.out.println("productNim---"+product_num);
			System.out.println("productEach_color---"+productEach_color);
			System.out.println("productEach_Size---"+productSize_size);
			Map<String,Object> map = new HashMap<>();
			map.put("curPage", curPage);
			map.put("perPage", perPage);
			map.put("sel", sel);
			map.put("mtpSel", mtpSel);
			map.put("kind_num", kind_num);
			map.put("productSelect_num", productSelect_num);
			map.put("product_num", product_num);
			map.put("productEach_color", productEach_color);
			map.put("productSize_size", productSize_size);
			model.addAttribute("list", mastService.mastProductList(map, model));
			path = "/mast/mastProductList";
		} else {
			path = "redirect:/";
		}
		return path;
	}

	@RequestMapping(value = "/mastBuyList")
	public String mastBuyList(HttpSession session, Model model, @RequestParam(defaultValue = "1") int state_num) {
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			model.addAttribute("list", mastService.mastBuyList(state_num));
			path = "/mast/mastBuyList";
		} else {
			path = "redirect:/";
		}
		return path;

	}
	
	@RequestMapping(value="/calendar")
	public String mastCalender(){
		String path="";
			path="/mast/calendar";
		return path;
	}
	
	
	
	
/////////////////////////////////////////////////////////////게시판/////////////////////////////////////////////////////////	
	@RequestMapping(value="/boardList")
	public String boardList(@RequestParam(defaultValue="1") int curPage, 
			@RequestParam(defaultValue="10") int perPage, @RequestParam(defaultValue="1") int board_kind,Model model){
			model.addAttribute("board_kind", board_kind);
		return "mast/board/mastBoard";
	}
	
	@RequestMapping(value="/resultBoard")
	public String resultBoard(@RequestParam(defaultValue="") String type, @RequestParam(defaultValue="") String find, @RequestParam(defaultValue="1") int curPage, 
			@RequestParam(defaultValue="10") int perPage, @RequestParam int board_kind, Model model){
		try {
			mastService.findList(type, find, curPage, perPage, board_kind, model);
			System.out.println("BOARD SEARCH");
			System.out.println("BOARD KIND : " +board_kind);
			System.out.println("TYPE : "+type);
			System.out.println("FIND : "+find);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		String path = "";
		path = "mast/board/list";
		return path;
	}
	//글보기//
	@RequestMapping(value="/boardView")
	public String boardView(BoardDTO boardDTO, int board_kind, Model model){
		try {
			mastService.boardView(boardDTO, board_kind, model);
			System.out.println("BOARD VIEW");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "mast/board/view";
	}
}
