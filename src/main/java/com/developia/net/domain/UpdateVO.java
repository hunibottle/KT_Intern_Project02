package com.developia.net.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class UpdateVO {
	private int update_seq;
	private String update_name;
	
	@DateTimeFormat(pattern ="yyyy-MM-dd")
	private Date update_time;
	private String update_content;
}
