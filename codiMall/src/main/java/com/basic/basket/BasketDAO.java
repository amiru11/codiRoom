package com.basic.basket;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.basic.member.MemberDTO;
import com.basic.product.ProductDTO;
import com.basic.product.ProductEachDTO;

@Repository
public class BasketDAO {

	@Autowired
	SqlSession sqlSession;
	private String namespace = "BasketMapper.";

	@Autowired
	private PlatformTransactionManager transactionManager;

	DefaultTransactionDefinition def = null;
	TransactionStatus status = null;

	public List<BasketListDTO> basketList(MemberDTO memberDTO) {
		List<BasketListDTO> ar = sqlSession.selectList(namespace + "NewSelBasketList", memberDTO);
		return ar;
	}

	public List<ProductEachDTO> basketProductEachList(int product_num) {
		return sqlSession.selectList(namespace + "SelBasketProductEachList", product_num);
	}

	public int basketAdd(ProductEachDTO productEachDTO, MemberDTO memberDTO) {
		def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		status = transactionManager.getTransaction(def);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productEachDTO", productEachDTO);
		map.put("memberDTO", memberDTO);
		System.out.println("pronum--" + productEachDTO.getProduct_num());
		System.out.println("Size--" + productEachDTO.getProductSize_size());
		System.out.println("Color--" + productEachDTO.getProductEach_color());
		System.out.println("Each--" + productEachDTO.getProductEach_each());

		int result = 0;
		int basket_num = 0;
		try {
			Integer a = sqlSession.selectOne(namespace + "SelBasketUseBasNum", map);
			System.out.println("aaaaaaa----" + a);
			if (a != null && (int) a > 0) {
				basket_num = (int) a;
				System.out.println("basekt_num---" + basket_num);
				Integer basket_each = sqlSession.selectOne(namespace + "SelBasketGetEach", basket_num);
				System.out.println("baseach--" + basket_each);
				Integer product_each = sqlSession.selectOne(namespace + "SelProuctGetEach", map);
				System.out.println("proeach--" + product_each);
				int base = (int) basket_each;
				int proe = (int) product_each;
				System.out.println(base);
				System.out.println(proe);
				System.out.println(base + productEachDTO.getProductEach_each());
				if (proe < base + productEachDTO.getProductEach_each()) {
					BasketInfoDTO basketInfoDTO = new BasketInfoDTO();
					basketInfoDTO.setBasket_num(basket_num);
					basketInfoDTO.setBasketInfo_each(proe);
					System.out.println("upFirst");
					result = sqlSession.update(namespace + "UpBasketEach", basketInfoDTO);
					System.out.println("upresult1" + result);
				} else {
					BasketInfoDTO basketInfoDTO = new BasketInfoDTO();
					System.out.println("eachFix_first");
					basketInfoDTO.setBasket_num(basket_num);
					basketInfoDTO.setBasketInfo_each(base + productEachDTO.getProductEach_each());
					result = sqlSession.update(namespace + "UpBasketEach", basketInfoDTO);
					System.out.println("upresult2" + result);
				}
			} else {
				System.out.println("firstelse----");
				result = sqlSession.insert(namespace + "InBasketAdd", map);
				System.out.println(result);
				result = sqlSession.insert(namespace + "InBasketInfoAdd", map);
				System.out.println(result);
			}
			if (result > 0) {
				transactionManager.commit(status);
				System.out.println("success");
			}else{
				transactionManager.rollback(status);
				result = 0;
			}
		} catch (Exception e) {
			// TODO: handle exception
			transactionManager.rollback(status);
			result = 0;
		}
		return result;
	}

	public String basketFix(HttpServletRequest request, HttpSession session) {
		ProductDTO productDTO = new ProductDTO();
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		productDTO.setProduct_num(product_num);
		BasketInfoDTO basketInfoDTO = new BasketInfoDTO();
		basketInfoDTO.setBasket_num(Integer.parseInt(request.getParameter("basket_num")));
		basketInfoDTO.setBasketInfo_size(request.getParameter("basketInfo_size"));
		basketInfoDTO.setBasketInfo_color(request.getParameter("basketInfo_color"));
		basketInfoDTO.setBasketInfo_each(Integer.parseInt(request.getParameter("basketInfo_each")));
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		System.out.println("pronum---" + product_num);
		System.out.println("basket_num---" + basketInfoDTO.getBasket_num());
		System.out.println("basketInfoSize---" + basketInfoDTO.getBasketInfo_size());
		System.out.println("basketInfoColor---" + basketInfoDTO.getBasketInfo_color());
		System.out.println("basketInfoEach---" + basketInfoDTO.getBasketInfo_each());
		System.out.println(memberDTO.getId());

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member", memberDTO);
		map.put("product", productDTO);
		map.put("basketInfo", basketInfoDTO);
		def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		status = transactionManager.getTransaction(def);

		String message = "";

		int result = 0;
		try {
			Integer a = sqlSession.selectOne(namespace + "SelBasketInfo", map);
			if (a != 0) {
				message = "동일한 상품이 이미있습니다";
				result = (sqlSession.selectOne(namespace + "SelBasketInfo", map));
			} else {
				result = sqlSession.update(namespace + "UpbasketInfo", map);
				if (result > 0) {
					transactionManager.commit(status);
					message = "수정성공";
				} else {
					message = "수정실패";
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			transactionManager.rollback(status);
			message = "error";
		}
		return message;
	}

	// Basket Del
	public int basketDel(int[] del_basket_num) {
		def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		status = transactionManager.getTransaction(def);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("del_basket_num", del_basket_num);
		int result = 0;
		try {
			result = sqlSession.delete(namespace + "DelBasketInfo", map);
			System.out.println(1 + "--" + result);

			result = sqlSession.delete(namespace + "DelBasket", map);
			System.out.println(2 + "--" + result);
			if (result > 0) {
				transactionManager.commit(status);
				System.out.println("success");
			}
		} catch (Exception e) {
			// TODO: handle exception
			transactionManager.rollback(status);
			result = 0;
		}

		return result;
	}

}
