package com.basic.codi;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.basic.product.ProductEachListDTO;
import com.basic.product.ProductService;

@Controller
@RequestMapping(value="/json")
@ResponseBody
public class JsonController {
	
	@Autowired
	private ProductService productService;
	
	@RequestMapping(value="/productSize", produces = "application/json; charset=utf-8")
	public List<String> productSizeList(@RequestParam int product_num){
		return productService.productSizeList(product_num);
	}
	
	@RequestMapping(value="/productEach", produces = "application/json; charset=utf-8")
	public Map<String, Object> productEachList(@RequestParam int product_num,@RequestParam String productSize_size){
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("eachList", productService.productEachList(product_num, productSize_size));
		return retVal;
	}

	@RequestMapping(value="/sale_item", method=RequestMethod.POST)
	public Map<String, Object> sale_item(@RequestParam HashMap<String, Object> param){
		System.out.println(param);
		
		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		hashmap.put("KEY", "VALUE");
		
		return hashmap;
		
	}
	
}
