package com.basic.mast;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class MastService {
	
	@Autowired
	private MastDAO mastDAO;
	
	public List<MastBuyListDTO> mastBuyList(int state_num){
		return mastDAO.mastBuyList(state_num);
	}
	
	public int mastUpState(int buy_num,int buyState_state,Integer buyState_expressNum){
		return mastDAO.mastUpState(buy_num, buyState_state, buyState_expressNum);
	}
}
