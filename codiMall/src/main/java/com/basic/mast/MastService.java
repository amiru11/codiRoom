package com.basic.mast;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.basic.board.BoardDAO;
import com.basic.board.BoardDTO;
import com.basic.board.CommentDAO;
import com.basic.board.CommentDTO;
import com.basic.member.MemberDTO;
import com.basic.product.ProductAllDTO;
import com.basic.product.ProductSelectDTO;
import com.basic.product.ProductSizeDTO;
import com.basic.util.PageMaker;

@Service
public class MastService {

	@Autowired
	private MastDAO mastDAO;

	@Autowired
	private BoardDAO boardDAO;

	@Autowired
	private CommentDAO commentDAO;
	//mast kind add SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
	public int mastKindAdd(String kind_name,int productSelect_num) {
		return mastDAO.mastKindAdd(kind_name,productSelect_num);
	}
	//mast kind add EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
	
	
	
	// mast product Add SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

	public int mastProductAdd(MastProductAddParamDTO paramDTO,HttpSession session) {
		return mastDAO.mastProductAdd(paramDTO, session);
	}

	// mast product Add EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
	
	//mast product Pic fixSSSSSSSSSS
	public int mastProductPicFix(HttpSession session,MultipartHttpServletRequest mr) {
		return mastDAO.mastProductPicFix(session, mr);
	}
	//mast product Pic fix EEEEEEEEEEEEEEEEEEEEEEEEEE
	
	

	public List<ProductAllDTO> mastProductList(Map<String, Object> map, Model model) {
		PageMaker pageMaker = new PageMaker();
		int totalCount = mastDAO.mastProductCount(map);
		pageMaker.setCurPage((int) map.get("curPage"));
		pageMaker.setPerPage((int) map.get("perPage"));
		pageMaker.makeRow();
		pageMaker.makePage(totalCount);
		System.out.println("service totalcount" + totalCount);
		model.addAttribute("productSelectList", mastDAO.mastProductSelectList());
		model.addAttribute("kindList", mastDAO.mastKindList());
		model.addAttribute("productList", mastDAO.mastProductList());
		model.addAttribute("productSizeList", mastDAO.mastProductSizeList());
		model.addAttribute("productColorList", mastDAO.mastProductColorList());

		model.addAttribute("pageing", pageMaker);
		model.addAttribute("map", map);
		return mastDAO.mastProductList(map, pageMaker);
	}

	public List<ProductSizeDTO> mastProductViewSizeList(int product_num) {
		return mastDAO.mastProductViewSizeList(product_num);
	}

	// mast productSize add ====================

	public int mastProductSizeAdd(int product_num, String productSize_size) {
		return mastDAO.mastProductSizeAdd(product_num, productSize_size);
	}

	public int mastProductEachAdd(int product_num, String productSize_size, String productEach_color,
			int productEach_each) {
		return mastDAO.mastProductEachAdd(product_num, productSize_size, productEach_color, productEach_each);
	}

	// mast ProductList Each 0 sssssssssssssss ---------------------------------
	public void mastProductListEach0(Model model) {
		model.addAttribute("list", mastDAO.mastProductListEach0());
	}

	// mast ProductList Each 0 eeeeeeeeee---------------------------------

	public MastProductViewDTO mastProductAllInfo(int product_num) {
		return mastDAO.mastProductAllInfo(product_num);
	}

	public List<MastBuyListDTO> mastBuyList(int state_num) {
		return mastDAO.mastBuyList(state_num);
	}

	public int mastUpState(int buy_num, int buyState_state, Integer buyState_expressNum) {
		return mastDAO.mastUpState(buy_num, buyState_state, buyState_expressNum);
	}

	public int mastProductEachFix(int product_num, String productSize_size, String productEach_color,
			int productEach_each) {
		return mastDAO.mastProductEachFix(product_num, productSize_size, productEach_color, productEach_each);
	}
	
	public List<ProductSelectDTO> mastProductSelectList(){
		return mastDAO.mastProductSelectList();
	}

	////////////////////////////////////////////////////////////// 게시판/////////////////////////////////////////////////////////////
	// 검색//

