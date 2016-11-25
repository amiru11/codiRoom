package com.basic.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.basic.board.BoardDAO;
import com.basic.util.PageMaker;

@Service
public class BoardService {

	@Autowired
	private BoardDAO boardDAO;	
	
	//등록//
	
	public String boardWrite(BoardDTO boardDTO,int board_kind) throws Exception {
		int result = 0;
		System.out.println("WRITE");
		result = boardDAO.boardWrite(boardDTO, board_kind);
		System.out.println("BOARD NUM : "+board_kind);
		String message = "";
		if(result > 0){
			message = "등록완료!";
		}else{
			message = "등록실패!";
		}
		
		System.out.println("결과 : "+message);
		return message;
	}
	
	//수정//
	
	public String boardMod(BoardDTO boardDTO,int board_kind) throws Exception {
		int result = 0;
		
		result = boardDAO.boardMod(boardDTO,board_kind);
		
		String message = "";
		if(result > 0){
			message = "수정완료!";
		}else{
			message = "수정실패!";
		}
		return message;		
		
	}

	//삭제//
	
	public String boardDel(int board_num,int board_kind) throws Exception {
		int result = 0;		
		result = boardDAO.boardDel(board_num,board_kind);
		String message = "";
		if(result > 0){
			message = "삭제완료!";
		}else{
			message = "삭제실패!";
		}
		return message;		
	}
	
	//뷰//
	
	public BoardDTO boardView(int board_num, int board_kind, Model model) throws Exception {
		
		BoardDTO boardDTO = boardDAO.boardView(board_num,board_kind);
		boardDAO.boardViewUpdate(boardDTO);
		
		model.addAttribute("view", boardDTO);
		return boardDTO;
	}
	
	//리스트//
	
	public void boardList(String type, String find, int curPage, int perPage, int board_kind, Model model){
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCurPage(curPage);
		pageMaker.setPerPage(perPage);
		pageMaker.makeRow();
		pageMaker.makePage(boardDAO.boardCount(board_kind));
		List<BoardDTO> ar;
		try {
			ar = boardDAO.findList(type, find, board_kind, pageMaker);
			System.out.println("boardNum : "+board_kind);
			System.out.println("검색종류 : "+type);
			System.out.println("검색어 : "+find);
			System.out.println("curPage : "+pageMaker.getCurPage());
			System.out.println("perPage : "+pageMaker.getPerPage());
			System.out.println("시작숫자 : "+pageMaker.getStartRowNum());
			System.out.println("마지막 숫자 : "+pageMaker.getLastLowNum());
			System.out.println("글의 총 갯수 : "+boardDAO.boardCount(board_kind));
			for(int i = 0; i<ar.size();i++){
				System.out.println("TITLE : "+ar.get(i).getBoard_title());
			}
			model.addAttribute("list", ar);
			model.addAttribute("paging", pageMaker);
			model.addAttribute("board", board_kind);
			if(board_kind==1){				
				model.addAttribute("boardName", "NOTICE");
			}else if(board_kind==2){
				model.addAttribute("boardName", "FAQ");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//답글//
	
/*	public String boardReply(BoardDTO boardDTO,int board) throws Exception {
		int result = 0;
		result = boardDAO.boardReply(boardDTO,board);
		String message = "";
		if(result > 0){
			message = "답글등록완료!";
		}else{
			message = "답글등록실패!";
		}
		return message;	
	}*/

	//검색//
	
	public void findList(String type, String find, int curPage, int perPage, int board_kind, Model model) throws Exception{
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCurPage(curPage);
		pageMaker.setPerPage(perPage);
		pageMaker.makeRow();
		pageMaker.makePage(boardDAO.boardCount(board_kind));
		List<BoardDTO> ar;
		
		ar = boardDAO.findList(type, find, board_kind, pageMaker);
		model.addAttribute("type", type);
		model.addAttribute("find", find);
		model.addAttribute("paging", pageMaker);
		model.addAttribute("list", ar);
		model.addAttribute("board_kind", board_kind);
		
		if(board_kind==1){				
			model.addAttribute("boardName", "NOTICE");
		}else if(board_kind==2){
			model.addAttribute("boardName", "FAQ");
		}
	}
	
}
