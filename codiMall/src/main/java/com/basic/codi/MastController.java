package com.basic.codi;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	@RequestMapping(value="/mastBuyList")
	public String mastBuyList(HttpSession session,Model model,@RequestParam(defaultValue="1") int state_num){
		String path="";
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		if(memberDTO !=null && memberDTO.getMember_level() == 0 ){
			model.addAttribute("list",mastService.mastBuyList(state_num));
			path="/mast/mastBuyList";
		}else{
			path="redirect:/";
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
