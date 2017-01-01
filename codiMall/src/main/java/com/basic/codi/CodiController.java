package com.basic.codi;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.basic.fashion.CodiDTO;
import com.basic.fashion.CodiService;
import com.basic.member.MemberDTO;
import com.basic.util.PageMaker;

@Controller
@RequestMapping(value = "fashion")
public class CodiController {
	
	@Autowired
	private CodiService codiService;
	
	//코디 리스트
	@RequestMapping(value = "codiList")
	public String codiList(@RequestParam(defaultValue="1") int curPage, @RequestParam(defaultValue="10") int perPage, CodiDTO codiDTO, Model model){
		try {
			codiService.codiList(curPage, perPage, model);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/fashion/codiList";
	}
	
	//코디 생성 페이지
	@RequestMapping(value = "codiWrite")
	public void codiWrite(){}
	
	//코디 등록 페이지
	@RequestMapping(value = "codiCreate")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> codiCreate(CodiDTO codiDTO, HttpServletRequest request, HttpSession session, Model model){
		Map<String, Object> m = new HashMap<String, Object>();
		int result = 0;
		String message = "";
		try {
			MemberDTO memberDTO = (MemberDTO) request.getSession().getAttribute("member");
			//data 이미지
            String data = request.getParameter("data");
            //data 이미지에서 필요 없는 앞부분 없앤 것
            data = data.replaceAll("data:image/png;base64,", "");
            //byte 단위로 ?
            byte[] bt = Base64.getDecoder().decode(data.getBytes());
            // ?
            ByteArrayInputStream is = new ByteArrayInputStream(bt);
            //이미지로 전환
            BufferedImage image = ImageIO.read(is);
            //파일 이름 생성 및 저장
            Date today = new Date();
            SimpleDateFormat dateForm= new SimpleDateFormat("yyyyMMdd-hhmmss");
            //파일 저장 경로
            String path = session.getServletContext().getRealPath("/resources/codiUpload");
            System.out.println(path);
            String filename = memberDTO.getId() + "_" + dateForm.format(today) +".png";
            File file = new File(path, filename);
            //실제 파일로 이미지 저장
            ImageIO.write(image, "png", file);
            
            codiDTO.setFileName(filename);
            codiDTO.setMember_id(memberDTO.getId());
            
            //DB에 저장
            result = codiService.codiCreate(codiDTO, model);
            if(result > 0){
            	message = "코디 등록 성공";
            }else {
            	message = "코디 등록 실패";
            }
            m.put("result", result);
            m.put("message", message);
        } catch (Exception e) {
            m.put("result", result);
            m.put("message", message);
        }
		return new ResponseEntity<Map<String, Object>>(m, HttpStatus.OK);
	}
	
}
