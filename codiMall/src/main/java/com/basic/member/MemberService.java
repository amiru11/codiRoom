package com.basic.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

	//controller로 보내겟어!!!
	
	@Autowired
	private MemberDAO memberDAO;
	
	//1.JOIN//
	public int memberJoin(MemberDTO memberDTO) throws Exception{
		return memberDAO.memberJoin(memberDTO);
	}
	//2.LOGIN//
	public MemberDTO memberLogin(MemberDTO memberDTO) throws Exception{
		return memberDAO.memberLogin(memberDTO);
	}
	
	//3.UPDATE//
	public int memberUpdate(MemberDTO memberDTO) throws Exception{
		return memberDAO.memberUpdate(memberDTO);
	}
	
	//4.DELETE//
	public int memberDelete(MemberDTO memberDTO) throws Exception{
		return memberDAO.memberDelete(memberDTO);
	}
	
	//ID 찾기
	public MemberDTO idFind(MemberDTO memberDTO) throws Exception{
		return memberDAO.idFind(memberDTO);
	}
	
	//ID 중복 체크 , PW 찾기
	public MemberDTO idCheck(MemberDTO memberDTO) throws Exception{
		return memberDAO.idCheck(memberDTO);
	}
	
}
