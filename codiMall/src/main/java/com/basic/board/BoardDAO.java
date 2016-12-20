package com.basic.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.basic.member.MemberDTO;
import com.basic.product.ProductDTO;
import com.basic.util.PageMaker;



@Repository
public class BoardDAO {

	@Autowired
	private SqlSession sqlSession;
	
	private List<BoardDTO> ar;
	private BoardDTO boardDTO;
	private String namespace1="NoticeMapper.";
	private String namespace2="FAQMapper.";//mapper.xml의 namespace와 일치시켜줘야한다!!
	private String namespace3="QnAMapper.";
	private String namespace4="ProductQnAMapper.";
	
	//MAXNUM//
	public int maxNum(BoardDTO boardDTO) throws Exception{
		int result = 0;
		result = sqlSession.selectOne(namespace4+"maxNum");
		return result;
	}
	
	//멤버별상품문의내역//
	public List<BoardDTO> memberBoardList(String name,PageMaker pageMaker) throws Exception{
		System.out.println("멤버 DAO");
		Map<String, Object> mp = new HashMap<String, Object>();
		mp.put("paging", pageMaker);
		mp.put("name", name);
		ar = sqlSession.selectList(namespace4+"memberBoardList", mp);
		
		return ar;
	}	
	//멤버별상품문의카운팅//
	public int memberBoardCount(String name){
		int result = 0;
		result = sqlSession.selectOne(namespace4+"memberBoardCount",name);
		return result;
	}
	
	//멤버별상품문의내역//
	public List<BoardDTO> memberBoardList2(String name,PageMaker pageMaker) throws Exception{
		System.out.println("멤버 DAO");
		Map<String, Object> mp = new HashMap<String, Object>();
		mp.put("paging", pageMaker);
		mp.put("name", name);
		ar = sqlSession.selectList(namespace3+"memberBoardList2", mp);
		
		return ar;
	}	
	//멤버별상품문의카운팅//
	public int memberBoardCount2(String name){
		int result = 0;
		result = sqlSession.selectOne(namespace3+"memberBoardCount2",name);
		return result;
	}
	
	
	
	//글쓰기//
	public int boardWrite(BoardDTO boardDTO,int board_kind) throws Exception{
		int result = 0;
		if(board_kind==1){
			result = sqlSession.insert(namespace1+"boardWrite",boardDTO);
		}else if(board_kind==2){
			result = sqlSession.insert(namespace2+"boardWrite",boardDTO);
		}else if(board_kind==3){
			result = sqlSession.insert(namespace3+"boardWrite",boardDTO);
		}
		
		return result;
	};

	//상품글쓰기//
	public int pWrite(BoardDTO boardDTO) throws Exception{
		return sqlSession.insert(namespace4+"boardWrite",boardDTO);
	}
	
	
	//QNA 글쓰기..FILEUP//
	public int qnaWrite(BoardDTO boardDTO, int board_kind, ArrayList<String> fileNames) throws Exception{		
		int result = 0;
		if(board_kind==3){
			result = sqlSession.insert(namespace3+"boardWrite", boardDTO);
			int fileNum = sqlSession.selectOne(namespace3+"fileNum");//fileNum을 가져온다
			Map<String, Object> data = new HashMap<String, Object>();//fileDB에 등록해줄 맵을 만들어준다//
			
			for(int i=0;i<fileNames.size();i++){
				data.put("bFile_refNum", fileNum);
				data.put("bFile_fileName", fileNames.get(i));
				System.out.println("파일 이름 : " + fileNames.get(i));
				sqlSession.insert(namespace3+"fileWrite", data);
			}
		}
		return result;
	}
	
	//QNA 글수정시 FILEUP//
	public int qnaModFileup(BoardDTO boardDTO, int board_kind, ArrayList<String> fileNames) throws Exception{		
		int result = 0;
		if(board_kind==3){
			int refNum = boardDTO.getBoard_num();
			Map<String, Object> data = new HashMap<String, Object>();//fileDB에 등록해줄 맵을 만들어준다//
			
			for(int i=0;i<fileNames.size();i++){
				data.put("bFile_refNum", refNum);
				data.put("bFile_fileName", fileNames.get(i));
				System.out.println("파일 이름 : " + fileNames.get(i));
				result = sqlSession.insert(namespace3+"fileWrite", data);
			}
		}
		return result;
	}
	
	
	
	
	//QNA 글수정 FILE도 같이 수정//
	public int qnaMod(BoardDTO boardDTO, int board_kind, ArrayList<String> fileNames, ArrayList<Integer> bFile_num, int checkNum) throws Exception{
		int result = 0;
		
		Map<String, Object> data = new HashMap<String, Object>();//fileDB에 등록해줄 맵을 만들어준다//
		int refNum = boardDTO.getBoard_num();
		//System.out.println("refNum : " + refNum);
		if(board_kind==3){
			result = sqlSession.update(namespace3+"boardUpdate",boardDTO);//board DB 수정//
			
				for(int i=0;i<bFile_num.size();i++){
					System.out.println(111111111);
					data.put("bFile_refNum", refNum);
					data.put("bFile_fileName", fileNames.get(i));
					data.put("bFile_num", bFile_num.get(i));
					System.out.println("파일 번호 : " + bFile_num.get(i));
					System.out.println("파일 이름 : " + fileNames.get(i));
					
					//바꾸려는 이미지의 갯수가 현재 이미지 갯수와 같을 때 & 적을 때//
					sqlSession.update(namespace3+"fileUpdate", data);//board_files DB 수정//	
				}
		}
		return result;
	};	
	
