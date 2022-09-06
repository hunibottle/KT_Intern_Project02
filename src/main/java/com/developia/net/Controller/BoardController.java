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
import com.developia.net.domain.UpdateVO;
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
	public ModelAndView getList(Model model, GroupVO groupVO, UpdateVO updateVO) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		log.info("main 컨트롤러 도착");
		try {
			List<GroupVO> list = boardService.getGroupList();
			List<UpdateVO> list2 = boardService.getUpdateList();
			List<UserVO> list3 = boardService.getAllUserList();
			model.addAttribute("list",list);
			model.addAttribute("list2",list2);
			model.addAttribute("list3",list3);
			log.info(list.size());
			log.info(list.toString());
			log.info("UPDATE TABLE 최신화 :"+list2.toString());
			log.info(list3.toString());
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
	public String upDate(UserVO userVO, UpdateVO updateVO) throws Exception{
		log.info(userVO.toString());
		try {
			String userName = userVO.getUser_nm();
			String content = userName + " 직원 정보 수정";
			boardService.upDate(userVO);
			boardService.upDateUserTable(userName, content);
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
			
			//업데이트 테이블 최신화
			String userName = userVO.getUser_nm();
			String content = userName + " 직원 부서 변경";
			log.info(userName+" "+content);
			boardService.upDateUserTable(userName, content);
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
	
	//추가할 부서 마지막 구간 레벨
	@ResponseBody
	@RequestMapping("/levelLastGroup")
	public ResponseEntity<List<Map<String, Object>>> getLastLevelGroup(Model model,
			GroupVO groupVO, @RequestParam("Lvlast") int lvlast) throws Exception{
		log.info(lvlast);
		List<Map<String, Object>> list = boardService.getLastLevelGroup(lvlast);
		log.info(list.toString());
		return ResponseEntity.ok().body(list);
	}
	
	//부서 추가 컨트롤러
	@ResponseBody
	@RequestMapping("/groupPlus")
	public String groupPlus(GroupVO groupVO, @RequestParam("level_2_code") int level_2_code,
			@RequestParam("level_3_code") int level_3_code, @RequestParam("groupName") String groupName)
			throws Exception{
		try {
			log.info(level_2_code+" "+level_3_code+" "+groupName);
			/* boardService.updateUserGroup(user_id, gCode, new_group); */
			int check = boardService.groupCheck(level_3_code);
			if(check == 0) {
				int nextGroupCode = level_3_code + 1;
				boardService.makeGroup_1(nextGroupCode, groupName, level_3_code);
				
				//업데이트 테이블 최신화
				String content = groupName + " 부서 추가";
				log.info(groupName+" "+content);
				boardService.upDateUserTable(groupName, content);
				
				
			}else {
				int nowGroup = boardService.makeGroupCode(level_3_code);
				log.info(nowGroup);
				int nextGroupCode = nowGroup + 1;
				boardService.makeGroup_1(nextGroupCode, groupName, level_3_code);
				
				//업데이트 테이블 최신화
				String content = groupName + " 부서 추가";
				log.info(groupName+" "+content);
				boardService.upDateUserTable(groupName, content);
			}
			return "0";
		}catch(Exception e) {
			e.printStackTrace();
			return "1";
		}
	}
	
	//부서 수정 페이지 이동
	@GetMapping("/groupUpdate")
	public String groupUpdate() {
		return "board/groupUpdate";
	}
	
	//부서 삭제 페이지 이동
	@GetMapping("/groupDelete")
	public String groupDelete() {
		return "board/groupDelete";
	}
	
	//부서 병합 페이지 이동
	@GetMapping("/groupSum")
	public String groupSum() {
		return "board/groupSum";
	}
	
	//부서 분리 페이지 이동
	@GetMapping("/groupDivision")
	public String groupDivision() {
		return "board/groupDivision";
	}
	
	//부서 병합 컨트롤러
	@ResponseBody
	@RequestMapping("/sumGroup")
	public String sumGroup(GroupVO groupVO, @RequestParam("option") String option,
			@RequestParam("groupOneCode") int groupOneCode, @RequestParam("groupTwoCode") int groupTwoCode,
			@RequestParam("level_3_code") int level_3_code, @RequestParam("level_2_code") int level_2_code,
			@RequestParam("groupNewName") String groupNewName) throws Exception{
		try {
			log.info(option+" "+groupOneCode+" "+groupTwoCode+" "+level_3_code+" "+level_2_code+" "+groupNewName);
			if(option.equals("part")) {
				log.info("파트 병합 시작");
				//해당 파트 부서코드 가져오기 (int)
				int getPartNum = boardService.getnewPartNum(level_3_code);
				log.info(getPartNum);
				int newPartNum = getPartNum + 1;
				//새로운 부서명 insert
				boardService.makeNewPart(newPartNum, level_3_code, groupNewName);
				//그룹1 사원 리스트 가져오기
				List<Map<String, Object>> list1 = boardService.getGroupOneMember(groupOneCode);
				if(!list1.isEmpty()) {
					log.info(list1.get(0).get("GROUP_CODE").toString());
					//그룹1 사원 새로운 부서코드로 update
					for(int i = 0 ; i < list1.size() ; i++) {
						int target = Integer.parseInt(list1.get(0).get("GROUP_CODE").toString());
						boardService.updateGroupMember(target, newPartNum, groupNewName);
					}
				}
				
				//그룹2 사원 리스트 가져오기
				List<Map<String, Object>> list2 = boardService.getGroupOneMember(groupTwoCode);
				if(!list2.isEmpty()) {
					//그룹2 사원 새로운 부서코드로 update
					for(int i = 0 ; i < list2.size() ; i++) {
						int target = Integer.parseInt(list2.get(0).get("GROUP_CODE").toString());
						boardService.updateGroupMember(target, newPartNum, groupNewName);
					}
				}
				//그룹1 삭제
				String groupOneName = boardService.getGroupName(groupOneCode);
				String groupTwoName = boardService.getGroupName(groupTwoCode);
				boardService.deleteGroup(groupOneCode);
				boardService.deleteGroup(groupTwoCode);		
				//업데이트 테이블 최신화
				String content = groupOneName + ", " +groupTwoName+ " 부서 병합";
				log.info(groupNewName+" "+content);
				boardService.upDateUserTable(groupNewName, content);

				return "0";

			}else {
				log.info("팀으로 전환 후 병합 시작");
				//새로운 부서코드 가져오기
				int getPartNum = boardService.getnewPartNum(level_2_code);
				int newPartNum = getPartNum + 1;
				log.info(getPartNum+" "+newPartNum);
				//새로운 부서명 insert(p코드로)
				boardService.makeNewPart(newPartNum, level_2_code, groupNewName);
				//그룹1 사원 리스트 가져오기
				List<Map<String, Object>> list1 = boardService.getGroupOneMember(groupOneCode);
				log.info(list1.get(0).get("GROUP_CODE").toString());
				//그룹1 사원 새로운 부서코드로 update
				for(int i = 0 ; i < list1.size() ; i++) {
					int target = Integer.parseInt(list1.get(0).get("GROUP_CODE").toString());
					boardService.updateGroupMember(target, newPartNum, groupNewName);
				}
				//그룹2 사원 리스트 가져오기
				List<Map<String, Object>> list2 = boardService.getGroupOneMember(groupTwoCode);
				//그룹2 사원 새로운 부서코드로 update
				for(int i = 0 ; i < list2.size() ; i++) {
					int target = Integer.parseInt(list2.get(0).get("GROUP_CODE").toString());
					boardService.updateGroupMember(target, newPartNum, groupNewName);
				}
				
				String groupOneName = boardService.getGroupName(groupOneCode);
				String groupTwoName = boardService.getGroupName(groupTwoCode);
				
				//그룹1 삭제
				boardService.deleteGroup(groupOneCode);
				boardService.deleteGroup(groupTwoCode);
				
				//업데이트 테이블 최신화
				String content = groupOneName + ", " +groupTwoName+ " 부서 병합";
				log.info(groupNewName+" "+content);
				boardService.upDateUserTable(groupNewName, content);
			}
			return "0";			
		}catch(Exception e) {
			e.printStackTrace();
			return "1";
		}
	}
	@ResponseBody
	@RequestMapping("/groupNameUpdateLv2")
	public String groupNameUpdateLv2(GroupVO groupVO, @RequestParam("new_name") String new_name, @RequestParam("level_2_code") int level_2_code) throws Exception{
		try {
			log.info(level_2_code+" "+new_name);
			//해당 그룹 멤버 리스트 불러오기
			List<Map<String, Object>> list = boardService.getGroupOneMember(level_2_code);
			//해당 팀 유저 정보 수정
			for(int i = 0; i < list.size() ; i++) {
				String target = list.get(i).get("GROUP_NM").toString();
				boardService.updateGroupName(target, new_name);
				log.info(target);
			}
			//해당 팀 이름 수정
			boardService.updateTeamName(level_2_code, new_name);
			return "0";
		}catch(Exception e) {
			e.printStackTrace();
			return "1";
		}
	}
	
	@ResponseBody
	@RequestMapping("/groupNameUpdateLv3")
	public String groupNameUpdateLv3(GroupVO groupVO, @RequestParam("new_name") String new_name, @RequestParam("level_3_code") int level_3_code) throws Exception{
		try {
			log.info(level_3_code+" "+new_name);
			//해당 그룹 멤버 리스트 불러오기
			List<Map<String, Object>> list = boardService.getGroupOneMember(level_3_code);
			//해당 팀 유저 정보 수정
			for(int i = 0; i < list.size() ; i++) {
				String target = list.get(i).get("GROUP_NM").toString();
				boardService.updateGroupName(target, new_name);
				log.info(target);
			}
			//해당 팀 이름 수정
			String nowName = boardService.getGroupName(level_3_code);
			String content = nowName + "->"+new_name+" 부서명 변경";
			log.info(nowName+" "+content);
			boardService.upDateUserTable(new_name, content);
			boardService.updateTeamName(level_3_code, new_name);
			return "0";
		}catch(Exception e) {
			e.printStackTrace();
			return "1";
		}
	}
	
	@ResponseBody
	@RequestMapping("/groupNameUpdateLv4")
	public String groupNameUpdateLv4(GroupVO groupVO, @RequestParam("new_name") String new_name, @RequestParam("level_4_code") int level_4_code) throws Exception{
		try {
			log.info(level_4_code+" "+new_name);
			//해당 그룹 멤버 리스트 불러오기
			List<Map<String, Object>> list = boardService.getGroupOneMember(level_4_code);
			//해당 팀 유저 정보 수정
			for(int i = 0; i < list.size() ; i++) {
				String target = list.get(i).get("GROUP_NM").toString();
				boardService.updateGroupName(target, new_name);
				log.info(target);
			}
			//해당 팀 이름 수정
			//업데이트 테이블 최신화
			String nowName = boardService.getGroupName(level_4_code);
			String content = nowName + " 에서"+new_name+"으로 "+"부서명 변경";
			log.info(nowName+" "+content);
			boardService.upDateUserTable(new_name, content);
			boardService.updateTeamName(level_4_code, new_name);
			return "0";
		}catch(Exception e) {
			e.printStackTrace();
			return "1";
		}
	}
	
	//삭제할 때 이름 맞는지 확인 (레벨3)
	@ResponseBody
	@RequestMapping("/groupDeleteCheckLv3")
	public String groupDeleteCheckLv3(GroupVO groupVO, @RequestParam("remove_name") String remove_name, @RequestParam("level_3_code") int level_3_code) throws Exception{
		try {
			log.info("삭제할 부서 정보: "+remove_name+" "+level_3_code);
			String target = boardService.deleteCheckLv3(level_3_code);
			if(target.equals(remove_name)) {
				log.info("삭제 가능");
				return "0";
			}else {
				log.info("삭제 불가능");
				return "1";
			}
		}catch(Exception e) {
			e.printStackTrace();
			return "1";
		}
	}
	
	//삭제할 때 이름 맞는지 확인 (레벨4)
		@ResponseBody
		@RequestMapping("/groupDeleteCheckLv4")
		public String groupDeleteCheckLv4(GroupVO groupVO, @RequestParam("remove_name") String remove_name, @RequestParam("level_4_code") int level_4_code) throws Exception{
			try {
				log.info("삭제할 부서 정보: "+remove_name+" "+level_4_code);
				String target = boardService.deleteCheckLv3(level_4_code);
				log.info(target);
				if(target.equals(remove_name)) {
					log.info("삭제 가능");
					return "0";
				}else {
					log.info("삭제 불가능");
					return "1";
				}
			}catch(Exception e) {
				e.printStackTrace();
				return "1";
			}
		}
	
	//레벨 별 부서 삭제
	@ResponseBody
	@RequestMapping("/groupDeleteLv3")
	public String groupDeleteLv3(GroupVO groupVO, @RequestParam("remove_name") String remove_name, @RequestParam("level_3_code") int level_3_code) throws Exception{
		try {
			log.info(level_3_code+" "+remove_name);
			//해당 그룹 멤버 리스트 불러오기
			List<Map<String, Object>> list = boardService.getGroupOneMember(level_3_code);
			if(list.size() != 0) {
				return "1";
				//만약 리스트에 직원이 들어있으면 삭제할 수 없도록 한다.
			}else {
				String groupName = boardService.getGroupName(level_3_code);
				//업데이트 테이블 최신화
				String content = groupName + " 부서 삭제";
				log.info(groupName+" "+content);
				boardService.upDateUserTable(groupName, content);
				boardService.deleteGroup(level_3_code);
				return "0";
			}
		}catch(Exception e) {
			e.printStackTrace();
			return "1";
		}
	}
	
	//레벨 별 부서 삭제
	@ResponseBody
	@RequestMapping("/groupDeleteLv4")		
	public String groupDeleteLv4(GroupVO groupVO, @RequestParam("remove_name") String remove_name, @RequestParam("level_4_code") int level_4_code) throws Exception{
		try {
			log.info(level_4_code+" "+remove_name);
			//해당 그룹 멤버 리스트 불러오기
			List<Map<String, Object>> list = boardService.getGroupOneMember(level_4_code);				if(list.size() != 0) {
				return "1";
				//만약 리스트에 직원이 들어있으면 삭제할 수 없도록 한다.
			}else {
				String groupName = boardService.getGroupName(level_4_code);
				//업데이트 테이블 최신화
				String content = groupName + " 부서 삭제";
				log.info(groupName+" "+content);
				boardService.upDateUserTable(groupName, content);
				boardService.deleteGroup(level_4_code);					
				return "0";
			}
		}catch(Exception e) {
			e.printStackTrace();
			return "1";
		}
	}
		
	//검색 컨트롤러
	@ResponseBody
	@RequestMapping("/getSearchList")
	public ResponseEntity<List<Map<String, Object>>> getSearchList(Model model, UserVO userVO
			,@RequestParam("keyword") String keyword, @RequestParam("option") int option) throws Exception{
		List<Map<String, Object>> list = boardService.getSearchList(keyword, option);
		return ResponseEntity.ok().body(list);
	}
	
	//검색어 자동완성
	@RequestMapping("/nameAutoComplete")
	public @ResponseBody Map<String, Object> nameAutoComplete(@RequestParam Map<String, Object> paramMap,
			@RequestParam("value") String value ,@RequestParam("option") int option) throws Exception{
		log.info("AUTOCOMPLETE CONTROLLER 도착");
		log.info(paramMap);
		
		List<Map<String, Object>> resultList = boardService.nameAutoComplete(paramMap, value, option);
		paramMap.put("resultList", resultList);
		log.info(resultList.toString());
		return paramMap;
	}
	
	//직원 삭제
	@ResponseBody
	@RequestMapping("/userDelete")
	public String userDelete(UserVO userVO, @RequestParam("user_id") String user_id) throws Exception {
		log.info("유저 삭제 컨트롤러 도착");
		log.info(user_id);
		
		try {
			String userName = boardService.getUserNameID(user_id);
			//업데이트 테이블 최신화
			String content = userName + " 사원 정보 삭제";
			log.info(userName+" "+content);
			boardService.upDateUserTable(userName, content);
			boardService.userDelete(user_id);
			return "1";
		}catch(Exception e) {
			e.printStackTrace();
			return "0";
		}
	}
	/*@RequestMapping("/updateGroup")
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
			
			//업데이트 테이블 최신화
			String userName = userVO.getUser_nm();
			String content = userName + " 직원 부서 변경";
			log.info(userName+" "+content);
			boardService.upDateUserTable(userName, content);
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return "redirect:/board/tree";
	}*/
}
