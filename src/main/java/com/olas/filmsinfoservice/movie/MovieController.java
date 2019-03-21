package com.olas.filmsinfoservice.movie;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.olas.filmsinfoservice.exception.MovieNotFoundException;
import com.olas.filmsinfoservice.user.UserService;

@Controller
public class MovieController 
{
	@Autowired
	private MovieService movieService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value = "/movies", method = RequestMethod.GET)
	public String redirectToMoviesFirstPage(Model model, Principal principal) 
	{
		return "redirect:/movies?page=0";
	}
	
	@RequestMapping(value = "/movies", params = {"page"}, method = RequestMethod.GET)
	public String getMovies(@RequestParam( "page" ) int page, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		List<Movie> movies = movieService.getMovies(page);
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getAllMoviesLastPage() );
		model.addAttribute("page", page);
		model.addAttribute("typeOfSite", "all");
		return "MoviesPage";
	}
	
	@RequestMapping(value = "/movies", params = {"type","page"}, method = RequestMethod.GET)
	public String getMoviesByType(@RequestParam( "page" ) int page,@RequestParam( "type" ) String type, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		List<Movie> movies = movieService.getMoviesByType(type, page);
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByTypeLastPage(type));
		model.addAttribute("page", page);
		model.addAttribute("movieType", type);
		model.addAttribute("typeOfSite", "type");
		return "MoviesPage"; //MoviesByTypePage
	}
	
	@RequestMapping(value = "/movies", params = {"page","title"}, method = RequestMethod.GET)
	public String getMoviesByTitle(@RequestParam( "page" ) int page,@RequestParam( "title" ) String title, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		List<Movie> movies = movieService.getMoviesByTitle(title, page);
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByTitleLastPage(title));
		model.addAttribute("page", page);
		model.addAttribute("title", title);
		model.addAttribute("typeOfSite", "title");
		return "MoviesPage"; //MoviesByTitlePage
	}
	
	@RequestMapping(value = "/movies", params = {"director","page"}, method = RequestMethod.GET)
	public String getMoviesByDirector(@RequestParam("page") int page,@RequestParam("director") String director, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		String newDirector = movieService.replaceDirectorWithSpace(director);
		List<Movie> movies = movieService.getMoviesByDirector(newDirector, page);
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByDirectorLastPage(newDirector));
		model.addAttribute("page", page);
		model.addAttribute("director", newDirector);
		model.addAttribute("typeOfSite", "director");
		return "MoviesPage"; //MoviesByDirectorPage
	}
	
	@RequestMapping(value = "/movies", params = {"director","page", "type"}, method = RequestMethod.GET)
	public String getMoviesByDirectorAndType(@RequestParam( "type" ) String type, @RequestParam("page") int page, @RequestParam("director") String director, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		String newDirector = movieService.replaceDirectorWithSpace(director);
		List<Movie> movies = movieService.getMoviesByDirectorAndType(newDirector, page, type);
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByDirectorAndTypeLastPage(newDirector, type));
		model.addAttribute("page", page);
		model.addAttribute("director", newDirector);
		model.addAttribute("movieType", type);
		model.addAttribute("typeOfSite", "directorType");
		return "MoviesPage"; // MoviesByDirectorAndTypePage
	}
	
	@RequestMapping(value = "/movies", params = {"director","page", "type", "year"}, method = RequestMethod.GET)
	public String getMoviesByDirectorAndTypeAndYear(@RequestParam("year") int year, @RequestParam( "type" ) String type, @RequestParam("page") int page, @RequestParam("director") String director, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		String newDirector = movieService.replaceDirectorWithSpace(director);
		List<Movie> movies = movieService.getMoviesByDirectorAndTypeAndYear(newDirector, page, type, year);
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByDirectorAndTypeAndYearLastPage(newDirector, type, year));
		model.addAttribute("page", page);
		model.addAttribute("year", year);
		model.addAttribute("director", newDirector);
		model.addAttribute("movieType", type);
		model.addAttribute("typeOfSite", "directorTypeYear");
		return "MoviesPage"; // MoviesByDirectorAndTypeAndYearPage
	}
	
	@RequestMapping(value = "/movies", params = {"director","page", "type", "endYear"}, method = RequestMethod.GET)
	public String getMoviesByDirectorAndTypeAndEndYear(@RequestParam("endYear") int endYear, @RequestParam( "type" ) String type, @RequestParam("page") int page, @RequestParam("director") String director, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		String newDirector = movieService.replaceDirectorWithSpace(director);
		List<Movie> movies = movieService.getMoviesByDirectorAndTypeAndEndYear(newDirector, page, type, endYear);
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByDirectorAndTypeAndEndYearLastPage(newDirector, type, endYear));
		model.addAttribute("page", page);
		model.addAttribute("endYear", endYear);
		model.addAttribute("director", newDirector);
		model.addAttribute("movieType", type);
		model.addAttribute("typeOfSite", "directorTypeEndYear");
		return "MoviesPage"; // MoviesByDirectorAndTypeAndEndYearPage
	}
	
	@RequestMapping(value = "/movies", params = {"director","page", "type", "year", "endYear"}, method = RequestMethod.GET)
	public String getMoviesByDirectorAndTypeAndYears(@RequestParam("year") int year, @RequestParam("endYear") int endYear, @RequestParam( "type" ) String type, @RequestParam("page") int page, @RequestParam("director") String director, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		String newDirector = movieService.replaceDirectorWithSpace(director);
		List<Movie> movies = movieService.getMoviesByDirectorAndTypeAndYears(newDirector, page, type, year, endYear);
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByDirectorAndTypeAndYearsLastPage(newDirector, type, year, endYear));
		model.addAttribute("page", page);
		model.addAttribute("endYear", endYear);
		model.addAttribute("year", year);
		model.addAttribute("director", newDirector);
		model.addAttribute("movieType", type);
		model.addAttribute("typeOfSite", "directorTypeYearEndYear");
		return "MoviesPage"; // MoviesByDirectorAndTypeAndYearsPage
	}
	
	@RequestMapping(value = "/movies", params = {"director","page","year"}, method = RequestMethod.GET)
	public String getMoviesByDirectorAndYear(@RequestParam( "year" ) int year, @RequestParam("page") int page, @RequestParam("director") String director, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		String newDirector = movieService.replaceDirectorWithSpace(director);
		List<Movie> movies = movieService.getMoviesByDirectorAndYear(newDirector, page, year);
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByDirectorAndYearLastPage(newDirector, year));
		model.addAttribute("page", page);
		model.addAttribute("year", year);
		model.addAttribute("director", newDirector);
		model.addAttribute("typeOfSite", "directorYear");
		return "MoviesPage"; // MoviesByDirectorAndYearPage
	}
	
	@RequestMapping(value = "/movies", params = {"director","page","endYear"}, method = RequestMethod.GET)
	public String getMoviesByDirectorAndEndYear(@RequestParam( "endYear" ) int endYear, @RequestParam("page") int page, @RequestParam("director") String director, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		String newDirector = movieService.replaceDirectorWithSpace(director);
		List<Movie> movies = movieService.getMoviesByDirectorAndEndYear(newDirector, page, endYear);
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByDirectorAndEndYearLastPage(newDirector, endYear));
		model.addAttribute("page", page);
		model.addAttribute("endYear", endYear);
		model.addAttribute("director", newDirector);
		model.addAttribute("typeOfSite", "directorEndYear");
		return "MoviesPage"; // MoviesByDirectorAndEndYearPage
	}
	
	@RequestMapping(value = "/movies", params = {"director","page", "year","endYear"}, method = RequestMethod.GET)
	public String getMoviesByDirectorAndYears(@RequestParam( "year" ) int year, @RequestParam( "endYear" ) int endYear, @RequestParam("page") int page, @RequestParam("director") String director, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		String newDirector = movieService.replaceDirectorWithSpace(director);
		List<Movie> movies = movieService.getMoviesByDirectorAndYears(newDirector, page, year,endYear);
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByDirectorAndYearsLastPage(newDirector, year, endYear));
		model.addAttribute("page", page);
		model.addAttribute("year", year);
		model.addAttribute("endYear", endYear);
		model.addAttribute("director", newDirector);
		model.addAttribute("typeOfSite", "directorYearEndYear");
		return "MoviesPage"; // MoviesByDirectorAndYearsPage
	}
	
	@RequestMapping(value = "/movies", params = {"year","page"}, method = RequestMethod.GET)
	public String getMoviesByYear(@RequestParam( "page" ) int page,@RequestParam( "year" ) int year, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		List<Movie> movies = movieService.getMoviesByYear(year,page); 
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByYearLastPage(year));
		model.addAttribute("page", page);
		model.addAttribute("year", year);
		model.addAttribute("typeOfSite", "year");
		return "MoviesPage"; // MoviesByYearPage
	}
	
	@RequestMapping(value = "/movies", params = {"endYear","page"}, method = RequestMethod.GET)
	public String getMoviesByEndYear(@RequestParam( "page" ) int page,@RequestParam( "endYear" ) int endYear, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		List<Movie> movies = movieService.getMoviesByEndYear(endYear,page); 
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByEndYearLastPage(endYear));
		model.addAttribute("page", page);
		model.addAttribute("endYear", endYear);
		model.addAttribute("typeOfSite", "endYear");
		return "MoviesPage"; // MoviesByEndYearPage
	}
	
	@RequestMapping(value = "/movies", params = {"endYear","year","page"}, method = RequestMethod.GET)
	public String getMoviesByYears(@RequestParam( "page" ) int page,@RequestParam( "year" ) int year, @RequestParam( "endYear" ) int endYear, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		List<Movie> movies = movieService.getMoviesByYears(year, endYear, page); 
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByYearsLastPage(year, endYear));
		model.addAttribute("page", page);
		model.addAttribute("year", year);
		model.addAttribute("endYear", endYear);
		model.addAttribute("typeOfSite", "yearEndYear");
		return "MoviesPage"; // MoviesByYearsPage
	}
	
	@RequestMapping(value = "/movies", params = {"year","page","type"}, method = RequestMethod.GET)
	public String getMoviesByYearAndType(@RequestParam( "type" ) String type, @RequestParam( "page" ) int page,@RequestParam( "year" ) int year, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		List<Movie> movies = movieService.getMoviesByYearAndType(type, year, page); 
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByYearAndTypeLastPage(year, type));
		model.addAttribute("page", page);
		model.addAttribute("year", year);
		model.addAttribute("movieType", type);
		model.addAttribute("typeOfSite", "yearType");
		return "MoviesPage"; // MoviesByYearAndTypePage
	}
	
	@RequestMapping(value = "/movies", params = {"endYear","page","type"}, method = RequestMethod.GET)
	public String getMoviesByEndYearAndType(@RequestParam( "type" ) String type, @RequestParam( "page" ) int page,@RequestParam( "endYear" ) int endYear, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		List<Movie> movies = movieService.getMoviesByEndYearAndType(type, endYear, page); 
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByEndYearAndTypeLastPage(endYear, type));
		model.addAttribute("page", page);
		model.addAttribute("endYear", endYear);
		model.addAttribute("movieType", type);
		model.addAttribute("typeOfSite", "endYearType");
		return "MoviesPage"; // MoviesByEndYearAndTypePage
	}
	
	@RequestMapping(value = "/movies", params = {"endYear","year","page","type"}, method = RequestMethod.GET)
	public String getMoviesByYearsAndType(@RequestParam( "type" ) String type, @RequestParam( "page" ) int page,@RequestParam( "year" ) int year, @RequestParam( "endYear" ) int endYear, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("FilterParams", new FilterParams());
		List<Movie> movies = movieService.getMoviesByYearsAndType(type, year, endYear, page); 
		model.addAttribute("directorLink", movieService.getDirectorLinks(movies) );
		model.addAttribute("movies", movies );
		model.addAttribute("pageSize", movieService.getMoviesByYearsAndTypeLastPage(year, endYear, type));
		model.addAttribute("page", page);
		model.addAttribute("year", year);
		model.addAttribute("endYear", endYear);
		model.addAttribute("movieType", type);
		model.addAttribute("typeOfSite", "yearEndYearType");
		return "MoviesPage"; // MoviesByYearsAndTypePage
	}
	
	@RequestMapping(value = "/movies/{movieID}", method = RequestMethod.GET)
	public String getMovieById(
			@RequestParam(value = "ratingNull", required = false) String ratingNull, 
			@RequestParam(value = "rateUpdated", required = false) String rateUpdated,
			@RequestParam(value = "successRating", required = false) String successRating,
			@RequestParam(value = "emptyComment", required = false) String emptyComment,
			@RequestParam(value = "replyTo", required = false) Integer replyTo,
			@PathVariable String movieID, Principal principal, Model model) 
	{
		if(ratingNull!=null){model.addAttribute("ratingNull", "Select stars to rate movie!");}
		if(rateUpdated!=null){model.addAttribute("rateUpdated", "Rate uptaded.");}
		if(successRating!=null){model.addAttribute("successRating", "Movie rated.");}
		if(emptyComment!=null){model.addAttribute("emptyComment", "Comment can't be empty.");}
		if(replyTo!=null){model.addAttribute("replyTo", replyTo);}
		
		String loggedUsername = "";
		if( principal != null )
		{
			loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			model.addAttribute("loggedUsername", loggedUsername );
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
			model.addAttribute("userRoles", rolesNumber );
			//model.addAttribute("userRoles", movieService.getUserRolesByUsernameFromUserRepository(loggedUsername).size() );
		}
		
		Movie movie = movieService.getMovie(movieID);
		if( movie.getComments() != null )
		{
			List<Boolean> isCommentLiked = new ArrayList<Boolean>();
			ArrayList<List<String>> usernamesLikedComments = new ArrayList<List<String>>();
			
			for(int i=0; i<movie.getComments().size(); i++)
			{
				String time = movie.getComments().get(i).getTime();
				if( time != null )
				{
					movie.getComments().get(i).setTime( movieService.convertTimestampToMovieCommentDate(time) );
				}
					
				usernamesLikedComments.add( movieService.UsernamesThatLikedComment(movie.getComments().get(i).getRowID()) );
				
				if( principal != null )
				{
					isCommentLiked.add( movieService.checkIfCommentAlreadyLiked(movie.getComments().get(i).getRowID(), loggedUsername) );
				}
			}
			model.addAttribute("usernamesLikedComments", usernamesLikedComments);
			model.addAttribute("isCommentLiked", isCommentLiked );
		}
		model.addAttribute("movie", movie );
		if( movie.getRating() == 0.0 ) { model.addAttribute("rating", "Not rated" ); }
		else { model.addAttribute("rating", movie.getRating() ); } 
		model.addAttribute("directorLink", movieService.getDirectorLink(movie) );
		return "OneMoviePage";
	}
	
	@RequestMapping(value = "/movies/add", method = RequestMethod.GET)
	public String addMovie(Model model, Principal principal) 
	{
		if( principal != null )
		{
			String loggedUsername = principal.getName();
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("movie", new Movie() );
		return "addMovie";
	}
	
	@RequestMapping(value = "/movies/added", method = RequestMethod.POST)
	public String addedMovie(@Valid Movie movie, BindingResult bindingResult, Model model, Principal principal) 
	{
		if (bindingResult.hasErrors()) 
		{
			if( principal != null )
			{
				String loggedUsername = principal.getName();
				int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
				model.addAttribute("rolesNumber", rolesNumber);
			}
			
			System.out.println("Not valid data");
			return "addMovie";
		}
		movieService.addMovie(movie);
		return "redirect:/movies?page=0";
	}
	
	@RequestMapping(value="/updateMovie", method = RequestMethod.POST)
	public String redirectToUpdateMovie(@RequestParam String movieID, Model model) throws MovieNotFoundException 
	{
		if( movieID == null || movieID.length() == 0 )
		{
			return "redirect:/adminPanel";
		}
		if( movieService.isMovieInDatabase(movieID) != true )
		{
			throw new MovieNotFoundException(movieID);
		}
		return "redirect:/movies/update/"+movieID;
	}
	
	@RequestMapping(value="/movies/update/{currentMovieID}", method = RequestMethod.GET)
	public String updateMovie(
			@RequestParam(value="movieIDtaken", required = false) String movieIDtaken,
			@PathVariable String currentMovieID, Model model, Principal principal) 
	{
		if(movieIDtaken!=null){model.addAttribute("movieIDtaken", "Movie ID already taken");}
		
		if( principal != null )
		{
			String loggedUsername = principal.getName();
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("movie", new Movie());
		model.addAttribute("currentMovieID", currentMovieID);
		return "updateMovie";
	}
	
	@RequestMapping(value = "/movies/updated/{currentMovieID}", method = RequestMethod.POST)
	public String updatedMovie(@PathVariable String currentMovieID, @Valid Movie movie, BindingResult bindingResult, Model model, Principal principal) throws MovieNotFoundException 
	{
		if (bindingResult.hasErrors()) 
		{
			if( principal != null )
			{
				String loggedUsername = principal.getName();
				int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
				model.addAttribute("rolesNumber", rolesNumber);
			}
			
			System.out.println("Not valid data");
			return "updateMovie";
		}
		return movieService.updateMovie(currentMovieID, movie);
	}
	
	@RequestMapping(value="/deleteMovie", method = RequestMethod.POST)
	public String redirectToDeleteMovie(@RequestParam String movieID, Model model) throws MovieNotFoundException 
	{
		if( movieID == null || movieID.length() == 0 )
		{
			return "redirect:/adminPanel";
		}
		if( movieService.isMovieInDatabase(movieID) != true )
		{
			throw new MovieNotFoundException(movieID);
		}
		return "redirect:/movies/delete/"+movieID;
	}
	
	@RequestMapping(value = "/movies/delete/{movieID}", method = RequestMethod.GET)
	public String deleteMovie(@PathVariable String movieID, Model model) 
	{
		movieService.deleteMovie(movieID);
		return "redirect:/movies?page=0";
	}
	
	@RequestMapping(value = "/movies/filtered", method = RequestMethod.POST)
	public String filteredMovies(FilterParams filterParams, Model model)
	{
		return movieService.chooseFilter(filterParams);
	}
	
	@RequestMapping(value = "/rateMovie/{movieID}", method = RequestMethod.POST)
	public String rateMovie(@RequestParam(value="rating", required = false) String rating, @PathVariable String movieID, Principal principal, Model model)
	{
		if( rating == null )
		{
			return "redirect:/movies/"+movieID+"?ratingNull";
		}
		
		Movie movie = movieService.getMovie(movieID);
		
		String personID = principal.getName();
		userService.updateLastSeen(personID);
		
		int numberOfRatings = userService.getNumberOfRatingsByUsername(personID) + 1;
		userService.addMovieRatingBadgeIfPossible(personID, numberOfRatings);
		
		if( movieService.canRatingBeAdded(movieID, personID) == false )
		{
			movieService.updateMovieRating(movie.getTitle(), movieID, personID, Integer.parseInt(rating));
			return "redirect:/movies/"+movieID+"?rateUpdated";
		}
		movieService.addMovieRating(movie.getTitle(), movieID, personID, Integer.parseInt(rating));
		return "redirect:/movies/"+movieID+"?successRating";
	}
	
	@RequestMapping(value = "/addMainComment", params = {"movieID"}, method = RequestMethod.POST)
	public String addMainComment(@RequestParam String comment, @RequestParam( "movieID" ) String movieID,  Principal principal, Model model) throws MovieNotFoundException
	{
		if( !movieService.isMovieInDatabase(movieID) )
		{
			throw new MovieNotFoundException(movieID);
		}
		
		if( comment.length() == 0 || comment == null )
		{
			return "redirect:/movies/"+movieID+"?emptyComment";
		}
		
		String movieTitle = movieService.getMovieTitleByMovieID(movieID);
		
		String loggedUsername = principal.getName();
		userService.updateLastSeen(loggedUsername);
		movieService.addMainComment(movieID, comment, loggedUsername, movieTitle);
		
		int numberOfComments = userService.getCountOfCommentsByUsername(loggedUsername);
		userService.addMovieCommentBadgeIfPossible(loggedUsername, numberOfComments);
		
		return "redirect:/movies/"+movieID;
	}
	
	@RequestMapping(value = "/addReplyComment", params = {"movieID", "commentID"}, method = RequestMethod.POST)
	public String addReplyComment(@RequestParam String comment, @RequestParam( "movieID" ) String movieID, @RequestParam( "commentID" ) int commentID, Principal principal, Model model) throws MovieNotFoundException
	{
		if( !movieService.isMovieInDatabase(movieID) )
		{
			throw new MovieNotFoundException(movieID);
		}
		
		if( comment.length() == 0 || comment == null )
		{
			return "redirect:/movies/"+movieID+"?emptyComment";
		}
		
		String movieTitle = movieService.getMovieTitleByMovieID(movieID);
		List<String> usernames = movieService.getUsernamesByCommentID(commentID);
		
		String loggedUsername = principal.getName();
		userService.updateLastSeen(loggedUsername);
		movieService.addReplyComment(movieID, commentID, comment, loggedUsername, movieTitle, usernames);
		
		int numberOfComments = userService.getCountOfCommentsByUsername(loggedUsername);
		userService.addMovieCommentBadgeIfPossible(loggedUsername, numberOfComments);
		
		return "redirect:/movies/"+movieID;
	}
	
	@RequestMapping(value = "/deleteMainAndReplyComments", params = {"commentID", "movieID"}, method = RequestMethod.GET)
	public String deleteMainAndReplyComments(@RequestParam( "commentID" ) int commentID, @RequestParam( "movieID" ) String movieID, Principal principal, Model model)
	{
		String loggedUsername = principal.getName();
		userService.updateLastSeen(loggedUsername);
		String usernameByComment = movieService.getUsernameByCommentID(commentID);
		List<String> loggedUserRoles = movieService.getUserRolesByUsernameFromUserRepository(loggedUsername);
		if( loggedUsername.equals(usernameByComment) || loggedUserRoles.size() == 2 || loggedUserRoles.size() == 3 )
		{
			movieService.deleteMainAndReplyComments(commentID);
		}
		return "redirect:/movies/"+movieID;
	}
	
	@RequestMapping(value = "/deleteReplyComment", params = {"rowID", "movieID"}, method = RequestMethod.GET)
	public String deleteReplyComment(@RequestParam( "rowID" ) int rowID, @RequestParam( "movieID" ) String movieID, Principal principal, Model model)
	{
		String loggedUsername = principal.getName();
		userService.updateLastSeen(loggedUsername);
		String usernameByComment = movieService.getUsernameByRowID(rowID);
		List<String> loggedUserRoles = movieService.getUserRolesByUsernameFromUserRepository(loggedUsername);
		if( loggedUsername.equals(usernameByComment) || loggedUserRoles.size() == 2 || loggedUserRoles.size() == 3 )
		{
			movieService.deleteReplyComment(rowID);
		}
		return "redirect:/movies/"+movieID;
	}
	
	/*@RequestMapping(value = "/likeComment", params = {"rowID", "movieID", "movieTitle", "commentUser"}, method = RequestMethod.GET)
	public String likeComment(
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
		
		return "redirect:/movies/"+movieID;
	}*/
}
