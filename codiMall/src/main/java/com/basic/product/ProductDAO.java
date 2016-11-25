package com.basic.product;

import java.util.List;

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
	
	public int productCount(){
		return 0;
	}

	public List<ProductListDTO> productList(PageMaker pageMaker) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+"SelProductList",pageMaker);
	}
	
	

}
