package com.basic.product;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.basic.member.MemberDTO;
import com.basic.util.PageMaker;

@Repository
public class ProductDAO {
	@Autowired
	SqlSession sqlSession;
	private String namespace = "ProductMapper.";

	@Autowired
	private PlatformTransactionManager transactionManager;

	DefaultTransactionDefinition def = null;
	TransactionStatus status = null;

	// productSale List
	public List<ProductListDTO> productSaleList(PageMaker pageMaker) {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("pageMaker", pageMaker);
		return sqlSession.selectList(namespace + "SelProductSaleList", hm);
	}

	public int productSaleCount() {
		return sqlSession.selectOne(namespace + "SelProductSaleCount");
	}

	// productSelect List

	public List<ProductSelectDTO> productSelectList() {
		List<ProductSelectDTO> ar = new ArrayList<>();
		ar = sqlSession.selectList(namespace + "SelProductSelectList");
		for (int i = 0; i < ar.size(); i++) {
			System.out.println(i + "-----------------" + i);
			System.out.println(ar.get(i).getProductSelect_name());
		}
		return sqlSession.selectList(namespace + "SelProductSelectList");
	}

	public int productCount(ProductParamDTO productParamDTO) {
		return sqlSession.selectOne(namespace + "SelProductCount", productParamDTO);
	}

	public List<ProductListDTO> productList(PageMaker pageMaker, ProductParamDTO productParamDTO) {
		// TODO Auto-generated method stub
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("pageMaker", pageMaker);
		hm.put("productParamDTO", productParamDTO);
		return sqlSession.selectList(namespace + "SelProductList", hm);
	}

	public ProductViewDTO productView(int product_num) {
		return sqlSession.selectOne(namespace + "SelProductView", product_num);
	}

