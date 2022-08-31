package com.developia.net.Controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.developia.net.domain.GroupVO;
import com.developia.net.domain.UserVO;
import com.developia.net.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
public class BoardController {

	@Setter(onMethod_ = @Autowired)
	  private BoardService boardService;
	
	@GetMapping("/tree")
	public ModelAndView getList(Model model, GroupVO groupVO) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		log.info("main 컨트롤러 도착");
		try {
			List<GroupVO> list = boardService.getGroupList();
			model.addAttribute("list",list);
			log.info(list.size());
			log.info(list.toString());
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@GetMapping("/test")
	public ModelAndView getTest(Model model) {
		ModelAndView mav = new ModelAndView();
		try {
			mav.setViewName("test");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/secondLevel")
	public ResponseEntity<List<Map<String, Object>>> getLevel2(Model model, GroupVO groupVO,
			@RequestParam("gCode") int gCode) throws Exception{
		log.info(gCode);
		List<Map<String, Object>> list = boardService.getSecondLevel(gCode);
		log.info(list.toString());
		return ResponseEntity.ok().body(list);
	}
	
	@ResponseBody
	@RequestMapping("/thirdLevel")
	public ResponseEntity<List<Map<String, Object>>> getLevel3(Model model, GroupVO groupVO,
			@RequestParam("pCode") int pCode) throws Exception{
		log.info(pCode);
		List<Map<String, Object>> list = boardService.getThirdLevel(pCode);
		log.info(list.toString());
		return ResponseEntity.ok().body(list);
	}
	
	@ResponseBody
	@RequestMapping("/lastLevel")
	public ResponseEntity<List<Map<String, Object>>> getLevelLast(Model model, GroupVO groupVO,
			@RequestParam("lastLevel") int lastLevel) throws Exception{
		log.info(lastLevel);
		List<Map<String, Object>> list = boardService.getLastLevel(lastLevel);
		log.info(list.toString());
		return ResponseEntity.ok().body(list);
	}
	
	@ResponseBody
	@RequestMapping("/showMember")
	public ResponseEntity<List<Map<String, Object>>> getMember(Model model, UserVO userVO,
			@RequestParam("memberCode") int memberCode) throws Exception{
		log.info("멤버 리스트 컨트롤러 도착"+memberCode);
		List<Map<String, Object>> list = boardService.getMember(memberCode);
		log.info(list.toString());
		return ResponseEntity.ok().body(list);
	}
}
