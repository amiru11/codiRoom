package com.basic.codi;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.basket.BasketService;
import com.basic.member.MemberDTO;
import com.basic.product.ProductEachDTO;


@Controller
@RequestMapping(value = "/basket")
public class BasketController {

	@Autowired
	private BasketService basketService;
	
	@RequestMapping(value="/basketList")
	public String basketList(RedirectAttributes ra,HttpSession session,Model model){
		String message="";
		String path = "";
		if(session.getAttribute("member")!=null){
			model.addAttribute("list", basketService.basketList(session));
			path="/basket/basketList";
		}else{
			message="Login 하세요";
			ra.addFlashAttribute("message",message);
			path="redirect:/";
		}
		return path;
	}
	
	@RequestMapping(value="/basketAdd")
	@ResponseBody
	public String basketAdd(RedirectAttributes ra,HttpSession session,ProductEachDTO productEachDTO){
		String message="";
		if(session.getAttribute("member")!=null){
			message=String.valueOf(basketService.basketAdd(session, productEachDTO));
		}else{
			message="Login 하세요";
			ra.addFlashAttribute("message",message);
		}
		return message;
	}
	@RequestMapping(value="/log")
	public String log(HttpSession session){
		MemberDTO memberDTO =  new MemberDTO();
		memberDTO.setId("asd123");
		session.setAttribute("member", memberDTO);
		
		return "redirect:/";
	}
	
	

}
