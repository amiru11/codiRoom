package com.basic.buy;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.basic.basket.BasketDTO;
import com.basic.basket.BasketListDTO;
import com.basic.member.MemberDTO;
import com.basic.product.ProductListDTO;

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
	
	public ProductListDTO BuyDirectList(int product_num){
		return buyDao.buyDirectList(product_num);
	}
	
	public Map<String, Object> buyDirect(int total_price,int product_num, String productSize_size, String productEach_color,int productEach_each,MemberDTO memberDTO){
		return buyDao.buyDirect(total_price,product_num,productSize_size,productEach_color,productEach_each, memberDTO);
	}


	public Map<String, Object> basketBuy(int[] basket_num,MemberDTO memberDTO){
		return buyDao.basketBuy(basket_num,memberDTO);
	}
	
	public String cancelBuy(int buy_num){
		return buyDao.cancelBuy(buy_num);
	}
	
	public String buyConfirm(int buy_num){
		return buyDao.buyConfirm(buy_num);
	}
	
	public int getExpressNum(int buy_num){
		return buyDao.getExpressNum(buy_num);
	}

}
