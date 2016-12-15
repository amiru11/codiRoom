package com.basic.buy;

import java.sql.Date;

public class BuyStateDTO extends BuyDTO{
	
	private String buyState_size;
	private String buyState_color;
	private int buyState_each;
	private int buyState_price;
	private int buyState_state;
	private int buyState_expressNum;
	private Date buyState_pay_date;
	private Date buyState_result_date;
	
	
	public int getBuyState_expressNum() {
		return buyState_expressNum;
	}
	public void setBuyState_expressNum(int buyState_expressNum) {
		this.buyState_expressNum = buyState_expressNum;
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
	public int getBuyState_state() {
		return buyState_state;
	}
	public void setBuyState_state(int buyState_state) {
		this.buyState_state = buyState_state;
	}
	public Date getBuyState_pay_date() {
		return buyState_pay_date;
	}
	public void setBuyState_pay_date(Date buyState_pay_date) {
		this.buyState_pay_date = buyState_pay_date;
	}
	public Date getBuyState_result_date() {
		return buyState_result_date;
	}
	public void setBuyState_result_date(Date buyState_result_date) {
		this.buyState_result_date = buyState_result_date;
	}

}
