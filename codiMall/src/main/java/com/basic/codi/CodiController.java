package com.basic.codi;

<<<<<<< HEAD
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.basic.codiCl.CodiService;

@Controller
@RequestMapping(value="/codi")
public class CodiController {
	
	@Autowired
	private CodiService codiService;
	
	@RequestMapping(value="/codiMake")
	public void codiMake(){
	}

=======
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.util.Base64;
import java.util.Calendar;

import javax.imageio.ImageIO;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.basic.fashion.CodiDTO;
import com.basic.fashion.CodiService;
import com.basic.member.MemberDTO;
import com.basic.util.PageMaker;

@Controller
@RequestMapping(value = "fashion")
public class CodiController {
	
	@Inject
	private CodiService codiService;
	
	//코디 리스트
	@RequestMapping(value = "codiList")
	public void codiList(@RequestParam(defaultValue="1") int curPage, @RequestParam(defaultValue="10") int perPage, CodiDTO codiDTO, Model model){
		PageMaker pageMaker = new PageMaker();
		pageMaker.setPerPage(perPage);
		pageMaker.setCurPage(curPage);
		try {
			codiService.codiList(pageMaker, codiDTO, model);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//코디 생성 페이지
	@RequestMapping(value = "codiWrite")
	public void codiWrite(){
		
	}
	
	@RequestMapping(value = "codiCreate")
	public void codiCreate(HttpServletRequest request, HttpSession session){
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
            Calendar c = Calendar.getInstance();
            String fileTime = c.get(Calendar.YEAR) + String.valueOf((c.get(Calendar.MONTH)+1)) + c.get(Calendar.DAY_OF_MONTH);;
            //파일 저장 경로
            String path = session.getServletContext().getRealPath("/resources/codiUpload");
            File file = new File(path, memberDTO.getId() + "_" + fileTime +".png");
            //실제 파일로 이미지 저장
            ImageIO.write(image, "png", file);
            
            
/*            response.setContentType("image/png");
            response.setHeader("Content-Disposition", "attachment; filename=" +"11"+ ".png");
            IOUtils.copy(is,  response.getOutputStream());
            response.flushBuffer();
            System.out.println(response.getBufferSize());
            System.out.println(response.getLocale());
            System.out.println(response.getOutputStream());*/
        } catch (Exception e) {
            
        }
	}
	
>>>>>>> refs/heads/Mir1212
}
