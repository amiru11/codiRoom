package com.basic.buy;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.basic.basket.BasketDTO;
import com.basic.basket.BasketListDTO;
import com.basic.member.MemberDTO;

@Repository
public class BuyDao {

	@Autowired
	SqlSession sqlSession;
	private String namespace = "BuyMapper.";

	@Autowired
	private PlatformTransactionManager transactionManager;

	DefaultTransactionDefinition def = null;
	TransactionStatus status = null;
	
	public List<BuyListDTO> buyList(HttpSession session){
		return sqlSession.selectList(namespace+"SelBuyList",(MemberDTO)session.getAttribute("member"));
		
	}

	public List<BasketListDTO> basketBuyList(int[] basket_num) {
		List<Integer> ar = new ArrayList<Integer>();
		List<BasketListDTO> ar2 = new ArrayList<BasketListDTO>();
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < basket_num.length; i++) {
			ar.add(basket_num[i]);
		}
		map.put("list", ar);
		ar2 = sqlSession.selectList(namespace + "SelBasketBuyList", map);
		return ar2;
	}

	public String basketBuy(int[] basket_num, MemberDTO memberDTO) {
		List<Integer> ar = new ArrayList<Integer>();
		List<BasketListDTO> ar2 = new ArrayList<BasketListDTO>();
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < basket_num.length; i++) {
			ar.add(basket_num[i]);
		}
		map.put("list", ar);
		ar2 = sqlSession.selectList(namespace + "SelBasketBuyList", map);
		for (int i = 0; i < ar2.size(); i++) {
			System.out.println(i + "--basnum--" + ar2.get(i).getBasket_num());
			System.out.println(i + "--pronum--" + ar2.get(i).getProduct_num());
			System.out.println(i + "--price--" + ar2.get(i).getProductInfo_price());
			System.out.println(i + "--salerate--" + ar2.get(i).getProductInfo_saleRate());
			System.out.println(i + "--size--" + ar2.get(i).getBasketInfo_size());
			System.out.println(i + "--color--" + ar2.get(i).getBasketInfo_color());
			System.out.println(i + "--each--" + ar2.get(i).getBasketInfo_each());

		}

		int result = 0;
		int upResult=0;
		String message = "";

		try {
			System.out.println("try in");
			def = new DefaultTransactionDefinition();
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

			status = transactionManager.getTransaction(def);

			for (int i = 0; i < basket_num.length; i++) {
				System.out.println("for" + i);
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("memberDTO", memberDTO);
				map2.put("basketListDTO", ar2.get(i));
				result = result + sqlSession.insert(namespace + "InsBuy", map2);
				System.out.println("ins" + i + "---" + result);
				result = result + sqlSession.insert(namespace + "InsBuyState", map2);
				System.out.println(i + "--buystate--succecc");
				
				if(result>0){
					upResult = sqlSession.update(namespace+"UpProductBuy",map2);
					System.out.println("resultvalue-"+result);
					System.out.println("upresult--"+i);
				}else{
					System.out.println("break");
					break;
				}
			}
			if (result == basket_num.length * 2 && upResult>0) {
				System.out.println("result==basket_num.length");
				Map<String, Object> map3 = new HashMap<String, Object>();
				map3.put("del_basket_num", ar);

				result = sqlSession.delete("BasketMapper.DelBasketInfo", map3);
				System.out.println("result1"+result);
				if (result == basket_num.length) {
					result = sqlSession.delete("BasketMapper.DelBasket", map3);
					System.out.println("result2"+result);
				}else{
					result=0;
				}
				if (result == basket_num.length) {
					transactionManager.commit(status);
					System.out.println("success");
					message = "구매성공";
				} else {
					message = "오류발생";
					transactionManager.rollback(status);
				}
			} else {
				transactionManager.rollback(status);
				System.out.println("fail");
				message = "오류발생";
			}

		} catch (Exception e) {
			// TODO: handle exception
			transactionManager.rollback(status);
			System.out.println("Exception");
			message = "예외발생";
		}

		return message;
	}

}
