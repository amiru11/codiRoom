package com.basic.util;

public class PageMaker {
	private int startRowNum;
	private int lastLowNum;
	private int curBlock;
	private int totalBlock;
	private int startNum;
	private int lastNum;
	private int curPage;
	private int perPage;
	
	//rownum
	public void makeRow(){
		this.startRowNum= (curPage-1)*perPage+1;
		this.lastLowNum = curPage*perPage;
	}
	
	//pageing
	public void makePage(int totalCount){
		//1. 전체 게시물 수-매개변수
		
		//2. 전체 page
		int totalPage=0;
		if(totalCount%perPage==0){
			totalPage=totalCount/perPage;
		}else {
			totalPage=totalCount/perPage+1;
		}
		//3. 전체 Block
		int perBlock=5;
		totalBlock=0;
		if(totalPage%perBlock==0){
			totalBlock=totalPage/perBlock;
		}else {
			totalBlock=totalPage/perBlock+1;
		}
		//4. curBlock
		curBlock=0;
		if(curPage%perBlock==0){
			curBlock=curPage/perBlock;
		}else {
			curBlock=curPage/perBlock+1;
		}
		//5. startNum, lastNum
		startNum=(curBlock-1)*perBlock+1;
		lastNum = curBlock*perBlock;
		
		//
		if(curBlock==totalBlock){
			lastNum = totalPage;
		}
	}
	
	
	
	
	public int getCurPage() {
		return curPage;
	}



	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}



	public int getPerPage() {
		return perPage;
	}



	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}



	public int getStartRowNum() {
		return startRowNum;
	}
	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}
	public int getLastLowNum() {
		return lastLowNum;
	}
	public void setLastLowNum(int lastLowNum) {
		this.lastLowNum = lastLowNum;
	}
	public int getCurBlock() {
		return curBlock;
	}
	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}
	public int getTotalBlock() {
		return totalBlock;
	}
	public void setTotalBlock(int totalBlock) {
		this.totalBlock = totalBlock;
	}
	public int getStartNum() {
		return startNum;
	}
	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}
	public int getLastNum() {
		return lastNum;
	}
	public void setLastNum(int lastNum) {
		this.lastNum = lastNum;
	}
	
	
	

}

