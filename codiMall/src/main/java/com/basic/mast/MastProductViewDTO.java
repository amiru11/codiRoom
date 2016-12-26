package com.basic.mast;

import java.sql.Date;
import java.util.List;

import com.basic.product.ProductEachDTO;

public class MastProductViewDTO {
	
	private int selCount;
	private int productSelect_num;
	private String productSelect_name;
	private int kind_num;
	private String kind_name;
	private int product_num;
	private String product_name;
	private int productInfo_price;
	private Date productInfo_reg_date;
	private Date productInfo_rec_date;
	private double productInfo_saleRate;
	private String productInfo_searchWord;
	private String productInfo_brand;
	private String productPic_pic;
	private List<ProductEachDTO> productEachDTOs;
	public int getSelCount() {
		return selCount;
	}
	public void setSelCount(int selCount) {
		this.selCount = selCount;
	}
	public int getProductSelect_num() {
		return productSelect_num;
	}
	public void setProductSelect_num(int productSelect_num) {
		this.productSelect_num = productSelect_num;
	}
	public String getProductSelect_name() {
		return productSelect_name;
	}
	public void setProductSelect_name(String productSelect_name) {
		this.productSelect_name = productSelect_name;
	}
	public int getKind_num() {
		return kind_num;
	}
	public void setKind_num(int kind_num) {
		this.kind_num = kind_num;
	}
	public String getKind_name() {
		return kind_name;
	}
	public void setKind_name(String kind_name) {
		this.kind_name = kind_name;
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
	public String getProductInfo_brand() {
		return productInfo_brand;
	}
	public void setProductInfo_brand(String productInfo_brand) {
		this.productInfo_brand = productInfo_brand;
	}
	public String getProductPic_pic() {
		return productPic_pic;
	}
	public void setProductPic_pic(String productPic_pic) {
		this.productPic_pic = productPic_pic;
	}
	public List<ProductEachDTO> getProductEachDTOs() {
		return productEachDTOs;
	}
	public void setProductEachDTOs(List<ProductEachDTO> productEachDTOs) {
		this.productEachDTOs = productEachDTOs;
	}
	
	
	

}
