package com.basic.basket;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.basic.member.MemberDTO;
import com.basic.product.ProductEachDTO;

@Repository
public class BasketDAO {

	@Autowired
	SqlSession sqlSession;
	private String namespace = "BasketMapper.";

	@Autowired
	private PlatformTransactionManager transactionManager;

	DefaultTransactionDefinition def = null;
	TransactionStatus status = null;

	public List<BasketListDTO> basketList(MemberDTO memberDTO) {
		return sqlSession.selectList(namespace + "SelBasketList", memberDTO);
	}

	public int basketAdd(ProductEachDTO productEachDTO, MemberDTO memberDTO) {
		def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		status = transactionManager.getTransaction(def);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productEachDTO", productEachDTO);
		map.put("memberDTO", memberDTO);
		int result = 0;
		try {
			result = sqlSession.insert(namespace + "InBasketAdd", map);
			System.out.println(result);
			result = sqlSession.insert(namespace + "InBasketInfoAdd", map);
			System.out.println(result);
			if (result > 0) {
				transactionManager.commit(status);
				System.out.println("success");
			}
		} catch (Exception e) {
			// TODO: handle exception
			transactionManager.rollback(status);
			result=0;
		}
		return result;
	}

}
