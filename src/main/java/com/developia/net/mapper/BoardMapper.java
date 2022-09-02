package com.developia.net.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.developia.net.domain.GroupVO;
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
}
