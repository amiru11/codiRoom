package com.basic.codi;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.member.MailService;
import com.basic.member.MemberDTO;
import com.basic.member.MemberService;

@Controller
@RequestMapping(value = "/member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MailService mailService;
	
	//ID 중복 체크
	@RequestMapping(value = "idCheck")
	public ResponseEntity<Map<String, Object>> idCheck(MemberDTO memberDTO){
		Map<String, Object> m = new HashMap<String, Object>();
		int idCheck = 0;
		try {
			memberDTO = memberService.idCheck(memberDTO);
			if(memberDTO != null){
				idCheck = 1;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		m.put("idCheck", idCheck);
		return new ResponseEntity<Map<String, Object>>(m, HttpStatus.OK);
	}
	
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
			message = "아이디와 비밀번호가 다릅니다.";
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
	public String myPage(Model model){
		String subMenu = "내 정보";
		model.addAttribute("subMenu", subMenu);
		return "/member/myPage";
	}
	
	//showMyinfo
	@RequestMapping(value = "/myPage/showMyinfo")
	public void showMyinfo(){}
	
	//회원 수정
	@RequestMapping(value = "memberUpdate", method = RequestMethod.POST)
	public String memberUpdate(MemberDTO memberDTO, RedirectAttributes rd, HttpSession session){
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
			session.setAttribute("member", memberDTO);
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
	public ResponseEntity<Map<String, Object>> memberDelete(MemberDTO memberDTO, HttpSession session){
		Map<String, Object> m = new HashMap<String, Object>();
		int result = 0;
		String message = "";
		try {
			result = memberService.memberDelete(memberDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(result > 0){
			message = "회원 탈퇴 성공";
			session.invalidate();
		}else {
			message = "비밀번호가 일치 하지 않습니다.";
		}
		m.put("result", result);
		m.put("message", message);
		return new ResponseEntity<Map<String, Object>>(m, HttpStatus.OK);
	}
	
	//findFrom
	@RequestMapping(value = "findFrom")
	public void findFrom(){}
	
	//ID 찾기
	@RequestMapping(value = "idFind", method = RequestMethod.POST)
	public String idFind(MemberDTO memberDTO, String mail, RedirectAttributes rd){
		String path = "";
		String message = "";
		
		try {
			memberDTO = memberService.idFind(memberDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(memberDTO != null){
			mailService.IdFind(memberDTO, mail);
			
			path = "redirect:/";
			message = "메일을 발송 하였습니다.";
		}else{
			path = "redirect:/member/findFrom";
			message = "이름과 전화번호가 다릅니다.";
		}
		
		rd.addFlashAttribute("message", message);
		return path;
	}
	
	//PW 찾기
	@RequestMapping(value = "pwFind", method = RequestMethod.POST)
	public String pwFind(MemberDTO memberDTO, RedirectAttributes rd){
		int result = 0;
		String path = "";
		String message = "";
		
		try {
			memberDTO = memberService.idCheck(memberDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(memberDTO != null){
			//랜덤 pw 생성
			memberDTO.setPw(String.valueOf((char)((int)(Math.random()*26)+97)) + ((int)Math.random()*10+1) + ((int)Math.random()*10+1) + ((int)Math.random()*10+1));
			//랜덤 pw 생성 후 pw DB 저장
			try {
				result = memberService.memberUpdate(memberDTO);
				if(result > 0){
					//랜덤 pw 메일로 전송
					mailService.PwFind(memberDTO);
					
					path = "redirect:/";
					message = "메일을 발송 하였습니다.";
				}
			}catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {
			//가입이이디 찾을 수 없음 메시지 리턴 ?
			path = "redirect:/member/findFrom";
			message = "가입된 회원이 없습니다.";
		}
		
		rd.addFlashAttribute("message", message);
		return path;
	}

}
