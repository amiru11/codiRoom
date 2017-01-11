package com.basic.fashion;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.basic.board.BoardDTO;
import com.basic.board.CommentDTO;
import com.basic.product.KindDTO;
import com.basic.product.ProductSelectDTO;
import com.basic.util.PageMaker;

@Service
public class CodiService {
	
	@Autowired
	private CodiDAO codiDAO;
	
	//코디 리스트
	public void codiList(int curPage, int perPage, Model model) throws Exception{
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCurPage(curPage);
		pageMaker.setPerPage(perPage);
		pageMaker.makeRow();
		pageMaker.makePage(codiDAO.codiCount());
		List<CodiDTO> ar;
		ar = codiDAO.codiList(pageMaker);
		model.addAttribute("pageing", pageMaker);
		model.addAttribute("list", ar);
	}
	
	//코디 베스트리스트
	public void bestCodiList(Model model) throws Exception{
		List<CodiDTO> ar;
		ar = codiDAO.bestCodiList();
		model.addAttribute("blist", ar);
		System.out.println("bestCodiListSERVICE");
	}
	//코디 뷰
	public CodiDTO codiView(CodiDTO codiDTO,Model model) throws Exception {
		codiDTO = codiDAO.codiView(codiDTO);
		codiDAO.codiViewUpdate(codiDTO);
		String pn = codiDTO.getProduct();
		String [] product;
		product = pn.split(",");
		
		List<CodiDTO> ar;
		ar = codiDAO.codiProduct(product);
		for(int i=0;i<product.length;i++){
			System.out.println("i번 : " + product[i]);
		}
		
		//codiDAO.codiViewUpdate(codiDTO);
		model.addAttribute("view", codiDTO);
		model.addAttribute("list", ar);
		return codiDTO;
	}
	
	//삭제//
	
	public String codiDel(int num) throws Exception {
		int result = 0;		
		result = codiDAO.codiDel(num);
		String message = "";
		if(result > 0){
			message = "삭제완료!";
		}else{
			message = "삭제실패!";
		}
		return message;		
	}
	
	
	//코디 저장
	public int codiCreate(CodiDTO codiDTO, Model model) throws Exception{
		return codiDAO.codiCreate(codiDTO);
	}
	
	//상품 리스트
	public Map<String, Object> codiProductList(int curPage, int perPage, int kind_num){
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setPerPage(perPage);
		pageMaker.setCurPage(curPage);
		pageMaker.makeRow();
		pageMaker.makePage(codiDAO.codiProductListCount(kind_num));
		List<CodiDTO> ar;
		ar = codiDAO.codiProductList(pageMaker,kind_num);
		Map<String, Object> retVal = new HashMap<String, Object>();
		retVal.put("ar", ar);
		retVal.put("pageing",pageMaker);
		retVal.put("startNum",pageMaker.getStartNum());
		retVal.put("lastNum",pageMaker.getLastNum());
		return retVal;
	}
	public List<KindDTO> codiKindList(int productSelect_num){
		return codiDAO.codiKindList(productSelect_num);
	}
	public List<ProductSelectDTO> codiSelectList(){
		return codiDAO.codiSelectList();
	}
	//상품 리스트 카운트
	 	public int codiProductListCount(int kind_num){
	 		return codiDAO.codiProductListCount(kind_num);
	 	}
	 	
	 	
}