	public void findList(String type, String find, int curPage, int perPage, int board_kind, Model model)
			throws Exception {
		System.out.println("FINDLIST");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCurPage(curPage);
		pageMaker.setPerPage(perPage);
		pageMaker.makeRow();
		pageMaker.makePage(boardDAO.boardCount(board_kind));
		List<BoardDTO> ar;
		// List<BoardDTO> br;
		ar = boardDAO.findList(type, find, board_kind, pageMaker);
		model.addAttribute("type", type);
		model.addAttribute("find", find);
		model.addAttribute("paging", pageMaker);
		model.addAttribute("list", ar);
		model.addAttribute("board_kind", board_kind);

		if (board_kind == 1) {
			model.addAttribute("boardName", "NOTICE");
		} else if (board_kind == 2) {
			model.addAttribute("boardName", "FAQ");
			// BEST 5//
			/*
			 * br = boardDAO.bestList(); for(int i = 0; i<br.size();i++){
			 * System.out.println("bestTITLE : "+br.get(i).getBoard_title());
			 * 
			 * }
			 * 
			 * model.addAttribute("bestList", br); } else if (board_kind == 3) {
			 * 
			 * model.addAttribute("bestList", br);
			 */
		} else if (board_kind == 3) {

			model.addAttribute("boardName", "QNA");
		}
	}

	// 뷰//
	public BoardDTO boardView(BoardDTO boardDTO, int board_kind, Model model) throws Exception {

		boardDTO = boardDAO.boardView(boardDTO, board_kind);
		// boardDAO.boardViewUpdate(boardDTO);

		List<CommentDTO> cr = commentDAO.commentList(boardDTO);

		model.addAttribute("view", boardDTO);
		if (board_kind == 3) {// QNA
			model.addAttribute("fileView", boardDAO.fileView(boardDTO));// 이미지파일도
			// 뷰에서
			// 같이
			// 보기위해서
			model.addAttribute("commentList", cr);// 해당뷰에서 필요한 댓글리스트 불러오기
		}
		return boardDTO;
	}

	// 등록//

	public String boardWrite(BoardDTO boardDTO, int board_kind) throws Exception {
		int result = 0;
		System.out.println("WRITE");
		result = boardDAO.boardWrite(boardDTO, board_kind);
		System.out.println("BOARD NUM : " + board_kind);
		String message = "";
		if (result > 0) {
			message = "등록완료!";
		} else {
			message = "등록실패!";
		}

		System.out.println("결과 : " + message);
		return message;
	}

	// 삭제//
	public String boardDel(int board_num, int board_kind) throws Exception {
		int result = 0;
		result = boardDAO.boardDel(board_num, board_kind);
		String message = "";
		if (result > 0) {
			message = "삭제완료!";
		} else {
			message = "삭제실패!";
		}
		return message;
	}

	// 수정//

	// QNA답글 리스트//
	public void mastCommList(int board_num, Model model) throws Exception {// 답글버튼
																			// 클릭시
																			// refNum을
																			// 받아서
																			// 리스트를
																			// 모달에다가
																			// 뿌려주기
		System.out.println("service");
		System.out.println("commList");
		System.out.println("board_num : " + board_num);
		List<CommentDTO> cr = commentDAO.mastCommentList(board_num);
		for (int i = 0; i < cr.size(); i++) {
			System.out.println(cr.get(i).getComm_num());
		}
		model.addAttribute("commentList", cr);
	}

	////////////////////////////////////////////////////// 회원관리////////////////////////////////////////////////////////

	// 검색과 리스트//
	public void findMemberList(String type, String find, int curPage, int perPage, Model model) throws Exception {
		System.out.println("FINDMEMBERLIST");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCurPage(curPage);
		pageMaker.setPerPage(perPage);
		pageMaker.makeRow();
		pageMaker.makePage(mastDAO.memberCount());
		List<MemberDTO> ar;

		ar = mastDAO.findList(type, find, pageMaker);
		model.addAttribute("type", type);
		model.addAttribute("find", find);
		model.addAttribute("paging", pageMaker);
		model.addAttribute("list", ar);

	}

	// 회원삭제//
	public String memberDelete(String id) throws Exception {
		int result = 0;
		result = mastDAO.memberDelete(id);
		String message = "";
		if (result > 0) {
			message = "삭제완료!";
		} else {
			message = "삭제실패!";
		}
		return message;
	}

}
