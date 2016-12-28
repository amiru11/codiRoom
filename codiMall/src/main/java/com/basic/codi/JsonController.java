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

import com.basic.basket.BasketService;
import com.basic.board.BoardService;
import com.basic.buy.BuyService;
import com.basic.fashion.CodiService;
import com.basic.mast.MastProductViewDTO;
import com.basic.mast.MastService;
import com.basic.mast.SSSSSService;
import com.basic.product.ProductDTO;
import com.basic.product.ProductEachDTO;
import com.basic.product.ProductEachListDTO;
import com.basic.product.ProductService;

@Controller
@RequestMapping(value = "/json")
@ResponseBody
public class JsonController {

	@Autowired
	private ProductService productService;

	@Autowired
	private BasketService basketService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private MastService mastService;

	@Autowired
	private BuyService buyService;

	@Autowired
	private CodiService codiService;
	
	@Autowired 
	private SSSSSService ssssssService;

	@RequestMapping(value = "/productSize", produces = "application/json; charset=utf-8")
	public List<String> productSizeList(@RequestParam int product_num) {
		return productService.productSizeList(product_num);
	}

	@RequestMapping(value = "/productEach", produces = "application/json; charset=utf-8")
	public Map<String, Object> productEachList(@RequestParam int product_num, @RequestParam String productSize_size) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("eachList", productService.productEachList(product_num, productSize_size));
		return retVal;
	}

	@RequestMapping(value = "/sale_item", method = RequestMethod.POST)
	public Map<String, Object> sale_item(@RequestParam HashMap<String, Object> param) {
		System.out.println(param);

		HashMap<String, Object> hashmap = new HashMap<String, Object>();
		hashmap.put("KEY", "VALUE");

		return hashmap;
	}

	@RequestMapping(value = "/productEachGet")
	public int productEachGet(int product_num, String productSize_size, String productEach_color) {
		System.out.println("json--" + product_num);
		System.out.println("json--" + productSize_size);
		System.out.println("json--" + productEach_color);

		ProductEachDTO productEachDTO = new ProductEachDTO();
		productEachDTO.setProduct_num(product_num);
		productEachDTO.setProductSize_size(productSize_size);
		productEachDTO.setProductEach_color(productEach_color);
		return productService.productEachGet(productEachDTO);
	}

	@RequestMapping(value = "/basketProductEach", produces = "application/json; charset=utf-8")
	public Map<String, Object> basketProductEach(@RequestParam int product_num) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("eachList", basketService.basketProductEachList(product_num));
		return retVal;
	}

	@RequestMapping(value = "/allProductSize", produces = "application/json; charset=utf-8")
	public Map<String, Object> allProductSize() {
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("sizeList", productService.allProductSize());
		return retVal;
	}

	@RequestMapping(value = "/allProductColor", produces = "application/json; charset=utf-8")
	public Map<String, Object> allProductColor() {
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("colorList", productService.allProductColor());
		return retVal;
	}

	@RequestMapping(value = "/allKindNum", produces = "application/json; charset=utf-8")
	public Map<String, Object> allKindNum() {
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("kindNumList", productService.allKindNum());
		return retVal;
	}

	/// buy
	@RequestMapping(value = "/getExpressNum")
	public int getExpressNum(int buy_num) {
		return buyService.getExpressNum(buy_num);
	}

	// buy

	// mast
	// ---------------------------------------------------------------------------------------

	@RequestMapping(value = "/mastBuyList", produces = "application/json; charset=utf-8")
	public Map<String, Object> mastBuyList(int buyState_state) {
		System.out.println("mast");
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("ar", mastService.mastBuyList(buyState_state));
		return retVal;
	}

	@RequestMapping(value = "/mastUpState")
	public int mastUpState(int buy_num, int buyState_state,
			@RequestParam(required = false, defaultValue = "0") int buyState_expressNum) {
		return mastService.mastUpState(buy_num, buyState_state, buyState_expressNum);
	}

	@RequestMapping(value="/mastProductAllInfo",produces = "application/json; charset=utf-8")
	public Map<String, Object> mastProductAllInfo(int product_num){
		System.out.println("mast");
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("ar", mastService.mastProductAllInfo(product_num));
		return retVal;
	}
	@RequestMapping(value="/mastProductEachFix")
	public int mastProductEachFix(int product_num,String productSize_size,String productEach_color,int productEach_each){
		System.out.println(product_num);
		System.out.println(productSize_size);
		System.out.println(productEach_color);
		System.out.println(productEach_each);
		
		return mastService.mastProductEachFix(product_num, productSize_size, productEach_color, productEach_each);
	}
	@RequestMapping(value="/mastProductInfoFix")
	public int mastProductInfoFix(int product_num,int productInfo_price,double productInfo_saleRate,String productInfo_searchWord){
		System.out.println("product_num----"+product_num);
		System.out.println("productInfo_sale----"+productInfo_saleRate);
		System.out.println("product_price----"+productInfo_price);
		System.out.println("product_searchWord----"+productInfo_searchWord);
		
		Map<String, Object> map = new HashMap<>();
		map.put("product_num", product_num);
		map.put("productInfo_price", productInfo_price);
		map.put("productInfo_saleRate", productInfo_saleRate);
		map.put("productInfo_searchWord",productInfo_searchWord);
		return ssssssService.mastProductInfoFix(map);
	}
	
	@RequestMapping(value="/mastRefundEachAdd")
	public int mastRefundEachAdd(int product_num,String productSize_size,String productEach_color,int productEach_each){
		System.out.println("product_num-----"+product_num);
		System.out.println("productSize_size-----"+productSize_size);
		System.out.println("productEach_color-----"+productEach_color);
		System.out.println("productEach_each-----"+productEach_each);
		
		return ssssssService.mastRefundEachAdd(product_num, productSize_size, productEach_color, productEach_each);				
	}
	
	
	//codi-----------------------------------------------------------------------------
	@RequestMapping(value="/codiProductList")
	public Map<String, Object> codiProductList(int kind_num){
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("ar", codiService.codiProductList(kind_num));
		return retVal;
	}

	@RequestMapping(value = "/codiKindList")
	public Map<String, Object> codiKindList(int productSelect_num) {
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("ar", codiService.codiKindList(productSelect_num));
		return retVal;
	}

	@RequestMapping(value = "/codiProductSelectList")
	public Map<String, Object> codiProductSelectList() {
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("ar", codiService.codiSelectList());
		return retVal;
	}

}
