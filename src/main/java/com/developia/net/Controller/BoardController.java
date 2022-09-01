package com.developia.net.Controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

	@ResponseBody
	@RequestMapping("/userUpdate/{user_nm}")
	public ModelAndView userUpdate(Model model, GroupVO groupVO
			,@PathVariable("user_nm") String user_nm) throws Exception{
		ModelAndView mav = new ModelAndView();
		try {
			List<Map<String, Object>> list = boardService.getUserDetail(user_nm);
			log.info(user_nm+"컨트롤러 도착");
			log.info(list.toString());
			mav.addObject("list",list);
			mav.setViewName("board/userUpdate");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	//유저 정보 업데이트
	@RequestMapping("/upDate")
	public String upDate(UserVO userVO) throws Exception{
		log.info(userVO.toString());
		try {
			boardService.upDate(userVO);
			log.info("업데이트 완료");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/board/tree";
	}
	
	//부서 이동시 부서 검색어 자동완성
	@RequestMapping("/autoComplete")
	public @ResponseBody Map<String, Object> autoComplete(@RequestParam Map<String, Object> paramMap,
			@RequestParam("value") String value) throws Exception{
		log.info(paramMap);
		List<Map<String, Object>> resultList = boardService.autoComplete(paramMap, value );
		paramMap.put("resultList", resultList);
		return paramMap;
	}
	
	//부서 이동 컨트롤러
	@RequestMapping("/updateGroup")
	public String updateGroup(UserVO userVO, @RequestParam("new_group") String new_group)
			throws Exception{
		try {
			//부서 이동시에는 유저 GROUP_CODE, GROUP_NM이 동시에 바뀌어야함
			log.info(new_group+"으로 부서이동");
			int gCode = boardService.getGroupCode(new_group);
			log.info("새로운 그룹 코드 :"+gCode);
			log.info(userVO.toString());
			String user_id = userVO.getUser_id();
			boardService.updateUserGroup(user_id, gCode, new_group);
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return "redirect:/board/tree";
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
	
	//조직관리 메뉴페이지 이동
	@GetMapping("/departmentMenu")
	public String departmentMenu(){
		return "board/departmentMenu";
	}
	
	//부서 추가 페이지 이동
	@GetMapping("/groupPlus")
	public String groupPlus() {
		return "board/groupPlus";
	}
	
	//추가할 부서 레벨2 구간 출력
	@ResponseBody
	@RequestMapping("/level2Group")
	public ResponseEntity<List<Map<String, Object>>> getSecondLevelGroup(Model model,
			GroupVO groupVO, @RequestParam("Lv2Pcode") int Lv2Pcode,
			@RequestParam("Gcode") int Gcode) throws Exception{
		log.info(Lv2Pcode+" "+Gcode);
		List<Map<String, Object>> list = boardService.getSecondLevelGroup(Lv2Pcode);
		log.info(list.toString());
		return ResponseEntity.ok().body(list);
	}
	
	//추가할 부서 레벨 3 구간 출력
	@ResponseBody
	@RequestMapping("/level3Group")
	public ResponseEntity<List<Map<String, Object>>> getThirdLevelGroup(Model model,
			GroupVO groupVO, @RequestParam("Lv3Pcode") int Lv3Pcode) throws Exception{
		log.info(Lv3Pcode);
		List<Map<String, Object>> list = boardService.getThirdLevelGroup(Lv3Pcode);
		log.info(list.toString());
		return ResponseEntity.ok().body(list);
	}
}
