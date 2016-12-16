package com.basic.buy;

public class BuyListDTO {
	
	private int buy_num;
	private int product_num;
	private String product_name;
	private String buyState_size;
	private String buyState_color;
	private int buyState_state;
	private int buyState_each;
	private int buyState_price;
	private int buyState_expressNum;
	
	
	public int getBuyState_expressNum() {
		return buyState_expressNum;
	}
	public void setBuyState_expressNum(int buyState_expressNum) {
		this.buyState_expressNum = buyState_expressNum;
	}
	public int getBuyState_state() {
		return buyState_state;
	}
	public void setBuyState_state(int buyState_state) {
		this.buyState_state = buyState_state;
	}
	public int getBuy_num() {
		return buy_num;
	}
	public void setBuy_num(int buy_num) {
		this.buy_num = buy_num;
	}
	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getBuyState_size() {
		return buyState_size;
	}
	public void setBuyState_size(String buyState_size) {
		this.buyState_size = buyState_size;
	}
	public String getBuyState_color() {
		return buyState_color;
	}
	public void setBuyState_color(String buyState_color) {
		this.buyState_color = buyState_color;
	}
	public int getBuyState_each() {
		return buyState_each;
	}
	public void setBuyState_each(int buyState_each) {
		this.buyState_each = buyState_each;
	}
	public int getBuyState_price() {
		return buyState_price;
	}
	public void setBuyState_price(int buyState_price) {
		this.buyState_price = buyState_price;
	}
}
