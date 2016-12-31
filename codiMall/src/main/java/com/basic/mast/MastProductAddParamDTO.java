package com.basic.mast;

import org.springframework.web.multipart.MultipartFile;

public class MastProductAddParamDTO {
	
	private String product_name;
	private int kind_num;
	private int productInfo_price;
	private double productInfo_saleRate;
	private String[] productInfo_searchWord;
	private String productInfo_brand;
	private MultipartFile productPic_pic;
	
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public int getKind_num() {
		return kind_num;
	}
	public void setKind_num(int kind_num) {
		this.kind_num = kind_num;
	}
	public int getProductInfo_price() {
		return productInfo_price;
	}
	public void setProductInfo_price(int productInfo_price) {
		this.productInfo_price = productInfo_price;
	}
	public double getProductInfo_saleRate() {
		return productInfo_saleRate;
	}
	public void setProductInfo_saleRate(double productInfo_saleRate) {
		this.productInfo_saleRate = productInfo_saleRate;
	}
	public String[] getProductInfo_searchWord() {
		return productInfo_searchWord;
	}
	public void setProductInfo_searchWord(String[] productInfo_searchWord) {
		this.productInfo_searchWord = productInfo_searchWord;
	}
	public String getProductInfo_brand() {
		return productInfo_brand;
	}
	public void setProductInfo_brand(String productInfo_brand) {
		this.productInfo_brand = productInfo_brand;
	}
	public MultipartFile getProductPic_pic() {
		return productPic_pic;
	}
	public void setProductPic_pic(MultipartFile productPic_pic) {
		this.productPic_pic = productPic_pic;
	}
	
	
	
	
}
