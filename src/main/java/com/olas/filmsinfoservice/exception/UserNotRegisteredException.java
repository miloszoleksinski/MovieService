package com.olas.filmsinfoservice.exception;

public class UserNotRegisteredException extends Exception
{
	private static final long serialVersionUID = -4505885820393730911L;

	public UserNotRegisteredException(String username)
	{
		super("User '"+username+"' is not registered.");
	}
}
