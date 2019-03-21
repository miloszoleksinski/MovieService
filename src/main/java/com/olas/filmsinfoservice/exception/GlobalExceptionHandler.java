package com.olas.filmsinfoservice.exception;

import java.io.IOException;
import java.security.Principal;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

import com.olas.filmsinfoservice.user.UserService;

@ControllerAdvice
public class GlobalExceptionHandler
{
	@Autowired
	private UserService userService;
	
	private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);
	
	@ResponseStatus(value=HttpStatus.NOT_FOUND, reason="IOException occured")
	@ExceptionHandler(IOException.class) 
	public void handleIOException(HttpServletRequest request, Exception ex)
	{
		logger.error("IOException handler executed");
	}
	
	@ExceptionHandler({SQLException.class, DataAccessException.class}) 
	public String handleNumberFormatException(HttpServletRequest request, Exception ex, Model model, Principal principal)
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		logger.error("Database error occured");
		ex.printStackTrace();
		return "database-error";
	}
	
	@ExceptionHandler(PersonNotFoundException.class) 
	public ModelAndView handlePersonNotFoundException(HttpServletRequest request, Exception ex, Model model, Principal principal)
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		logger.error("PersonNotFound error occured");
		ModelAndView mav = new ModelAndView();
		mav.addObject("exception", ex.getMessage());
		mav.setViewName("PersonNotFoundException");
		return mav;
	}
	
	@ExceptionHandler(MovieNotFoundException.class) 
	public ModelAndView handleMovieNotFoundException(HttpServletRequest request, Exception ex, Model model, Principal principal)
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		logger.error("MovieNotFound error occured");
		ModelAndView mav = new ModelAndView();
		mav.addObject("exception", ex.getMessage());
		mav.setViewName("MovieNotFoundException");
		return mav;
	}
	
	@ExceptionHandler(NumberFormatException.class) 
	public String handleDatabaseExceptions(HttpServletRequest request, Exception ex, Model model, Principal principal)
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		logger.error("NumberFormatException handler executed");
		return "500";
	}
	
	@ExceptionHandler(UserNotRegisteredException.class) 
	public ModelAndView handleUserNotRegisteredException(HttpServletRequest request, Exception ex, Model model, Principal principal)
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		logger.error("UserNotRegisteredException handler executed");
		ModelAndView mav = new ModelAndView();
		mav.addObject("exception", ex.getMessage());
		mav.setViewName("UserNotRegisteredException");
		return mav;
	}
	
	@ExceptionHandler(UserIsAlreadyEnabledException.class) 
	public ModelAndView handleUserIsAlreadyEnabledException(HttpServletRequest request, Exception ex, Model model, Principal principal)
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		logger.error("UserIsAlreadyEnabledException handler executed");
		ModelAndView mav = new ModelAndView();
		mav.addObject("exception", ex.getMessage());
		mav.setViewName("UserIsAlreadyEnabledException");
		return mav;
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
    public String handleNoHandlerFoundException(NoHandlerFoundException ex, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
        return "404";
    }
}
