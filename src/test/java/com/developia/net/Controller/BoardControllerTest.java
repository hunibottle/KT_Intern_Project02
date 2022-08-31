package com.developia.net.Controller;

import static org.junit.Assert.*;

import java.util.List;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.developia.net.DataSourceTests;
import com.developia.net.domain.GroupVO;
import com.developia.net.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
@Controller
public class BoardControllerTest {
	
	  @Setter(onMethod_ = {@Autowired})
	  private BoardService boardService;
	
	@Test
	public void test() throws Exception {
		List<GroupVO> getGroup = boardService.getGroupList();
		log.info(getGroup.toString());
	}

}
