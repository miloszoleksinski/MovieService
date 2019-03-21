package com.olas.filmsinfoservice.movie;

public class FilterParams 
{
	private String title;
	private String type;
	private String year;
	private String endYear;
	private String director;
	
	public String getType() {return type;}
	public void setType(String type) {this.type = type;}
	
	public String getYear() {return year;}
	public void setYear(String year) {this.year = year;}
	
	public String getEndYear() {return endYear;}
	public void setEndYear(String endYear) {this.endYear = endYear;}
	
	public String getDirector() {return director;}
	public void setDirector(String director) {this.director = director;}
	
	public String getTitle() {return title;}
	public void setTitle(String title) {this.title = title;}
}