package spring.sts.webtest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import spring.model.member.MemberDAO;
import spring.model.member.MemberDTO;
import spring.model.member.MemberInter;
import spring.utility.webtest.Utility;



@Controller
public class MemberController {

	@Autowired
	private MemberDAO dao;
	@Autowired
	private MemberInter inter;
	

	@PostMapping("/member/delete")
	public String delete(String id, String oldfile,
			HttpSession session,
			HttpServletRequest request,
			RedirectAttributes redi) {
		String upDir = request.getRealPath("/member/storage");
		String grade = (String)session.getAttribute("grade");
		
		int flag = inter.delete(id);
		
		if(flag == 1) {
			//기존파일이 존재한다면 (member.jpg가 아니라면)
			//파일 삭제
			if(!oldfile.equals("member.jpg")) {
				Utility.deleteFile(upDir, oldfile);
			}
			
			//관리자가 아닌경우에 session초기화
			if(!grade.equals("A")) {
				session.invalidate();
			}
			
			redi.addFlashAttribute("msg", "탈퇴되었습니다");
			return "redirect:/";
		}else {
			request.setAttribute("flag", flag);
			return "/member/error";
		}
	}
	
	@GetMapping("/member/delete")
	public String delete() {
		return "/delete";
	}
	
	@GetMapping("/member/read")
	public String read(HttpServletRequest request) {
		String id = request.getParameter("id");
		String grade = (String)request.getSession().getAttribute("grade");

		if (id == null) {
			id = (String)request.getSession().getAttribute("id");
		}
		MemberDTO dto = inter.read(id);	

		request.setAttribute("dto", dto);
		request.setAttribute("grade", grade);
		
		return "/read";
	}
	
	
	
	@RequestMapping("/admin/list")// get post 둘 다 받고싶을 때
	//(value="/admin/list", method=RequestMethod.POST)
	//(value="/admin/list", method=RequestMethod.GET)

	public String list(HttpServletRequest request) {
		
		 String col=Utility.checkNull(request.getParameter("col"));
		 String word=Utility.checkNull(request.getParameter("word"));
		 
		 if(col.equals("total")) word="";
		 
		 int nowPage = 1;
		 int recordPerPage = 3;
		 
		 if(request.getParameter("nowPage")!=null){
		   nowPage = Integer.parseInt(request.getParameter("nowPage"));
		   
		 }
		 
		 int sno= ((nowPage-1)*recordPerPage)+1;
		 int eno= nowPage * recordPerPage;
		 
		 Map map = new HashMap();
		 map.put("col", col);
		 map.put("word", word);
		 map.put("sno", sno);
		 map.put("eno", eno);
		 
		 int total = inter.total(map);
		 
		 List<MemberDTO> list = inter.list(map);
		 
		 String url ="list";
		 
		 String paging = Utility.paging(total, nowPage, recordPerPage, col, word, url);
		 
		 request.setAttribute("list", list);
		 request.setAttribute("paging", paging);
		 request.setAttribute("col", col);
		 request.setAttribute("word", word);
		 request.setAttribute("nowPage", nowPage);
		 
		 
	return "/list";
		
		
	}
	
	@GetMapping("/member/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		return "redirect:/";
	}
				
	
	@GetMapping("/member/id_findform")
	public String idfindform() {
		
		return "member/id_findForm";
		
	}
	
	@ResponseBody //뷰를 선택하지 않고 결과값만 리턴
	@GetMapping(value="/member/id_findproc", produces="text/plain; charset=utf-8")
	public String idfindform(@RequestParam Map<String, String> map) {
		String id = dao.idfind(map);
		String str="";
		if (id!=null) {
			str = "회원님의 아이디는 "+id+" 입니다.";
		} else {
			str = "입력하신 내용이 틀렸거나 회원정보가 존재하지 않습니다. 다시 입력해주세요.";
		}
		return str;
	}

	@GetMapping("/member/passwd_find")
	public String passwd_findform() {
		
		return "member/passwd_findForm";
		
	}
	
	@ResponseBody //뷰를 선택하지 않고 결과값만 리턴
	@GetMapping(value="/member/passproc", produces="text/plain; charset=utf-8")
	public String idform(@RequestParam Map<String, String> map) {
		
		String passwd = dao.passwdfind(map);
		
		String str="";
		
		if (passwd!=null) {
			str = "회원님의 비밀번호는 "+passwd+" 입니다.";
		} else {
			str = "입력하신 내용이 틀렸거나 회원정보가 존재하지 않습니다. 다시 입력해주세요.";
		}
		return str;
	}
	
