package com.basic.smart;

import java.io.File;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "/board")
public class BoardController {
	@RequestMapping(value = "/boardView")
	public void boardView() {

	}

	@RequestMapping(value = "/boardWrite", method = RequestMethod.GET)
	public void boardWrite() {

	}

	@RequestMapping(value = "/boardWrite", method = RequestMethod.POST)
	public String boardWrite(String title, String contents, Model model, RedirectAttributes rd) {
		model.addAttribute("title", title);
		model.addAttribute("contents", contents);
		rd.addFlashAttribute("title", title);
		rd.addFlashAttribute("contents", contents);
		System.out.println(title);
		System.out.println(contents);

		return "redirect:/board/boardView";

	}

	@RequestMapping(value = "/fileupload")
	public String fileupload(PhotoDTO photoDTO, HttpSession session) {
		System.out.println("gggg");
		String rootPath = "";
		rootPath = session.getServletContext().getContextPath();
		System.out.println(session.getServletContext().getContextPath());
		String callback = photoDTO.getCallback();
		String callback_func = photoDTO.getCallback_func();
		String file_result = "";
		try {
			if (photoDTO.getFiledata() != null && photoDTO.getFiledata().getOriginalFilename() != null
					&& !photoDTO.getFiledata().getOriginalFilename().equals("")) {
				// 파일이 존재하면
				String original_name = photoDTO.getFiledata().getOriginalFilename();
				String ext = original_name.substring(original_name.lastIndexOf(".") + 1);
				// 파일 기본경로
				String defaultPath = session.getServletContext().getRealPath("/");
				// 파일 기본경로 _ 상세경로
				String path = defaultPath + "resources" + File.separator + "upload" + File.separator;
				File file = new File(path);
				System.out.println("path:" + path);
				// 디렉토리 존재하지 않을경우 디렉토리 생성
				if (!file.exists()) {
					file.mkdirs();
				}

				// 서버에 업로드 할 파일명(한글문제로 인해 원본파일은 올리지 않는것이 좋음)
				String realname = UUID.randomUUID().toString() + "." + ext;
				///////////////// 서버에 파일쓰기 /////////////////
				photoDTO.getFiledata().transferTo(new File(path + realname));
				file_result += "&bNewLine=true&sFileName=" + original_name + "&sFileURL="+rootPath+"/resources/upload/"
						+ realname;
			} else {
				file_result += "&errstr=error";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("redirect:" + callback + "?callback_func=" + callback_func + file_result);
		return "redirect:" + callback + "?callback_func=" + callback_func + file_result;
	}

}
