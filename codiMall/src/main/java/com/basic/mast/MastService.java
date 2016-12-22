package com.basic.mast;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.basic.board.BoardDAO;
import com.basic.board.BoardDTO;
import com.basic.board.CommentDAO;
import com.basic.board.CommentDTO;
import com.basic.util.PageMaker;


@Service
public class MastService {
	
	@Autowired
	private MastDAO mastDAO;
	
	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired
	private CommentDAO commentDAO;
	
	
	
	public List<MastBuyListDTO> mastBuyList(int state_num){
		return mastDAO.mastBuyList(state_num);
	}
	
	public int mastUpState(int buy_num,int buyState_state,Integer buyState_expressNum){
		return mastDAO.mastUpState(buy_num, buyState_state, buyState_expressNum);
	}
	
	
	
	
	
	
	
	
	
	
	
	
//////////////////////////////////////////////////////////////게시판/////////////////////////////////////////////////////////////	
	//검색//
	
	public void findList(String type, String find, int curPage, int perPage, int board_kind, Model model) throws Exception{
		System.out.println("FINDLIST");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCurPage(curPage);
		pageMaker.setPerPage(perPage);
		pageMaker.makeRow();
		pageMaker.makePage(boardDAO.boardCount(board_kind));
		List<BoardDTO> ar;
		List<BoardDTO> br;
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
			//BEST 5//
			br = boardDAO.bestList();
			for(int i = 0; i<br.size();i++){
				System.out.println("bestTITLE : "+br.get(i).getBoard_title());
			}
			model.addAttribute("bestList", br);
		}else if(board_kind==3){
			model.addAttribute("boardName", "QNA");
		}
	}	
	
	//뷰//
	public BoardDTO boardView(BoardDTO boardDTO, int board_kind, Model model) throws Exception {
		
		boardDTO = boardDAO.boardView(boardDTO,board_kind);
		boardDAO.boardViewUpdate(boardDTO);
		
		List<CommentDTO> cr = commentDAO.commentList(boardDTO);
		
		model.addAttribute("view", boardDTO);
		if(board_kind==3){//QNA			
			model.addAttribute("fileView", boardDAO.fileView(boardDTO));//이미지파일도 뷰에서 같이 보기위해서
			model.addAttribute("commentList", cr);//해당뷰에서 필요한 댓글리스트 불러오기
		}
		return boardDTO;
	}
	
	
}