	public int productAdd(ProductAddDTO productAddDTO) {
		System.out.println("padDAO--add");
		System.out.println(productAddDTO.getProduct_name());
		System.out.println(productAddDTO.getKind_num());
		System.out.println(productAddDTO.getProductInfo_price());

		def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		status = transactionManager.getTransaction(def);

		int result = 0;

		try {
			result = sqlSession.insert(namespace + "ProductAdd", productAddDTO);
			System.out.println("result1----" + result);
			result = sqlSession.insert(namespace + "ProductInfoAdd", productAddDTO);
			System.out.println("result2----" + result);
			result = sqlSession.insert(namespace + "ProductKindAdd", productAddDTO);
			System.out.println("result3----" + result);
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

	public int productEachAdd(ProductEachAddDTOs productEachAddDTOs) {
		int result = 0;
		for (int i = 0; i < productEachAddDTOs.getProductEach_color().length; i++) {
			ProductEachAddDTO productEachAddDTO = new ProductEachAddDTO();
			productEachAddDTO.setProduct_num(productEachAddDTOs.getProduct_num());
			productEachAddDTO.setProductSize_size(productEachAddDTOs.getProductSize_size()[i]);
			productEachAddDTO.setProductEach_color(productEachAddDTOs.getProductEach_color()[i]);
			productEachAddDTO.setProductEach_each(productEachAddDTOs.getProductEach_each()[i]);
			try {
				def = new DefaultTransactionDefinition();
				def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
				status = transactionManager.getTransaction(def);
				result = sqlSession.selectOne(namespace + "ProductSizeCheck", productEachAddDTO);
				System.out.println("RESULT 1 -" + result);
				if (result > 0) {
				} else {
					result = sqlSession.insert(namespace + "ProductSizeAdd", productEachAddDTO);
					// System.out.println("RESULT 1_1 -"+result);
				}
				System.out.println("-------------------------------------------------");

				result = sqlSession.insert(namespace + "ProductEachAdd", productEachAddDTO);
				System.out.println("RESULT 2 -" + result);
				if (result > 0) {
					transactionManager.commit(status);
					System.out.println("success");
				}
			} catch (Exception e) {
				// TODO: handle exception
				transactionManager.rollback(status);
				result = 0;
				System.out.println("FAIL");
			}
		}
		return result;
	}
	// JSon

	public List<String> productSizeList(int product_num) {
		return sqlSession.selectList(namespace + "SelProductSizeList", product_num);
	}

	public List<ProductEachListDTO> productEachList(int product_num, String productSize_size) {
		ProductEachDTO productEachDTO = new ProductEachDTO();
		productEachDTO.setProduct_num(product_num);
		productEachDTO.setProductSize_size(productSize_size);
		return sqlSession.selectList(namespace + "SelProductEachList", productEachDTO);
	}

	public int productEachGet(ProductEachDTO productEachDTO) {
		System.out.println("EA--" + sqlSession.selectOne(namespace + "SelProductEachGet", productEachDTO));
		return sqlSession.selectOne(namespace + "SelProductEachGet", productEachDTO);
	}

	// productBestList

	public List<ProductBestDTO> productBestList() {
		List<ProductBestDTO> ar = new ArrayList<>();
		ar = sqlSession.selectList(namespace + "SelProductBest");
		for (int i = 0; i < ar.size(); i++) {
			System.out.println(i + "---------" + i);
			System.out.println("selCount---" + ar.get(i).getSel_count());
			System.out.println("pronum---" + ar.get(i).getProduct_num());
			System.out.println("proPrice---" + ar.get(i).getProductInfo_price());
		}
		return sqlSession.selectList(namespace + "SelProductBest");
	}

	// product List seach use size and color and kind_num

	public List<String> allProductSize(int productSelect_num) {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("productSelect_num", productSelect_num);
		return sqlSession.selectList(namespace + "SelAllProductSize", hm);
	}

	public List<String> allProductColor(int productSelect_num) {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("productSelect_num", productSelect_num);
		return sqlSession.selectList(namespace + "SelAllProductColor", hm);
	}

	public List<Integer> allKindNum(int productSelect_num) {
		HashMap<String, Object> hm = new HashMap<String, Object>();
		hm.put("productSelect_num", productSelect_num);
		return sqlSession.selectList(namespace + "SelAllKindNum", hm);
	}

	// AUTO ADD FUNCTION
	/*public void proAdd() {
		for (int i = 7; i < 14; i++) {
			System.out.println("i---start---" + i);
			for (int j = 0; j < 50; j++) {

				Calendar c = Calendar.getInstance();
				Random r = new Random(c.getTimeInMillis());
				// 65~90
				int a = r.nextInt(26) + 65;
				char c1 = (char) a;
				for (int k = 0; k < 10000000; k++) {
				}
				a = r.nextInt(26) + 65;
				char c2 = (char) a;
				for (int k = 0; k < 10000000; k++) {
				}
				a = r.nextInt(26) + 65;
				char c3 = (char) a;
				String name = String.valueOf(c1) + String.valueOf(c2) + String.valueOf(c3);

				ProductAddDTO productAddDTO = new ProductAddDTO();
				productAddDTO.setKind_num(i);
				productAddDTO.setProduct_name(name + i + j);
				productAddDTO.setProductInfo_price(i * 10000 + j * 1000);
				productAddDTO.setProductInfo_searchWord(String.valueOf(c1) + String.valueOf(c2) + String.valueOf(c3));
				productAddDTO.setProductInfo_SaleRate(r.nextInt(100) / 10);

				System.out.println("j---start---" + j);
				def = new DefaultTransactionDefinition();
				def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

				status = transactionManager.getTransaction(def);

				int result = 0;

				try {
					result = sqlSession.insert(namespace + "ProductAdd", productAddDTO);
					System.out.println("result1----" + result);
					result = sqlSession.insert(namespace + "ProductInfoAdd", productAddDTO);
					System.out.println("result2----" + result);
					result = sqlSession.insert(namespace + "ProductKindAdd", productAddDTO);
					System.out.println("result3----" + result);
					if (result > 0) {
						transactionManager.commit(status);
						System.out.println("success");
					}
				} catch (Exception e) {
					// TODO: handle exception
					transactionManager.rollback(status);
					result = 0;
				} finally {
					for (int k = 0; k < 120000000; k++) {
						for (int k2 = 0; k2 < 1; k2++) {
						}
					}
				}

			}
		}

	}*/
/*
	public int autoAdd() {
		String colorArray[] = { "RED", "ORANGE", "YELLOW", "GREEN", "BLUE", "NAVY", "PURPLE", "BLACK", "GRAY", "IVORY",
				"BROWN" };
		String sizeArray[] = { "SSS", "SS", "S", "M", "L", "XL", "XXL" };
		// 11COLOR
		for (int i = 798; i < 799; i++) {
			System.out.println(i + "i-----start----i" + i);
			for (int z = 0; z < sizeArray.length; z++) {
				System.out.println(z + "z-----start----z" + z);

				for (int j = 0; j < colorArray.length; j++) {
					System.out.println(j + "j-----start----j" + j);

					ProductEachAddDTO productEachAddDTO = new ProductEachAddDTO();
					productEachAddDTO.setProduct_num(i);
					productEachAddDTO.setProductEach_color(colorArray[j]);
					productEachAddDTO.setProductEach_each(i * 10 + j);
					productEachAddDTO.setProductSize_size(sizeArray[z]);

					int result = 0;
					try {

						def = new DefaultTransactionDefinition();
						def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
						status = transactionManager.getTransaction(def);
						result = sqlSession.selectOne(namespace + "ProductSizeCheck", productEachAddDTO);
						System.out.println("RESULT 1 -" + result);
						if (result > 0) {
						} else {
							result = sqlSession.insert(namespace + "ProductSizeAdd", productEachAddDTO);
							// System.out.println("RESULT 1_1 -"+result);
						}
						System.out.println("-------------------------------------------------");

						result = sqlSession.insert(namespace + "ProductEachAdd", productEachAddDTO);
						System.out.println("RESULT 2 -" + result);
						if (result > 0) {
							transactionManager.commit(status);
							System.out.println("success");
						}
					} catch (Exception e) {
						// TODO: handle exception
						transactionManager.rollback(status);
						result = 0;
						System.out.println("FAIL");
					} finally {
						for (int k = 0; k < 50000000; k++) {
							for (int k2 = 0; k2 < 2; k2++) {
							}
						}

					}

					System.out.println(j + "j-----end----j" + j);
				}
				System.out.println(z + "z-----end----z" + z);

			}
			System.out.println(i + "i-----end----i" + i);

		}

		return 0;
	}*/
/*
	public void testPicADD(MultipartHttpServletRequest mpr, HttpSession session) {
		String savePath = session.getServletContext().getRealPath("resources/upload");
		// 위에가 리얼패스 아래는 임시용 배포전 아래꺼 삭제

		// 이동전의 폴더
		String inFolder = "C:\\Users\\NotePerson\\Desktop\\a_z\\testPic\\";
		// 이동후의 폴더
		String outFolder = "C:\\Users\\NotePerson\\git\\codiMall\\codiMall\\src\\main\\webapp\\resources\\testPic";

		savePath = "C:\\Users\\NotePerson\\git\\codiMall\\codiMall\\src\\main\\webapp\\resources\\testPic";

		
		 * File f = new
		 * File("C:\\Users\\NotePerson\\Desktop\\a_z\\testPic\\a.jpg");
		 * System.out.println("File----" + f.getPath());
		 * System.out.println("fgetname--" + f.getName());
		 * System.out.println("fabsoloutpath---" + f.getAbsolutePath());
		 
		int result = 0;
		int alp = 97;
		for (int j = 1; j < 800; j++) {
			UUID uid = UUID.randomUUID();
			String saveName = uid.toString();
			saveName = saveName + ".jpg";
			char a = (char) alp;
			ProductPicDTO productPicDTO = new ProductPicDTO();
			Integer product_num = sqlSession.selectOne(namespace + "SelGetTestProductNum", j);
			if (product_num != null) {
				productPicDTO.setProduct_num(product_num);
				productPicDTO.setProductPic_pic(saveName);
				result = sqlSession.insert(namespace + "InsTestFileUp", productPicDTO);
				if (result > 0) {
					System.out.println("success");
					fileCopy("C:\\Users\\NotePerson\\Desktop\\a_z\\testPic\\" + a + ".jpg",
							outFolder + "\\" + saveName);
				} else {
					System.out.println("fail");
				}
				alp++;
				if (alp == 123) {
					alp = 97;
				}
				System.out.println((char)alp+"c-----n"+alp);
				for (int k = 0; k < 10000; k++) {
					for (int k2 = 0; k2 < 1; k2++) {
					}
				}
			}
		}

	}

	public static void fileCopy(String inFileName, String outFileName) {
		try {
			FileInputStream fis = new FileInputStream(inFileName);
			FileOutputStream fos = new FileOutputStream(outFileName);

			int data = 0;
			while ((data = fis.read()) != -1) {
				fos.write(data);
			}
			fis.close();
			fos.close();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}*/

}