package com.basic.mast;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.basic.buy.BuyStateDTO;

@Repository
public class MastDAO {
	
	@Autowired
	private SqlSession sqlSession;
	private String namespace = "MastMapper.";
	
	public List<MastBuyListDTO> mastBuyList(int state_num){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state_num", state_num);
		if(state_num==4){
			sqlSession.update(namespace+"UpBuyStateAuto");
		}
		return sqlSession.selectList(namespace+"SelMastBuyList",map);
	}
	
	public int mastUpState(int buy_num,int buyState_state,int buyState_expressNum){
		System.out.println("num--"+buy_num);
		System.out.println("state--"+buyState_state);
		System.out.println("exp--"+buyState_expressNum);

		
		
		Map<String, Integer> map = new HashMap<String, Integer>();
		BuyStateDTO buyStateDTO = new BuyStateDTO();
		buyStateDTO.setBuy_num(buy_num);
		buyStateDTO.setBuyState_expressNum(buyState_expressNum);
		buyStateDTO.setBuyState_state(buyState_state);
		

		return sqlSession.update(namespace+"UpBuyState",buyStateDTO);
	}

}
