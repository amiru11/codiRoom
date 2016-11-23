package com.basic.board;

import java.util.ArrayList;
import java.util.List;

import com.basic.util.PageMaker;

public interface BoardDAO {

	
	
	//view//
	public BoardDTO boardView(BoardDTO boardDTO) throws Exception;
	
	//list//
	public List<BoardDTO> boardList(PageMaker pageMaker) throws Exception;
	
	//insert//
	public int boardWrite(BoardDTO boardDTO,ArrayList<String> fileNames) throws Exception;
	
	//update//
	public int boardUpdate(BoardDTO boardDTO,ArrayList<String> fileNames) throws Exception;
	
	//delete//
	public int boardDelete(int num) throws Exception;
	
	//count//
	public int boardCount() throws Exception;
	//검색할 때 counting하는걸 생각해봐야한다!!
	
	
}
