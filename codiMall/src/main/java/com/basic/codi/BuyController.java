package com.basic.codi;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.basket.BasketDTO;
import com.basic.basket.BasketInfoDTO;
import com.basic.basket.BasketListDTO;
import com.basic.buy.BuyNonBasketDTO;
import com.basic.buy.BuyService;
import com.basic.member.MemberDTO;

@Controller
@RequestMapping(value = "buy")
public class BuyController {

	@Autowired
	private BuyService buyService;

	@RequestMapping(value = "/buyList", method = RequestMethod.GET)
	public String buyList(HttpSession session, Model model,RedirectAttributes ra) {
		String message = "";
		String path = "";
		if (session.getAttribute("member") != null) {
			model.addAttribute("list", buyService.buyList(session));
			path="/buy/buyList";
		}else{
			message="로그인하세요";
			path="redirect:/";
			ra.addFlashAttribute("message", message);
		}
		return path;
	}

	@RequestMapping(value = "/basketBuyList", method = RequestMethod.POST)
	public String basketBuyList(int[] basket_num, HttpSession session, Model model, RedirectAttributes ra) {
		String message = "";
		String path = "";
		if (session.getAttribute("member") != null && buyService.basketBuyList(basket_num) != null) {
			model.addAttribute("list", buyService.basketBuyList(basket_num));
			path = "/buy/basketBuyList";
		} else {
			message = "잘못된 접근";
			ra.addFlashAttribute("message", message);
			ra.addFlashAttribute("location", "/");
			path = "/result/result";
		}

		return path;
	}
	
	@RequestMapping(value = "/nonBasketBuyList", method = RequestMethod.POST)
	public String nonBasketBuyList(BuyNonBasketDTO buyNonBasketDTO, HttpSession session, Model model, RedirectAttributes ra) {
		String message = "";
		String path = "";
		if (session.getAttribute("member") != null && buyNonBasketDTO != null) {
			model.addAttribute("list", buyNonBasketDTO);
			path = "/buy/nonBasketBuyList";
		} else {
			message = "잘못된 접근";
			ra.addFlashAttribute("message", message);
			ra.addFlashAttribute("location", "/");
			path = "redirect:/result/result";
		}

		return path;
	}
	
	@RequestMapping(value="/nonBasketBuy", method = RequestMethod.POST)
	public String nonBasketBuy(BuyNonBasketDTO buyNonBasketDTO, HttpSession session,RedirectAttributes ra){
		
		String message = "";
		String path = "redirect:/result/result";
		String location = "";
		if (session.getAttribute("member") != null && buyNonBasketDTO != null) {
			message = buyService.nonBasketBuy(buyNonBasketDTO, (MemberDTO) session.getAttribute("member"));
			location="/buy/buyList";
			ra.addFlashAttribute("message",message);
			ra.addFlashAttribute("location",location);
		} else {
			message = "잘못된 접근";
		}

		return path;
	}

	@RequestMapping(value = "/basketBuy", method = RequestMethod.POST)
	public String basketBuy(int[] basket_num, HttpSession session, RedirectAttributes ra) {
		String message = "";
		String path = "";
		String location = "";
		if (session.getAttribute("member") != null) {
			message = buyService.basketBuy(basket_num, (MemberDTO) session.getAttribute("member"));
			location = "/buy/buyList";
			path = "redirect:/result/result";
			ra.addFlashAttribute("message", message);
			ra.addFlashAttribute("location", location);
		} else {
			message = "잘못된접근";
			path = "redirect:/result/result";
			location = "/";
			ra.addFlashAttribute("message", message);
			ra.addFlashAttribute("locate", location);

		}

		return path;
	}
	
	@RequestMapping(value="/cancelBuy" , method = RequestMethod.POST)
	public String cancelBuy(@RequestParam(defaultValue="0") int buy_num,HttpSession session,RedirectAttributes ra){
		String message="";
		String location="";
		
		if(session.getAttribute("member") != null && buy_num!=0 ){
			message=buyService.cancelBuy(buy_num);
			location="/buy/buyList";
			ra.addFlashAttribute("message",message);
			ra.addFlashAttribute("location",location);	
		}else{
		}
		return "redirect:/result/result";
	}
	
	@RequestMapping(value="/buyConfirm",method=RequestMethod.POST)
	public String buyConfirm(int buy_num,HttpSession session,RedirectAttributes ra){
		String message="";
		String location="";
		
		if(session.getAttribute("member") != null && buy_num!=0 ){
			message=buyService.buyConfirm(buy_num);
			location="/buy/buyList";
			ra.addFlashAttribute("message",message);
			ra.addFlashAttribute("location",location);	
		}else{
		}
		return "redirect:/result/result";
	}

}
