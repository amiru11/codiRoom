package com.basic.board;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

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
	
	//QNA등록//
	public String qnaWrite(BoardDTO boardDTO,int board_kind, MultipartRequest mr, HttpSession session) throws Exception {
		int result = 0;
		System.out.println("QNA WRITE");
		System.out.println("BOARD NUM : "+board_kind);
		String path = session.getServletContext().getRealPath("resources/upload");//파일저장경로 만들어주기
		List<MultipartFile> files = mr.getFiles("files");//files로 지정된 애들을 List에 집어넣는다
		ArrayList<String> fileNames = new ArrayList<String>();//list에 담은 file의 경로+이름을 담을 arrayList
		
		for(int i = 0; i<files.size();i++){
			MultipartFile mf = files.get(i);//반복문이 돌 동안 하나씩 뽑아준다
			String fileName = UUID.randomUUID().toString()+"_" + mf.getOriginalFilename();//랜덤 아이디를 붙어주면서 fileName 만들어주기
			File file = new File(path, fileName);
			mf.transferTo(file);//TransferTo를 통해 파일객체에 경로+파일명 저장
			System.out.println(file);
			fileNames.add(fileName);//fileNames ArrayList에 만들어준 fileName을 담아준다
		}		
		result = boardDAO.qnaWrite(boardDTO, board_kind, fileNames);
		String message = "";
		if(result > 0){
			message = "등록완료!";
		}else{
			message = "등록실패!";
		}
		
		System.out.println("결과 : "+message);
		return message;
	}	
	
	//QNA수정//
	public String qnaUpdate(BoardDTO boardDTO, int board_kind, int [] bFile_num, MultipartRequest mr, HttpSession session) throws Exception {
		int result = 0;
		String path = session.getServletContext().getRealPath("resources/upload");//파일저장경로 만들어주기
		List<MultipartFile> files = mr.getFiles("files");//files로 지정된 애들을 List에 집어넣는다
		ArrayList<String> fileNames = new ArrayList<String>();
		
		for(int i=0;i<bFile_num.length;i++){
			System.out.println(bFile_num[i]);
		}
		
		for(int i = 0; i<files.size();i++){
			MultipartFile mf = files.get(i);//반복문이 돌 동안 하나씩 뽑아준다
			String fileName = UUID.randomUUID().toString()+"_" + mf.getOriginalFilename();//랜덤 아이디를 붙어주면서 fileName 만들어주기
			File file = new File(path, fileName);
			mf.transferTo(file);//TransferTo를 통해 파일객체에 경로+파일명 저장
			System.out.println(file);
			fileNames.add(fileName);//fileNames ArrayList에 만들어준 fileName을 담아준다
			System.out.println("파일명 : " + fileNames.get(i));
			
		}
		result = boardDAO.qnaMod(boardDTO, board_kind, fileNames, bFile_num);
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
	
	public BoardDTO boardView(BoardDTO boardDTO, int board_kind, Model model) throws Exception {
		
		boardDTO = boardDAO.boardView(boardDTO,board_kind);
		boardDAO.boardViewUpdate(boardDTO);
		
		model.addAttribute("view", boardDTO);
		model.addAttribute("fileView", boardDAO.fileView(boardDTO));
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
		System.out.println("FINDLIST");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCurPage(curPage);
		pageMaker.setPerPage(perPage);
		pageMaker.makeRow();
		pageMaker.makePage(boardDAO.boardCount(board_kind));
		List<BoardDTO> ar;
		List<BoardDTO> br;
		List<BoardDTO> cr;
		System.out.println("boardNum : "+board_kind);
		System.out.println("검색종류 : "+type);
		System.out.println("검색어 : "+find);
		System.out.println("curPage : "+pageMaker.getCurPage());
		System.out.println("perPage : "+pageMaker.getPerPage());
		System.out.println("시작숫자 : "+pageMaker.getStartRowNum());
		System.out.println("마지막 숫자 : "+pageMaker.getLastLowNum());
		System.out.println("글의 총 갯수 : "+boardDAO.boardCount(board_kind));
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
