package com.basic.product;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.review.ReviewDAO;
import com.basic.util.PageMaker;

@Service
public class ProductService {

	@Autowired
	private ProductDAO productDAO;
	
	// productSelect List
	public List<ProductSelectDTO> productSelectList() {
		return productDAO.productSelectList();
	}
	
	//productSaleList
	public List<ProductListDTO> productSaleList(int curPage,int perPage,Model model,int productSelect_num){
		HashMap<String, Object> hm = new HashMap<String, Object>();
		int totalCount = productDAO.productSaleCount();
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCurPage(curPage);
		pageMaker.setPerPage(perPage);
		pageMaker.makeRow();
		pageMaker.makePage(totalCount);
		model.addAttribute("pageing", pageMaker);
		model.addAttribute("selKind_num", productDAO.allKindNum(productSelect_num));
		model.addAttribute("selColor", productDAO.allProductColor(productSelect_num));
		model.addAttribute("selSize", productDAO.allProductSize(productSelect_num));
		return productDAO.productSaleList(pageMaker);
	}

	public List<ProductListDTO> productList(int curPage, int perPage, ProductParamDTO productParamDTO, Model model,RedirectAttributes ra) {
		int totalCount = productDAO.productCount(productParamDTO);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCurPage(curPage);
		pageMaker.setPerPage(perPage);
		pageMaker.makeRow();
		pageMaker.makePage(totalCount);
		model.addAttribute("pageing", pageMaker);
		model.addAttribute("selKind_num", productDAO.allKindNum(productParamDTO.getProductSelect_num()));
		model.addAttribute("selColor", productDAO.allProductColor(productParamDTO.getProductSelect_num()));
		model.addAttribute("selSize", productDAO.allProductSize(productParamDTO.getProductSelect_num()));
		
		ra.addFlashAttribute("pageing", pageMaker);
		ra.addFlashAttribute("selKind_num", productDAO.allKindNum(productParamDTO.getProductSelect_num()));
		ra.addFlashAttribute("selColor", productDAO.allProductColor(productParamDTO.getProductSelect_num()));
		ra.addFlashAttribute("selSize", productDAO.allProductSize(productParamDTO.getProductSelect_num()));
		

		return productDAO.productList(pageMaker, productParamDTO);

		/*
		 * System.out.println("curPage : " + curPage);
		 * System.out.println("perPage : " + perPage);
		 * System.out.println("sel : " + productParamDTO.getSel()); //임시 페이징//
		 * //model.addAttribute("paging", pageMaker); return
		 * productDAO.productList(pageMaker,productParamDTO);
		 */

	}

	public ProductViewDTO productView(int product_num) {
		return productDAO.productView(product_num);
	}

	public int productAdd(ProductAddDTO productAddDTO) {
		return productDAO.productAdd(productAddDTO);
	}

	public int productEachAdd(ProductEachAddDTOs productEachAddDTOs) {
		return productDAO.productEachAdd(productEachAddDTOs);
	}

	// json
	public List<String> productSizeList(int product_num) {
		return productDAO.productSizeList(product_num);
	}

	public List<ProductEachListDTO> productEachList(int product_num, String productSize_size) {
		return productDAO.productEachList(product_num, productSize_size);
	}

	public int productEachGet(ProductEachDTO productEachDTO) {
		return productDAO.productEachGet(productEachDTO);
	}

	public List<ProductBestDTO> productBestList() {
		return productDAO.productBestList();
	}

	// product List seach use size and color and kind_num

	public List<String> allProductSize() {
		return productDAO.allProductSize(0);
	}

	public List<String> allProductColor() {
		return productDAO.allProductColor(0);
	}

	public List<Integer> allKindNum() {
		return productDAO.allKindNum(0);
	}
	
	
	// auto add
	/*
	public int autoAdd(){
		return productDAO.autoAdd();
	}
	
	public void proAdd(){
		productDAO.proAdd();
	}
	
	//test pic add
	
	public void testPicAdd(MultipartHttpServletRequest mpr , HttpSession session){
		productDAO.testPicADD(mpr, session);
	}*/
	
	/*상품검색*/
	@RequestMapping(value="productSearchList")
	public void productSearchList(int curPage,int perPage,String find,Model model){
		System.out.println("상품검색서비스접속");
		System.out.println("상품검색어 :"+find);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCurPage(curPage);
		pageMaker.setPerPage(perPage);
		pageMaker.makeRow();
		pageMaker.makePage(productDAO.searchCount(find));
		List<ProductListDTO> ar=productDAO.productSearchList(find, pageMaker);
		for(int i=0;i<ar.size(); i++){
			System.out.println("상품이름 :"+ar.get(i).getProductDTO().getProduct_num());
		}
		model.addAttribute("pegeing", pageMaker);
		model.addAttribute("list1",ar);
		model.addAttribute("find",find);	
	}

}