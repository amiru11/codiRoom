package com.basic.codi;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.review.ReviewDTO;
import com.basic.review.ReviewService;

@Controller
@RequestMapping(value="/review")
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	@RequestMapping (value="/reviewWriteForm")
	public void reviewWriteform(){
		System.out.println("모달 접속");
	}
	
	@RequestMapping(value="/reviewWrite")
	public String reviewWrite(ReviewDTO reviewDTO, RedirectAttributes rt, MultipartHttpServletRequest mr, HttpSession session){
		System.out.println("reviewWrite접속");
		System.out.println("리뷰 작성자 :"+reviewDTO.getReview_writer());
		System.out.println("리뷰 내용 :"+reviewDTO.getReview_contents());
		System.out.println("리뷰 별점 :"+reviewDTO.getReview_star());
		System.out.println("파일명 :"+mr.getFile("reviewfile"));
		String messege;
		try {
			messege = reviewService.reviewWrite(reviewDTO, mr, session);
			rt.addFlashAttribute("message", messege);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/review/reviewList";
	}
	
	@RequestMapping(value="/review")
	public void review(ReviewDTO reviewDTO,Model model){
		reviewService.review(model, reviewDTO);
	}
	
	@RequestMapping(value="/reviewList")
	public String reviewList(ReviewDTO reviewDTO,Model model ,@RequestParam(defaultValue="1") int curPage,@RequestParam(defaultValue="10")int perPage){
		System.out.println("review컨트롤러접속");
		reviewService.reviewList(reviewDTO, curPage, perPage, model);
		return "review/reviewList";
	}
	
	@RequestMapping(value="reviewUpdateForm")
	public String reviewUpdateForm(Model model,ReviewDTO reviewDTO){
		System.out.println("reviewUpdateForm접속");
		reviewService.review(model, reviewDTO);
		return "review/reviewUpdateForm";
	}
	
	@RequestMapping(value="reviewUpdate")
	public String reviewUpdate(ReviewDTO reviewDTO, RedirectAttributes rt,MultipartHttpServletRequest mr,@RequestParam String fileimg, HttpSession session){
		System.out.println("reviewUpdate접속");
		System.out.println("새파일명 :"+mr.getFile("reviewfile").getOriginalFilename());
		System.out.println("기존 파일이름:"+fileimg);
		String messege=reviewService.reviewUpdate(reviewDTO, mr, session, fileimg);
		rt.addFlashAttribute("message", messege);	
		return "redirect:/review/reviewList";				
	}
	
	@RequestMapping(value="reviewDelete")
	public String reviewdelete(ReviewDTO reviewDTO,RedirectAttributes rt){
		System.out.println("delete컨트롤러 접속");
		System.out.println(reviewDTO.getReview_num());
		String messege=reviewService.reviewDel(reviewDTO);
		rt.addFlashAttribute("messege",messege);
		return "redirect:/review/reviewList";
		
	}

}
