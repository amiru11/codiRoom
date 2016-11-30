package com.basic.board;

import java.sql.Date;

public class CommentDTO {

	private int comm_num;
	private int comm_refNum;
	private String comm_writer;
	private String comm_contents;
	private Date comm_date;
	
	
	public int getComm_num() {
		return comm_num;
	}
	public void setComm_num(int comm_num) {
		this.comm_num = comm_num;
	}
	public int getComm_refNum() {
		return comm_refNum;
	}
	public void setComm_refNum(int comm_refNum) {
		this.comm_refNum = comm_refNum;
	}
	public String getComm_writer() {
		return comm_writer;
	}
	public void setComm_writer(String comm_writer) {
		this.comm_writer = comm_writer;
	}
	public String getComm_contents() {
		return comm_contents;
	}
	public void setComm_contents(String comm_contents) {
		this.comm_contents = comm_contents;
	}
	public Date getComm_date() {
		return comm_date;
	}
	public void setComm_date(Date comm_date) {
		this.comm_date = comm_date;
	}
	
	
	
	
}
