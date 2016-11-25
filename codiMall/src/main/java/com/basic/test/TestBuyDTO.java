package com.basic.test;

import java.sql.Date;

public class TestBuyDTO{
	//Product
	private int product_num;
	private String product_name;
	//ProductEach
	private String[] productEach_size;
	private String[] productEach_color;
	private int[] productEach_each; 
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
	public String[] getProductEach_size() {
		return productEach_size;
	}
	public void setProductEach_size(String[] productEach_size) {
		this.productEach_size = productEach_size;
	}
	public String[] getProductEach_color() {
		return productEach_color;
	}
	public void setProductEach_color(String[] productEach_color) {
		this.productEach_color = productEach_color;
	}
	public int[] getProductEach_each() {
		return productEach_each;
	}
	public void setProductEach_each(int[] productEach_each) {
		this.productEach_each = productEach_each;
	}
	public int getProductInfo_price() {
		return productInfo_price;
	}
	public void setProductInfo_price(int productInfo_price) {
		this.productInfo_price = productInfo_price;
	}
	public Date getProductInfo_reg_date() {
		return productInfo_reg_date;
	}
	public void setProductInfo_reg_date(Date productInfo_reg_date) {
		this.productInfo_reg_date = productInfo_reg_date;
	}
	public Date getProductInfo_rec_date() {
		return productInfo_rec_date;
	}
	public void setProductInfo_rec_date(Date productInfo_rec_date) {
		this.productInfo_rec_date = productInfo_rec_date;
	}
	public double getProductInfo_saleRate() {
		return productInfo_saleRate;
	}
	public void setProductInfo_saleRate(double productInfo_saleRate) {
		this.productInfo_saleRate = productInfo_saleRate;
	}
	public String getProductInfo_searchWord() {
		return productInfo_searchWord;
	}
	public void setProductInfo_searchWord(String productInfo_searchWord) {
		this.productInfo_searchWord = productInfo_searchWord;
	}
	public int getKind_num() {
		return kind_num;
	}
	public void setKind_num(int kind_num) {
		this.kind_num = kind_num;
	}
	//ProductInfo
	private int productInfo_price;
	private Date productInfo_reg_date;
	private Date productInfo_rec_date;
	private double productInfo_saleRate;
	private String productInfo_searchWord;
	//ProductKind
	private int kind_num;
	
}
