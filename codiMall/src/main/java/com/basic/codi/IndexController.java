package com.basic.codi;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.test.ProductDTO;
import com.basic.test.TestDTO;

@Controller
public class IndexController {

	@RequestMapping(value="/", method = RequestMethod.GET)
	public String index(){
		return "index";
	}
	
	@Autowired
	private SqlSession sqlSession;
	private String namespace = "TestMapper.";

	@Autowired
	private PlatformTransactionManager transactionManager;

	DefaultTransactionDefinition def = null;
	TransactionStatus status = null;

	@RequestMapping(value = "/t3")
	public String ttteee3() {

		System.out.println(sqlSession.selectOne(namespace + "TestListCount"));

		return "redirect:/";
	}

	@RequestMapping(value = "/t1")
	public String ttteee(Model ra) {
		List<ProductDTO> ar = new ArrayList<ProductDTO>();
		ar = sqlSession.selectList(namespace + "TestListPr");
		ra.addAttribute("list", ar);
		return "/ttt/tlist2";
	}

	@RequestMapping(value = "/t2")
	public String ttteee2(Model ra) {
		List<TestDTO> ar = new ArrayList<TestDTO>();
		ar = sqlSession.selectList(namespace + "TestListAll");
		for (int i = 0; i < ar.size(); i++) {
			System.out.println(i + "---" + ar.get(i).getProductDTO().getProduct_num());
			System.out.println(i + "---" + ar.get(i).getProductDTO().getProduct_name());
			System.out.println("-----------------------------------------");
		}
		return "/ttt/tlist2";
	}

}
