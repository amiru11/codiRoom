package com.basic.codi;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	@RequestMapping(value="/boardList")
	public String boardList(){
		String path = "";
		path = "mast/mastBoard";
		return path;
	}
	
}
