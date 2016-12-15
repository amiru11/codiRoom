package com.basic.codi;

import java.io.File;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.board.BoardDTO;
import com.basic.board.BoardFileDTO;
import com.basic.board.BoardService;
import com.basic.board.CommentDTO;
import com.basic.board.CommentService;
import com.basic.board.PhotoDTO;


@Controller
@RequestMapping(value="/board")
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private CommentService commentService;
	
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
	
	//댓글쓰기//
	@RequestMapping(value="/commentWrite")
	public String commentWrite(CommentDTO commentDTO, Model model){
		try {
			String message = commentService.commentWrite(commentDTO);
			
			model.addAttribute("message", message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board/commentResult";
	}
	
	//댓글수정//
	@RequestMapping(value="/commentUpdate")
	public String commentUpdate(CommentDTO commentDTO, Model model){
		try {
			String message = commentService.commentUpdate(commentDTO);
			model.addAttribute("message", message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board/commentResult";
	}
	//댓글삭제//
	@RequestMapping(value="/commentDelete")
	public String commentDelete(int comm_num, Model model){
		try {
			String message = commentService.commentDelete(comm_num);
			model.addAttribute("message", message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board/commentResult";
	}
	//글쓰기폼//
	@RequestMapping(value = "/boardWrite", method=RequestMethod.GET)
	public String boardWriteForm(int board_kind,Model model){
		System.out.println("WRITEFORM");
		model.addAttribute("board_kind", board_kind);
		return "board/boardWrite";
	}

	//상품QNA//
	@RequestMapping(value="/qnaWrite", method=RequestMethod.GET)
	public String qnaWrite(BoardDTO boardDTO, Model model){
		
		try {
			String message = boardService.pQnAWrite(boardDTO);
			System.out.println("BOARD WRITE");
			model.addAttribute("message", message);		
		} catch (Exception e) {

			e.printStackTrace();
		}
		
		return "/board/writeResult";
		
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
	
	//QNA수정//
	@RequestMapping(value="/qnaUpdate")
	public String qnaMod(BoardDTO boardDTO, int board_kind, @RequestParam(value="checkNum") int checkNum, @RequestParam(required = false) ArrayList<Integer> bFile_num, RedirectAttributes ra, MultipartHttpServletRequest mr, HttpSession session){
		String message = "";
		try {
			message = boardService.qnaUpdate(boardDTO, board_kind, checkNum, bFile_num, mr, session);
/*			System.out.println("QNA MOD");
			System.out.println("글 번호 : " + boardDTO.getBoard_num());
			System.out.println("글 수정 : " + message);*/
			ra.addFlashAttribute("message", message);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/board/boardView?board_num="+boardDTO.getBoard_num()+"&board_kind="+board_kind;
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
		return "redirect:/board/boardView?board_num="+boardDTO.getBoard_num()+"&board_kind="+board_kind;
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
	
	
	//SMART EDITOR//
	@RequestMapping(value="/fileUpload")
	public String fileUpload(PhotoDTO photoDTO, HttpSession session){
		String callback = photoDTO.getCallback();
		String callback_func = photoDTO.getCallback_func();
		String file_result = "";
		try {
		if(photoDTO.getFiledata() != null && photoDTO.getFiledata().getOriginalFilename() != null && !photoDTO.getFiledata().getOriginalFilename().equals("")){
			//파일이 존재하면
			
			//파일명
			String original_name = photoDTO.getFiledata().getOriginalFilename();
			//확장자를 찾는 구간
			String ext = original_name.substring(original_name.lastIndexOf(".")+1);
			//파일 기본 경로
			String defaultPath = session.getServletContext().getRealPath("/");
			//파일 상세경로
			String path = defaultPath + "resources" + File.separator + "upload"; //separator는 구분자!!
			
			File file = new File(path);
			
			//디렉토리 존재하지 않을 경우, 디렉토리 생성
			if(!file.exists()){
				file.mkdirs();
			}
			//서버에 업로드 할 파일명
			String realName = UUID.randomUUID().toString() + "." + ext;//기존이름을 버리고 랜덤이름을 붙여서 새로운 이름을 만들어줌
			
			//서버에 파일쓰기//
			
				photoDTO.getFiledata().transferTo(new File(path+realName));
				file_result += "&bNewLine=true&sFileName=" + original_name + "&sFileURL=/codi/resources/upload" + realName;
			
			}else{
				file_result += "&errstr=error";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:" + callback + "?callback_func=" + callback_func + file_result;
	}
	
	@RequestMapping(value="/productQnAList")
	public String findList(@RequestParam(defaultValue="") String type, @RequestParam(defaultValue="") String find, @RequestParam(defaultValue="1") int curPage, 
			@RequestParam(defaultValue="10") int perPage, @RequestParam(defaultValue="4") int board_kind, @RequestParam int product_num,  Model model){
		
		try {
			boardService.findList(type, find, curPage, perPage, board_kind, product_num, model);
			System.out.println("product QnA");
			System.out.println("BOARD KIND : " +board_kind);
			System.out.println("productNum : " + product_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board/productQnAResult";

	}
	
	@RequestMapping(value="/productQnAComment")
	public String pComm(@RequestParam int board_num, Model model){
		
		try {
			boardService.pcommList(board_num, model);
			System.out.println("product Comment");
			System.out.println("boardNUM : " +board_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "board/QnAResult";
	}
	
	
}
