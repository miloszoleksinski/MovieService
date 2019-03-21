package com.olas.filmsinfoservice.user;

public class UserRatingModel 
{
	private String movieID;
	private int movieRate;
	private String time;
	
	public String getMovieID() {return movieID;}
	public void setMovieID(String movieID) {this.movieID = movieID;}
	
	public int getMovieRate() {return movieRate;}
	public void setMovieRate(int movieRate) {this.movieRate = movieRate;}
	
	public String getTime() {return time;}
	public void setTime(String time) {this.time = time;}
}
