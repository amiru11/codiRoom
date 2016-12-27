package com.basic.codi;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import java.io.File;
import java.sql.Date;
import java.util.UUID;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.board.BoardDTO;
import com.basic.board.PhotoDTO;
import com.basic.mast.MastService;
import com.basic.mast.SSSSSService;
import com.basic.member.MemberDTO;

@Controller
@RequestMapping(value="/mast")
public class SSSController {

	@Autowired
	private MastService mastService;
	
	@Autowired
	private SSSSSService sssssService;
	
	@RequestMapping(value="/mastProductList", method=RequestMethod.GET)
	public String mastProductListG(HttpServletRequest request,Model model) {
		HttpSession session =request.getSession();
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {		
			Map<String,Object> map = new HashMap<>();
			map.put("curPage", 1);
			map.put("perPage", 9);
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
			@RequestParam(defaultValue="1")int curPage,@RequestParam(defaultValue="9")int perPage,@RequestParam(required=false)int[] kind_num,
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
			System.out.println("kind_num---"+kind_num+"---");
			System.out.println("productSelect_num---"+productSelect_num+"---");
			System.out.println("productNim---"+product_num+"---");
			System.out.println("productEach_color---"+productEach_color+"---");
			System.out.println("productEach_Size---"+productSize_size+"---");

			
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
	
	@RequestMapping(value = "/mastBuyListPay",method=RequestMethod.GET)
	public String mastBuyListPay(HttpSession session, Model model) {
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			Map<String, Object> map = new HashMap<>();
			map.put("first_date", null);
			map.put("last_date", null);
			model.addAttribute("list",sssssService.mastBuyPayList(map));
			path = "/mast/mastBuyListPay";
		} else {
			path = "redirect:/";
		}
		return path;
	}
	@RequestMapping(value = "/mastBuyListPay",method=RequestMethod.POST)
	public String tttttteeeessss(HttpSession session,@RequestParam(required=false)Date first_date,@RequestParam(required=false)Date last_date,Model model){
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			Map<String, Object> map = new HashMap<>();
			map.put("first_date", first_date);
			map.put("last_date", last_date);
			model.addAttribute("list",sssssService.mastBuyPayList(map));
			path = "/mast/mastBuyListPay";
		} else {
			path = "redirect:/";
		}
		return path;
	}
}
