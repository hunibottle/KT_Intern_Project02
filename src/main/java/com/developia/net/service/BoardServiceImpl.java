package com.developia.net.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.developia.net.domain.GroupVO;
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

}
