package com.basic.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.basic.member.MemberDTO;
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

	public int productCount(ProductParamDTO productParamDTO) {
		return sqlSession.selectOne(namespace + "SelProductCount", productParamDTO);
	}

	public List<ProductListDTO> productList(PageMaker pageMaker, ProductParamDTO productParamDTO) {
		// TODO Auto-generated method stub
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("pageMaker", pageMaker);
		hm.put("productParamDTO", productParamDTO);
		return sqlSession.selectList(namespace + "SelProductList", hm);
	}

	public ProductViewDTO productView(int product_num) {
		return sqlSession.selectOne(namespace + "SelProductView", product_num);
	}

	public int productAdd(ProductAddDTO productAddDTO) {
		def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		status = transactionManager.getTransaction(def);

		int result = 0;

		try {
			result = sqlSession.insert(namespace + "ProductAdd", productAddDTO);
			result = sqlSession.insert(namespace + "ProductInfoAdd", productAddDTO);
			result = sqlSession.insert(namespace + "ProductKindAdd", productAddDTO);
			if (result > 0) {
				transactionManager.commit(status);
				System.out.println("success");
			}
		} catch (Exception e) {
			// TODO: handle exception
			transactionManager.rollback(status);
			result = 0;
		}

		return result;

	}

	public int productEachAdd(ProductEachAddDTOs productEachAddDTOs) {
		int result = 0;
		for (int i = 0; i < productEachAddDTOs.getProductEach_color().length; i++) {
			ProductEachAddDTO productEachAddDTO = new ProductEachAddDTO();
			productEachAddDTO.setProduct_num(productEachAddDTOs.getProduct_num());
			productEachAddDTO.setProductSize_size(productEachAddDTOs.getProductSize_size()[i]);
			productEachAddDTO.setProductEach_color(productEachAddDTOs.getProductEach_color()[i]);
			productEachAddDTO.setProductEach_each(productEachAddDTOs.getProductEach_each()[i]);
			try {
				def = new DefaultTransactionDefinition();
				def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
				status = transactionManager.getTransaction(def);
				result = sqlSession.selectOne(namespace + "ProductSizeCheck", productEachAddDTO);
				//System.out.println("RESULT 1 -"+result);
				if (result > 0) {
				} else {
					result = sqlSession.insert(namespace + "ProductSizeAdd", productEachAddDTO);
					//System.out.println("RESULT 1_1 -"+result);
				}
				//System.out.println("-------------------------------------------------");

				result = sqlSession.insert(namespace + "ProductEachAdd", productEachAddDTO);
				//System.out.println("RESULT 2 -"+result);
				if (result > 0) {
					transactionManager.commit(status);
					System.out.println("success");
				}
			} catch (Exception e) {
				// TODO: handle exception
				transactionManager.rollback(status);
				result = 0;
				System.out.println("FAIL");
			}
		}
		return result;
	}
	// JSon 
	
	public List<String> productSizeList(int product_num){
		return sqlSession.selectList(namespace+"SelProductSizeList", product_num);
	}
	
	public List<ProductEachListDTO> productEachList(int product_num,String productSize_size){
		ProductEachDTO productEachDTO = new ProductEachDTO();
		productEachDTO.setProduct_num(product_num);
		productEachDTO.setProductSize_size(productSize_size);
		return sqlSession.selectList(namespace+"SelProductEachList", productEachDTO);
	}

}
