package com.basic.codi;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.basic.product.ProductParamDTO;
import com.basic.product.ProductService;
import com.basic.util.PageMaker;

@Controller
@RequestMapping(value = "/product")
public class ProductController {

	@Autowired
	private ProductService productService;

	@RequestMapping(value = "/productList")
	public void productList(int curPage, int perPage, @RequestParam(required = false)ProductParamDTO productParamDTO
			,Model model){
		
		model.addAttribute("list", productService.productList(curPage, perPage, productParamDTO));
	}

}
