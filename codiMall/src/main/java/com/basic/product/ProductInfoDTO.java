package com.basic.product;

import java.sql.Date;

public class ProductInfoDTO {
	private int product_num;
	private int productInfo_price;
	private Date productInfo_reg_date;
	private Date productInfo_rec_date;
	private double productInfo_saleRate;
	private String productInfo_searchWord;
	private String productInfo_brand;
	
	
	public String getProductInfo_brand() {
		return productInfo_brand;
	}
	public void setProductInfo_brand(String productInfo_brand) {
		this.productInfo_brand = productInfo_brand;
	}
	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
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
	
	
	
	
	
	
	

}
