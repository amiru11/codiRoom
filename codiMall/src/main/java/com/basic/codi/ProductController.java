package com.basic.codi;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.member.MemberDTO;
import com.basic.product.ProductAddDTO;
import com.basic.product.ProductEachAddDTO;
import com.basic.product.ProductParamDTO;
import com.basic.product.ProductService;
import com.basic.util.PageMaker;

@Controller
@RequestMapping(value = "/product")
public class ProductController {

	@Autowired
	private ProductService productService;

	@RequestMapping(value = "/productList")
	public void productList(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "10") int perPage, @RequestParam(defaultValue = "1") int sel,
			@RequestParam(required = false) String[] kind_num, @RequestParam(required = false) String[] color,
			@RequestParam(required = false) String[] size, Model model) {
		ProductParamDTO productParamDTO = new ProductParamDTO();
		productParamDTO.setColor(color);

		int[] ina = null;
		if (kind_num != null) {
			ina = new int[kind_num.length];
			for (int i = 0; i < ina.length; i++) {
				ina[i] = Integer.parseInt(kind_num[i]);
			}
		}
		productParamDTO.setSize(size);
		productParamDTO.setKind_num(ina);
		productParamDTO.setSel(sel);
		model.addAttribute("list", productService.productList(curPage, perPage, productParamDTO));
	}

	@RequestMapping(value = "/productView")
	public void productView(@RequestParam(required = false) int product_num, Model model) {
		model.addAttribute("view", productService.productView(product_num));
	}

	@RequestMapping(value = "/productAdd", method = RequestMethod.GET)
	public void productAdd() {
	}

	@RequestMapping(value = "/productAdd", method = RequestMethod.POST)
	public String productAdd(ProductAddDTO productAddDTO, HttpSession session, RedirectAttributes ra) {
		String message = "";
		String path = "";
		int result = 0;
		result = productService.productAdd(productAddDTO);

		if (result > 0) {
			message = "add success";
			path = "redirect:/";
			ra.addFlashAttribute("message", message);
		} else {
			message = "add fail";
			path = "redirect:/";
			ra.addFlashAttribute("message", message);
		}

		return path;
	}

	@RequestMapping(value = "/productEachAdd")
	public String productEachAdd(ProductEachAddDTO productEachAddDTOs[], HttpSession session, RedirectAttributes ra) {
		String message = "";
		String path = "";
		int result = 0;
		result = productService.productEachAdd(productEachAddDTOs);
		if (result > 0) {
			message = "add success";
			path = "redirect:/";
			ra.addFlashAttribute("message", message);
		} else {
			message = "add fail";
			path = "redirect:/";
			ra.addFlashAttribute("message", message);
		}

		return path;

	}

}
