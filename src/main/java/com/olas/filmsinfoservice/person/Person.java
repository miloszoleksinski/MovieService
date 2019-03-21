package com.olas.filmsinfoservice.person;

import javax.validation.constraints.Size;

public class Person 
{
	@Size(min=1,max=150) 
	private String id;
	@Size(min=1,max=150) 
	private String name;
	@Size(min=1,max=150) 
	private String birth_date;
	private Integer growth;
	@Size(min=1,max=150) 
	private String born;
	
	public String getId() {return id;}
	public void setId(String id) {this.id = id;}
	
	public String getName() {return name;}
	public void setName(String name) {this.name = name;}
	
	public String getBirth_date() {return birth_date;}
	public void setBirth_date(String birth_date) {this.birth_date = birth_date;}
	
	public Integer getGrowth() {return growth;}
	public void setGrowth(Integer growth) {this.growth = growth;}
	
	public String getBorn() {return born;}
	public void setBorn(String born) {this.born = born;}
}
