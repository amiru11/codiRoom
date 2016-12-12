package com.basic.buy;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.basic.basket.BasketDTO;
import com.basic.basket.BasketListDTO;
import com.basic.member.MemberDTO;

@Service 
public class BuyService {
	
	@Autowired
	private BuyDao buyDao;
	
	public List<BuyListDTO> buyList(HttpSession session){
		return buyDao.buyList(session);
	}
	
	public List<BasketListDTO> basketBuyList(int[] basket_num){
		return buyDao.basketBuyList(basket_num);
	}
	
	public String nonBasketBuy(BuyNonBasketDTO buyNonBasketDTO,MemberDTO memberDTO){
		return buyDao.nonBasketBuy(buyNonBasketDTO, memberDTO);
	}


	public String basketBuy(int[] basket_num,MemberDTO memberDTO){
		return buyDao.basketBuy(basket_num,memberDTO);
	}
	
	public String cancelBuy(int buy_num){
		return buyDao.cancelBuy(buy_num);
	}

}
