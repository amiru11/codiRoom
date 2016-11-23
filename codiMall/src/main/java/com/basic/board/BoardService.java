package com.basic.board;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartRequest;

public interface BoardService {
	
	//맵핑을 여기서 할껀지, 컨트롤러에서 할껀지 생각해야한다!
	
	//view//
	public BoardDTO boardView(BoardDTO boardDTO) throws Exception;
	
	//insert//
	public int boardWrite(BoardDTO boardDTO, MultipartRequest mr, HttpSession session) throws Exception;
	
	//update//
	public int boardUpdate(BoardDTO boardDTO, MultipartRequest mr, HttpSession session) throws Exception;
	
	//delete//
	public int boardDelete(int num) throws Exception;
	
	//list//
	public void boardList(int curPage, int perPage, Model model) throws Exception;
	
	
	
	
}
