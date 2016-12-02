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
	public void productList(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "10") int perPage, @RequestParam(defaultValue = "1") int sel,
			@RequestParam(required = false) String[] kind_num, @RequestParam(required = false) String[] color,
			@RequestParam(required = false) String[] size, Model model) {
		ProductParamDTO productParamDTO = new ProductParamDTO();
		productParamDTO.setColor(color);
		
		int[] ina = null;
		if (kind_num != null) {
			ina =  new int[kind_num.length];
			for (int i = 0; i < ina.length; i++) {
				ina[i] = Integer.parseInt(kind_num[i]);
			}
		}
		productParamDTO.setSize(size);
		productParamDTO.setKind_num(ina);
		productParamDTO.setSel(sel);
		model.addAttribute("list", productService.productList(curPage, perPage, productParamDTO));
	}
	@RequestMapping(value="/productView")
	public void productView(@RequestParam(required = false)int product_num,Model model){
		model.addAttribute("view",productService.productView(product_num));
	}
	

}
