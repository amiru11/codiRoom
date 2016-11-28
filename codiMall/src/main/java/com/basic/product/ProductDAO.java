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
		return 0;
	}

	public List<ProductListDTO> productList(PageMaker pageMaker,ProductParamDTO productParamDTO) {
		// TODO Auto-generated method stub
		Map<String, Object> ar = new HashMap<String, Object>();
		ar.put("pageMaker", pageMaker);
		ar.put("productParamDTO",productParamDTO);
		return sqlSession.selectList(namespace+"SelProductList",ar);
	}
	
	

}
