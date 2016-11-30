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
	
	public List<ProductListDTO> productList(int curPage,int perPage,ProductParamDTO productParamDTO){
		int totalCount = productDAO.productCount(productParamDTO);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCurPage(curPage);
		pageMaker.setPerPage(perPage);
		pageMaker.makeRow();
		pageMaker.makePage(totalCount);
		
		return productDAO.productList(pageMaker,productParamDTO);
	}
	public List<ProductViewDTO> productView(int product_num){
		return productDAO.productView(product_num);
	}
	
	public int productAdd(ProductAddDTO productAddDTO){
		return productDAO.productAdd(productAddDTO);
	}
	
	public int productEachAdd(ProductEachAddDTO[] productEachAddDTOs){
		return productDAO.productEachAdd(productEachAddDTOs);
	}

}
