package com.olas.filmsinfoservice.exception;

public class EmailExistsException extends Exception
{
	private static final long serialVersionUID = -8755000870233733477L;
	
	public EmailExistsException(String email)
	{
		super("There already is account with that email adress: '"+email+"'");
	}
}
