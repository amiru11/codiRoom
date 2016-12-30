package com.basic.codi;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.basic.buy.BuyListDTO;
import com.basic.buy.BuyNonBasketDTO;
import com.basic.buy.BuyService;
import com.basic.member.MemberDTO;

@Controller
@RequestMapping(value = "/buy")
public class BuyController {

	@Autowired
	private BuyService buyService;
	@RequestMapping(value = "/buyListN", method = RequestMethod.GET)
	public String buyListN(HttpSession session, Model model, RedirectAttributes ra) {
		String message = "";
		String path = "";
		if (session.getAttribute("member") != null) {
			model.addAttribute("list", buyService.buyList(session));
			path = "/buy/buyList";
		} else {
			message = "로그인하세요";
			path = "redirect:/";
			ra.addFlashAttribute("message", message);
		}
		return path;
	}

	@RequestMapping(value = "/buyList", method = RequestMethod.GET)
	public String buyList(HttpSession session, Model model, RedirectAttributes ra) {
		String message = "";
		String path = "";
		if (session.getAttribute("member") != null) {
			model.addAttribute("list", buyService.buyList(session));
			path = "/buy/buyList";
		} else {
			message = "로그인하세요";
			path = "redirect:/";
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

	@RequestMapping(value = "/buyDirectList", method = RequestMethod.POST)
	public String nonBasketBuyList(@RequestParam(defaultValue="0")int product_num, String productSize_size, String productEach_color,
			@RequestParam(defaultValue="0")int productEach_each, HttpSession session, Model model, RedirectAttributes ra) {
		String message = "";
		String path = "";
		if (session.getAttribute("member") != null && product_num!=0 && productSize_size !=null && productEach_color != null && productEach_each !=0) {
			model.addAttribute("list", buyService.BuyDirectList(product_num));
			model.addAttribute("productSize_size",productSize_size);
			model.addAttribute("productEach_each",productEach_each);
			model.addAttribute("productEach_color",productEach_color);
			path = "/buy/buyDirectList";
		} else {
			message = "잘못된 접근";
			ra.addFlashAttribute("message", message);
			ra.addFlashAttribute("location", "/");
			path = "redirect:/result/result";
		}

		return path;
	}

	@RequestMapping(value = "/buyDirect", method = RequestMethod.POST)
	public String nonBasketBuy(@RequestParam(defaultValue="0")double total_price,@RequestParam(defaultValue="0")int product_num, String productSize_size, String productEach_color,
			@RequestParam(defaultValue="0")int productEach_each,String buyState_address, HttpSession session, RedirectAttributes ra,Model model) {
		List<BuyListDTO> ar = new ArrayList<>();
		String message = "";
		String path = "redirect:/result/result";
		String location = "";
		if (session.getAttribute("member") != null && product_num!=0 && productSize_size !=null && productEach_color != null && productEach_each !=0 && total_price !=0 && buyState_address != null) {
			Map<String, Object> map22 = buyService.buyDirect(buyState_address,(int)total_price,product_num,productSize_size,productEach_color,productEach_each,(MemberDTO) session.getAttribute("member"));
			ar = (List<BuyListDTO>) map22.get("ar");
			System.out.println("cont"+ar);
			System.out.println(map22.get("message"));
			if(ar==null){
				path="redirect:/result/result";
				location="/";
				message=(String) map22.get("message");
				ra.addFlashAttribute("message", message);
				ra.addFlashAttribute("location", location);
				
			}else{
				System.out.println("buyController-------------");
				System.out.println("buyarsize--" + ar.size());
				System.out.println(ar.get(0).getBuy_num());
				System.out.println(ar.get(0).getBuyState_color());
				model.addAttribute("message", map22.get("message"));
				model.addAttribute("list",map22.get("ar"));
				path = "/buy/buyListN";
			}
			
			ra.addFlashAttribute("message", message);
			ra.addFlashAttribute("location", location);
		} else {
			message = "잘못된 접근";
		}

		return path;
	}

	// 주문완료페이지로 가게 바꾸겠습니다~
	@RequestMapping(value = "/basketBuy", method = RequestMethod.POST)
	public String basketBuy(String buyState_address,int[] basket_num, HttpSession session, RedirectAttributes ra,Model model) {
		Map<String, Object> map = new HashMap<>();
		ArrayList<BuyListDTO> ar = new ArrayList<>();
		String message = "";
		String path = "";
		String location = "";
		if (session.getAttribute("member") != null) {
			map = buyService.basketBuy(buyState_address,basket_num, (MemberDTO) session.getAttribute("member"));
			ar=(ArrayList<BuyListDTO>) map.get("ar");
			System.out.println(map.get("message"));
			if(ar!=null){
			path = "/buy/buyListN";
			
			model.addAttribute("message", map.get("message"));
			model.addAttribute("list",ar);
			}else{
				message=(String) map.get("message");
				path = "redirect:/result/result";
				location = "/";
				ra.addFlashAttribute("message", message);
				ra.addFlashAttribute("locate", location);
			}
		} else {
			message = "잘못된접근";
			path = "redirect:/result/result";
			location = "/";
			ra.addFlashAttribute("message", message);
			ra.addFlashAttribute("locate", location);

		}

		return path;
	}

	@RequestMapping(value = "/cancelBuy", method = RequestMethod.POST)
	public String cancelBuy(@RequestParam(defaultValue = "0") int buy_num, HttpSession session, RedirectAttributes ra) {
		String message = "";
		String location = "";

		if (session.getAttribute("member") != null && buy_num != 0) {
			message = buyService.cancelBuy(buy_num);
			location = "/member/myPage";
			ra.addFlashAttribute("message", message);
			ra.addFlashAttribute("buyList", 1);
			ra.addFlashAttribute("location", location);
		} else {
		}
		return "redirect:/result/result";
	}

	@RequestMapping(value = "/buyConfirm", method = RequestMethod.POST)
	public String buyConfirm(int buy_num, HttpSession session, RedirectAttributes ra) {
		String message = "";
		String location = "";

		if (session.getAttribute("member") != null && buy_num != 0) {
			message = buyService.buyConfirm(buy_num);
			location = "/member/myPage";
			ra.addFlashAttribute("message", message);
			ra.addFlashAttribute("buyList", 1);
			ra.addFlashAttribute("location", location);
		} else {
		}
		return "redirect:/result/result";
	}

}