	//글수정//
	public int boardMod(BoardDTO boardDTO,int board_kind) throws Exception{
		int result = 0;
		if(board_kind==1){
			result = sqlSession.update(namespace1+"boardUpdate",boardDTO);
		}else if(board_kind==2){
			result = sqlSession.update(namespace2+"boardUpdate",boardDTO);			
		}else if(board_kind==4){
			result = sqlSession.update(namespace4+"boardUpdate", boardDTO);
		}
		return result;
	};

	//글삭제//
	public int boardDel(int board_num,int board_kind) throws Exception{
		int result = 0;
		if(board_kind==1){
			result = sqlSession.delete(namespace1+"boardDelete",board_num);
		}else if(board_kind==2){
			result = sqlSession.delete(namespace2+"boardDelete",board_num);			
		}else if(board_kind==3){
			result = sqlSession.delete(namespace3+"boardDelete",board_num);
		}else if(board_kind==4){
			result = sqlSession.delete(namespace4+"boardDelete",board_num);
		}
		return result;
	};

	//글보기//
	public BoardDTO boardView(BoardDTO boardDTO, int board_kind) throws Exception{
		System.out.println("BOARDDAO.VIEW");
		if(board_kind==1){
			boardDTO = sqlSession.selectOne(namespace1+"boardView", boardDTO);			
		}else if(board_kind==2){
			boardDTO = sqlSession.selectOne(namespace1+"boardView", boardDTO);
		}else if(board_kind==3){
			boardDTO = sqlSession.selectOne(namespace3+"boardView", boardDTO);
		}
		return boardDTO;
	};
	
	//뷰에서 파일 보기//
	public List<BoardFileDTO> fileView(BoardDTO boardDTO) throws Exception {
		
		return sqlSession.selectList(namespace3+"fileView", boardDTO);
	}

	//리스트//
	public List<BoardDTO> boardList(String type, String find, PageMaker pageMaker, int board_kind) throws Exception{
		System.out.println("BOARDDAO.LIST");
		if(board_kind==1){			
			System.out.println(namespace1);
			ar = sqlSession.selectList(namespace1+"boardList", pageMaker);
		}else if(board_kind==2){
			System.out.println(namespace2);
			ar = sqlSession.selectList(namespace2+"boardList", pageMaker);			
		}
		return ar;
	};
	
	//페이징시 글의 총개수세기//
	public int boardCount(int board_kind){
		int result = 0;
		System.out.println("boardCount :" + board_kind);
		if(board_kind==1){
			result = sqlSession.selectOne(namespace1+"boardCount");
		}else if(board_kind==2){
			result = sqlSession.selectOne(namespace2+"boardCount");
			System.out.println(namespace2 +"count");
		}else if(board_kind==3){
			result = sqlSession.selectOne(namespace3+"boardCount");
			System.out.println(namespace3 +"count");
		}
		/*if(board_kind==4){
			result = sqlSession.selectOne(namespace4+"boardCount");
			System.out.println(namespace4 +"count");
		}*/
		return result;
	};

	public int pboardCount(int product_num){
		int result = 0;
/*		Map<String, Object> mp = new HashMap<String, Object>();
		mp.put("product_num", product_num);*/
		result = sqlSession.selectOne(namespace4+"boardCount",product_num);
		System.out.println(namespace4 +"count");
		
		return result;
	}
	
	
	//답글쓰기//
/*	public int boardReply(BoardDTO boardDTO,int board_kind) throws Exception{
		int result1 = 0;
		int result2 = 0;
		if(board==1){			
			result1 = sqlSession.update(namespace1+"boardReply1", boardDTO);
			result2 = sqlSession.insert(namespace1+"boardReply2", boardDTO);
		}else{
			result1 = sqlSession.update(namespace2+"boardReply1", boardDTO);
			result2 = sqlSession.insert(namespace2+"boardReply2", boardDTO);
		}
		System.out.println("REPLY UP : " + result1);
		System.out.println("REPLY WRITE : " + result2);
		return result2;	
	};*/

	//뷰업데이트//
	public void boardViewUpdate(BoardDTO boardDTO) throws Exception{
		sqlSession.update(namespace1+"boardViewUpdate", boardDTO);
	};
	
	//검색//
	public List<BoardDTO> findList(String type, String find, int board_kind, PageMaker pageMaker) throws Exception{
		Map<String, Object> mp = new HashMap<String, Object>();
		mp.put("type", type);
		mp.put("find", "%"+find+"%");
		mp.put("paging", pageMaker);
		
		if(board_kind==1){			
			ar = sqlSession.selectList(namespace1+"findList", mp);
		}else if(board_kind==2){
			ar = sqlSession.selectList(namespace2+"findList", mp);
		}else if(board_kind==3){
			ar = sqlSession.selectList(namespace3+"findList", mp);
		}
		return ar;
	}
	
	//product FIND LIST/
	public List<BoardDTO> findList(String type, String find, int board_kind, int product_num, PageMaker pageMaker) throws Exception{
		System.out.println("product_num" + product_num);
		Map<String, Object> mp = new HashMap<String, Object>();
		mp.put("type", type);
		mp.put("find", "%"+find+"%");
		mp.put("paging", pageMaker);
		mp.put("product_num", product_num);
		if(board_kind==4){
			ar = sqlSession.selectList(namespace4+"findList", mp);
		}
		return ar;
	}
	
	
	
	
	//FAQ BEST 5//
		public List<BoardDTO> bestList(){
			return sqlSession.selectList(namespace2+"bestList");
		}
	
	//FAQ BEST 5 test//
	public List<BoardDTO> bestList(PageMaker pageMaker) throws Exception{
		return sqlSession.selectList(namespace2+"bestList2",pageMaker);
	}
	
	public int bestCount(){
		return sqlSession.selectOne(namespace2+"bestCount");
	}
}
