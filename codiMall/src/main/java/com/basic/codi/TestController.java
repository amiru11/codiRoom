package com.basic.codi;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import com.basic.test.MemoDAO;
import com.basic.test.MemoDTO;


@Controller
@RequestMapping(value = "/test")
public class TestController {


	@RequestMapping(value="move")
	public void teeess(){
	}

	@Autowired
	private MemoDAO memoDAO;

	
	//test


	
	
	
	//memo
	
	@RequestMapping(value="/testmemo")
	public void testmemo(){
		
	}
	
	//write//
	@RequestMapping(value="/memoWrite")
	public String memoWrite(MemoDTO memoDTO,Model model){
		System.out.println("memoNum : " + memoDTO.getNum());
		System.out.println("memoWriter : " + memoDTO.getWriter());
		System.out.println("memoContents : " + memoDTO.getContents());
		int result = memoDAO.memoWrite(memoDTO);
		String message = "";
		if(result> 0){
			message="등록 성공";
		}else{
			message="등록 실패";
		}
		model.addAttribute("message", message);
		return "/ttt/memoResult";
	}
	
	@RequestMapping(value="/memoResult")
	public void memoResult(){
		
	}
	
	//list//
	@RequestMapping(value="/memoList")
	public String memoList(Model model){
		List<MemoDTO> ar;
		ar = memoDAO.memoList();
		
		model.addAttribute("list", ar);
		return "/ttt/testmemo";
	}	
	
	
	
}
