package com.olas.filmsinfoservice.user;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotEmpty;

import com.olas.filmsinfoservice.annotation.PasswordMatches;

@PasswordMatches
public class UserModel 
{
	/*@NotNull
    @NotEmpty
    @Pattern(regexp = "[A-Za-z]*")
    private String firstName;
     
    @NotNull
    @NotEmpty
    @Pattern(regexp = "[A-Za-z]*")
    private String lastName;*/
    
    @NotNull
    @NotEmpty
    @Pattern(regexp = "[A-Za-z]*")
    private String username;
     
    @NotNull
    @NotEmpty
    @Pattern(regexp = "[A-Za-z0-9]*")
    private String password;
    @NotNull
    @NotEmpty
    @Pattern(regexp = "^[A-Za-z0-9]*")
    private String matchingPassword;
     
    @NotNull
    @NotEmpty
    @Pattern(regexp = "^[_A-Za-z0-9-+]+(.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(.[A-Za-z0-9]+)*(.[A-Za-z]{2,})$")
    private String email;
    
    private boolean enabled;

	/*public String getFirstName() {return firstName;}
	public void setFirstName(String firstName) {this.firstName = firstName;}

	public String getLastName() {return lastName;}
	public void setLastName(String lastName) {this.lastName = lastName;}*/
	
	public String getUsername() {return username;}
	public void setUsername(String username) {this.username = username;}

	public String getPassword() {return password;}
	public void setPassword(String password) {this.password = password;}

	public String getMatchingPassword() {return matchingPassword;}
	public void setMatchingPassword(String matchingPassword) {this.matchingPassword = matchingPassword;}

	public String getEmail() {return email;}
	public void setEmail(String email) {this.email = email;}
	
	public boolean isEnabled() {return enabled;}
	public void setEnabled(boolean enabled) {this.enabled = enabled;}
}
