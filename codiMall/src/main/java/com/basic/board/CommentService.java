package com.basic.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

@Service
public class CommentService {

	@Autowired
	private CommentDAO commentDAO;
	
	//댓글리스트 -> 보드뷰에서 들어가야 제대로 작동된다!!
	public void commentList(BoardDTO boardDTO,Model model) throws Exception{
		System.out.println("댓글리스트");
		List<CommentDTO> ar = commentDAO.commentList(boardDTO);
		model.addAttribute("comment", ar);
	}
	//댓글작성//
	public String commentWrite(CommentDTO commentDTO) throws Exception{
		System.out.println("댓글작성");
		int result = 0;
		String message = "";
		result = commentDAO.commentWrite(commentDTO);
		
		if(result >0){
			message = "작성완료";
		}else{
			message = "작성실패";
		}
		
		
		return message;
	}
	//댓글수정//
	public String commentUpdate(CommentDTO commentDTO) throws Exception{
		System.out.println("댓글수정");
		int result = 0;
		String message = "";
		result = commentDAO.commentUpdate(commentDTO);
		
		if(result >0){
			message = "수정완료";
		}else{
			message = "수정실패";
		}
		System.out.println(message);
		return message;
	}
	//댓글삭제//
	public String commentDelete(int comm_num) throws Exception{
		System.out.println("댓글삭제");
		int result = 0;
		String message = "";
		result = commentDAO.commentDelete(comm_num);
	
		if(result >0){
			message = "삭제완료";
		}else{
			message = "삭제실패";
		}
		return message;
	}
}
