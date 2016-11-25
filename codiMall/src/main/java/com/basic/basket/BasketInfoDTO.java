package com.basic.basket;

public class BasketInfoDTO extends BasketDTO{
	
	private String basketInfo_size;
	private String basketInfo_color;
	private int  basketInfo_each;
	
	public String getBasketInfo_size() {
		return basketInfo_size;
	}
	public void setBasketInfo_size(String basketInfo_size) {
		this.basketInfo_size = basketInfo_size;
	}
	public String getBasketInfo_color() {
		return basketInfo_color;
	}
	public void setBasketInfo_color(String basketInfo_color) {
		this.basketInfo_color = basketInfo_color;
	}
	public int getBasketInfo_each() {
		return basketInfo_each;
	}
	public void setBasketInfo_each(int basketInfo_each) {
		this.basketInfo_each = basketInfo_each;
	}
	
	

}
