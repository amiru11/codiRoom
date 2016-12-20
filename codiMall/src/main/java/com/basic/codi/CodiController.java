package com.basic.codi;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.basic.codiCl.CodiService;

@Controller
@RequestMapping(value="/codi")
public class CodiController {
	
	@Autowired
	private CodiService codiService;
	
	@RequestMapping(value="/codiMake")
	public void codiMake(){
	}

}
