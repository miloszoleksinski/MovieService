package com.olas.filmsinfoservice.exception;

public class PersonNotFoundException extends Exception
{
	private static final long serialVersionUID = -7953466069518358370L;
	
	public PersonNotFoundException(String id)
	{
		super("Person not found with id='"+id+"'");
	}
}
