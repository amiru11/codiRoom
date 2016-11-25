package com.basic.codi;

import java.util.List;

import javax.servlet.http.HttpSession;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.basket.BasketDTO;
import com.basic.basket.BasketInfoDTO;
import com.basic.member.MemberDTO;
import com.basic.test.ProductDTO;
import com.basic.test.ProductEachDTO;
import com.basic.test.ProductInfoDTO;
import com.basic.test.ProductKindDTO;
import com.basic.test.TestDTO;
import com.basic.test.TestMemberDTO;
import com.basic.test.TestAddDTO;
import com.basic.test.TestBasketDTO;

@Controller
@RequestMapping(value = "/member")
public class TestMemberController {
	@Autowired
	private SqlSession sqlSession;
	private String namespace = "TestMemberMapper.";
	

	@RequestMapping(value="/login")
	public String testLogin(HttpSession session, RedirectAttributes ra) {
		String path = "";
		String message = "";
		if (session.getAttribute("member") != null) {
			message = "member is loging";
			ra.addFlashAttribute("message", message);
			path = "redirect:/";
		} else {
			TestMemberDTO testMemberDTO = new TestMemberDTO();
			testMemberDTO.setMember_id("asd123");
			testMemberDTO.setMember_pw("asd123");

			testMemberDTO = sqlSession.selectOne(namespace + "MemberLogin", testMemberDTO);

			if (testMemberDTO != null) {
				session.setAttribute("member", testMemberDTO);
				message = "login success";
				ra.addFlashAttribute("message", message);
				path = "redirect:/";
			} else {
				message = "login fail";
				ra.addFlashAttribute("message", message);
				path = "redirect:/";
			}
		}

		return path;

	}

	@RequestMapping(value="/logout")
	public String testLogout(HttpSession session,RedirectAttributes ra) {
		String message = "";
		if(session.getAttribute("member") != null){
			session.invalidate();
			message="logout success";
			ra.addFlashAttribute("message",message);
		}else{
			message="잘못된 접근";
			ra.addFlashAttribute("message",message);
		}
		
		return "redirect:/";

	}

}
