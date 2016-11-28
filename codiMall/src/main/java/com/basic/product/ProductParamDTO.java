package com.basic.product;

public class ProductParamDTO {
	private int sel;
	private int []kind_num;
	private String []color;
	private String []size;
	
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
