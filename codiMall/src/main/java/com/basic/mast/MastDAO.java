package com.basic.mast;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;

import com.basic.board.BoardDTO;
import com.basic.buy.BuyStateDTO;
import com.basic.member.MemberDTO;
import com.basic.product.KindDTO;
import com.basic.product.ProductAllDTO;
import com.basic.product.ProductDTO;
import com.basic.product.ProductEachDTO;
import com.basic.product.ProductSelectDTO;
import com.basic.product.ProductSizeDTO;
import com.basic.util.PageMaker;

@Repository
public class MastDAO {

	@Autowired
	private SqlSession sqlSession;
	private String namespace = "MastMapper.";
	
	@Autowired
	private PlatformTransactionManager transactionManager;

	DefaultTransactionDefinition def = null;
	TransactionStatus status = null;


	private List<MemberDTO> ar;
	// mast productList   S -------------------------------

	public List<ProductAllDTO> mastProductList(Map<String, Object> map,PageMaker pageMaker) {
		map.put("pageMaker", pageMaker);
		List<ProductAllDTO> ar = sqlSession.selectList(namespace+"SelMastProductList", map);
		for (int i = 0; i < ar.size(); i++) {
			System.out.println(i+"--------------------"+i);
			System.out.println(ar.get(i).getSelCount());
			System.out.println(ar.get(i).getProductSelectDTO().getProductSelect_name());
			System.out.println(ar.get(i).getProductSelectDTO().getProductSelect_num());
			System.out.println(ar.get(i).getKindDTO().getKind_name());
			System.out.println(ar.get(i).getKindDTO().getKind_num());
			System.out.println(ar.get(i).getProductDTO().getProduct_name());
			System.out.println(ar.get(i).getProductDTO().getProduct_num());
			System.out.println(ar.get(i).getProductInfoDTO().getProductInfo_price());
			System.out.println(ar.get(i).getProductInfoDTO().getProductInfo_saleRate());
			
		}
		System.out.println(ar.size());
		return sqlSession.selectList(namespace+"SelMastProductList", map);
	}

	public int mastProductCount(Map<String, Object> map) {
		int a = sqlSession.selectOne(namespace+"SelMastProductCount", map);
		System.out.println("aaalleach"+a);
		return sqlSession.selectOne(namespace+"SelMastProductCount", map);
	}
	
	public List<KindDTO> mastKindList(){
		return sqlSession.selectList(namespace+"SelMastKindSelList");
	}
	public List<ProductSelectDTO> mastProductSelectList(){
		return sqlSession.selectList(namespace+"SelMastProductSelectSelList");
	}
	public List<ProductDTO> mastProductList(){
		return sqlSession.selectList(namespace+"SelMastProductSelList");
	}
	public List<ProductSizeDTO> mastProductSizeList(){
		return sqlSession.selectList(namespace+"SelMastProductSizeSelList");
	}
	public List<ProductEachDTO> mastProductColorList(){
		return sqlSession.selectList(namespace+"SelMastProductColorSelList");
	}

	
	//  mast product List E------------------------------
	
	// mast product List Each 0  S -----------------------------------------
	public List<MastProductViewDTO> mastProductListEach0(){
		List<MastProductViewDTO> ar = sqlSession.selectList(namespace+"SelMastProductListEach0");
		System.out.println(ar.size());
		return sqlSession.selectList(namespace+"SelMastProductListEach0");
	}
	
	// mast product List Each 0  E -----------------------------------------
	
	
	
	public MastProductViewDTO mastProductAllInfo(int product_num){
		System.out.println(product_num);
		MastProductViewDTO mastProductViewDTO = sqlSession.selectOne(namespace+"SelMastProductInfoAll",product_num);

		return mastProductViewDTO;
	}
	
	

	public List<MastBuyListDTO> mastBuyList(int state_num) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state_num", state_num);
		if (state_num == 4) {
			sqlSession.update(namespace + "UpBuyStateAuto");
		}
		return sqlSession.selectList(namespace + "SelMastBuyList", map);
	}

	public int mastUpState(int buy_num, int buyState_state, int buyState_expressNum) {
		System.out.println("num--" + buy_num);
		System.out.println("state--" + buyState_state);
		System.out.println("exp--" + buyState_expressNum);

		Map<String, Integer> map = new HashMap<String, Integer>();
		BuyStateDTO buyStateDTO = new BuyStateDTO();
		buyStateDTO.setBuy_num(buy_num);
		buyStateDTO.setBuyState_expressNum(buyState_expressNum);
		buyStateDTO.setBuyState_state(buyState_state);

		return sqlSession.update(namespace + "UpBuyState", buyStateDTO);
	}
	
	//mast product Each fix
	
	public int mastProductEachFix(int product_num,String productSize_size,String productEach_color,int productEach_each){
		int result = 0;
		ProductEachDTO productEachDTO = new ProductEachDTO();
		productEachDTO.setProduct_num(product_num);
		productEachDTO.setProductSize_size(productSize_size);
		productEachDTO.setProductEach_color(productEach_color);
		productEachDTO.setProductEach_each(productEach_each);
		def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		status = transactionManager.getTransaction(def);

		try {
			result = sqlSession.update(namespace+"UpProductEach",productEachDTO);
			if(result>0){
				result = sqlSession.update(namespace+"UpProductInfoDate",product_num);
			}
			if (result > 0) {
				transactionManager.commit(status);
				System.out.println("success");
			}
		} catch (Exception e) {
			// TODO: handle exception
			transactionManager.rollback(status);
			System.out.println("faile");
			result = 0;
		}
		return result;
		
	}

	
	
	/////////////////////////////////////////////////////////회원관리///////////////////////////////////////////////////////
	
	//회원리스트//
	public List<MemberDTO> findList(String type, String find,  PageMaker pageMaker) throws Exception{
		Map<String, Object> mp = new HashMap<String, Object>();
		mp.put("type", type);
		mp.put("find", "%"+find+"%");
		mp.put("paging", pageMaker);
		ar = sqlSession.selectList(namespace+"findList", mp);
		return ar;
	}
	//페이징시 회원수세기//
	public int memberCount(){
		int result = 0;
		result = sqlSession.selectOne(namespace+"memberCount");

		/*if(board_kind==4){
			result = sqlSession.selectOne(namespace4+"boardCount");
			System.out.println(namespace4 +"count");
		}*/
		return result;
	};
	
	
}
