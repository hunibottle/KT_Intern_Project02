package com.developia.net.domain;

import java.util.List;

import lombok.Data;

@Data
public class UserVO {
	private int seq;
	private int co_seq;
	private String user_id;
	private int user_num;
	private int group_code;
	private String user_nm;
	private String user_office;
	private String user_email;
	private String grade_code;
	private String user_mobile;
	private String user_title;
	private String grade_nm;
	
	private List<GroupVO> groupList;
	private List<TitleVO> titleList;
	private List<GradeVO> gradeList;
}
