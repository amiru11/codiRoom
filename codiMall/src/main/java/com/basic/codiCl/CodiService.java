package com.basic.codiCl;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.basic.product.KindDTO;
import com.basic.product.ProductSelectDTO;

@Service
public class CodiService {
	
	@Autowired
	private CodiDAO codiDAO;
	
	public List<CodiProductDTO> codiProductList(int kind_num){
		return codiDAO.codiProductList(kind_num);

	}
	
	public List<KindDTO> codiKindList(int productSelect_num){
		return codiDAO.codiKindList(productSelect_num);

	}
	
	public List<ProductSelectDTO> codiSelectList(){
		return codiDAO.codiSelectList();
	}

}
