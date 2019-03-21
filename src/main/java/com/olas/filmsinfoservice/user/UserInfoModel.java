package com.olas.filmsinfoservice.user;

public class UserInfoModel 
{
	private String name;
	private Integer age;
	private String favMovies;
	private String aboutMe;
	private String description;
	
	public String getName() {return name;}
	public void setName(String name) {this.name = name;}
	
	public Integer getAge() {return age;}
	public void setAge(Integer age) {this.age = age;}
	
	public String getFavMovies() {return favMovies;}
	public void setFavMovies(String favMovies) {this.favMovies = favMovies;}
	
	public String getAboutMe() {return aboutMe;}
	public void setAboutMe(String aboutMe) {this.aboutMe = aboutMe;}
	
	public String getDescription() {return description;}
	public void setDescription(String description) {this.description = description;}
}
