package com.basic.codi;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.basic.board.BoardDTO;
import com.basic.board.BoardService;

@Controller
public class IndexController {

	@Autowired
	private BoardService boardService;
	
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String index(Model model){
		Calendar c = Calendar.getInstance();
		String lastDate = c.get(Calendar.YEAR) + "-" + (c.get(Calendar.MONTH)+1) + "-" + c.get(Calendar.DAY_OF_MONTH);
		String startDate = (c.get(Calendar.YEAR)-100) + "-" + (c.get(Calendar.MONTH)+1) + "-" + c.get(Calendar.DAY_OF_MONTH);
		
		model.addAttribute("lastDate", lastDate);
		model.addAttribute("startDate", startDate);
		return "index";
	}

	@RequestMapping(value="/board/bestList", method= RequestMethod.GET)
	@ResponseBody//responseBody 사용시 model 불필요
	public ResponseEntity<List<BoardDTO>> boardlist(@RequestParam(defaultValue="1") int curPage, @RequestParam(defaultValue="3") int perPage, Model model){
		//System.out.println("JSON BEST LIST");
		//System.out.println("cur : " +curPage);
		//System.out.println("per : " +perPage);
		List<BoardDTO> list = boardService.bestList(curPage, perPage, model);
		ResponseEntity<List<BoardDTO>> re ;
		if(HttpStatus.OK != null){			
			re = new ResponseEntity<List<BoardDTO>>(list,HttpStatus.OK);//보통 이런식으로 설정해준ㄷ아!!@ 에러시에도 설정해줄수있다
		}/*else if(HttpStatus.NOT_FOUND !=null){
			re =new ResponseEntity<List<BoardDTO>>(list,HttpStatus.NOT_FOUND);//보통 이런식으로 설정해준ㄷ아!!@ 에러시에도 설정해줄수있다
		}*/
		return new ResponseEntity<List<BoardDTO>>(list,HttpStatus.OK);//보통 이런식으로 설정해준ㄷ아!!@ 에러시에도 설정해줄수있다;
	}	
	
	
}
