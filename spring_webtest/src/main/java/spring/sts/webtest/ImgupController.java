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

import spring.model.imgup.ImgUpDAO;
import spring.model.imgup.ImgUpDTO;
import spring.model.imgup.ImgupInter;
import spring.utility.webtest.Utility;

@Controller
public class ImgupController {

	@Autowired
	private ImgupInter imgInter;	

	
	
	@GetMapping("/imgup/read")
	public String read(int imgno, Model model) {
		imgInter.upViewcnt(imgno);
		ImgUpDTO dto = imgInter.read(imgno);
		
		String content=dto.getContent();
		content=content.replaceAll("\r\n", "<br>");
				
		model.addAttribute("imgno", imgno);
		model.addAttribute("dto", dto);
		model.addAttribute("content", content);
		
		return "/imgup/read";
		
	}
	
	@PostMapping("/imgup/create")
	public String create(ImgUpDTO dto, HttpServletRequest request, Model model, RedirectAttributes redi) {
		String upDir = request.getRealPath("/imgup/storage");
		
		int size = (int)dto.getFnameMF().getSize();
		String fname="";
		if (size>0) {
			fname=Utility.saveFileSpring(dto.getFnameMF(), upDir);
			
		} else {
			fname="default.jpg";
		}
		
		dto.setFname(fname);
		
	    int flag = imgInter.create(dto);

		request.setAttribute("flag", flag);

		if (flag==1) {
			redi.addFlashAttribute("msg", "게시글을 올렸습니다.");
			return "redirect:/imgup/list";
		} else {

			model.addAttribute("flag", flag);
			return "/imgup/error";
		}
	}
	
	@GetMapping("/imgup/create")
	public String create() {

		return "/imgup/create";
	}
	
	@RequestMapping("/imgup/list")
	public String list(HttpServletRequest request) {

		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));

		if (col.equals("total"))
			word = "";

		int nowPage = 1;
		int recordPerPage = 3;

		if (request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}

		int sno = ((nowPage - 1) * recordPerPage) + 1;
		int eno = nowPage * recordPerPage;

		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);

		int total = imgInter.total(map);

		List<ImgUpDTO> list = imgInter.list(map);

		String url = "list";
		String paging = Utility.paging(total, nowPage, recordPerPage, col, word, url);

		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("paging", paging);
		request.setAttribute("list", list);

		return "/imgup/list";
	}





	@GetMapping("/imgup/update")
	public String update(int imgno, Model model) {
		model.addAttribute("dto", imgInter.read(imgno));
		return "/imgup/update";
	}

	@PostMapping("/imgup/update")
	public String update(HttpServletRequest request, 
			RedirectAttributes redi,
			Model model,
			String oldfile, 
			ImgUpDTO dto
			) 

			{
		System.out.println(dto);
		
		
		Map map = new HashMap();
		map.put("imgno", dto.getImgno());
		map.put("passwd", dto.getPasswd());
		
		boolean pflag = imgInter.passwdCheck(map);
		boolean flag = false;
		int cnt=imgInter.update(dto);
		if(cnt>0) flag=true;
		
		if(pflag) {
			String fname = "";
			String upDir = request.getRealPath("/image/storage");
			int size = (int) dto.getFnameMF().getSize();
			if (size > 0) {
				fname=Utility.saveFileSpring(dto.getFnameMF(), upDir);
			} else {
				fname=oldfile;
			}
			dto.setFname(fname);
			
			flag = imgInter.update(dto);
			
			if(flag) {
				if(oldfile!= null && !oldfile.equals("default.jpg") && size > 0){
					 Utility.deleteFile(upDir, oldfile);
				}				
			}
		}else {
			model.addAttribute("pflag", pflag);
			return "imgup/passwdError";
			//패스워드에러페이지 이동
		}
		
		if(flag) {
			redi.addFlashAttribute("msg", "게시글이 수정되었습니다.");
			return "redirect:/imgup/list";
			//list페이지이동
		}else {
			//에러페이지이동
			model.addAttribute("flag", flag);
			return "imgup/error";
		}
	}

	@GetMapping("/imgup/delete")
	public String delete(Model model, int imgno) {
		
		model.addAttribute("dto", imgInter.read(imgno));
		
		return "/imgup/delete";
	}

	@PostMapping("/imgup/delete")
	public String delete(@RequestParam Map<String, String> map, HttpServletRequest request, Model model,
			RedirectAttributes redi) {
		
		String upDir=request.getRealPath("/imgup/storage");
	
		int imgno = Integer.parseInt(request.getParameter("imgno"));
		
		boolean flag=false;
		
		boolean pflag=imgInter.passwdCheck(map);
		
		if(pflag) {
			flag=imgInter.delete(imgno);
		} else {
			model.addAttribute("pflag", pflag);
			return "imgup/passwdError";
			}
		
		if(flag) {
			redi.addFlashAttribute("msg", "이미지 삭제가 완료되었습니다.");
			return "redirect:/imgup/list";
		} else {
			
			model.addAttribute("flag", flag);
			return "imgup/error";
		}
	
	
	}
	
	
	
	
}
