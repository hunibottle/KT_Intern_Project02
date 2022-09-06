package com.developia.net.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.developia.net.domain.GroupVO;
import com.developia.net.domain.UpdateVO;
import com.developia.net.domain.UserVO;

public interface BoardMapper {

	List<GroupVO> getGroupList() throws Exception;

	List<Map<String, Object>> getSecondLevel(int gCode) throws Exception;

	List<Map<String, Object>> getThirdLevel(int pCode) throws Exception;

	List<Map<String, Object>> getLastLevel(int lastLevel) throws Exception;

	List<Map<String, Object>> getMember(int memberCode) throws Exception;

	List<Map<String, Object>> getUserDetail(String user_nm) throws Exception;

	List<Map<String, Object>> autoComplete(@Param("paramMap") Map<String, Object> paramMap,
			@Param("value") String value) throws Exception;

	public void upDate(UserVO userVO) throws Exception;

	public void updateUserGroup(@Param("user_id") String user_id, 
			@Param("gCode") int gCode, @Param("new_group") String new_group) throws Exception;

	public int getGroupCode(String new_group) throws Exception;

	List<Map<String, Object>> getSecondLevelGroup(int lv2Pcode) throws Exception;

	List<Map<String, Object>> getThirdLevelGroup(int lv3Pcode) throws Exception;

	List<Map<String, Object>> getLastLevelGroup(int lvlast) throws Exception;

	public int makeGroupCode(int level_3_code) throws Exception;

	public void makeGroup_1(@Param("nextGroupCode") int nextGroupCode, @Param("groupName") String groupName,
			@Param("level_3_code") int level_3_code) throws Exception;

	public int groupCheck(int level_3_code) throws Exception;

	public int bigGroupCheck(int level_2_code) throws Exception;

	public int getnewPartNum(int group_cd) throws Exception;

	public void makeNewPart(@Param("newPartNum") int newPartNum,@Param("level_3_code") int level_3_code, @Param("groupNewName") String groupNewName) throws Exception;

	List<Map<String, Object>> getGroupOneMember(int groupOneCode) throws Exception;

	public void updateGroupMember(@Param("target") int target, @Param("newPartNum") int newPartNum, @Param("groupNewName") String groupNewName) throws Exception;

	public void deleteGroup(int group_code) throws Exception;

	public void updateGroupName(@Param("target") String target, @Param("new_name") String new_name) throws Exception;

	public void updateTeamName(@Param("level_3_code") int level_3_code,@Param("new_name") String new_name) throws Exception;

	public String deleteCheckLv3(int level_3_code) throws Exception;

	public void upDateUserTable(@Param("userName") String userName, @Param("content") String content) throws Exception;

	List<UpdateVO> getUpdateList() throws Exception;
	
	List<UserVO> getAllUserList() throws Exception;

	List<Map<String, Object>> getSearchList(@Param("keyword") String keyword,@Param("option") int option) throws Exception;

	List<Map<String, Object>> nameAutoComplete(@Param("paramMap") Map<String, Object> paramMap, @Param("value") String value, @Param("option") int option) throws Exception;

	public String getGroupName(int groupOneCode) throws Exception;

	public void userDelete(String user_id) throws Exception;

	public String getUserNameID(String user_id) throws Exception;
}
