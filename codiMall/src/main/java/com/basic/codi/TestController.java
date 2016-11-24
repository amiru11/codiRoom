package com.basic.codi;

import java.util.List;
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

import com.basic.test.ProductDTO;
import com.basic.test.ProductEachDTO;
import com.basic.test.ProductInfoDTO;
import com.basic.test.ProductKindDTO;
import com.basic.test.TestDTO;

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
	public void productAdd(MultipartHttpServletRequest multiReq) {
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
			System.out.println("result11--"+result);
			result = sqlSession.insert(namespace + "TestAdd2", productInfoDTO);
			System.out.println("result22--"+result);
			for (int i = 0; i < a; i++) {
				productEachDTO.setProductEach_size(productEach_size[i]);
				productEachDTO.setProductEach_color(productEach_color[i]);
				productEachDTO.setProductEach_each(Integer.parseInt(productEach_each[i]));
				result = sqlSession.insert(namespace + "TestAdd3", productEachDTO);
			}
			System.out.println("result33--"+result);
			result = sqlSession.insert(namespace + "TestAdd4", productKindDTO);
			System.out.println("result44--"+result);
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
