package com.basic.mast;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.w3c.dom.ls.LSInput;

@Repository
public class SSSDAO {
	@Autowired
	private SqlSession sqlSession;
	private String namespace = "SSSSMapper.";

	@Autowired
	private PlatformTransactionManager transactionManager;

	DefaultTransactionDefinition def = null;
	TransactionStatus status = null;

	public List<MastBuyListDTO> mastBuyPayList(Map<String, Object> map) {
		List<MastBuyListDTO> ar = sqlSession.selectList(namespace + "SelMastBuyPayList", map);
		System.out.println("arsize----" + ar.size());
		for (int i = 0; i < ar.size(); i++) {
			System.out.println("buynum----" + ar.get(i).getBuyStateDTO().getBuy_num());
			System.out.println("memid---" + ar.get(i).getBuyDTO().getMember_id());
			System.out.println("-proname---" + ar.get(i).getProductDTO().getProduct_name());
			System.out.println("pronum----" + ar.get(i).getProductDTO().getProduct_num());
			System.out.println("busresult----" + ar.get(i).getBuyStateDTO().getBuyState_result_date());

		}

		return sqlSession.selectList(namespace + "SelMastBuyPayList", map);
	}

}
