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

	public List<ProductViewDTO> productView(int product_num) {
		List<ProductViewDTO> ar = new ArrayList<ProductViewDTO>();
		ar = sqlSession.selectList(namespace + "SelProductView", product_num);
		System.out.println("arsize--" + ar.size());
		System.out.println("ar2size--" + ar.get(0).getProductEachDTOs().size());

		return sqlSession.selectList(namespace + "SelProductView", product_num);
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

	public int productEachAdd(ProductEachAddDTO[] productEachAddDTOs) {
		def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		status = transactionManager.getTransaction(def);

		int result = 0;
		for (int i = 0; i < productEachAddDTOs.length; i++) {

			try {
				result = sqlSession.insert(namespace + "ProductSizeAdd", productEachAddDTOs[i]);
				result = sqlSession.insert(namespace + "ProductEachAdd", productEachAddDTOs[i]);
				if (result > 0) {
					transactionManager.commit(status);
					System.out.println("success");
				}
			} catch (Exception e) {
				// TODO: handle exception
				transactionManager.rollback(status);
				result = 0;
			}
		}

		return result;
	}

}
