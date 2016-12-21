package com.basic.fashion;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.basic.product.KindDTO;
import com.basic.product.ProductSelectDTO;
import com.basic.util.PageMaker;

@Service
public class CodiService {
	
	@Autowired
	private CodiDAO codiDAO;
	
	//코디 리스트
	public void codiList(PageMaker pageMaker, CodiDTO codiDTO, Model model) throws Exception{
		List<CodiDTO> ar;
		ar = codiDAO.codiList(pageMaker, codiDTO);
		model.addAttribute("list", ar);
	}
	
	//상품 리스트
	public List<CodiDTO> codiProductList(int kind_num){
		return codiDAO.codiProductList(kind_num);

	}
	
	public List<KindDTO> codiKindList(int productSelect_num){
		return codiDAO.codiKindList(productSelect_num);

	}
	
	public List<ProductSelectDTO> codiSelectList(){
		return codiDAO.codiSelectList();
	}

}
