package com.basic.freeboard;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.basic.board.BoardDAO;
import com.basic.board.BoardDTO;
import com.basic.util.PageMaker;

@Repository
public class FreeboardDAO implements BoardDAO {

	@Autowired
	private SqlSession sqlSession;
	private String namespace="FreeboardMapper.";
	
	
	//글보기//
	@Override
	public BoardDTO boardView(BoardDTO boardDTO) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+"boardView", boardDTO);
	}
	
	//뷰에서 파일 보기//
	public List<FileDTO> fileView(BoardDTO boardDTO) throws Exception {
		
		return sqlSession.selectList(namespace+"fileView", boardDTO);
	}
	
	
	//게시글 리스트//
	@Override
	public List<BoardDTO> boardList(PageMaker pageMaker) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+"boardList", pageMaker);
	}

	
	//글쓰기//
	@Override
	public int boardWrite(BoardDTO boardDTO, ArrayList<String> fileNames) throws Exception {
		// TODO Auto-generated method stub
		//file등록의 방법은 2가지!! 맵 OR DTO !!!!!!!
		int result = sqlSession.insert(namespace+"boardWrite", boardDTO);
		int fileNum = sqlSession.selectOne(namespace+"fileNum");//fileNum을 가져온다
		Map<String, Object> data = new HashMap<String, Object>();//fileDB에 등록해줄 맵을 만들어준다//
		
		for(int i=0;i<fileNames.size();i++){
			data.put("refNum", fileNum);
			data.put("fileName", fileNames.get(i));
			System.out.println("파일 이름 : " + fileNames.get(i));
			sqlSession.insert(namespace+"fileWrite", data);
		}
		return result;
	}

	//수정하기//
	@Override
	public int boardUpdate(BoardDTO boardDTO, ArrayList<String> fileNames) throws Exception {
		
		int result = sqlSession.update(namespace+"boardUpdate", boardDTO);
		System.out.println("게시글 번호 : " + boardDTO.getNum());
		Map<String, Object> data = new HashMap<String, Object>();//fileDB에 등록해줄 맵을 만들어준다//
		int refNum = boardDTO.getNum();
		
		//파일을 수정하지 않는 경우에는? 그대로 가야한다//
		for(int i=0;i<fileNames.size();i++){
			data.put("refNum", refNum);
			data.put("fileName", fileNames.get(i));
			System.out.println("파일 이름 : " + fileNames.get(i));
			sqlSession.update(namespace+"fileUpdate", data);
		}
		
		return result;
	}

	@Override
	public int boardDelete(int num) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+"boardDelete", num);
	}

	@Override
	public int boardCount() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+"boardCount");
	}

}
