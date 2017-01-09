package com.basic.mast;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	
	//mast kind add SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
		public int mastKindAdd(String kind_name,int productSelect_num) {
			Map<String, Object> map = new HashMap<>();
			map.put("productSelect_num", productSelect_num);
			map.put("kind_name", kind_name);
			int kind_num = sqlSession.selectOne(namespace+"SelMastLastKindNum");
			kind_num = kind_num+1;
			map.put("kind_num",kind_num);
			return sqlSession.insert(namespace+"InMastKindAdd",map);
		}
		//mast kind add EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
	

	// mast product Pic fixSSSSSSSSSS
	public int mastProductPicFix(HttpSession session,MultipartHttpServletRequest mr) {
		String savePath = session.getServletContext().getRealPath("resources/testPic");
		int product_num = Integer.parseInt(mr.getParameter("product_num"));
		MultipartFile mf = mr.getFile("productPic_pic");
		UUID uid = UUID.randomUUID();
		String saveName = uid.toString() + "_" + mf.getOriginalFilename();
		byte[] filedata;
		try {
			filedata = mf.getBytes();
			File f = new File(savePath, saveName);
			FileCopyUtils.copy(filedata, f);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Map<String, Object> map = new HashMap<>();
		map.put("productPic_pic", saveName);
		map.put("product_num", product_num);

		return sqlSession.update(namespace + "UpMastProductPicFix", map);
	}
	// mast product Pic fix EEEEEEEEEEEEEEEEEEEEEEEEEE

	// mast product Add SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

	public int mastProductAdd(MastProductAddParamDTO paramDTO, HttpSession session) {
		int result = 0;
		String savePath = session.getServletContext().getRealPath("resources/testPic");

		MultipartFile mt = paramDTO.getProductPic_pic();

		UUID uid = UUID.randomUUID();
		String saveName = uid.toString();
		System.out.println(saveName);
		saveName = saveName + "_" + mt.getOriginalFilename();
		System.out.println(savePath);
		File f = new File(savePath, saveName);
		Map<String, Object> map = new HashMap<>();
		map.put("productPic_pic", saveName);
		map.put("DTO", paramDTO);
		try {
			mt.transferTo(f);
			def = new DefaultTransactionDefinition();
			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

			status = transactionManager.getTransaction(def);
			try {
				result = sqlSession.insert(namespace + "InMastProductAdd", map);
				if (result > 0) {
					result = sqlSession.insert(namespace + "InMastProductInfoAdd", map);
					if (result > 0) {
						result = sqlSession.insert(namespace + "InMastProductKindAdd", map);
						if (result > 0) {
							result = sqlSession.insert(namespace + "InMastProductPicAdd", map);
						}else{
							result=0;
						}
					}else{
						result=0;
					}
				}else{
					result=0;
				}
				if (result > 0) {
					transactionManager.commit(status);
					System.out.println("success");
				} else {
					result = 0;
					System.out.println("try fails");
				}

			} catch (Exception e) {
				// TODO: handle exception
				transactionManager.rollback(status);
				System.out.println("fail");
				result = 0;
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

	// mast product Add EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

	// mast productList S -------------------------------

	public List<ProductAllDTO> mastProductList(Map<String, Object> map, PageMaker pageMaker) {
		map.put("pageMaker", pageMaker);
		List<ProductAllDTO> ar = sqlSession.selectList(namespace + "SelMastProductList", map);
		for (int i = 0; i < ar.size(); i++) {
			/*System.out.println(i + "--------------------" + i);
			System.out.println(ar.get(i).getSelCount());
			System.out.println(ar.get(i).getProductSelectDTO().getProductSelect_name());
			System.out.println(ar.get(i).getProductSelectDTO().getProductSelect_num());
			System.out.println(ar.get(i).getKindDTO().getKind_name());
			System.out.println(ar.get(i).getKindDTO().getKind_num());
			System.out.println(ar.get(i).getProductDTO().getProduct_name());
			System.out.println(ar.get(i).getProductDTO().getProduct_num());
			System.out.println(ar.get(i).getProductInfoDTO().getProductInfo_price());
			System.out.println(ar.get(i).getProductInfoDTO().getProductInfo_saleRate());*/

		}
		System.out.println(ar.size());
		return sqlSession.selectList(namespace + "SelMastProductList", map);
	}

	public int mastProductCount(Map<String, Object> map) {
		int a = sqlSession.selectOne(namespace + "SelMastProductCount", map);
		System.out.println("aaalleach" + a);
		return sqlSession.selectOne(namespace + "SelMastProductCount", map);
	}

	public List<ProductSizeDTO> mastProductViewSizeList(int product_num) {
		return sqlSession.selectList(namespace + "SelMastProductViewSizeList", product_num);
	}

	public int mastProductSizeAdd(int product_num, String productSize_size) {
		Map<String, Object> map = new HashMap<>();
		map.put("product_num", product_num);
		map.put("productSize_size", productSize_size);
		return sqlSession.insert(namespace + "InMastProductSizeAdd", map);
	}

	public int mastProductEachAdd(int product_num, String productSize_size, String productEach_color,
			int productEach_each) {
		int result = 0;

		Map<String, Object> map = new HashMap<>();
		map.put("product_num", product_num);
		map.put("productSize_size", productSize_size);
		map.put("productEach_color", productEach_color);
		map.put("productEach_each", productEach_each);
		int check = sqlSession.selectOne(namespace + "SelMastProductEachAddCheck", map);
		if (check > 0) {
			result = sqlSession.update(namespace + "UpMastProductEachAdd", map);
		} else {
			result = sqlSession.insert(namespace + "InMastProductEachAdd", map);
		}

		return result;
	}

	public List<KindDTO> mastKindList() {
		return sqlSession.selectList(namespace + "SelMastKindSelList");
	}

	public List<ProductSelectDTO> mastProductSelectList() {
		return sqlSession.selectList(namespace + "SelMastProductSelectSelList");
	}

	public List<ProductDTO> mastProductList() {
		return sqlSession.selectList(namespace + "SelMastProductSelList");
	}

	public List<ProductSizeDTO> mastProductSizeList() {
		return sqlSession.selectList(namespace + "SelMastProductSizeSelList");
	}

	public List<ProductEachDTO> mastProductColorList() {
		return sqlSession.selectList(namespace + "SelMastProductColorSelList");
	}

	public int mastProductInfoFix(Map<String, Object> map) {
		int result = 0;
		def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		status = transactionManager.getTransaction(def);

		try {
			result = sqlSession.update(namespace + "UpProductInfoFix", map);
			if (result > 0) {
				result = sqlSession.update(namespace + "UpProductInfoDate2", map);
			}
			if (result > 0) {
				transactionManager.commit(status);
				System.out.println("success");
			}
		} catch (Exception e) {
			// TODO: handle exception
			transactionManager.rollback(status);
			System.out.println("fail");
			result = 0;
		}
		return result;

	}

	// mast product List E------------------------------

	// mast product List Each 0 S -----------------------------------------
	public List<MastProductViewDTO> mastProductListEach0() {
		List<MastProductViewDTO> ar = sqlSession.selectList(namespace + "SelMastProductListEach0");
		System.out.println(ar.size());
		return sqlSession.selectList(namespace + "SelMastProductListEach0");
	}

	// mast product List Each 0 E -----------------------------------------

	public MastProductViewDTO mastProductAllInfo(int product_num) {
		System.out.println(product_num);
		MastProductViewDTO mastProductViewDTO = sqlSession.selectOne(namespace + "SelMastProductInfoAll", product_num);

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

	// mast product Each fix

	public int mastProductEachFix(int product_num, String productSize_size, String productEach_color,
			int productEach_each) {
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
			result = sqlSession.update(namespace + "UpProductEach", productEachDTO);
			if (result > 0) {
				result = sqlSession.update(namespace + "UpProductInfoDate", product_num);
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

	///////////////////////////////////////////////////////// 회원관리///////////////////////////////////////////////////////

	// 회원리스트//
	public List<MemberDTO> findList(String type, String find, PageMaker pageMaker) throws Exception {
		Map<String, Object> mp = new HashMap<String, Object>();
		mp.put("type", type);
		mp.put("find", "%" + find + "%");
		mp.put("paging", pageMaker);
		ar = sqlSession.selectList(namespace + "findList", mp);
		return ar;
	}

	// 페이징시 회원수세기//
	public int memberCount() throws Exception {
		int result = 0;
		result = sqlSession.selectOne(namespace + "memberCount");

		/*
		 * if(board_kind==4){ result =
		 * sqlSession.selectOne(namespace4+"boardCount");
		 * System.out.println(namespace4 +"count"); }
		 */
		return result;
	};

	// 회원삭제//
	public int memberDelete(String id) throws Exception {
		Map<String, Object> mp = new HashMap<String, Object>();
		mp.put("id", id);
		return sqlSession.delete(namespace + "memberDelete", id);
	}

}
