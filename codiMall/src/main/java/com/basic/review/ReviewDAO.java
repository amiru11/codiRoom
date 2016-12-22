package com.basic.review;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.basic.board.BoardDTO;
import com.basic.util.PageMaker;

@Repository
public class ReviewDAO {
	
	
	String namespace="ReviewMapper.";
	
	@Autowired
	private SqlSession sqlSession;
	
	//리뷰리스트
	public List<ReviewDTO> reviewList(ReviewDTO reviewDTO,PageMaker pageMaker){
		System.out.println("reviewDAO접속");
		Map<String, Object> rm = new HashMap<>();
		rm.put("review", reviewDTO);
		rm.put("page", pageMaker);
		rm.put("page", pageMaker);
		List<ReviewDTO> ar =sqlSession.selectList(namespace+"reviewList",rm);
		return ar;	
	}
	public int reviewWrite(ReviewDTO reviewDTO) throws Exception{		
		int result = 0;
		result = sqlSession.insert(namespace+"reviewWrite", reviewDTO);		
		return result;
	}
	//리뷰 하나 보기
	public ReviewDTO review(ReviewDTO reviewDTO){
		return sqlSession.selectOne(namespace+"review", reviewDTO);	
	}
	//리뷰 수정
	public int reviewUpdate(ReviewDTO reviewDTO){
		System.out.println("reviewUpdateDAO 접속");
		return sqlSession.update(namespace+"reviewUpdate", reviewDTO);
		
	}
	//리뷰 삭제
	public int reviewDel(ReviewDTO reviewDTO){
		System.out.println("deleteDAO접속");
		System.out.println(reviewDTO.getReview_num());
		return sqlSession.delete(namespace+"reviewDel", reviewDTO);
		
	}
	//리뷰 count
	public int reviewCount(){
		return sqlSession.selectOne(namespace+"reviewCount");
	}
	

}
