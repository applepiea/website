package spring.sts.webtest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import spring.model.bbs.BbsDTO;
import spring.model.bbs.BbsInter;
import spring.model.bbs.BbsService;
import spring.model.reply.replyInter;
import spring.utility.webtest.Utility;

@Controller
public class BbsController {

	@Autowired
	private replyInter rinter;

	@Autowired
	private BbsInter inter;

	@Autowired
	private BbsService service;

	@PostMapping("/bbs/reply")
	public String reply(BbsDTO dto, RedirectAttributes redi, Model model) {


		try {
			service.reply(dto);
			redi.addFlashAttribute("msg", "답변을 등록하였습니다.");
			return "redirect:/bbs/list";
		} catch(Exception e) {
			model.addAttribute("flag", false);
			return "/bbs/error";
		}

	}

	@GetMapping("/bbs/reply")
	public String reply(int bbsno, Model model) {

		model.addAttribute("dto", inter.readReply(bbsno));

		return "/bbs/reply";
	}

	@PostMapping("/bbs/delete")
	public String delete(@RequestParam Map<String, String> map, int bbsno, Model model, RedirectAttributes redi)

	{
		boolean pflag = inter.passCheck(map) > 0;

		try {
			 service.delete(bbsno);
			if (pflag) {
				redi.addFlashAttribute("msg", "게시물을 삭제했습니다.");
				return "redirect:/bbs/list";
			} else {
				model.addAttribute("pflag", pflag);
				return "/bbs/passwdError";
			}
		} catch (Exception e) {
			model.addAttribute("flag", false);
			return "/bbs/error";
		}
	}

	@GetMapping("/bbs/delete")
	public String delete(int bbsno, Model model) {

		model.addAttribute("flag", inter.refnumCheck(bbsno) > 0);

		return "/bbs/delete";

	}

	@PostMapping("/bbs/update")
	public String update(BbsDTO dto, Model model, RedirectAttributes redi) {

		Map map = new HashMap();
		map.put("bbsno", dto.getBbsno());
		map.put("passwd", dto.getPasswd());

		boolean pflag = inter.passCheck(map) > 0;

		boolean flag = false;

		if (pflag) {
			flag = inter.update(dto) > 0;
		} else {
			model.addAttribute("pflag", pflag);
			return "/bbs/passwdError";
		}

		if (flag) {
			redi.addAttribute("msg", "게시물을 수정했습니다.");
			return "redirect:/bbs/list";
		} else {
			model.addAttribute("flag", flag);
			return "error/error";
		}

	}

	@GetMapping("/bbs/update")
	public String update(int bbsno, Model model) {
		model.addAttribute("dto", inter.read(bbsno));

		return "/bbs/update";
	}

	@GetMapping("/bbs/read")
	public String read(int bbsno, Model model, int nowPage, String col, String word, HttpServletRequest request) {

		inter.Viewcnt(bbsno);

		BbsDTO dto = inter.read(bbsno);

		dto.setContent(dto.getContent().replaceAll("\r\n", "<br>"));

		model.addAttribute("dto", dto);

		/* 댓글 관련 시작 */
		int nPage = 1; // 시작 페이지 번호는 1부터

		if (request.getParameter("nPage") != null) {
			nPage = Integer.parseInt(request.getParameter("nPage"));
		}
		int recordPerPage = 3; // 한페이지당 출력할 레코드 갯수

		int sno = ((nPage - 1) * recordPerPage) + 1; //
		int eno = nPage * recordPerPage;

		Map map = new HashMap();
		map.put("sno", sno);
		map.put("eno", eno);
		map.put("bbsno", bbsno);
		map.put("nPage", nPage);
		map.put("nowPage", nowPage);
		map.put("col", col);
		map.put("word", word);

		model.addAllAttributes(map);

		/* 댓글 관련 끝 */

		return "/bbs/read";
	}

	@PostMapping("/bbs/create")
	public String create(BbsDTO dto, Model model, RedirectAttributes redi) {

		boolean flag = inter.create(dto) > 0;
		if (flag) {
			redi.addFlashAttribute("msg", "게시글을 올렸습니다.");
			return "redirect:/bbs/list";
		} else {

			model.addAttribute("flag", flag);
			return "error/error";
		}

	}

	@GetMapping("/bbs/create")
	public String create() {

		return "/bbs/create";
	}

	@RequestMapping("/bbs/list")
	public String list(HttpServletRequest request) {

		// 검색 관련 ------------------
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));

		if (col.equals("total"))
			word = "";

		// 페이지 관련 -------------------

		int nowPage = 1; // 현재 보고 있는 페이지
		if (request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		int recordPerPage = 5; // 한페이지당 보여줄 레코드 갯수

		// DB에서 가져올 순번 ------------------

		// nowPage : 현재 보고 있는 페이지

		int sno = ((nowPage - 1) * recordPerPage) + 1;
		int eno = nowPage * recordPerPage;

		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);

		int total = inter.total(map);

		List<BbsDTO> list = inter.list(map);

		String url = "list";
		String paging = Utility.paging(total, nowPage, recordPerPage, col, word, url);

		request.setAttribute("list", list);
		request.setAttribute("paging", paging);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("rinter", rinter);

		return "/bbs/list";

	}
}
