package com.basic.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.basic.util.PageMaker;

@Repository
public class ProductDAO {
	@Autowired
	SqlSession sqlSession;
	private String namespace = "ProductMapper.";
	
	@Autowired
	private PlatformTransactionManager transactionManager;

	DefaultTransactionDefinition def = null;
	TransactionStatus status = null;
	
	public int productCount(ProductParamDTO productParamDTO){
		return sqlSession.selectOne(namespace+"SelProductCount",productParamDTO);
	}

	public List<ProductListDTO> productList(PageMaker pageMaker,ProductParamDTO productParamDTO) {
		// TODO Auto-generated method stub
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("pageMaker", pageMaker);
		hm.put("productParamDTO",productParamDTO);
		return sqlSession.selectList(namespace+"SelProductList",hm);
	}
	
	public List<ProductViewDTO> productView(int product_num){
		List<ProductViewDTO> ar =  new ArrayList<ProductViewDTO>();
		ar = sqlSession.selectList(namespace+"SelProductView",product_num);
		System.out.println("arsize--"+ar.size());
		System.out.println("ar2size--"+ar.get(0).getProductEachDTOs().size());

		
		return sqlSession.selectList(namespace+"SelProductView",product_num);
	}
	
	

}
