package com.basic.board;

import java.sql.Date;

public class BoardDTO {//부모역할의  DTO
	
	private int num;
	private String writer;
	private String title;
	private String contents;
	private String category;
	private Date reg_date;
	private int counts;
	private int board;
	
	
	
	
	public int getBoard() {
		return board;
	}
	public void setBoard(int board) {
		this.board = board;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getCounts() {
		return counts;
	}
	public void setCounts(int counts) {
		this.counts = counts;
	}
	
	
	
	
	

}
