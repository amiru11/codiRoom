package com.basic.fashion;

import com.basic.product.ProductDTO;
import com.basic.product.ProductPicDTO;

public class CodiDTO {
	private int num;
	private String fileName;
	private String member_id;
	private String product;
	private String title;
	private int count;
	private ProductDTO productDTO;
	private ProductPicDTO productPicDTO;
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public ProductDTO getProductDTO() {
		return productDTO;
	}
	public void setProductDTO(ProductDTO productDTO) {
		this.productDTO = productDTO;
	}
	public ProductPicDTO getProductPicDTO() {
		return productPicDTO;
	}
	public void setProductPicDTO(ProductPicDTO productPicDTO) {
		this.productPicDTO = productPicDTO;
	}
}
