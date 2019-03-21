package com.olas.filmsinfoservice.exception;

public class UserIsAlreadyEnabledException extends Exception
{
	private static final long serialVersionUID = 4929814725263807891L;
	
	public UserIsAlreadyEnabledException(String username)
	{
		super("User '"+username+"' account is already activated.");
	}
}
