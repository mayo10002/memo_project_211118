package com.memo.test;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class testController {
	@ResponseBody
	@RequestMapping("/test1")
	public String helloWorld() {
		return "Hello World!";
	}
	
	//json
	@ResponseBody
	@RequestMapping("/test2")
	public Map<String, Object> test2(){
		Map<String, Object> result = new HashMap<>();
		result.put("aaa", 2828);
		result.put("bbbb", "result");
		result.put("cccc", 1212);
		
		return result;
	}
	
	//jsp
	@RequestMapping("/test3")
	public String test3() {
		return "test/example";
	}
}
