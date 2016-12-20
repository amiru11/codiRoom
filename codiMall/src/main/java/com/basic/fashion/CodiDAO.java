package com.basic.fashion;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.basic.util.PageMaker;

@Repository
public class CodiDAO {
	
	@Autowired
	private SqlSession sqlSession;
	private String namespace = "CodiMapper.";
	
	//리스트
	public List<CodiDTO> codiList(PageMaker pageMaker, CodiDTO codiDTO) throws Exception{
		return sqlSession.selectList(namespace + "codiList", pageMaker);
	}
	
	//등록
	public void codiWrite() throws Exception{
		
	}
	
	//삭제
	public void codiDelete() throws Exception{
		
	}

}
