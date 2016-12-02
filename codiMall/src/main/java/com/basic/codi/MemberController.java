package com.basic.codi;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.member.MemberDTO;
import com.basic.member.MemberService;

@Controller
@RequestMapping(value = "/member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	//가입
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoin(MemberDTO memberDTO, RedirectAttributes rd){
		int result = 0;
		String path = "";
		String message = "";
		try {
			result = memberService.memberJoin(memberDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(result > 0){
			path = "redirect:/";
			message = "회원 가입 성공";
			
		}else {
			path = "redirect:/";
			message = "회원 가입 실패";
		}
		rd.addFlashAttribute("message", message);
		return path;
	}
	
	//로그인
	@RequestMapping(value = "memberLogin", method = RequestMethod.POST)
	public String memberLogin(MemberDTO memberDTO, RedirectAttributes rd, HttpSession session){
		String path = "";
		String message = "";
		try {
			memberDTO = memberService.memberLogin(memberDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(memberDTO != null){
			path = "redirect:/";
			message = "로그인 성공";
			session.setAttribute("member", memberDTO);
		}else {
			path = "redirect:/";
			message = "로그인 실패";
		}
		rd.addFlashAttribute("message", message);
		return path;
	}
	
	//로그아웃
	@RequestMapping(value = "memberLogout")
	public String memberLogout(HttpSession session){
		session.invalidate();
		return "redirect:/";
	}
	
	//마이페이지
	@RequestMapping(value = "myPage")
	public void myPage(@RequestParam(defaultValue = "0") int showMyinfo, RedirectAttributes rd){
		
	}
	
	//showMyinfo
	@RequestMapping(value = "/myPage/showMyinfo")
	public void showMyinfo(){}
	
	//회원 수정
	@RequestMapping(value = "memberUpdate", method = RequestMethod.POST)
	public String memberUpdate(MemberDTO memberDTO, RedirectAttributes rd){
		int result = 0;
		String path = "";
		String message = "";
		try {
			result = memberService.memberUpdate(memberDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(result > 0){
			path = "redirect:/member/myPage/resultMessage";
			message = "회원정보 수정 성공";
		}else {
			path = "redirect:/member/myPage/resultMessage";
			message = "회원정보 수정 실패";
		}
		rd.addFlashAttribute("message", message);
		return path;
	}
	
	
	//myPage의 모든 결과 메시지
	@RequestMapping(value = "/myPage/resultMessage")
	public void resultMessage(){}
	
	//회원 탈퇴 From
	@RequestMapping(value = "/myPage/deleteFrom")
	public void deleteFrom(){}
	
	//회원 탈퇴
	@RequestMapping(value = "memberDelete", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> memberDelete(MemberDTO memberDTO, RedirectAttributes rd, HttpSession session){
		Map<String, Object> m = new HashMap<String, Object>();
		int result = 0;
		String path = "";
		String message = "";
		try {
			result = memberService.memberDelete(memberDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(result > 0){
			path = "redirect:/";
			message = "회원 탈퇴 성공";
			session.invalidate();
		}else {
			path = "redirect:/member/myPage/resultMessage";
			message = "비밀번호가 일치 하지 않습니다.";
		}
		m.put("result", result);
		rd.addFlashAttribute("message", message);
		return new ResponseEntity<Map<String, Object>>(m, HttpStatus.OK);
	}

}
