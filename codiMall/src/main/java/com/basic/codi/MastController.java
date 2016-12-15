package com.basic.codi;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String mastBuyList(HttpSession session,Model model){
		String path="";
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		if(memberDTO !=null && memberDTO.getMember_level() == 0 ){
			model.addAttribute("list",mastService.mastBuyList());
			path="/mast/mastBuyList";
		}else{
			path="redirect:/";
		}
		return path;
		
	}
}
