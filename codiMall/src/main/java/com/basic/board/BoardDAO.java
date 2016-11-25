package com.basic.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.basic.util.PageMaker;

@Repository
public class BoardDAO {

	@Autowired
	private SqlSession sqlSession;
	
	private List<BoardDTO> ar;
	private BoardDTO boardDTO;
	private String namespace1="NoticeMapper.";
	private String namespace2="FAQMapper.";//mapper.xml의 namespace와 일치시켜줘야한다!!
	
	
	//글쓰기//
	public int boardWrite(BoardDTO boardDTO,int board_kind) throws Exception{
		int result = 0;
		if(board_kind==1){
			result = sqlSession.insert(namespace1+"boardWrite",boardDTO);
		}else if(board_kind==2){
			result = sqlSession.insert(namespace2+"boardWrite",boardDTO);
		}
		return result;
	};

	//글수정//
	public int boardMod(BoardDTO boardDTO,int board_kind) throws Exception{
		int result = 0;
		if(board_kind==1){
			result = sqlSession.update(namespace1+"boardUpdate",boardDTO);
		}else if(board_kind==2){
			result = sqlSession.update(namespace2+"boardUpdate",boardDTO);			
		}
		return result;
	};

	//글삭제//
	public int boardDel(int num,int board_kind) throws Exception{
		int result = 0;
		if(board_kind==1){
			result = sqlSession.delete(namespace1+"boardDelete",num);
		}else if(board_kind==2){
			result = sqlSession.delete(namespace2+"boardDelete",num);			
		}
		return result;
	};

	//글보기//
	public BoardDTO boardView(int num, int board_kind) throws Exception{
		System.out.println("BOARDDAO.VIEW");
		if(board_kind==1){
			boardDTO = sqlSession.selectOne(namespace1+"boardView", num);			
		}else if(board_kind==2){
			boardDTO = sqlSession.selectOne(namespace1+"boardView", num);
			
		}
		return boardDTO;
	};

	//리스트//
	public List<BoardDTO> boardList(String type, String find, PageMaker pageMaker, int board_kind) throws Exception{
		System.out.println("BOARDDAO.LIST");
		if(board_kind==1){			
			System.out.println(namespace1);
			ar = sqlSession.selectList(namespace1+"boardList", pageMaker);
		}else if(board_kind==2){
			System.out.println(namespace2);
			ar = sqlSession.selectList(namespace2+"boardList", pageMaker);			
		}
		return ar;
	};
	
	//페이징시 글의 총개수세기//
	public int boardCount(int board_kind){
		int result = 0;
		System.out.println("boardCount :" + board_kind);
		if(board_kind==1){
			result = sqlSession.selectOne(namespace1+"boardCount");
		}else if(board_kind==2){
			result = sqlSession.selectOne(namespace2+"boardCount");
			System.out.println(namespace2 +"count");
		}
		
		return result;
	};

	//답글쓰기//
/*	public int boardReply(BoardDTO boardDTO,int board_kind) throws Exception{
		int result1 = 0;
		int result2 = 0;
		if(board==1){			
			result1 = sqlSession.update(namespace1+"boardReply1", boardDTO);
			result2 = sqlSession.insert(namespace1+"boardReply2", boardDTO);
		}else{
			result1 = sqlSession.update(namespace2+"boardReply1", boardDTO);
			result2 = sqlSession.insert(namespace2+"boardReply2", boardDTO);
		}
		System.out.println("REPLY UP : " + result1);
		System.out.println("REPLY WRITE : " + result2);
		return result2;	
	};*/

	//뷰업데이트//
	public void boardViewUpdate(BoardDTO boardDTO) throws Exception{
		sqlSession.update(namespace1+"boardViewUpdate", boardDTO);
	};
	
	//검색//
	public List<BoardDTO> findList(String type, String find, int board_kind,PageMaker pageMaker) throws Exception{
		Map<String, Object> mp = new HashMap<String, Object>();
		mp.put("type", type);
		mp.put("find", "%"+find+"%");
		mp.put("paging", pageMaker);
		if(board_kind==1){			
			ar = sqlSession.selectList(namespace1+"findList", mp);
		}else if(board_kind==2){
			ar = sqlSession.selectList(namespace2+"findList", mp);
		}
		return ar;
		
	}
}
