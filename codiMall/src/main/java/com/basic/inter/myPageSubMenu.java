package com.basic.inter;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.basic.member.MemberDTO;

public class myPageSubMenu extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		MemberDTO memberDTO = (MemberDTO)request.getSession().getAttribute("member");
		if(memberDTO == null){
			response.sendRedirect(request.getContextPath()+"/");
			return false;
		}else {
			return true;
		}
	}

}
