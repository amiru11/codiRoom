package com.basic.test;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemoDAO {
	
	@Autowired
	private SqlSession sqlSession;
	private String namespace = "TestMapper.";
	
	//list//
	public List<MemoDTO> memoList(){
		return sqlSession.selectList(namespace+"memoList");
	}
	//write//
	public int memoWrite(MemoDTO memoDTO){
		return sqlSession.insert(namespace+"memoWrite", memoDTO);
	}
	
}
