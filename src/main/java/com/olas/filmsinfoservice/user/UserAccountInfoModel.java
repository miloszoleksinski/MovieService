package com.olas.filmsinfoservice.user;

public class UserAccountInfoModel 
{
	private String username;
	private String registrationTimestamp;
	private int accountViews;
	private String lastSeenTimestamp;
	private int score;
	
	public String getUsername() {return username;}
	public void setUsername(String username) {this.username = username;}
	
	public String getRegistrationTimestamp() {return registrationTimestamp;}
	public void setRegistrationTimestamp(String registrationTimestamp) {this.registrationTimestamp = registrationTimestamp;}
	
	public int getAccountViews() {return accountViews;}
	public void setAccountViews(int accountViews) {this.accountViews = accountViews;}
	
	public String getLastSeenTimestamp() {return lastSeenTimestamp;}
	public void setLastSeenTimestamp(String lastSeenTimestamp) {this.lastSeenTimestamp = lastSeenTimestamp;}
	
	public int getScore() {return score;}
	public void setScore(int score) {this.score = score;}
}
