package com.basic.fashion;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.basic.board.BoardDTO;
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
	
	//코디 저장
	public int codiCreate(CodiDTO codiDTO, Model model) throws Exception{
		return codiDAO.codiCreate(codiDTO);
	}
	
	//상품 리스트
	public List<CodiDTO> codiProductList(int curPage, int perPage, int kind_num){
		PageMaker pageMaker = new PageMaker();
		pageMaker.setPerPage(perPage);
		pageMaker.setCurPage(curPage);
		pageMaker.makeRow();
		pageMaker.makePage(codiDAO.codiProductListCount(kind_num));
		List<CodiDTO> ar;
		ar = codiDAO.codiProductList(pageMaker,kind_num);
		return ar;
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
