package com.olas.filmsinfoservice.exception;

public class UsernameExistsException extends Exception
{
	private static final long serialVersionUID = 4200859641142048175L;

	public UsernameExistsException(String username)
	{
		super("There already is account with that username: '"+username+"'");
	}
}
