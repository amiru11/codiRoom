package com.basic.codi;

import static org.hamcrest.CoreMatchers.instanceOf;

import javax.servlet.http.HttpServletRequest;
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

	@RequestMapping(value = "/basketList")
	public String basketList(RedirectAttributes ra, HttpSession session, Model model) {
		String message = "";
		String path = "";
		if (session.getAttribute("member") != null) {
			model.addAttribute("list", basketService.basketList(session));
			path = "/basket/basketList";
		} else {
			message = "Login 하세요";
			ra.addFlashAttribute("message", message);
			path = "redirect:/";
		}
		return path;
	}

	@RequestMapping(value = "/basketAdd")
	@ResponseBody
	public String basketAdd(RedirectAttributes ra, HttpSession session, ProductEachDTO productEachDTO) {
		String message = "";
		if (session.getAttribute("member") != null) {
			message = String.valueOf(basketService.basketAdd(session, productEachDTO));
		} else {
			message = "Login 하세요";
			ra.addFlashAttribute("message", message);
		}
		return message;
	}

	@RequestMapping(value = "/log")
	public String log(HttpSession session) {
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setId("asd123");
		session.setAttribute("member", memberDTO);

		return "redirect:/";
	}

	@RequestMapping(value = "/basketFix")
	public String basketFix(HttpServletRequest request, HttpSession session, RedirectAttributes ra) {
		String message = "";
		String path = "";
		String location = "";
		if (session.getAttribute("member") != null) {
			message = basketService.basketFix(request, session);
			location = session.getServletContext().getContextPath() + "/basket/basketList";
			path = "redirect:/result/result";
		} else {
			message = "잘못된접근";
			path = "redirect:/";
		}
		ra.addFlashAttribute("location", location);
		ra.addFlashAttribute("message", message);

		return path;
	}

	@RequestMapping(value = "/basketDel")
	public String basketDel(HttpSession session, int[] del_basket_num,RedirectAttributes ra) {
		String message = "";
		String path = "";
		String location = "";
		if (session.getAttribute("member") != null) {
			int result = basketService.basketDel(del_basket_num);
			if (result > 0) {
				message = "삭제성공";
			} else {
				message = "삭제실패";
			}
			location = session.getServletContext().getContextPath() + "/basket/basketList";

			path = "redirect:/result/result";
		} else {
			message = "잘못된접근";
			path = "redirect:/";
		}
		ra.addFlashAttribute("location", location);
		ra.addFlashAttribute("message", message);

		return path;
	}

}
