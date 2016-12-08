package com.basic.basket;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.basic.member.MemberDTO;
import com.basic.product.ProductEachDTO;

@Service
public class BasketService {

	@Autowired
	private BasketDAO basketDAO;

	public List<BasketListDTO> basketList(HttpSession session) {
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		return basketDAO.basketList(memberDTO);
	}

	public List<ProductEachDTO> basketProductEachList(int product_num) {
		return basketDAO.basketProductEachList(product_num);
	}

	public int basketAdd(HttpSession session, ProductEachDTO productEachDTO) {
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		return basketDAO.basketAdd(productEachDTO, memberDTO);
	}

	public String basketFix(HttpServletRequest request, HttpSession session) {
		return basketDAO.basketFix(request, session);
	}

	// Basket Del
	public int basketDel(int[] del_basket_num) {
		return basketDAO.basketDel(del_basket_num);
	}

}