	@PostMapping("/member/updateFile")
	public String updateFile(String id, String oldfile,
			MultipartFile fnameMF,
			HttpServletRequest request,
			RedirectAttributes redi) {
		
		String upDir = request.getRealPath("/member/storage");
		
		String fname = null;
		int size = (int)fnameMF.getSize();
		if(size > 0) {
			if(!oldfile.equals("member.jpg") || oldfile != null) {
				Utility.deleteFile(upDir, oldfile);
			}
			fname = Utility.saveFileSpring(fnameMF, upDir);
		}
	
		Map map = new HashMap();
		map.put("id", id);
		map.put("fname", fname);
		
		int flag = inter.updateFile(map);
		
		if(flag == 1) {
			redi.addFlashAttribute("id", id);
			redi.addFlashAttribute("msg", "사진이 변경되었습니다");
			return "redirect:/member/read";
		}else {
			request.setAttribute("flag", flag);
			return "/member/error";
		}

	}
	
	@GetMapping("/member/updateFile")
	public String updateFile() {
		return "/updateFile";
	}
	
	
	@PostMapping("/member/update")
	public String update(MemberDTO dto, 
			String xemail, 
			Model model, 
			RedirectAttributes redi) {
		String url = "";
		
		String email = dto.getEmail();
		String str = "";

		if(!(email.equals(xemail)) && inter.duplicateEmail(email) == 1) {
			str = "중복된 이메일입니다. 이메일중복 확인을 하세요";
			model.addAttribute("msg", str);
			url = "error/prcreate";
		}else {			
			int flag = inter.update(dto);
			if(flag == 1) {
				str = "회원정보가 수정되었습니다";
				redi.addFlashAttribute("msg", str);
				url = "redirect:/";
			}else {
				model.addAttribute("flag", flag);
				url = "/member/error";
			}
		}
		
		return url;
	}
	
	@GetMapping("/member/update")
	public String update(String id, HttpSession session, Model model) {
		if(id==null){
			id = (String)session.getAttribute("id");
		}

		MemberDTO dto = inter.read(id);
		model.addAttribute("dto", dto);
		
		return "/update";
	}

	@PostMapping("/member/updatePw")
	public String updatePw(@RequestParam Map<String, String> map,
			RedirectAttributes redi,
			Model model) {
		
		
		int flag = inter.updatePw(map);
		
		if(flag == 1) {
			redi.addFlashAttribute("id", map.get("id"));
			redi.addFlashAttribute("msg", "비밀번호가 변경되었습니다");
			return "redirect:/member/read";
		}else {
			model.addAttribute("flag", flag);
			return "/member/error";
		}
	}
	
	@GetMapping("/member/updatePw")
	public String updatePw() {
		return "/updatePw";
	}
	
	

	@PostMapping("/member/login")
	public String login(@RequestParam Map<String, String> map, HttpServletResponse response, HttpSession session,
			RedirectAttributes redi, String c_id, Model model) {

		int flag = inter.loginCheck(map);

		String grade = null; // 회원등급에 저장할 변수

		if (flag==1) {
			grade = inter.getGrade(map.get("id"));
			session.setAttribute("id", map.get("id"));
			session.setAttribute("grade", grade);

			// ---------------------------------------

			// Cookie 저장, Checkbox는 선택하지 않으면 null 임

			// ---------------------------------------

			Cookie cookie = null;

//			String c_id = request.getParameter("c_id");  Y, 아이디 저장 여부

			if (c_id != null) { // 처음에는 값이 없음으로 null 체크로 처리
				cookie = new Cookie("c_id", "Y"); // 아이디 저장 여부 쿠키
				cookie.setMaxAge(120); // 2분 유지
				response.addCookie(cookie); // 쿠키 기록
				cookie = new Cookie("c_id_val", map.get("ID")); // 아이디 값 저장 쿠키
				cookie.setMaxAge(120); // 2분 유지
				response.addCookie(cookie); // 쿠키 기록

			} else {

				cookie = new Cookie("c_id", ""); // 쿠키 삭제
				cookie.setMaxAge(0);
				response.addCookie(cookie);
				cookie = new Cookie("c_id_val", ""); // 쿠키 삭제
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}

			// ---------------------------------------

		}
		if (flag==1) {
			if(map.get("rurl")!=null && !map.get("rurl").equals("")) {
			 
			redi.addAttribute("bbsno", map.get("bbsno"));
			redi.addAttribute("nowPage", map.get("nowPage"));
			redi.addAttribute("nPage", map.get("nPage"));
			redi.addAttribute("col", map.get("col"));
			redi.addAttribute("word", map.get("word"));
			return "redirect:"+map.get("rurl");
			}
			else {
			redi.addFlashAttribute("msg", "로그인이 되었습니다.");
			return "redirect:/"; // /를 url 로 갖는 곳을 찾아감
			//디스패쳐 서블릿이 받아서 핸들러맵핑에서 찾은후 컨트롤러가 모델사용하고 뷰 리턴
			
			}
		} else {
			model.addAttribute("msg", "회원이 아닙니다. 다시 입력해주세요.");
			return "member/precreate"; 
		}
		//요청결과 보여주는거 forward
		//결과가 아니라 새로운페이지 보여주는거 redirect

	}

