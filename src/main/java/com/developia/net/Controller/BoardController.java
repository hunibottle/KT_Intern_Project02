package com.developia.net.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class BoardController {

	@GetMapping("/tree")
	public ModelAndView getList(Model model) {
		ModelAndView mav = new ModelAndView();
		try {
			mav.setViewName("tree");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@GetMapping("/test")
	public ModelAndView getTest(Model model) {
		ModelAndView mav = new ModelAndView();
		try {
			mav.setViewName("test");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
}
