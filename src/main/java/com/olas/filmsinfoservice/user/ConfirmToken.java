package com.olas.filmsinfoservice.user;

public class ConfirmToken 
{
	private String username;
	private String token;
	private long expiryTime;
	
	public ConfirmToken(){}
	
	public ConfirmToken(String username, String token, long expiryTime)
	{
		this.username = username;
		this.token = token;
		this.expiryTime = expiryTime;
	}
	
	public String getUsername() {return username;}
	public void setUsername(String username) {this.username = username;}
	
	public String getToken() {return token;}
	public void setToken(String token) {this.token = token;}
	
	public long getExpiryTime() {return expiryTime;}
	public void setExpiryTime(long expiryTime) {this.expiryTime = expiryTime;}
}