	@GetMapping("/member/login")
	public String login(HttpServletRequest request) {

		// ----------쿠키설정 내용 시작--------

		String c_id = ""; // ID 저장 여부를 저장하는 변수, Y
		String c_id_val = ""; // ID 값
		// 2개의 변수 선언

		Cookie[] cookies = request.getCookies();
		Cookie cookie = null; // 쿠키 배열 선언
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				cookie = cookies[i];
				if (cookie.getName().equals("c_id")) {
					c_id = cookie.getValue(); // Y
				} else if (cookie.getName().equals("c_id_val")) {
					c_id_val = cookie.getValue();// user1...
				}
			}
		}

		// ----------쿠키설정 내용 끝--------

		request.setAttribute("c_id_val", c_id_val);
		request.setAttribute("c_id", c_id);
		return "/login";

	}

	@PostMapping("/member/createProc")
	public String createProc(MemberDTO dto, HttpServletRequest request, RedirectAttributes redi) {

		String str = null;
		String url = "member/precreate";

		if (inter.duplicateId(dto.getId())==1) {
			str = "중복된 아이디입니다. ";
			request.setAttribute("msg", str); // el에서 쓰려면 flash넣어줘야함
		} else if (inter.duplicateEmail(dto.getEmail())==1) {
			str = "중복된 이메일입니다. ";
			request.setAttribute("msg", str);
		} else {

			String basePath = request.getRealPath("/member/storage");

			String fname = null;

			int size = (int) dto.getFnameMF().getSize();

			if (size > 0) {

				fname = Utility.saveFileSpring(dto.getFnameMF(), basePath);
			} else {
				fname = "member.jpg";
			}
			dto.setFname(fname);

			int flag = inter.create(dto);

			if (flag==1) {

				redi.addFlashAttribute("msg", "회원등록을 완료했습니다.");
				url = "redirect:/";

			} else {
				request.setAttribute("flag", false);
				url = "member/error";
			}

		}

		return url;
	}

	@ResponseBody // viewresolver에서 찾지않고 바로 데이터 받아옴
	@GetMapping(value = "/member/idcheck", produces = "text/plain;charset=utf-8")
	public String idCheck(String id) {

		int flag = inter.duplicateId(id);
		String str = "";

		if (flag==1) {
			str = "입력하신 id " + id + " 는 중복되어 사용할 수 없습니다.";
		} else {
			str = "사용 가능한 아이디입니다. " + id;
		}

		return str;

	}

	@ResponseBody
	@GetMapping(value = "/member/emailcheck", produces = "text/plain;charset=utf-8")
	public String emailCheck(String email) {

		int flag =inter.duplicateEmail(email); //duplicate의 return형이 int
		String str = "";

		if (flag==1) {
			str = email + " 은 중복되어 사용할 수 없습니다.";
		} else {
			str = "사용가능한 이메일입니다. " + email;
		}

		return str;

	}

	@GetMapping("/member/agreement")
	public String agree() {

		return "/agree";
	}

	@PostMapping("/member/create")
	public String create() {

		return "/create";
	}

}
//model - forward, sendredirect (url 앞에 무조건 파라미터 노출)
//redirectattributes - sendredirect

//addflashattribute() url에 파라미터 노출 x
//addattribute() url에 파라미터 노출 

//extends model 을 써서 forward 할수있음  