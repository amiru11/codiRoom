package com.basic.product;

public class ProductParamDTO {
	private int sel;//최저가 & 최대가 & 최신순 등 정렬종류
	private int productSelect_num; // 상품종류 대분류 (아우터 상의 하의 등등)
	private int []kind_num; //상품 종류 소분류 (패딩 니트 재킷 등등)
	private String []color; //색깔
	private String []size; //사이즈
	
	
	
	public int getProductSelect_num() {
		return productSelect_num;
	}
	public void setProductSelect_num(int productSelect_num) {
		this.productSelect_num = productSelect_num;
	}
	public int getSel() {
		return sel;
	}
	public void setSel(int sel) {
		this.sel = sel;
	}
	public String[] getSize() {
		return size;
	}
	public void setSize(String[] size) {
		this.size = size;
	}
	private String searchWord;
	
	
	public int[] getKind_num() {
		return kind_num;
	}
	public void setKind_num(int[] kind_num) {
		this.kind_num = kind_num;
	}
	public String[] getColor() {
		return color;
	}
	public void setColor(String[] color) {
		this.color = color;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

}
