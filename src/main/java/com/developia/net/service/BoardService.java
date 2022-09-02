package com.developia.net.service;

import java.util.List;
import java.util.Map;

import com.developia.net.domain.GroupVO;
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

}
