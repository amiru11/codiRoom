package com.basic.codi;

import java.util.List;

import javax.servlet.http.HttpSession;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.basket.BasketDTO;
import com.basic.basket.BasketInfoDTO;
import com.basic.member.MemberDTO;
import com.basic.test.ProductDTO;
import com.basic.test.ProductEachDTO;
import com.basic.test.ProductInfoDTO;
import com.basic.test.ProductKindDTO;
import com.basic.test.TestDTO;
import com.basic.test.TestDTO2;
import com.basic.test.TestMemberDTO;
import com.basic.test.TestAddDTO;
import com.basic.test.TestBasketDTO;

@Controller
@RequestMapping(value = "/ttt")
public class TestController {

	@Autowired
	private SqlSession sqlSession;
	private String namespace = "TestMapper.";

	@Autowired
	private PlatformTransactionManager transactionManager;

	DefaultTransactionDefinition def = null;
	TransactionStatus status = null;
	
	//test
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(){
		List<TestDTO2> ar = new ArrayList<TestDTO2>();
		ar = sqlSession.selectList(namespace+"TestProjproe");
		
		System.out.println("ar size --"+ar.size());
		for (int i = 0; i < ar.size(); i++) {
			System.out.println("ar num --"+i+"--i-------------");
			System.out.println("pronum--"+i+"--"+ar.get(i).getProduct_num());
			System.out.println("pro-name--"+i+"--"+ar.get(i).getProduct_name());
			for (int j = 0; j < ar.get(i).getListProEach().size(); j++) {
				System.out.println("ar.getprdto2--size - "+ar.get(i).getListProEach().size());
				System.out.println("ar num --"+i+"--"+ar.get(i).getListProEach().get(j).getProductEach_color());
				System.out.println("ar num --"+i+"--"+ar.get(i).getListProEach().get(j).getProductEach_size());
				System.out.println("ar num --"+i+"--"+ar.get(i).getListProEach().get(j).getProductEach_each());
				
			}
		}
		return "redirect:/";
		
	}

	// view
	@RequestMapping(value = "/view")
	public void viiew(int product_num, Model model) {
		List<TestDTO> ar = new ArrayList<TestDTO>();
		ar = sqlSession.selectList(namespace + "TestView", product_num);
		model.addAttribute("list", ar);
	}

	// buy
	@RequestMapping(value = "/buy", method = RequestMethod.POST)
	public void buy(Model model) {

	}

	// basket
	@RequestMapping(value = "/basket", method = RequestMethod.GET)
	public String basket(HttpSession session,RedirectAttributes ra) {
		String path="";
		String message="";
		if(session.getAttribute("member") != null){
			path="redirect:/ttt/basket";
		}else{
			message="잘못된 접근";
			ra.addFlashAttribute("message", message);
			path="redirect:/";
		}
		return path;
		
	}

	// basket
	@RequestMapping(value = "/basket", method = RequestMethod.POST)
	public String basket(BasketInfoDTO basketInfoDTO, Model model, HttpSession session) {
		System.out.println("aaa");
		int result = 0;
		String path = "";
		String message = "";

		if (session != null) {
			System.out.println("loging");
			def = new DefaultTransactionDefinition();
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

			status = transactionManager.getTransaction(def);

			try {
				BasketDTO basketDTO = new BasketDTO();
				TestMemberDTO memberDTO = new TestMemberDTO();
				memberDTO = (TestMemberDTO) (session.getAttribute("member"));
				basketDTO.setMember_id(memberDTO.getMember_id());
				basketDTO.setProduct_num(basketInfoDTO.getProduct_num());
				result = sqlSession.insert(namespace + "TestBasketAdd", basketDTO);
				System.out.println("first");
				result = sqlSession.insert(namespace + "TestBasketAdd2", basketInfoDTO);
				System.out.println("second");
				if (result > 0) {
					transactionManager.commit(status);
				}
				List<TestDTO> ar = new ArrayList<TestDTO>();

				ar = sqlSession.selectList(namespace + "TestView", basketInfoDTO.getProduct_num());
				model.addAttribute("list", ar);
				model.addAttribute("basket", basketInfoDTO);

			} catch (Exception e) {
				// TODO: handle exception
				transactionManager.rollback(status);
				message = "basket add fail";
			}
			path = "/ttt/basket";

		} else {
			message = "잘못된 접근";
			path = "redirect:/";
			model.addAttribute("message", message);
		}

		return path;
	}

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

	@RequestMapping(value = "/product_add", method = RequestMethod.GET)
	public void productAdd() {
	}

	@RequestMapping(value = "/product_add", method = RequestMethod.POST)
	public void productAdd(TestAddDTO testDTO2, MultipartHttpServletRequest multiReq) {
		System.out.println(testDTO2.getProduct_name());
		System.out.println(testDTO2.getProductInfo_price());
		System.out.println(testDTO2.getProductEach_each()[0]);
		System.out.println(testDTO2.getKind_num());

		TestDTO testDTO = new TestDTO();
		ProductDTO productDTO = new ProductDTO();
		ProductInfoDTO productInfoDTO = new ProductInfoDTO();
		ProductKindDTO productKindDTO = new ProductKindDTO();
		ProductEachDTO productEachDTO = new ProductEachDTO();
		System.out.println("z-------" + multiReq.getParameter("product_name"));
		productDTO.setProduct_name((String) multiReq.getParameter("product_name"));
		productInfoDTO.setProductInfo_price(Integer.parseInt((String) multiReq.getParameter("productInfo_price")));
		productInfoDTO
				.setProductInfo_saleRate(Double.parseDouble((String) multiReq.getParameter("productInfo_saleRate")));
		productInfoDTO.setProductInfo_searchWord((String) multiReq.getParameter("productInfo_price"));

		int a = multiReq.getParameterValues("productEach_size").length;
		System.out.println("aaa---" + a);
		String[] productEach_size = multiReq.getParameterValues("productEach_size");
		String[] productEach_color = multiReq.getParameterValues("productEach_color");
		String[] productEach_each = multiReq.getParameterValues("productEach_each");
		productKindDTO.setKind_num(Integer.parseInt((String) multiReq.getParameter("kind_num")));

		def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		status = transactionManager.getTransaction(def);
		int result = 0;

		try {
			result = sqlSession.insert(namespace + "TestAdd1", productDTO);
			System.out.println("result11--" + result);
			result = sqlSession.insert(namespace + "TestAdd2", productInfoDTO);
			System.out.println("result22--" + result);
			for (int i = 0; i < a; i++) {
				productEachDTO.setProductEach_size(productEach_size[i]);
				productEachDTO.setProductEach_color(productEach_color[i]);
				productEachDTO.setProductEach_each(Integer.parseInt(productEach_each[i]));
				result = sqlSession.insert(namespace + "TestAdd3", productEachDTO);
			}
			System.out.println("result33--" + result);
			result = sqlSession.insert(namespace + "TestAdd4", productKindDTO);
			System.out.println("result44--" + result);
			if (result > 0) {
				transactionManager.commit(status);
			}
		} catch (Exception e) {
			// TODO: handle exception
			transactionManager.rollback(status);
		}
		System.out.println("success");
	}

}
