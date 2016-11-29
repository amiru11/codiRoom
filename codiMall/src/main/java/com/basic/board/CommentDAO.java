package com.basic.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommentDAO {

	@Autowired
	private SqlSession sqlsession;
	private String namespace = "CommentMapper.";
	
	//리스트//
	public List<CommentDTO> commentList(BoardDTO boardDTO){//게시물에 대한 참조번호가 필요하기때문에 파라미터로 boardDTO를 받아온다
		return sqlsession.selectList(namespace+"commentList", boardDTO);
	}
	//댓글쓰기//
	public int commentWrite(CommentDTO commentDTO){
		return sqlsession.insert(namespace+"commentWrite", commentDTO);
	}
	//댓글수정//
	public int commentUpdate(CommentDTO commentDTO){
		return sqlsession.update(namespace+"commentUpdate", commentDTO);
	}
	//댓글삭제//
	public int commentDelete(int comm_num){
		return sqlsession.delete(namespace+"commentDelete", comm_num);
	}
}
