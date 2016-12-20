package com.basic.codiCl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.util.AlternativeJdkIdGenerator;

import com.basic.product.KindDTO;
import com.basic.product.ProductSelectDTO;

@Repository
public class CodiDAO {
	
	@Autowired
	SqlSession sqlSession;
	private String namespace = "CodiMapper.";

	@Autowired
	private PlatformTransactionManager transactionManager;

	DefaultTransactionDefinition def = null;
	TransactionStatus status = null;
	
	public List<CodiProductDTO> codiProductList(int kind_num){
		Map<String, Integer> map = new HashMap<>();
		map.put("kind_num", kind_num);
		System.out.println("kind_num---"+kind_num);
		List<CodiProductDTO> ar = sqlSession.selectList(namespace+"SelCodiProductList", map);
		for (int i = 0; i < ar.size(); i++) {
			System.out.println(i+"------"+ar.get(i).getProductDTO().getProduct_name());
			
		}
		
		return ar;
	}
	
	public List<KindDTO> codiKindList(int productSelect_num){
		System.out.println(productSelect_num);
		Map<String, Integer> map = new HashMap<>();
		map.put("productSelect_num", productSelect_num);
		List<KindDTO> ar = sqlSession.selectList(namespace+"SelkindList", map);
		System.out.println(ar.get(0).getKind_name());
		return ar;
	}
	
	public List<ProductSelectDTO> codiSelectList(){
		return sqlSession.selectList(namespace+"SelProductSelectList");
	}

}
