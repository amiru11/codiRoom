package com.basic.product;

public class ProductParamDTO {
	private int sel;//최저가 & 최대가 & 최신순 등 정렬종류
	private int []kind_num; //상품 종류 (상의, 하의, etc..)
	private String []color; //색깔
	private String []size; //사이즈
	
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
