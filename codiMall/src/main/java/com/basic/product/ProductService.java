package com.basic.product;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.basic.util.PageMaker;

@Service
public class ProductService {
	
	@Autowired
	private ProductDAO productDAO;
	
	public List<ProductListDTO> productList(int curPage,int perPage,ProductParamDTO productParamDTO, Model model){
		int totalCount = productDAO.productCount(productParamDTO);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCurPage(curPage);
		pageMaker.setPerPage(perPage);
		pageMaker.makeRow();
		pageMaker.makePage(totalCount);
		System.out.println("curPage : " + curPage);
		System.out.println("perPage : " + perPage);
		//임시 페이징//
		model.addAttribute("paging", pageMaker);
		return productDAO.productList(pageMaker,productParamDTO);
	}
	public ProductViewDTO productView(int product_num){
		return productDAO.productView(product_num);
	}
	
	public int productAdd(ProductAddDTO productAddDTO){
		return productDAO.productAdd(productAddDTO);
	}
	
	public int productEachAdd(ProductEachAddDTOs productEachAddDTOs){
		return productDAO.productEachAdd(productEachAddDTOs);
	}
	
	//json
	public List<String> productSizeList(int product_num){
		return productDAO.productSizeList(product_num);
	}
	
	public List<ProductEachListDTO> productEachList(int product_num,String productSize_size){
		return productDAO.productEachList(product_num, productSize_size);
	}

}