package com.olas.filmsinfoservice.exception;

public class MovieNotFoundException extends Exception
{
	private static final long serialVersionUID = -5950037488715525566L;
	
	public MovieNotFoundException(String id)
	{
		super("Movie not found with id='"+id+"'");
	}
}
