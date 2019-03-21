package com.olas.filmsinfoservice.user;

public class UserNotificationModel 
{
	private String fromUser;
	private String addedFriend;
	private String movieID;
	private String notification;
	private String type;
	private Integer rate;
	private String time;
	private String seen;
	
	public String getFromUser() {return fromUser;}
	public void setFromUser(String fromUser) {this.fromUser = fromUser;}
	
	public String getAddedFriend() {return addedFriend;}
	public void setAddedFriend(String addedFriend) {this.addedFriend = addedFriend;}
	
	public String getMovieID() {return movieID;}
	public void setMovieID(String movieID) {this.movieID = movieID;}
	
	public String getNotification() {return notification;}
	public void setNotification(String notification) {this.notification = notification;}
	
	public String getType() {return type;}
	public void setType(String type) {this.type = type;}
	
	public Integer getRate() {return rate;}
	public void setRate(Integer rate) {this.rate = rate;}
	
	public String getTime() {return time;}
	public void setTime(String time) {this.time = time;}
	
	public String getSeen() {return seen;}
	public void setSeen(String seen) {this.seen = seen;}
}
