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
import com.basic.product.ProductListDTO;

@Repository
public class BuyDao {

	@Autowired
	SqlSession sqlSession;
	private String namespace = "BuyMapper.";

	@Autowired
	private PlatformTransactionManager transactionManager;

	DefaultTransactionDefinition def = null;
	TransactionStatus status = null;

	public List<BuyListDTO> buyList(HttpSession session) {
		return sqlSession.selectList(namespace + "SelBuyList", (MemberDTO) session.getAttribute("member"));
	}

	public ProductListDTO buyDirectList(int product_num) {
		return sqlSession.selectOne(namespace + "SelProductInfo", product_num);
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

	public Map<String, Object> buyDirect(String buyState_address,int total_price, int product_num, String productSize_size,
			String productEach_color, int productEach_each, MemberDTO memberDTO) {
		System.out.println("---- non basket buy ---- start ----");
		List<Integer> ar = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> map22 = new HashMap<>();
		map.put("buyState_address", buyState_address);
		map.put("total_price", total_price);
		map.put("product_num", product_num);
		map.put("productSize_size", productSize_size);
		map.put("productEach_color", productEach_color);
		map.put("productEach_each", productEach_each);
		map.put("memberDTO", memberDTO);
		String message = "";
		int result = 0;
		int buy_num = 0;
		int productEach = sqlSession.selectOne(namespace + "SelProductEachGet", map);

		System.out.println("product_num---" + product_num);
		System.out.println("productSize_size---" + productSize_size);
		System.out.println("productEach_color---" + productEach_color);
		System.out.println("productEach_each---" + productEach_each);
		System.out.println("productEach----" + productEach);
		if (productEach > productEach_each) {
			try {
				def = new DefaultTransactionDefinition();
				def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

				status = transactionManager.getTransaction(def);

				result = sqlSession.update(namespace + "UpProductNonBasketBuy", map);
				if (result > 0) {
					result = sqlSession.insert(namespace + "InsNonBasketBuy", map);
					result = sqlSession.insert(namespace + "InsNonBasketBuyState", map);
				} else {
					result = 0;
				}
				if (result > 0) {
					buy_num = sqlSession.selectOne(namespace + "SelCurrBuyNum");
					System.out.println("success--buy_num---" + buy_num);
					transactionManager.commit(status);
					System.out.println("success");
					ar.add(buy_num);
					message = "구매성공";
					System.out.println("구매성공");
				} else {
					transactionManager.rollback(status);
					message = "구매실패";
					ar = null;
				}
			} catch (Exception e) {
				// TODO: handle exception
				transactionManager.rollback(status);
				System.out.println("fail");
				message = "오류발생";
				ar = null;
			}
		} else {
			message = "재고없음 구매실패";
			ar = null;
		}
		if (ar != null) {
			map.put("ar", ar);
			List<BuyListDTO> buyAr = sqlSession.selectList(namespace + "SelBuyListNow", map);
			if (buyAr.size() == 0) {
				buyAr = null;
			} else {
				System.out.println("buyarsize--" + buyAr.size());
				System.out.println(buyAr.get(0).getBuy_num());
				System.out.println(buyAr.get(0).getBuyState_color());
				System.out.println(buyAr.get(0).getBuyState_size());
				System.out.println(buyAr.get(0).getProduct_num());

			}
			map22.put("ar", buyAr);
		}
		map22.put("message", message);

		return map22;
	}

	public Map<String, Object> basketBuy(String buyState_address,int[] basket_num, MemberDTO memberDTO) {
		int buy_num = 0;
		boolean eachCheck = true;
		List<Integer> nar = new ArrayList<>();
		List<Integer> ar = new ArrayList<Integer>();
		List<BasketListDTO> ar2 = new ArrayList<BasketListDTO>();
		Map<String, Object> map22 = new HashMap<>();
		Map<String, Object> map = new HashMap<String, Object>();
		for (int i = 0; i < basket_num.length; i++) {
			ar.add(basket_num[i]);
		}
		map.put("list", ar);
		ar2 = sqlSession.selectList(namespace + "SelBasketBuyList", map);
		int size = ar2.size();
		System.out.println("arsize--first--" + ar2.size());

		for (int i = 0; i < ar2.size(); i++) {
			int productEach = sqlSession.selectOne(namespace + "SelProductEachGet_Bas", ar2.get(i));
			System.out.println("proeach--" + productEach);
			if (ar2.get(i).getBasketInfo_each() > productEach) {
				int num = ar2.get(i).getBasket_num();
				ar2.remove(i);
				sqlSession.update(namespace + "UpBasketEachZero", num);
				eachCheck = false;
			}
		}

		for (int i = 0; i < ar2.size(); i++) {
			int productEach = sqlSession.selectOne(namespace + "SelProductEachGet_Bas", ar2.get(i));
			System.out.println("proeach---" + productEach);
			System.out.println(i + "--basnum--" + ar2.get(i).getBasket_num());
			System.out.println(i + "--pronum--" + ar2.get(i).getProduct_num());
			System.out.println(i + "--price--" + ar2.get(i).getProductInfo_price());
			System.out.println(i + "--salerate--" + ar2.get(i).getProductInfo_saleRate());
			System.out.println(i + "--size--" + ar2.get(i).getBasketInfo_size());
			System.out.println(i + "--color--" + ar2.get(i).getBasketInfo_color());
			System.out.println(i + "--each--" + ar2.get(i).getBasketInfo_each());
		}

		int result = 0;
		int upResult = 0;
		String message = "";
		System.out.println("arsize--last--" + ar2.size());
		if (eachCheck) {

			try {
				System.out.println("try in");
				def = new DefaultTransactionDefinition();
				def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

				status = transactionManager.getTransaction(def);

				for (int i = 0; i < ar2.size(); i++) {
					System.out.println("for" + i);
					Map<String, Object> map2 = new HashMap<String, Object>();
					map2.put("buyState_address",buyState_address);
					map2.put("memberDTO", memberDTO);
					map2.put("basketListDTO", ar2.get(i));
					result = result + sqlSession.insert(namespace + "InsBuy", map2);
					System.out.println("ins" + i + "---" + result);
					result = result + sqlSession.insert(namespace + "InsBuyState", map2);
					System.out.println(i + "--buystate--succecc");

					if (result > 0) {
						upResult = sqlSession.update(namespace + "UpProductBuy", map2);
						System.out.println("resultvalue-" + result);
						System.out.println("upresult--" + i);
					} else {
						System.out.println("break");
						break;
					}
					buy_num = sqlSession.selectOne(namespace + "SelCurrBuyNum");
					System.out.println("success--buy_num---" + buy_num);
					nar.add(buy_num);
					System.out.println("nar등록성공");
				}
				if (result == ar2.size() * 2 && upResult > 0) {
					System.out.println("result==basket_num.length");
					Map<String, Object> map3 = new HashMap<String, Object>();
					map3.put("del_basket_num", ar);

					result = sqlSession.delete("BasketMapper.DelBasketInfo", map3);
					System.out.println("result1" + result);
					if (result == ar2.size()) {
						result = sqlSession.delete("BasketMapper.DelBasket", map3);
						System.out.println("result2" + result);
					} else {
						result = 0;
					}
					if (result == ar2.size()) {
						transactionManager.commit(status);
						System.out.println("success");
						message = "구매성공";
					} else {
						message = "오류발생";
						transactionManager.rollback(status);
						nar=null;
					}
				} else {
					transactionManager.rollback(status);
					System.out.println("fail");
					message = "오류발생";
					nar=null;
				}

			} catch (Exception e) {
				// TODO: handle exception
				transactionManager.rollback(status);
				System.out.println("Exception");
				message = "예외발생";
				nar=null;
			}
		} else {
			message = "재고부족 구매실패";
			nar=null;
		}
		
		if (nar != null) {
			map.put("ar", nar);
			List<BuyListDTO> buyAr = sqlSession.selectList(namespace + "SelBuyListNow", map);
			if (buyAr.size() == 0) {
				buyAr = null;
			} else {
				System.out.println("buyarsize--" + buyAr.size());
				for (int i = 0; i < buyAr.size(); i++) {
					System.out.println("buynum----"+i+"-----"+buyAr.get(i).getBuy_num());
					System.out.println("buycolor----"+i+"-----"+buyAr.get(i).getBuyState_color());
					System.out.println("buySize----"+i+"-----"+buyAr.get(i).getBuyState_size());
					System.out.println("buypronum----"+i+"-----"+buyAr.get(i).getProduct_num());
				}

			}
			map22.put("ar", buyAr);
		}
		map22.put("message", message);

		return map22;
	}

	// CanCel buy

	public String cancelBuy(int buy_num) {
		String message = "";
		int result = 0;
		def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		status = transactionManager.getTransaction(def);
		try {
			result = sqlSession.delete(namespace + "DelBuyState", buy_num);
			if (result > 0) {
				result = sqlSession.delete(namespace + "DelBuy", buy_num);
				if (result > 0) {
					transactionManager.commit(status);
					System.out.println("Del--success");
					message = "구매취소성공";
				}
			} else {
				transactionManager.rollback(status);
				System.out.println("Del--fail");
				message = "오류발생";
			}

		} catch (Exception e) {
			transactionManager.rollback(status);
			System.out.println("fail");
			message = "오류발생";
		}
		return message;
	}

	// buy Confirm
	public String buyConfirm(int buy_num) {
		String message = "";
		int result = 0;
		result = sqlSession.update(namespace + "UpBuyConfirm", buy_num);
		if (result == 1) {
			message = "구매확정 성공";
		}
		return message;
	}

	// SelGetExpressNum
	// get ExpressNum

	public int getExpressNum(int buy_num) {
		return sqlSession.selectOne(namespace + "SelGetExpressNum", buy_num);
	}

}
