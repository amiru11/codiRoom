package com.basic.mast;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.basic.board.BoardDAO;
import com.basic.board.BoardDTO;
import com.basic.util.PageMaker;


@Service
public class MastService {
	
	@Autowired
	private MastDAO mastDAO;
	
	@Autowired
	private BoardDAO boardDAO;
	
	
	public List<MastBuyListDTO> mastBuyList(int state_num){
		return mastDAO.mastBuyList(state_num);
	}
	
	public int mastUpState(int buy_num,int buyState_state,Integer buyState_expressNum){
		return mastDAO.mastUpState(buy_num, buyState_state, buyState_expressNum);
	}
	
	
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
}
