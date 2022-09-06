package com.developia.net.service;

import java.util.List;
import java.util.Map;

import com.developia.net.domain.GroupVO;
import com.developia.net.domain.UpdateVO;
import com.developia.net.domain.UserVO;

public interface BoardService {

	List<GroupVO> getGroupList() throws Exception;

	List<Map<String, Object>> getSecondLevel(int gCode) throws Exception;

	List<Map<String, Object>> getThirdLevel(int pCode) throws Exception;

	List<Map<String, Object>> getLastLevel(int lastLevel) throws Exception;

	List<Map<String, Object>> getMember(int memberCode) throws Exception;

	List<Map<String, Object>> getUserDetail(String user_nm) throws Exception;

	List<Map<String, Object>> autoComplete(Map<String, Object> paramMap, String value) throws Exception;

	public void upDate(UserVO userVO) throws Exception;

	public void updateUserGroup(String user_id, int gCode, String new_group) throws Exception;

	public int getGroupCode(String new_group) throws Exception;

	List<Map<String, Object>> getSecondLevelGroup(int lv2Pcode) throws Exception;

	List<Map<String, Object>> getThirdLevelGroup(int lv3Pcode) throws Exception;

	List<Map<String, Object>> getLastLevelGroup(int lvlast) throws Exception;

	public int makeGroupCode(int level_3_code) throws Exception;

	public void makeGroup_1(int nextGroupCode, String groupName, int level_3_code) throws Exception;

	public int groupCheck(int level_3_code) throws Exception;

	public int bigGroupCheck(int level_2_code) throws Exception;

	public int getnewPartNum(int group_cd) throws Exception;

	public void makeNewPart(int newPartNum, int level_3_code, String groupNewName) throws Exception;

	List<Map<String, Object>> getGroupOneMember(int groupOneCode) throws Exception;

	public void updateGroupMember(int target, int newPartNum, String groupNewName) throws Exception;

	public void deleteGroup(int group_code) throws Exception;

	public void updateGroupName(String target, String new_name) throws Exception;

	public void updateTeamName(int level_3_code, String new_name) throws Exception;

	public String deleteCheckLv3(int level_3_code) throws Exception;

	public void upDateUserTable(String userName, String content) throws Exception;

	List<UpdateVO> getUpdateList() throws Exception;

	List<UserVO> getAllUserList() throws Exception;

	List<Map<String, Object>> getSearchList(String keyword, int option) throws Exception;

	List<Map<String, Object>> nameAutoComplete(Map<String, Object> paramMap, String value, int option) throws Exception;

	public String getGroupName(int groupOneCode) throws Exception;

	public void userDelete(String user_id) throws Exception;

	public String getUserNameID(String user_id) throws Exception;

}
