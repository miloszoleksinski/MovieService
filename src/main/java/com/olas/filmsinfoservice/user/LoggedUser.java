package com.olas.filmsinfoservice.user;

import java.util.List;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

public class LoggedUser implements HttpSessionBindingListener
{
	private String username; 
    private ActiveUserStore activeUserStore;
    
    public LoggedUser(String username, ActiveUserStore activeUserStore) 
    {
        this.username = username;
        this.activeUserStore = activeUserStore;
    }
     
    public LoggedUser() {}
    
	public String getUsername() {return username;}
	public void setUsername(String username) {this.username = username;}

	public ActiveUserStore getActiveUserStore() {return activeUserStore;}
	public void setActiveUserStore(ActiveUserStore activeUserStore) {this.activeUserStore = activeUserStore;}
 
    @Override
    public void valueBound(HttpSessionBindingEvent event) 
    {
        List<String> users = activeUserStore.getUsers();
        LoggedUser user = (LoggedUser) event.getValue();
        if ( !users.contains(user.getUsername()) ) 
        {
        	activeUserStore.getUsers().add(user.getUsername());
        }
    }
 
    @Override
    public void valueUnbound(HttpSessionBindingEvent event) 
    {
        List<String> users = activeUserStore.getUsers();
        LoggedUser user = (LoggedUser) event.getValue();
        if ( users.contains(user.getUsername()) ) 
        {
        	activeUserStore.getUsers().remove(user.getUsername());
        }
    }
}