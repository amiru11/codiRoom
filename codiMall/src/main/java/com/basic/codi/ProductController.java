package com.basic.codi;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.product.ProductEachAddDTOs;
import com.basic.product.ProductParamDTO;

import com.basic.product.ProductService;


@Controller
@RequestMapping(value = "/product")
public class ProductController {

	@Autowired
	private ProductService productService;
	
	
	
	@RequestMapping(value="/productSaleList",method=RequestMethod.GET)
	public void productSaleListG(Model model){
		model.addAttribute("productSelectList",productService.productSelectList());
		model.addAttribute("list",productService.productSaleList(1, 9, model, 0));
	}
	@RequestMapping(value="/productSaleList",method=RequestMethod.POST)
	public void productSaleListP(Model model,int curPage){
		model.addAttribute("productSelectList",productService.productSelectList());
		model.addAttribute("list",productService.productSaleList(curPage, 9, model, 0));
	}
	
	
	@RequestMapping(value = "/productList",method=RequestMethod.GET)
	public void productListG(Model model,RedirectAttributes ra) {

		ProductParamDTO productParamDTO = new ProductParamDTO();
		productParamDTO.setProductSelect_num(1);
		model.addAttribute("productSelectList",productService.productSelectList());
		model.addAttribute("curPage", 1);
		model.addAttribute("productSelect_num",1);
		model.addAttribute("list", productService.productList(1, 9, productParamDTO, model,ra));
	}
	


	@RequestMapping(value = "/productList",method=RequestMethod.POST)
	public void productListP(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "9") int perPage, @RequestParam(defaultValue = "1") int sel,
			@RequestParam(required = false) int[] kind_num,@RequestParam(defaultValue ="1") int productSelect_num, @RequestParam(required = false) String[] color,
			@RequestParam(required = false) String[] size, Model model,RedirectAttributes ra) {

		ProductParamDTO productParamDTO = new ProductParamDTO();
		// 파람DTO에 파라미터로 받은 컬러,사이즈,넘버,셀렉트를 넣어주기//
		productParamDTO.setProductSelect_num(productSelect_num);
		productParamDTO.setColor(color);
		productParamDTO.setSize(size);
		productParamDTO.setKind_num(kind_num);
		productParamDTO.setSel(sel);
		
		model.addAttribute("productSelectList",productService.productSelectList());
		model.addAttribute("curPage", curPage);
		model.addAttribute("productSelect_num",productSelect_num);
		model.addAttribute("list", productService.productList(curPage, perPage, productParamDTO, model,ra));
		model.addAttribute("kind_num", kind_num);
		model.addAttribute("size", size);
		model.addAttribute("color", color);
		ra.addFlashAttribute("productSelectList",productService.productSelectList());
		ra.addFlashAttribute("curPage", curPage);
		ra.addFlashAttribute("productSelect_num",productSelect_num);
		ra.addFlashAttribute("list", productService.productList(curPage, perPage, productParamDTO, model,ra));
		ra.addFlashAttribute("kind_num", kind_num);
		ra.addFlashAttribute("size", size);
		ra.addFlashAttribute("color", color);
	}

	@RequestMapping(value = "/productserList", method = RequestMethod.GET)
	public String productserList(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "9") int perPage, @RequestParam(defaultValue = "1") int sel,
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
		// model.addAttribute("list", productService.productList(curPage,
		// perPage, productParamDTO, model));
		return "/product/productserList";
	}

	@RequestMapping(value = "/productView", method = RequestMethod.GET)
	public void productView(@RequestParam(required = false) int product_num, Model model) {
		model.addAttribute("view", productService.productView(product_num));
	}

	@RequestMapping(value = "/productEachAdd", method = RequestMethod.POST)
	public String productEachAdd(ProductEachAddDTOs productEachAddDTOs, RedirectAttributes rs) {
		String message = "";
		int result = productService.productEachAdd(productEachAddDTOs);
		if (result > 0) {
			message = "등록성공";
		} else {
			message = "등록실패";
		}
		rs.addFlashAttribute("message", message);
		return "redirect:/product/productEachAdd";
	}

	@RequestMapping(value = "/productAdd", method = RequestMethod.GET)
	public void productAdd() {
	}

	@RequestMapping(value = "/productBestList")
	public void productBestList(Model model) {
		model.addAttribute("productSelectList",productService.productSelectList());
		model.addAttribute("list", productService.productBestList());
	}

}
