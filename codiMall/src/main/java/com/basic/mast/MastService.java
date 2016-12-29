package com.basic.mast;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.basic.board.BoardDAO;
import com.basic.board.BoardDTO;
import com.basic.product.ProductDAO;
import com.basic.product.ProductDTO;
import com.basic.product.ProductListDTO;
import com.basic.review.ReviewDAO;
import com.basic.review.ReviewDTO;
import com.basic.util.PageMaker;


@Service
public class MastService {
	
	@Autowired
	private MastDAO mastDAO;
	
	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired
	private ProductDAO productDAO;
	
	
	public List<MastBuyListDTO> mastBuyList(int state_num){
		return mastDAO.mastBuyList(state_num);
	}
	
	public int mastUpState(int buy_num,int buyState_state,Integer buyState_expressNum){
		return mastDAO.mastUpState(buy_num, buyState_state, buyState_expressNum);
	}
	
	
	//검색//
	
	public void findList( int productGroup,String type, String find, int curPage, int perPage, int board_kind, Model model) throws Exception{
		System.out.println("FINDLIST");
		ReviewDTO reviewDTO= new ReviewDTO();
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCurPage(curPage);
		pageMaker.setPerPage(perPage);
		pageMaker.makeRow();
		List<BoardDTO> ar;
		List<BoardDTO> br;
		List<ProductDTO> ar1;
		if(board_kind ==4){
			System.out.println("관리자 상품리스트");
			System.out.println("curPage :"+curPage);
			pageMaker.makePage(productDAO.mastProductBoardCount(productGroup));
			ar1=productDAO.mastProductBoard(pageMaker, productGroup);
			for(int i=0; i<ar1.size();i++){
				System.out.println("상품페이지리스트 :"+ar1.get(i).getProduct_num());
			}
			System.out.println("관리자 상품리스트개수"+productDAO.mastProductBoardCount(productGroup));
			model.addAttribute("list", ar1);
			model.addAttribute("paging", pageMaker);
			model.addAttribute("productGroup", productGroup);
		}else{	
			System.out.println("curPage :"+curPage);
			ar = boardDAO.findList(type, find, board_kind, pageMaker);
			pageMaker.makePage(boardDAO.boardCount(board_kind));
			model.addAttribute("type", type);
			model.addAttribute("find", find);
			model.addAttribute("list", ar);
			model.addAttribute("paging", pageMaker);
		}
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
		}else if(board_kind==4){
			model.addAttribute("boardName", "REVIEW");
		}
	}	
}
