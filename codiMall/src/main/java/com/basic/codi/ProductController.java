package com.basic.codi;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.member.MemberDTO;
import com.basic.product.ProductAddDTO;
import com.basic.product.ProductEachAddDTOs;
import com.basic.product.ProductParamDTO;

import com.basic.product.ProductService;
import com.basic.util.PageMaker;


@Controller
@RequestMapping(value = "/product")
public class ProductController {

	@Autowired
	private ProductService productService;
	
	@RequestMapping(value = "/productList",method=RequestMethod.GET)
	public void productListG(Model model,RedirectAttributes ra) {

		ProductParamDTO productParamDTO = new ProductParamDTO();
		productParamDTO.setProductSelect_num(1);
		model.addAttribute("productSelectList",productService.productSelectList());
		model.addAttribute("curPage", 1);
		model.addAttribute("productSelect_num",1);
		model.addAttribute("list", productService.productList(1, 9, productParamDTO, model,ra,null));
	}
	


	@RequestMapping(value = "/productList",method=RequestMethod.POST)
	public void productListP(@RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "9") int perPage, @RequestParam(defaultValue = "1") int sel,@RequestParam(required = false) String sale,
			@RequestParam(required = false) int[] kind_num,@RequestParam(defaultValue ="1") int productSelect_num, @RequestParam(required = false) String[] color,
			@RequestParam(required = false) String[] size, Model model,RedirectAttributes ra) {

		ProductParamDTO productParamDTO = new ProductParamDTO();
		// 파람DTO에 파라미터로 받은 컬러,사이즈,넘버,셀렉트를 넣어주기//
		
		productParamDTO.setProductSelect_num(productSelect_num);
		productParamDTO.setColor(color);
		productParamDTO.setSize(size);
		productParamDTO.setKind_num(kind_num);
		productParamDTO.setSel(sel);
		
		if(sale != null){
			productParamDTO.setProductSelect_num(0);
		}
		model.addAttribute("sel",sel);
		model.addAttribute("sale",sale);
		model.addAttribute("productSelectList",productService.productSelectList());
		model.addAttribute("curPage", curPage);
		model.addAttribute("productSelect_num",productSelect_num);
		model.addAttribute("list", productService.productList(curPage, perPage, productParamDTO, model,ra,sale));
		model.addAttribute("kind_num", kind_num);
		model.addAttribute("size", size);
		model.addAttribute("color", color);

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
		return "redirect:/product/productAdd";
	}

	@RequestMapping(value = "/productAdd", method = RequestMethod.GET)
	public void productAdd() {
	}
	@RequestMapping(value="/productAdd",method=RequestMethod.POST)
	public String productAddAction(HttpSession session,ProductAddDTO productAddDTO,RedirectAttributes ra ){
		String location="";
		String message="";
		String path="";
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		if(memberDTO !=null && memberDTO.getMember_level() == 0 ){
			int result = productService.productAdd(productAddDTO);
			if(result>0){
				message="상품 등록성공";
				location="/product/productAdd";
			}else{
				message = "상품등록 실패";
				location="/product/productAdd";
			}
			ra.addFlashAttribute("location",location);
			ra.addFlashAttribute("message",message);
			
			path="redirect:/result/result";
		}else{
			path="redirect:/";
		}
		return path;
	}
	

	@RequestMapping(value = "/productBestList")
	public void productBestList(Model model) {
		model.addAttribute("productSelectList",productService.productSelectList());
		model.addAttribute("list", productService.productBestList());
	}
	
	/*//test pic add method.Get
	@RequestMapping(value="/testPicAdd",method=RequestMethod.GET)
	public void testPicAdd(){		
	}
	
	//test pic add method.Get
	@RequestMapping(value="/testPicAdd",method=RequestMethod.POST)
	public void testPicAdd(MultipartHttpServletRequest mpr, HttpSession session){
		productService.testPicAdd(mpr, session);
	}*/
	
	/*상품검색 */
	@RequestMapping(value="productSearchList")
	public void productSearchList(Model model,@RequestParam(defaultValue="1") int curPage,@RequestParam(defaultValue="10")int perPage,String find,PageMaker pageMaker){
		System.out.println("상품검색컨트롤러");
		System.out.println("상품검색어 :"+find);
		productService.productSearchList(curPage, perPage, find, model);
	}
	

}
