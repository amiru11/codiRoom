package com.basic.basket;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BasketService {
	
	@Autowired
	private BasketDAO basketDAO;
	
	public List<BasketListDTO> basketList(HttpSession session){
		return basketDAO.basketList(session);
	}
	

}
