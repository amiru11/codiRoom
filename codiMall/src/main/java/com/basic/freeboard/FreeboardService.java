package com.basic.freeboard;

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

import com.basic.board.BoardDTO;
import com.basic.board.BoardService;
import com.basic.util.PageMaker;

@Service
public class FreeboardService implements BoardService {

	@Autowired
	private FreeboardDAO fDAO;
	
	
	
	@Override
	public BoardDTO boardView(BoardDTO boardDTO) throws Exception {
		// TODO Auto-generated method stub
		return fDAO.boardView(boardDTO);
	}

	public void fileView(BoardDTO boardDTO, Model model) throws Exception {
		model.addAttribute("fileView", fDAO.fileView(boardDTO));
	}
	
	@Override
	public int boardWrite(BoardDTO boardDTO, MultipartRequest mr, HttpSession session) throws Exception {
		// TODO Auto-generated method stub
		String path = session.getServletContext().getRealPath("resources/upload");//파일저장경로 만들어주기
		List<MultipartFile> files = mr.getFiles("files");//files로 지정된 애들을 List에 집어넣는다
		ArrayList<String> fileNames = new ArrayList<String>();//list에 담은 file의 경로+이름을 담을 arrayList
		
		for(int i = 0; i<files.size();i++){
			MultipartFile mf = files.get(i);//반복문이 돌 동안 하나씩 뽑아준다
			String fileName = UUID.randomUUID().toString()+"_" + mf.getOriginalFilename();//랜덤 아이디를 붙어주면서 fileName 만들어주기
			File file = new File(path, fileName);
			mf.transferTo(file);//TransferTo를 통해 파일객체에 경로+파일명 저장
			System.out.println(path+fileName);
			fileNames.add(fileName);//fileNames ArrayList에 만들어준 fileName을 담아준다
		}
		return fDAO.boardWrite(boardDTO,fileNames);//DTO와 arrayList fileNames를 매개변수로 받아주는 DAO를 리턴받는다
	}

	@Override
	public int boardUpdate(BoardDTO boardDTO, MultipartRequest mr, HttpSession session) throws Exception {
		String path = session.getServletContext().getRealPath("resources/upload");//파일저장경로 만들어주기
		List<MultipartFile> files = mr.getFiles("files");//files로 지정된 애들을 List에 집어넣는다
		ArrayList<String> fileNames = new ArrayList<String>();
		
		for(int i = 0; i<files.size();i++){
			MultipartFile mf = files.get(i);//반복문이 돌 동안 하나씩 뽑아준다
			String fileName = UUID.randomUUID().toString()+"_" + mf.getOriginalFilename();//랜덤 아이디를 붙어주면서 fileName 만들어주기
			File file = new File(path, fileName);
			mf.transferTo(file);//TransferTo를 통해 파일객체에 경로+파일명 저장
			System.out.println(path+fileName);
			fileNames.add(fileName);//fileNames ArrayList에 만들어준 fileName을 담아준다
			System.out.println("파일명 : " + fileNames.get(i));
		}
		return fDAO.boardUpdate(boardDTO, fileNames);
	}

	@Override
	public int boardDelete(int num) throws Exception {
		// TODO Auto-generated method stub
		return fDAO.boardDelete(num);
	}

	@Override
	public void boardList(int curPage, int perPage, Model model) throws Exception {
		int totalCount = fDAO.boardCount();
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCurPage(curPage);
		pageMaker.setPerPage(perPage);
		pageMaker.makeRow();//startRow & lastRow
		pageMaker.makePage(totalCount);
		
		model.addAttribute("list", fDAO.boardList(pageMaker));
		model.addAttribute("paging", pageMaker);
	}

}
