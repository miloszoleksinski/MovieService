package com.olas.filmsinfoservice.movie;


public class MovieComment 
{
	private Integer rowID;
	private String username;
	private String comment;
	private String commentType;
	private Integer commentID;
	private String time;
	private Integer likes;
	
	public Integer getRowID() {return rowID;}
	public void setRowID(Integer rowID) {this.rowID = rowID;}

	public String getUsername() {return username;}
	public void setUsername(String username) {this.username = username;}
	
	public String getComment() {return comment;}
	public void setComment(String comment) {this.comment = comment;}
	
	public String getCommentType() {return commentType;}
	public void setCommentType(String commentType) {this.commentType = commentType;}
	
	public Integer getCommentID() {return commentID;}
	public void setCommentID(Integer commentID) {this.commentID = commentID;}
	
	public String getTime() {return time;}
	public void setTime(String time) {this.time = time;}
	
	public Integer getLikes() {return likes;}
	public void setLikes(Integer likes) {this.likes = likes;}
}
