package com.basic.codi;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import java.io.File;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.basic.board.BoardDTO;
import com.basic.board.PhotoDTO;
import com.basic.mast.MastProductAddParamDTO;
import com.basic.mast.MastService;
import com.basic.member.MemberDTO;

@Controller
@RequestMapping(value = "/mast")
public class MastController {

	@Autowired
	private MastService mastService;
	
	@RequestMapping(value="/mastProductAdd" ,method=RequestMethod.GET)
	public String mastProductAddG(HttpSession session){
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			path = "/mast/mastProductAdd";
		} else {
			path = "redirect:/";
		}
		return path;
	}
	@RequestMapping(value="/mastProductAdd" ,method=RequestMethod.POST)
	public String mastProductAddP(HttpSession session,MastProductAddParamDTO paramDTO,RedirectAttributes ra){
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			path = "/mast/mastProductAdd";
		} else {
			path = "redirect:/";
		}
		return path;
	}

	@RequestMapping(value = "/mastIndex")
	public String mastIndex(HttpSession session) {
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			path = "/mast/mastIndex";
		} else {
			path = "redirect:/";
		}
		return path;
	}

	@RequestMapping(value = "/calendar")
	public String mastCalender(HttpSession session) {
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			path = "/mast/calendar";
		} else {
			path = "redirect:/";
		}
		return path;
	}

	///////////////////////////////////////////////////////////// 게시판/////////////////////////////////////////////////////////
	// 사이드메뉴에서 게시판 메뉴 클릭시//
	@RequestMapping(value = "/boardList")
	public String boardList(HttpSession session, @RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "10") int perPage, @RequestParam(defaultValue = "1") int board_kind,
			Model model) {
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			model.addAttribute("board_kind", board_kind);
			path = "mast/board/mastBoard";
		} else {
			path = "redirect:/";
		}
		return path;
	}

	// subMenu로 이동시//
	@RequestMapping(value = "/resultBoard")
	public String resultBoard(HttpSession session, @RequestParam(defaultValue = "") String type,
			@RequestParam(defaultValue = "") String find, @RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "10") int perPage, @RequestParam int board_kind, Model model) {
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			try {
				mastService.findList(type, find, curPage, perPage, board_kind, model);
				System.out.println("BOARD SEARCH");
				System.out.println("BOARD KIND : " + board_kind);
				System.out.println("TYPE : " + type);
				System.out.println("FIND : " + find);
			} catch (Exception e) {
				e.printStackTrace();
			}
			path = "mast/board/list";
		} else {
			path = "redirect:/";
		}
		return path;
	}

	// 글보기//
	@RequestMapping(value = "/boardView")
	public String boardView(HttpSession session, BoardDTO boardDTO, int board_kind, Model model) {
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			try {
				mastService.boardView(boardDTO, board_kind, model);
				System.out.println("BOARD VIEW");
			} catch (Exception e) {
				e.printStackTrace();
			}
			path = "mast/board/view";
		} else {
			path = "redirect:/";
		}
		return path;

	}

	// 글쓰기//
	@RequestMapping(value = "/boardWrite")
	public String boardWrite(HttpSession session, BoardDTO boardDTO, int board_kind, RedirectAttributes ra) {
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			try {
				String message = mastService.boardWrite(boardDTO, board_kind);
				System.out.println("BOARD WRITE");
				System.out.println("BOARD NUM : " + board_kind);
				ra.addFlashAttribute("message", message);
			} catch (Exception e) {
				e.printStackTrace();
			}
			path = "mast/boardList?board_kind=";
			path = "redirect:/" + path + board_kind;
		} else {
			path = "redirect:/";
		}
		return path;
	}

	// 글삭제//
	@RequestMapping(value = "/boardDelete")
	public String boardDelete(HttpSession session, int board_num, int board_kind, RedirectAttributes ra) {
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {

			try {
				String message = mastService.boardDel(board_num, board_kind);
				System.out.println("mastBOARD DEL");
				System.out.println("글 삭제 : " + message);
				ra.addFlashAttribute("message", message);
			} catch (Exception e) {
				e.printStackTrace();
			}
			path = "mast/boardList?board_kind=";
			path = "redirect:/" + path + board_kind;
		} else {
			path = "redirect:/";
		}
		return path;
	}

	// SMART EDITOR//
	@RequestMapping(value = "/seWrite")
	public String fileUpload(PhotoDTO photoDTO, HttpSession session) {
		String callback = photoDTO.getCallback();
		String callback_func = photoDTO.getCallback_func();
		String file_result = "";
		try {
			if (photoDTO.getFiledata() != null && photoDTO.getFiledata().getOriginalFilename() != null
					&& !photoDTO.getFiledata().getOriginalFilename().equals("")) {
				// 파일이 존재하면

				// 파일명
				String original_name = photoDTO.getFiledata().getOriginalFilename();
				// 확장자를 찾는 구간
				String ext = original_name.substring(original_name.lastIndexOf(".") + 1);
				// 파일 기본 경로
				String defaultPath = session.getServletContext().getRealPath("/");
				// 파일 상세경로
				String path = defaultPath + "resources" + File.separator + "upload"; // separator는
																						// 구분자!!

				File file = new File(path);

				// 디렉토리 존재하지 않을 경우, 디렉토리 생성
				if (!file.exists()) {
					file.mkdirs();
				}
				// 서버에 업로드 할 파일명
				String realName = UUID.randomUUID().toString() + "." + ext;// 기존이름을
																			// 버리고
																			// 랜덤이름을
																			// 붙여서
																			// 새로운
																			// 이름을
																			// 만들어줌

				// 서버에 파일쓰기//

				photoDTO.getFiledata().transferTo(new File(path + realName));
				file_result += "&bNewLine=true&sFileName=" + original_name + "&sFileURL=/codi/resources/upload"
						+ realName;

			} else {
				file_result += "&errstr=error";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:" + callback + "?callback_func=" + callback_func + file_result;
	}

	// QNA답글 리스트//
	@RequestMapping(value = "/mastCommList")
	public String commList(HttpSession session, @RequestParam int board_num, Model model) {
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			System.out.println("controller");
			System.out.println("commList");
			System.out.println("board_num : " + board_num);
			try {
				mastService.mastCommList(board_num, model);
			} catch (Exception e) {
				e.printStackTrace();
			}
			path = "mast/board/mastCommList";
		} else {
			path = "redirect:/";
		}
		return path;

	}

	/////////////////////////////////////////////////// 회원관리//////////////////////////////////////////
	// 회원인덱스
	@RequestMapping(value = "/mastMember")
	public String mastMember(HttpSession session) {
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			path = "mast/member/mastMember";
		} else {
			path = "redirect:/";
		}
		return path;

	}

	// 회원검색&리스트
	@RequestMapping(value = "/mastMemberList")
	public String memberList(HttpSession session, @RequestParam(defaultValue = "") String type,
			@RequestParam(defaultValue = "") String find, @RequestParam(defaultValue = "1") int curPage,
			@RequestParam(defaultValue = "10") int perPage, Model model) {
		String path = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			try {
				mastService.findMemberList(type, find, curPage, perPage, model);
			} catch (Exception e) {

				e.printStackTrace();
			}
			path = "mast/member/list";
		} else {
			path = "redirect:/";
		}
		return path;
	}

	// 회원삭제
	@RequestMapping(value = "/mastMemberDelete")
	public String memberDelete(HttpSession session, @RequestParam String id, RedirectAttributes ra) {
		String path = "";
		String message = "";
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
		if (memberDTO != null && memberDTO.getMember_level() == 0) {
			try {
				message = mastService.memberDelete(id);
			} catch (Exception e) {
				e.printStackTrace();
			}
			path = "redirect:/" + "mast/mastMemberList";
			ra.addFlashAttribute("message", message);
			System.out.println(message);
		} else {
			path = "redirect:/";
		}
		return path;
	}
}
