package com.basic.codi;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.board.BoardDTO;
import com.basic.board.BoardService;


@Controller
@RequestMapping(value="/board")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	//리스트//
	@RequestMapping(value="/boardList")
	public String boardList(@RequestParam String type, @RequestParam String find,@RequestParam(defaultValue="1") int curPage, @RequestParam(defaultValue="10") int perPage, @RequestParam int board, Model model){
		try {
			boardService.boardList(type, find, curPage, perPage, board, model);
			System.out.println("BOARD CONTROLLER");
			System.out.println("BOARD NUM : " +board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board/boardList";
	}
	//글쓰기폼//
	@RequestMapping(value = "/boardWrite", method=RequestMethod.GET)
	public String boardWriteForm(int board_kind,Model model){
		System.out.println("WRITEFORM");
		model.addAttribute("board_kind", board_kind);
		return "board/boardWrite";
	}

	//글쓰기//
	@RequestMapping(value="/boardWrite")
	public String boardWrite(BoardDTO boardDTO, int board_kind, RedirectAttributes ra){
		try {
			String message = boardService.boardWrite(boardDTO, board_kind);
			System.out.println("BOARD WRITE");
			System.out.println("BOARD NUM : " +board_kind);
			ra.addFlashAttribute("message", message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/board/findList?board_kind="+board_kind;
	}
	
	//QNA글쓰기//
	@RequestMapping(value="/qnaWrite")
	public String qnaWrite(BoardDTO boardDTO, int board_kind, RedirectAttributes ra, MultipartHttpServletRequest mr, HttpSession session){
		try {
			String message = boardService.qnaWrite(boardDTO, board_kind, mr, session);
			System.out.println("BOARD WRITE");
			System.out.println("BOARD NUM : " +board_kind);
			ra.addFlashAttribute("message", message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/board/findList?board_kind="+board_kind;
	}	
	
	//QNA뷰//
	@RequestMapping(value="/qnaView")
	public String qnaView(BoardDTO boardDTO, int board_kind, Model model){
		try {
			System.out.println("QNA VIEW");
			boardService.boardView(boardDTO, board_kind, model);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board/boardView";
	}
	
	//글보기//
	@RequestMapping(value="/boardView")
	public String boardView(BoardDTO boardDTO, int board_kind, Model model){
		try {
			boardService.boardView(boardDTO, board_kind, model);
			System.out.println("BOARD VIEW");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board/boardView";
	}

	//수정//
	@RequestMapping(value="/boardUpdate")
	public String boardMod(BoardDTO boardDTO, int board_kind, RedirectAttributes ra){
		try {
			String message = boardService.boardMod(boardDTO,board_kind);
			System.out.println("FREEBOARD MOD");
			System.out.println("글 번호 : " + boardDTO.getBoard_num());
			System.out.println("글 수정 : " + message);
			ra.addFlashAttribute("message", message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/board/boardView?num="+boardDTO.getBoard_num()+"&board_kind="+board_kind;
	}
	//삭제//
	@RequestMapping(value="/boardDelete")
	public String boardDel(int board_num, int board_kind, RedirectAttributes ra){
		try {
			String message = boardService.boardDel(board_num,board_kind);
			System.out.println("BOARD DEL");
			System.out.println("글 삭제 : " + message);
			ra.addFlashAttribute("message", message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/board/findList?board_kind="+board_kind;
	}
	//답글//
/*	@RequestMapping(value="/boardReply")
	public String boardReply(BoardDTO boardDTO, int board,RedirectAttributes ra){
		try {
			String message = boardService.boardReply(boardDTO,board);
			System.out.println("BOARD REPLY");
			System.out.println("답글 등록 : " + message);
			ra.addFlashAttribute("message", message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/board/boardList?board="+board;
	}*/
	
	//검색//
	@RequestMapping(value="/findList")
	public String findList(@RequestParam(defaultValue="") String type, @RequestParam(defaultValue="") String find, @RequestParam(defaultValue="1") int curPage, 
											@RequestParam(defaultValue="10") int perPage, @RequestParam int board_kind, Model model){
		//검색조건중 하나가 오는데 어떤게 올지 몰른다 HOW?//
		try {
			boardService.findList(type, find, curPage, perPage, board_kind, model);
			System.out.println("BOARD SEARCH");
			System.out.println("BOARD KIND : " +board_kind);
			System.out.println("TYPE : "+type);
			System.out.println("FIND : "+find);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board/boardList";
		
	}
}
