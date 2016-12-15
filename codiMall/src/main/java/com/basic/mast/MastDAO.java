package com.basic.mast;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MastDAO {
	
	@Autowired
	private SqlSession sqlSession;
	private String namespace = "MastMapper.";
	
	public List<MastBuyListDTO> mastBuyList(){
		return sqlSession.selectList(namespace+"SelMastBuyList");
	}
}
