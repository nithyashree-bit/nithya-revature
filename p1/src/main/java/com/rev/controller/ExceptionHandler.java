package com.rev.controller;

import org.springframework.web.bind.annotation.ControllerAdvice;

@ControllerAdvice
public class ExceptionHandler {

	@org.springframework.web.bind.annotation.ExceptionHandler(Exception.class)
	public String allexceptions(Exception e) {
		System.out.println(e.getMessage());
		return "redirect:/";
	}
	
}
