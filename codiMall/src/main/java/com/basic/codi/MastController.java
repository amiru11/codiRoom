package com.basic.codi;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.mast.MastService;
import com.basic.member.MemberDTO;
import com.basic.review.ReviewDTO;
import com.basic.review.ReviewService;

@Controller
@RequestMapping(value="/mast")
public class MastController {

	@Autowired
	private MastService mastService;
	@Autowired
	private ReviewService reviewService;
	
	
	
	
	@RequestMapping(value="/mastIndex")
	public String mastIndex(HttpSession session){
		String path="";
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		if(memberDTO !=null && memberDTO.getMember_level() == 0 ){
			path="/mast/mastIndex";
		}else{
			path="redirect:/";
		}
		return path;
	}
	
	@RequestMapping(value="/mastBuyList")
	public String mastBuyList(HttpSession session,Model model,@RequestParam(defaultValue="1") int state_num){
		String path="";
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("member");
		if(memberDTO !=null && memberDTO.getMember_level() == 0 ){
			model.addAttribute("list",mastService.mastBuyList(state_num));
			path="/mast/mastBuyList";
		}else{
			path="redirect:/";
		}
		return path;
		
	}
	
	@RequestMapping(value="/calendar")
	public String mastCalender(){
		String path="";
			path="/mast/calendar";
		return path;
	}
	
	@RequestMapping(value="/boardList")
	public String boardList(@RequestParam(defaultValue="1") int curPage, 
			@RequestParam(defaultValue="10") int perPage,@RequestParam int board_kind,Model model,@RequestParam(defaultValue="0")int productGroup){
			System.out.println("pagelist접속 ");
			System.out.println("board_kind :"+ board_kind);
			System.out.println("productGroup :"+ productGroup);
			model.addAttribute("board_kind", board_kind);
			model.addAttribute("curPage", curPage);
			model.addAttribute("productGroup", productGroup);
		return "mast/mastBoard";
	}
	
	@RequestMapping(value="/resultBoard")
	public String resultBoard(@RequestParam(defaultValue="") String type, @RequestParam(defaultValue="") String find, @RequestParam(defaultValue="1") int curPage,
			@RequestParam(defaultValue="10") int perPage, @RequestParam int board_kind, Model model,@RequestParam(defaultValue="0")int productGroup){
		System.out.println("관리자게시판 컨트롤 접속");
		try {
			mastService.findList(productGroup,type, find, curPage, perPage, board_kind, model);
			System.out.println("BOARD SEARCH");
			System.out.println("BOARD KIND : " +board_kind);
			System.out.println("TYPE : "+type);
			System.out.println("FIND : "+find);
			System.out.println(curPage);
			System.out.println(perPage);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		String path = "";
		path = "mast/resultBoard";
		return path;
	}
	@RequestMapping(value="/reviewList")
	public String reviewList(ReviewDTO reviewDTO,Model model ,@RequestParam(defaultValue="1") int curPage,@RequestParam(defaultValue="10")int perPage,String board_kind){
		System.out.println("review컨트롤러접속");
		System.out.println("review_product"+reviewDTO.getReview_product());
		model.addAttribute("review_product",reviewDTO.getReview_product());
		model.addAttribute("board_kind", board_kind);
		reviewService.reviewList(reviewDTO, curPage, perPage, model);
		return "mast/mastReview";
	}
	@RequestMapping(value="/review")
	public String review(ReviewDTO reviewDTO,Model model){
		System.out.println("관리자리뷰 접속");
		System.out.println("review_num :"+reviewDTO.getReview_num());
		System.out.println("review_product :"+reviewDTO.getReview_product());
		reviewService.review(model, reviewDTO);
		return"mast/mastReview_View";
	}
	@RequestMapping(value="reviewDelete")
	public String reviewDelete(ReviewDTO reviewDTO,RedirectAttributes ra,int productGroup,int board_kind){
		String message= reviewService.reviewDel(reviewDTO);
		ra.addFlashAttribute("message", message);
		return "redirect:/mast/boardList?productGroup="+productGroup+"&board_kind="+board_kind;
	}
	


}
