package com.basic.board;

import java.sql.Date;

public class BoardDTO {
	
	private int board_num;
	private String board_title;
	private String board_writer;
	private String board_contents;
	private String board_category;
	private Date board_date;
	private int board_counts;
	private int board_ref;
	private int board_step;
	private int board_depth;
	private int board_kind;
	private int product_num;
	
	
	
	
	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_writer() {
		return board_writer;
	}
	public void setBoard_writer(String board_writer) {
		this.board_writer = board_writer;
	}
	public String getBoard_contents() {
		return board_contents;
	}
	public void setBoard_contents(String board_contents) {
		this.board_contents = board_contents;
	}
	public String getBoard_category() {
		return board_category;
	}
	public void setBoard_category(String board_category) {
		this.board_category = board_category;
	}
	public Date getBoard_date() {
		return board_date;
	}
	public void setBoard_date(Date board_date) {
		this.board_date = board_date;
	}
	public int getBoard_counts() {
		return board_counts;
	}
	public void setBoard_counts(int board_counts) {
		this.board_counts = board_counts;
	}
	public int getBoard_ref() {
		return board_ref;
	}
	public void setBoard_ref(int board_ref) {
		this.board_ref = board_ref;
	}
	public int getBoard_step() {
		return board_step;
	}
	public void setBoard_step(int board_step) {
		this.board_step = board_step;
	}
	public int getBoard_depth() {
		return board_depth;
	}
	public void setBoard_depth(int board_depth) {
		this.board_depth = board_depth;
	}
	public int getBoard_kind() {
		return board_kind;
	}
	public void setBoard_kind(int board_kind) {
		this.board_kind = board_kind;
	}
	
	

}
