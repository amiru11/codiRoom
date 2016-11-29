package com.basic.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentService {

	@Autowired
	private CommentDAO commentDAO;
	
	//댓글리스트//
	public String commentList(BoardDTO boardDTO){
		commentDAO.commentList(boardDTO);
		return null;
	}
	//댓글작성//
	public String commentWrite(CommentDTO commentDTO){
		commentDAO.commentWrite(commentDTO);
		return "";
	}
	//댓글수정//
	public String commentUpdate(CommentDTO commentDTO){
		commentDAO.commentUpdate(commentDTO);
		return "";
	}
	//댓글삭제//
	public String commentDelete(int comm_num){
		commentDAO.commentDelete(comm_num);
		return "";
	}
}
