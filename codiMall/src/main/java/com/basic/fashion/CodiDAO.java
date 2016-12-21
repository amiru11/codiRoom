package com.basic.fashion;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.basic.product.KindDTO;
import com.basic.product.ProductSelectDTO;
import com.basic.util.PageMaker;

@Repository
public class CodiDAO {
	
	@Autowired
	private SqlSession sqlSession;
	private String namespace = "CodiMapper.";
	
	@Autowired
	private PlatformTransactionManager transactionManager;

	DefaultTransactionDefinition def = null;
	TransactionStatus status = null;
	
	//코디 리스트
	public List<CodiDTO> codiList(PageMaker pageMaker, CodiDTO codiDTO) throws Exception{
		return sqlSession.selectList(namespace + "codiList", pageMaker);
	}
	
	//등록
	public void codiWrite() throws Exception{
		
	}
	
	//삭제
	public void codiDelete() throws Exception{
		
	}
	
	//코디 등록 할 상품 리스트
	public List<CodiDTO> codiProductList(int kind_num){
		Map<String, Integer> map = new HashMap<>();
		map.put("kind_num", kind_num);
		System.out.println("kind_num---"+kind_num);
		List<CodiDTO> ar = sqlSession.selectList(namespace+"SelCodiProductList", map);
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
