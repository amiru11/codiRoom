package com.basic.review;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import com.basic.util.PageMaker;

@Service
public class ReviewService {
	
	@Autowired
	private ReviewDAO reviewDAO;
	//리뷰리스트
		public void reviewList(ReviewDTO reviewDTO,int curPage,int perPage,Model model){
			System.out.println("reviewService접속");
			System.out.println("review상품번호 :"+reviewDTO.getReview_product());
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCurPage(curPage);
			pageMaker.setPerPage(perPage);
			pageMaker.makeRow();
			pageMaker.makePage(reviewDAO.reviewCount());
			List<ReviewDTO> ar=reviewDAO.reviewList(reviewDTO, pageMaker);
			for(int i=0;i<ar.size();i++){
				System.out.println("리뷰num :"+ar.get(i).getReview_num());		
			}
			model.addAttribute("reviewList",ar);
			model.addAttribute("paging", pageMaker);
			
			
		}
		//리뷰 글쓰기
		public String reviewWrite(ReviewDTO reviewDTO, MultipartHttpServletRequest mr, HttpSession session) throws Exception {
			int result = 0;
			if(!mr.getFile("reviewfile").getOriginalFilename().equals("")){
			String path = session.getServletContext().getRealPath("resources/upload");//파일저장경로 만들어주기
			System.out.println("이미지경로 :"+mr.getFile("reviewfile"));
			MultipartFile reviewfile = mr.getFile("reviewfile");			
					String fileName = UUID.randomUUID().toString()+"_" + reviewfile.getOriginalFilename();//랜덤 아이디를 붙어주면서 fileName 만들어주기
					File file = new File(path, fileName);
					reviewfile.transferTo(file);//TransferTo를 통해 파일객체에 경로+파일명 저장
					System.out.println("파일 :"+file);				
					reviewDTO.setReview_img(fileName);
			}
			result = reviewDAO.reviewWrite(reviewDTO);
			
			String message = "";
			if(result > 0){
				message = "등록완료!";
			}else{
				message = "등록실패!";
			}
			
			System.out.println("결과 : "+message);
			return message;
		}
		//리뷰 하나 보기
		public ReviewDTO review(Model model,ReviewDTO reviewDTO){
			reviewDTO=reviewDAO.review(reviewDTO);
			model.addAttribute("review", reviewDTO);
			return reviewDTO;	
		}
		//리뷰 수정
		public String reviewUpdate(ReviewDTO reviewDTO,MultipartHttpServletRequest mr,HttpSession session,String fileimg){
			System.out.println("reviewupdate서비스 접속");
			if(!mr.getFile("reviewfile").getOriginalFilename().equals("")){
			String path = session.getServletContext().getRealPath("resources/upload");//파일저장경로 만들어주기
			MultipartFile reviewfile = mr.getFile("reviewfile");			
					String fileName = UUID.randomUUID().toString()+"_" + reviewfile.getOriginalFilename();//랜덤 아이디를 붙어주면서 fileName 만들어주기
					File file = new File(path, fileName);
						try {
							reviewfile.transferTo(file);
						} catch (IllegalStateException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					//TransferTo를 통해 파일객체에 경로+파일명 저장
					System.out.println("파일 :"+file);
					reviewDTO.setReview_img(fileName);
			}else if(mr.getFile("reviewfile").getOriginalFilename().equals("")){	
				reviewDTO.setReview_img(fileimg);
			}
			System.out.println("뷰 수정 최종파일 :"+reviewDTO.getReview_img());
			int result = reviewDAO.reviewUpdate(reviewDTO);
			String message = "";
			if(result > 0){
				message = "수정완료!";
			}else{
				message = "수정실패!";
			}
			
			System.out.println("결과 : "+message);
			return message;
			
		}
		//리뷰 삭제
		public String reviewDel(ReviewDTO reviewDTO){
			System.out.println("delete서비스 접속");
			System.out.println(reviewDTO.getReview_num());
			int result = reviewDAO.reviewDel(reviewDTO);
			String message = "";
			if(result > 0){
				message = "삭제완료!";
			}else{
				message = "삭제실패!";
			}
			
			System.out.println("결과 : "+message);
			return message;
			
		}

}
