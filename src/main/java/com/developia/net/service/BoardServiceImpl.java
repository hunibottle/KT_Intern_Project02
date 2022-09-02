package com.developia.net.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.developia.net.domain.GroupVO;
import com.developia.net.domain.UserVO;
import com.developia.net.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{

	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	
	@Override
	public List<GroupVO> getGroupList() throws Exception {
		return boardMapper.getGroupList();
	}


	@Override
	public List<Map<String, Object>> getSecondLevel(int gCode) throws Exception {
		return boardMapper.getSecondLevel(gCode);
	}


	@Override
	public List<Map<String, Object>> getThirdLevel(int pCode) throws Exception {
		return boardMapper.getThirdLevel(pCode);
	}


	@Override
	public List<Map<String, Object>> getLastLevel(int lastLevel) throws Exception {
		return boardMapper.getLastLevel(lastLevel);
	}


	@Override
	public List<Map<String, Object>> getMember(int memberCode) throws Exception {
		return boardMapper.getMember(memberCode);
	}


	@Override
	public List<Map<String, Object>> getUserDetail(String user_nm) throws Exception {
		return boardMapper.getUserDetail(user_nm);
	}


	@Override
	public List<Map<String, Object>> autoComplete(Map<String, Object> paramMap, String value) throws Exception {
		return boardMapper.autoComplete(paramMap, value);
	}


	@Override
	public void upDate(UserVO userVO) throws Exception {
		boardMapper.upDate(userVO);
	}


	@Override
	public void updateUserGroup(String user_id, int gCode, String new_group) throws Exception {
		boardMapper.updateUserGroup(user_id, gCode, new_group);
	}


	@Override
	public int getGroupCode(String new_group) throws Exception {
		return boardMapper.getGroupCode(new_group);
	}


	@Override
	public List<Map<String, Object>> getSecondLevelGroup(int lv2Pcode) throws Exception {
		return boardMapper.getSecondLevelGroup(lv2Pcode);
	}


	@Override
	public List<Map<String, Object>> getThirdLevelGroup(int lv3Pcode) throws Exception {
		return boardMapper.getThirdLevelGroup(lv3Pcode);
	}


	@Override
	public List<Map<String, Object>> getLastLevelGroup(int lvlast) throws Exception {
		return boardMapper.getLastLevelGroup(lvlast);
	}


	@Override
	public int makeGroupCode(int level_3_code) throws Exception {
		return boardMapper.makeGroupCode(level_3_code);
	}


	@Override
	public void makeGroup_1(int nextGroupCode, String groupName, int level_3_code) throws Exception {
		boardMapper.makeGroup_1(nextGroupCode, groupName, level_3_code);
	}


	@Override
	public int groupCheck(int level_3_code) throws Exception {
		return boardMapper.groupCheck(level_3_code);
	}


	@Override
	public int bigGroupCheck(int level_2_code) throws Exception {
		return boardMapper.bigGroupCheck(level_2_code);
	}

}
