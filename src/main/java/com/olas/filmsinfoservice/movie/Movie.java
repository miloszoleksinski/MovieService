package com.olas.filmsinfoservice.movie;

import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class Movie 
{
	@Size(min=1,max=150) 
	private String id;
	@Size(min=1,max=150)
	private String title;
	@NotNull @Min(1800)
	private Integer year;
	@Size(min=1,max=150)
	private String director;
	@Size(min=1,max=3000)
	private String description;
	
	private List<String> types;
	private double rating;
	private List<MovieComment> comments;
	
	public String getId() {return id;}
	public void setId(String id) {this.id = id;}
	
	public String getTitle() {return title;}
	public void setTitle(String title) {this.title = title;}
	
	public Integer getYear() {return year;}
	public void setYear(Integer year) {this.year = year;}
	
	public List<String> getTypes() {return types;}
	public void setTypes(List<String> types) {this.types = types;}
	
	public List<MovieComment> getComments() {return comments;}
	public void setComments(List<MovieComment> comments) {this.comments = comments;}
	
	public String getDirector() {return director;}
	public void setDirector(String director) {this.director = director;}
	
	public String getDescription() {return description;}
	public void setDescription(String description) {this.description = description;}
	
	public Double getRating() { return rating; }
	public void setRating(Double rating) { this.rating = rating; }
}
