package com.olas.filmsinfoservice;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.olas.filmsinfoservice.movie.FilterParams;
import com.olas.filmsinfoservice.movie.Movie;
import com.olas.filmsinfoservice.movie.MovieService;
import com.olas.filmsinfoservice.person.PersonFilterParams;
import com.olas.filmsinfoservice.user.UserService;

@Controller
public class HomeController 
{
	@Autowired
	private HomeService homeService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private MovieService movieService;
	
	@RequestMapping(value = {"/", "/home"}, method = RequestMethod.GET)
	public String home(Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		List<Movie> bestRatedMovies = homeService.get9MoviesWithGreatestRating();
		model.addAttribute("bestMovies", bestRatedMovies);
		model.addAttribute("directorLink", movieService.getDirectorLinks(bestRatedMovies) );
		
		List<Movie> newestMovies = homeService.get9NewestMovies();
		model.addAttribute("newMovies", newestMovies);
		model.addAttribute("newestMovieDirectorLink", movieService.getDirectorLinks(newestMovies) );
		
		List<Movie> latelyAddedMovies = homeService.get9MoviesAddedLately();
		model.addAttribute("latelyAddedMovies", latelyAddedMovies);
		model.addAttribute("latelYaddedMovieDirectorLink", movieService.getDirectorLinks(latelyAddedMovies) );
		
		return "home";
	}
	
	@RequestMapping(value = "/filter", method = RequestMethod.GET)
	public String filterMovies(Model model, Principal principal)
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		model.addAttribute("PersonFilterParams", new PersonFilterParams());
		return "filterMovie";
	}
}
