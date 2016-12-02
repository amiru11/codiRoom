package com.basic.basket;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.basic.member.MemberDTO;
import com.basic.product.ProductEachDTO;

@Service
public class BasketService {
	
	@Autowired
	private BasketDAO basketDAO;
	
	public List<BasketListDTO> basketList(HttpSession session){
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");		
		return basketDAO.basketList(memberDTO);
	}
	
	public int basketAdd(HttpSession session,ProductEachDTO productEachDTO){
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		return basketDAO.basketAdd(productEachDTO, memberDTO);		
	}
	

}
