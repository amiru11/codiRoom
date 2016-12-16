package com.basic.mast;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MastDAO {
	
	@Autowired
	private SqlSession sqlSession;
	private String namespace = "MastMapper.";
	
	public List<MastBuyListDTO> mastBuyList(int state_num){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state_num", state_num);
		return sqlSession.selectList(namespace+"SelMastBuyList",map);
	}
	
	public int mastUpState(int buy_num,int buyState_state,Integer buyState_expressNum){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("buy_num", buy_num);
		map.put("buyState_state", buyState_state);
		map.put("buyState_expressNum", buyState_expressNum);
		return sqlSession.update(namespace+"UpBuyState", map);
	}

}
