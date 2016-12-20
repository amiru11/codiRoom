package com.basic.fashion;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.basic.util.PageMaker;

@Service
public class CodiService {
	
	@Autowired
	private CodiDAO codiDAO;
	
	public void codiList(PageMaker pageMaker, CodiDTO codiDTO, Model model) throws Exception{
		List<CodiDTO> ar;
		ar = codiDAO.codiList(pageMaker, codiDTO);
		model.addAttribute("list", ar);
	}

}
