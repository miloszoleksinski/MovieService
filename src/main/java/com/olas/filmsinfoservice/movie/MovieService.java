package com.olas.filmsinfoservice.movie;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olas.filmsinfoservice.exception.MovieNotFoundException;
import com.olas.filmsinfoservice.user.UserRatingModel;
import com.olas.filmsinfoservice.user.UserRepository;

@Service
public class MovieService 
{
	@Autowired
	private MovieRepository movieRepository;
	
	@Autowired
	private UserRepository userRepository;
	
	public Movie getMovie(String movieID)
	{
		return movieRepository.getMovie(movieID);
	}
	
	public List<Movie> getMovies(int page)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMovies(page);
		}
	}
	
	public List<Movie> getMoviesByType(String movieType, int page)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByType(movieType, page);
		}
	}
	
	public List<Movie> getMoviesByTitle(String title, int page)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByTitle(title, page);
		}
	}
	
	public List<Movie> getMoviesByDirector(String director, int page)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByDirector(director, page);
		}
	}
	
	public List<Movie> getMoviesByDirectorAndType(String director, int page, String type)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByDirectorAndType(director, page, type);
		}
	}
	
	public List<Movie> getMoviesByDirectorAndTypeAndYear(String director, int page, String type, int year)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByDirectorAndTypeAndYear(director, page, type, year);
		}
	}
	
	public List<Movie> getMoviesByDirectorAndTypeAndEndYear(String director, int page, String type, int endYear)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByDirectorAndTypeAndEndYear(director, page, type, endYear);
		}
	}
	
	public List<Movie> getMoviesByDirectorAndTypeAndYears(String director, int page, String type, int year, int endYear)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByDirectorAndTypeAndYears(director, page, type, year, endYear);
		}
	}
	
	public List<Movie> getMoviesByDirectorAndYear(String director, int page, int year)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByDirectorAndYear(director, page, year);
		}
	}
	
	public List<Movie> getMoviesByDirectorAndEndYear(String director, int page, int endYear)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByDirectorAndEndYear(director, page, endYear);
		}
	}
	
	public List<Movie> getMoviesByDirectorAndYears(String director, int page, int year, int endYear)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByDirectorAndYears(director, page, year, endYear);
		}
	}
	
	public List<Movie> getMoviesByYear(int year, int page)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByYear(year, page);
		}
	}
	
	public List<Movie> getMoviesByEndYear(int endYear, int page)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByEndYear(endYear, page);
		}
	}
	
	public List<Movie> getMoviesByYears(int year, int endYear, int page)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByYears(year, endYear, page);
		}
	}
	
	public List<Movie> getMoviesByYearAndType(String type, int year, int page)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByYearAndType(type, year, page);
		}
	}
	
	public List<Movie> getMoviesByEndYearAndType(String type, int endYear, int page)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByEndYearAndType(type, endYear, page);
		}
	}
	
	public List<Movie> getMoviesByYearsAndType(String type, int year, int endYear, int page)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return movieRepository.getMoviesByYearsAndType(type, year, endYear, page);
		}
	}
	
	public int getCountOfLikes(int rowID)
	{
		return movieRepository.getCountOfLikes(rowID);
	}
	
	public void addMovie(Movie movie)
	{
		if( isMovieInDatabase(movie.getId()) != true )
		{
			movieRepository.addMovie(movie);
		}
		else
		{
			System.out.println( "This movie already exists in database" );
		}
	}
	
	public String updateMovie(String currentMovieID, Movie movie) throws MovieNotFoundException
	{
		if( isMovieInDatabase(currentMovieID) != true )
		{
			throw new MovieNotFoundException(currentMovieID);
		}
		else if( isMovieInDatabase(movie.getId()) == true && !movie.getId().equals(currentMovieID) )
		{
			return "redirect:/movies/update/"+currentMovieID+"?movieIDtaken";
		}
		else
		{
			movieRepository.updateMovie(currentMovieID,movie);
			return "redirect:/movies?page=0";
		}
	}
	
	public void deleteMovie(String movieID)
	{
		movieRepository.deleteMovie(movieID);
	}
	
	public void addMovieRating(String movieTitle, String movieID, String personID, int rating)
	{
		movieRepository.addMovieRating(movieTitle, movieID, personID, rating);
	}
	
	public void updateMovieRating(String movieTitle, String movieID, String personID, int rating)
	{
		movieRepository.updateMovieRating(movieTitle, movieID, personID, rating);
	}
	
	public void addMainComment(String movieID, String comment, String loggedUsername, String movieTitle)
	{
		movieRepository.addMainComment(movieID, comment, loggedUsername, movieTitle);
	}
	
	public void addReplyComment(String movieID, int commentID, String comment, String loggedUsername, String movieTitle, List<String> usernames)
	{
		List<Integer> counters = new ArrayList<Integer>();
		for(int i=0; i<usernames.size(); i++)
		{ counters.add( userRepository.getNumberOfNewNotificationsByUsername(usernames.get(i)) ); }
		
		movieRepository.addReplyComment(movieID, commentID, comment, loggedUsername, movieTitle, usernames, counters);
	}
	
	public void deleteMainAndReplyComments(int commentID)
	{
		movieRepository.deleteMainAndReplyComments(commentID);
	}
	
	public void deleteReplyComment(int rowID)
	{
		movieRepository.deleteReplyComment(rowID);
	}
	
	public void likeOrUnlikeComment(int rowID, String loggedUsername, String commentUser, String movieID, String movieTitle)
	{
		if( checkIfCommentAlreadyLiked(rowID, loggedUsername) == false )
		{
			int numberOfNotifications = userRepository.getNumberOfNewNotificationsByUsername(commentUser);
			numberOfNotifications++;
			movieRepository.likeComment(rowID, loggedUsername, commentUser, movieID, movieTitle, numberOfNotifications);
			int likes = movieRepository.getCountOfLikes(rowID);
			userRepository.addLikeBadgesIfPossible(commentUser, likes, rowID);
		}
		else
		{
			movieRepository.unlikeComment(rowID, loggedUsername, commentUser, movieID, movieTitle);
		}
	}
	
	public boolean checkIfCommentAlreadyLiked(int rowID, String username)
	{
		return movieRepository.checkIfCommentAlreadyLiked(rowID, username);
	}
	
	public List<String> getUserRolesByUsernameFromUserRepository(String username)
	{
		return userRepository.getUserRolesByUsername(username);
	}
	
	public List<String> getMoviesNamesByMovieID(List<UserRatingModel> ratings)
	{
		return movieRepository.getMoviesNamesByMovieID(ratings);
	}
	
	public String getMovieTitleByMovieID(String movieID)
	{
		return movieRepository.getMovieTitleByMovieID(movieID);
	}
	
	public String getUsernameByCommentID(int commentID)
	{
		return movieRepository.getUsernameByCommentID(commentID);
	}
	
	public List<String> UsernamesThatLikedComment(int commentID)
	{
		return movieRepository.UsernamesThatLikedComment(commentID);
	}
	
	public String getUsernameByRowID(int rowID)
	{
		return movieRepository.getUsernameByRowID(rowID);
	}
	
	public List<String> getUsernamesByCommentID(int commentID)
	{
		return movieRepository.getUsernamesByCommentID(commentID);
	}
	
	public boolean isMovieInDatabase(String movieID)
	{
		return movieRepository.isMovieInDatabase(movieID) != null; // true if exists in database
	}
	
	public int getAllMoviesLastPage()
	{
		int countMovies = movieRepository.getAllMoviesLastPage();
		return countLastPage(countMovies);
	}
	
	public int getMoviesByTypeLastPage(String movieType)
	{
		int countMovies = movieRepository.getMoviesByTypeLastPage(movieType);
		return countLastPage(countMovies);
	}
	
	public int getMoviesByTitleLastPage(String title)
	{
		int countMovies = movieRepository.getMoviesByTitleLastPage(title);
		return countLastPage(countMovies);
	}
	
	public int getMoviesByDirectorLastPage(String director)
	{
		int countMovies = movieRepository.getMoviesByDirectorLastPage(director);
		return countLastPage(countMovies);
	}
	
	public int getMoviesByDirectorAndTypeLastPage(String director, String type)
	{
		int countMovies = movieRepository.getMoviesByDirectorAndTypeLastPage(director, type);
		return countLastPage(countMovies);
	}
	
	public int getMoviesByDirectorAndTypeAndYearLastPage(String director, String type, int year)
	{
		int countMovies = movieRepository.getMoviesByDirectorAndTypeAndYearLastPage(director, type, year);
		return countLastPage(countMovies);
	}
	
	public int getMoviesByDirectorAndTypeAndEndYearLastPage(String director, String type, int endYear)
	{
		int countMovies = movieRepository.getMoviesByDirectorAndTypeAndEndYearLastPage(director, type, endYear);
		return countLastPage(countMovies);
	}
	
	public int getMoviesByDirectorAndTypeAndYearsLastPage(String director, String type, int year, int endYear)
	{
		int countMovies = movieRepository.getMoviesByDirectorAndTypeAndYearsLastPage(director, type, year, endYear);
		return countLastPage(countMovies);
	}
	
	public int getMoviesByDirectorAndYearLastPage(String director, int year)
	{
		int countMovies = movieRepository.getMoviesByDirectorAndYearLastPage(director, year);
		return countLastPage(countMovies);
	}
	
	public int getMoviesByDirectorAndEndYearLastPage(String director, int endYear)
	{
		int countMovies = movieRepository.getMoviesByDirectorAndEndYearLastPage(director, endYear);
		return countLastPage(countMovies);
	}
	
	public int getMoviesByDirectorAndYearsLastPage(String director, int year, int endYear)
	{
		int countMovies = movieRepository.getMoviesByDirectorAndYearsLastPage(director, year, endYear);
		return countLastPage(countMovies);
	}
	
	public int getMoviesByYearLastPage(int year)
	{
		int countMovies = movieRepository.getMoviesByYearLastPage(year);
		return countLastPage(countMovies);
	}
	
	public int getMoviesByEndYearLastPage(int endYear)
	{
		int countMovies = movieRepository.getMoviesByEndYearLastPage(endYear);
		return countLastPage(countMovies);
	}
	
	public int getMoviesByYearsLastPage(int year, int endYear)
	{
		int countMovies = movieRepository.getMoviesByYearsLastPage(year, endYear);
		return countLastPage(countMovies);
	}
	
	public int getMoviesByYearAndTypeLastPage(int year, String type)
	{
		int countMovies = movieRepository.getMoviesByYearAndTypeLastPage(year, type);
		return countLastPage(countMovies);
	}
	
	public int getMoviesByEndYearAndTypeLastPage(int endYear, String type)
	{
		int countMovies = movieRepository.getMoviesByEndYearAndTypeLastPage(endYear, type);
		return countLastPage(countMovies);
	}
	
	public int getMoviesByYearsAndTypeLastPage(int year, int endYear, String type)
	{
		int countMovies = movieRepository.getMoviesByYearsAndTypeLastPage(year, endYear, type);
		return countLastPage(countMovies);
	}
	
	public int countLastPage(int toCount)
	{
		toCount = (int) Math.ceil((double)toCount/(double)10);
		return toCount;
	}
	
	public List<String> getDirectorLinks(List<Movie> movies)
	{
		List<String> directors = new ArrayList<String>();
		for(int i=0; i<movies.size(); i++)
		{
			directors.add( movies.get(i).getDirector().toLowerCase().trim().replace(" ", "_") );
		}
		return directors;
	}
	
	public String getDirectorLink(Movie movie)
	{
		return movie.getDirector().toLowerCase().trim().replace(" ", "_") ;
	}
	
	public String chooseFilter(FilterParams filterParams)
	{
		if( filterParams.getTitle() != null )
		{
			if( !filterParams.getTitle().equals("") )
			{
				return "redirect:/movies?page=0&title="+filterParams.getTitle();
			}
			else
			{
				return "redirect:/movies?page=0";
			}
		} 
		
		String type = filterParams.getType();
		Integer year=0;
		if( filterParams.getYear() != "" ) { year = Integer.parseInt( filterParams.getYear() ); }
		Integer endYear=0;
		if( filterParams.getEndYear() != "" ) { endYear = Integer.parseInt( filterParams.getEndYear() ); } 
		String director = filterParams.getDirector().replace(" ", "_").trim();
		String linkToReturn = "redirect:/movies?page=0";
		
		if( !type.equals("") ){ linkToReturn+="&type="+type; }
		if( !director.equals("") ){ linkToReturn+="&director="+director; }
		if( (year>1800 && year<2200) ){ linkToReturn+="&year="+year; }
		if( (endYear>1800 && endYear<2200) ){ linkToReturn+="&endYear="+endYear; }
		return linkToReturn;
	}
	
	public String replaceDirectorWithSpace(String director)
	{
		return director.replace("_", " ");
	}
	
	public boolean canRatingBeAdded(String movieID, String personID)
	{
		return movieRepository.canRatingBeAdded(movieID, personID);
	}
	
	public String convertTimestampToMovieCommentDate(String time)
	{
		int day = Integer.parseInt(time.substring(8, 10));
		int monthNum = Integer.parseInt(time.substring(5, 7));
		int year = Integer.parseInt(time.substring(0, 4));
		String month = new String();
		if(monthNum==1) 	 { month = "January";  } else if(monthNum==2) { month = "February"; }
		else if(monthNum==3) { month = "March";    } else if(monthNum==4) { month = "April"; }
		else if(monthNum==5) { month = "May";      } else if(monthNum==6) { month = "June"; }
		else if(monthNum==7) { month = "July";     } else if(monthNum==8) { month = "August"; }
		else if(monthNum==9) { month = "September";} else if(monthNum==10) { month = "October"; }
		else if(monthNum==11){ month = "November"; } else if(monthNum==12) { month = "December"; }
		return day + " " + month + " " + year + ", " + time.substring(11,16) + ".";
	}
}