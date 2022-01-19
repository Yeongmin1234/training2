package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.domain.BoardAttachVO;
import org.zerock.service.BoardService;

import jdk.internal.org.jline.utils.Log;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping(value="board")
public class BoardController {
	
	
	public BoardService service;
	UploadController upload;
	
	@GetMapping("searchAll")
	public void searchAll(Model model,Criteria cri) {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DAY_OF_MONTH, -1);  
		model.addAttribute("nowday",cal.getTime());
		model.addAttribute("pinList", service.pinList(cri));
		model.addAttribute("list", service.list(cri));
		int total= service.totalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri,total));
	}
	
	@GetMapping("list")
	public void list(Model model,Criteria cri) {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, -1);  
        model.addAttribute("nowday",cal.getTime());
		model.addAttribute("pinList", service.pinList(cri));
		model.addAttribute("list", service.list(cri));
		int total= service.totalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri,total));
	}
	
	@GetMapping("elist")
	public void eachList(Model model,Criteria cri) {
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, -1);  
        System.out.println(service.list(cri));
        model.addAttribute("nowday",cal.getTime());
		model.addAttribute("pinList", service.pinEachList(cri));
		model.addAttribute("list", service.eachList(cri));
		int total= service.etotalCount(cri);
		model.addAttribute("pageMaker", new PageDTO(cri,total));
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("create")
	public void create() {
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("create")
	public String create(BoardVO vo, RedirectAttributes rttr, Model model) {
		
		
		if(vo.getTitle().length()==0 || vo.getTitle().equals(" ")) {
			return null;
		}
		if(vo.getText().equals("<p><br></p>") || vo.getText().length()==0 || vo.getText().equals("<p>&nbsp;</p>")) {
			return null;
		}
		System.out.println("controller : "+ vo);
		service.create(vo);
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("cate", vo.getCate());
		return "redirect:/board/read";
	}
	@GetMapping("read/{cate}")
	public String read(int bno, Model model,BoardVO vo,@PathVariable int cate) {
		vo.setBno(bno);
		vo.setCate(bno);
		System.out.println(vo);
		
		model.addAttribute("read", service.read(bno,cate));
		return "/board/read";
	}
	
	@GetMapping("update")
	public void update(int bno, Model model,int cate) {
		System.out.println("¿Ã∞≈æﬂ!"+service.read(bno,cate));
		model.addAttribute("update", service.read(bno,cate));
	}
	@PostMapping("update")
	public String modifyPostNo(BoardVO vo,RedirectAttributes rttr, Model model) {
		if(vo.getTitle().length()==0 || vo.getTitle().equals(" ")) {
			return null;
		}
		if(vo.getText().equals("<p><br></p>") || vo.getText().length()==0 || vo.getText().equals("<p>&nbsp;</p>")) {
			return null;
		}
		System.out.println(service.update(vo));
		model.addAttribute("update", service.update(vo));
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("cate", vo.getCate());
		return "redirect:/board/read";
	}
	@GetMapping("delete")
	public String delete(int bno) {
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		if(service.delete(bno)==1) {
			deleteFile(attachList);
		}
		
		return "redirect:/board/list";
	}
	//CRUD
//================================================================
	//Upload
	@GetMapping(value="getAttachList",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList (int bno,@RequestParam(value = "in", required=false) List<Integer> in){
		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
	}
	@GetMapping(value="fileGetAttachList",produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> fileGetAttachList (int bno,@RequestParam(value = "in", required=false) List<Integer> in){
		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
	}
	

	@PostMapping("/deleteFilee1")
	@ResponseBody
	public void deleteFile(List<BoardAttachVO> attachList) {
		
		if(attachList == null || attachList.size()==0) {
			return;
		}

		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("C:\\Upload\\"+attach.getUploadpath()+"\\"+
			attach.getUuid()+"_"+attach.getFilename());
				Files.deleteIfExists(file);
				
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("C:\\Upload\\"+attach.getUploadpath()+"\\"+
			attach.getUuid()+"_"+attach.getFilename());
					
					Files.delete(thumbNail);}
			} catch(Exception e) {
				log.error("delete "+e.getMessage());
			}

	});
}

}
