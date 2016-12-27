package com.basic.codi;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import java.io.File;
import java.util.UUID;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.board.BoardDTO;
import com.basic.board.PhotoDTO;
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
			System.out.println("kind_num---"+kind_num+"---"+kind_num.length);
			System.out.println("productSelect_num---"+productSelect_num+"---"+productSelect_num.length);
			System.out.println("productNim---"+product_num+"---"+product_num.length);
			System.out.println("productEach_color---"+productEach_color+"---"+productEach_color.length);
			System.out.println("productEach_Size---"+productSize_size+"---"+productSize_size.length);
			if(kind_num.length==0){
				kind_num=null;
			}
			if(product_num.length==0){
				product_num=null;
			}
			if(productSelect_num.length==0){
				productSelect_num=null;
			}
			if(productEach_color.length==0){
				productEach_color=null;
			}
			if(productSize_size.length==0){
				productSize_size=null;
			}
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
	
	@RequestMapping(value="/mastProductListEach0",method=RequestMethod.GET)
	public void mastProductListEach0G(Model model){
		mastService.mastProductListEach0(model);
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
	//사이드메뉴에서 게시판 메뉴 클릭시//
	@RequestMapping(value="/boardList")
	public String boardList(@RequestParam(defaultValue="1") int curPage, 
			@RequestParam(defaultValue="10") int perPage, @RequestParam(defaultValue="1") int board_kind,Model model){
			model.addAttribute("board_kind", board_kind);
		return "mast/board/mastBoard";
	}
	//subMenu로 이동시//
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
	
	//글쓰기//
	@RequestMapping(value="/boardWrite")
	public String boardWrite(BoardDTO boardDTO, int board_kind, RedirectAttributes ra){
		try {
			String message = mastService.boardWrite(boardDTO, board_kind);
			System.out.println("BOARD WRITE");
			System.out.println("BOARD NUM : " +board_kind);
			ra.addFlashAttribute("message", message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String path = "";
		path = "mast/boardList?board_kind=";
		return "redirect:/"+path+board_kind;
	}
	
	//글삭제//
	@RequestMapping(value="/boardDelete")
	public String boardDelete(int board_num, int board_kind, RedirectAttributes ra){
		String path = "";
		
		try {
			String message = mastService.boardDel(board_num,board_kind);
			System.out.println("mastBOARD DEL");
			System.out.println("글 삭제 : " + message);
			ra.addFlashAttribute("message", message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		path = "mast/boardList?board_kind=";
		return "redirect:/"+path+board_kind;
	}
	
	
	//SMART EDITOR//
	@RequestMapping(value="/seWrite")
	public String fileUpload(PhotoDTO photoDTO, HttpSession session){
		String callback = photoDTO.getCallback();
		String callback_func = photoDTO.getCallback_func();
		String file_result = "";
		try {
		if(photoDTO.getFiledata() != null && photoDTO.getFiledata().getOriginalFilename() != null && !photoDTO.getFiledata().getOriginalFilename().equals("")){
			//파일이 존재하면
			
			//파일명
			String original_name = photoDTO.getFiledata().getOriginalFilename();
			//확장자를 찾는 구간
			String ext = original_name.substring(original_name.lastIndexOf(".")+1);
			//파일 기본 경로
			String defaultPath = session.getServletContext().getRealPath("/");
			//파일 상세경로
			String path = defaultPath + "resources" + File.separator + "upload"; //separator는 구분자!!

			File file = new File(path);

			//디렉토리 존재하지 않을 경우, 디렉토리 생성
			if(!file.exists()){
				file.mkdirs();
			}
			//서버에 업로드 할 파일명
			String realName = UUID.randomUUID().toString() + "." + ext;//기존이름을 버리고 랜덤이름을 붙여서 새로운 이름을 만들어줌
			
			//서버에 파일쓰기//
			
				photoDTO.getFiledata().transferTo(new File(path+realName));
				file_result += "&bNewLine=true&sFileName=" + original_name + "&sFileURL=/codi/resources/upload" + realName;
			
			}else{
				file_result += "&errstr=error";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:" + callback + "?callback_func=" + callback_func + file_result;
	}
	
	//QNA답글 리스트//
	@RequestMapping(value="/mastCommList")
	public String commList(@RequestParam int board_num, Model model){
		System.out.println("controller");
		System.out.println("commList");	
		System.out.println("board_num : " + board_num);
		try {
				mastService.mastCommList(board_num, model);
			} catch (Exception e) {
				e.printStackTrace();
			}
		return "mast/board/mastCommList";
	}	
	
}
