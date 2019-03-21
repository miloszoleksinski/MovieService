package com.olas.filmsinfoservice.ajax;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.olas.filmsinfoservice.movie.MovieService;
import com.olas.filmsinfoservice.user.UserAccountInfoModel;
import com.olas.filmsinfoservice.user.UserBadgeModel;
import com.olas.filmsinfoservice.user.UserService;

@Controller
public class AjaxController 
{
	@Autowired
	private MovieService movieService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value = "/searchBadges2")
	public @ResponseBody List<String> searchBadges2(HttpServletRequest request)
	{
		String badgeName = request.getParameter("badgeName").trim();
		List<UserBadgeModel> badges = userService.getUserBadgesByTitle(badgeName);
		ArrayList<String> badgesJsonList = new ArrayList<String>();
		ObjectMapper mapper = new ObjectMapper();
		
		for(int i=0; i<badges.size(); i++)
		{
			try { badgesJsonList.add( mapper.writeValueAsString( badges.get(i) ) );}
			catch (JsonProcessingException e) {return null;}
		}
		
		return badgesJsonList;
	}
	
	@RequestMapping(value = "/bestUsers/list")
	public @ResponseBody List<String> bestUsersList()
	{
		List<UserAccountInfoModel> bestUsers = userService.getBestUsers();
		ArrayList<String> bestUsersJsonList = new ArrayList<String>();
		ObjectMapper mapper = new ObjectMapper();
		
		for(int i=0; i<bestUsers.size(); i++)
		{
			try { bestUsersJsonList.add( mapper.writeValueAsString( bestUsers.get(i) ) );}
			catch (JsonProcessingException e) {return null;}
		}
		
		return bestUsersJsonList;
	}
	
	@RequestMapping(value = "/moderators/listOfAdmins")
	public @ResponseBody List<String> listOfAdmins()
	{
		List<String> admins = userService.getUsernamesOfAdmins();
		return admins;
	}
	
	@RequestMapping(value = "/moderators/listOfHosts")
	public @ResponseBody List<String> listOfHosts()
	{
		List<String> hosts = userService.getUsernamesOfHosts();
		return hosts;
	}
	
	@RequestMapping(value = "/likeComment", params = {"rowID", "movieID", "movieTitle", "commentUser"}, method = RequestMethod.GET)
	public @ResponseBody String likeComment(
			@RequestParam( "rowID" ) int rowID,
			@RequestParam( "movieID" ) String movieID,
			@RequestParam( "movieTitle" ) String movieTitle,
			@RequestParam( "commentUser" ) String commentUser,
			Principal principal, Model model)
	{
		String loggedUsername = principal.getName();
		userService.updateLastSeen(loggedUsername);
		
		movieService.likeOrUnlikeComment(rowID, loggedUsername, commentUser, movieID, movieTitle);
		
		int givenLikes = userService.getCountOfGivenLikesByUsername(loggedUsername);
		userService.addGivenLikesBadgeIfPossible(loggedUsername, givenLikes);
		
		return "0";
	}
}
