package com.basic.basket;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.basic.test.TestMemberDTO;

@Repository
public class BasketDAO {
	
	@Autowired
	SqlSession sqlSession;
	private String namespace = "BasketMapper.";
	
	@Autowired
	private PlatformTransactionManager transactionManager;

	DefaultTransactionDefinition def = null;
	TransactionStatus status = null;
	
	public List<BasketListDTO> basketList(HttpSession session){
		TestMemberDTO testMemberDTO = (TestMemberDTO)session.getAttribute("member");
		String member_id = testMemberDTO.getMember_id();
		return sqlSession.selectList(namespace+"SelBasketList",member_id);
	}

}
