package com.basic.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSession sqlSession;
	private String namespace = "MemberMapper.";
	
	//1.JOIN//
		public int memberJoin(MemberDTO memberDTO) throws Exception{
			return sqlSession.insert(namespace+"memberJoin", memberDTO);
		}
	//2.LOGIN//
	public MemberDTO memberLogin(MemberDTO memberDTO) throws Exception{
		return sqlSession.selectOne(namespace+"memberLogin", memberDTO);
	}
	
	//3.UPDATE//
	public int memberUpdate(MemberDTO memberDTO) throws Exception{
		return sqlSession.update(namespace+"memberUpdate", memberDTO);
	}
	
	//4.DELETE//
	public int memberDelete(MemberDTO memberDTO) throws Exception{
		return sqlSession.delete(namespace+"memberDelete", memberDTO);
	}
	
	//ID 찾기
	public MemberDTO idFind(MemberDTO memberDTO) throws Exception{
		return sqlSession.selectOne(namespace+"idFind", memberDTO);
	}
	
	//PW 찾기
	public MemberDTO pwFind(MemberDTO memberDTO) throws Exception{
		return sqlSession.selectOne(namespace+"pwFind", memberDTO);
	}
}
