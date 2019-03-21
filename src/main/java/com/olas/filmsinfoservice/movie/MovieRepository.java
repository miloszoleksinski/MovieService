package com.olas.filmsinfoservice.movie;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.olas.filmsinfoservice.user.UserRatingModel;
import com.olas.filmsinfoservice.user.UserRepository;

@Repository
public class MovieRepository 
{
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	// ---------------- GET MOVIE ---------------- \\
	public Movie getMovie(String movieID)
	{
		String selectMovieById = "SELECT * FROM movie WHERE id = '" + movieID + "'";
		Movie fullMovieInfo =  jdbcTemplate.queryForObject(selectMovieById, new FullMovieRowMapper());
		
		String selectMovieTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movieID + "'";
		List<String> types = jdbcTemplate.query(selectMovieTypes, new MovieIdRowMapper());
		fullMovieInfo.setTypes( types );
		
		String selectMovieComments = "SELECT row_id, username, comment_type, comment, comment_id, time, likes from movie_comment where movie_id='"+movieID+"' order by comment_id desc";
		List<MovieComment> comments = jdbcTemplate.query(selectMovieComments, new MovieCommentRowMapper());
		fullMovieInfo.setComments(comments);
		
		return fullMovieInfo;
	}
	
	// ---------------- GET ALL MOVIES ---------------- \\
	public List<Movie> getMovies(int page)
	{
		String selectMovies = "SELECT * FROM movie LIMIT " + page + ", 10"; 
		List<Movie> movies = jdbcTemplate.query(selectMovies, new FullMovieRowMapper()); 
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY TYPE ---------------- \\
	public List<Movie> getMoviesByType(String movieType, int page)
	{
		String selectMoviesByType = "SELECT m.id AS id, m.title AS title, m.year AS year, m.director AS director, m.description AS description"
				+ " FROM movie m, movie_type mt WHERE mt.type='" + movieType + "' AND mt.movie_id = m.id"
						+ " LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(selectMoviesByType, new SmallMovieRowMapper());
		
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY TITLE ---------------- \\
	public List<Movie> getMoviesByTitle(String title, int page)
	{
		String SelectMoviesByTitle = "SELECT * FROM movie WHERE title LIKE '%"+title+"%' LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(SelectMoviesByTitle, new FullMovieRowMapper()); 
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY DIRECTOR ---------------- \\
	public List<Movie> getMoviesByDirector(String director, int page)
	{
		String selectMoviesByDirector = "SELECT * FROM movie WHERE director = '" + director + "' LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(selectMoviesByDirector, new FullMovieRowMapper());
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY DIRECTOR AND TYPE ---------------- \\
	public List<Movie> getMoviesByDirectorAndType(String director, int page, String type)
	{
		String selectMoviesByDirectorAndType = "SELECT m.id AS id, m.title AS title, m.year AS year, m.director AS director, m.description AS description"
				+ " FROM movie m, movie_type mt WHERE mt.type='" + type + "' AND mt.movie_id = m.id AND m.director='"+director+"'"
						+ " LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(selectMoviesByDirectorAndType, new SmallMovieRowMapper());
		
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY DIRECTOR, TYPE AND YEAR ---------------- \\
	public List<Movie> getMoviesByDirectorAndTypeAndYear(String director, int page, String type, int year)
	{
		String selectMoviesByDirectorAndTypeAndYear = "SELECT m.id AS id, m.title AS title, m.year AS year, m.director AS director, m.description AS description"
				+ " FROM movie m, movie_type mt WHERE mt.type='"+type+"' AND mt.movie_id = m.id AND m.director='"+director+"' AND m.year="+year
						+ " LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(selectMoviesByDirectorAndTypeAndYear, new SmallMovieRowMapper());
		
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY DIRECTOR, TYPE AND END YEAR ---------------- \\
	public List<Movie> getMoviesByDirectorAndTypeAndEndYear(String director, int page, String type, int endYear)
	{
		String selectMoviesByDirectorAndTypeAndEndYear = "SELECT m.id AS id, m.title AS title, m.year AS year, m.director AS director, m.description AS description"
				+ " FROM movie m, movie_type mt WHERE mt.type='"+type+"' AND mt.movie_id = m.id AND m.director='"+director+"' AND m.year<="+endYear
						+ " LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(selectMoviesByDirectorAndTypeAndEndYear, new SmallMovieRowMapper());
		
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY DIRECTOR, TYPE AND YEARS ---------------- \\
	public List<Movie> getMoviesByDirectorAndTypeAndYears(String director, int page, String type, int year, int endYear)
	{
		String selectMoviesByDirectorAndTypeAndYears = "SELECT m.id AS id, m.title AS title, m.year AS year, m.director AS director, m.description AS description"
				+ " FROM movie m, movie_type mt WHERE mt.type='"+type+"' AND mt.movie_id = m.id AND m.director='"+director+"' AND m.year>="+year+" AND m.year<="+endYear
						+ " LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(selectMoviesByDirectorAndTypeAndYears, new SmallMovieRowMapper());
		
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY DIRECTOR AND YEAR ---------------- \\
	public List<Movie> getMoviesByDirectorAndYear(String director, int page, int year)
	{
		String selectMoviesByDirectorAndYear = "SELECT * FROM movie WHERE director = '" + director + "' AND "
									  + "year = " + year + " LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(selectMoviesByDirectorAndYear, new FullMovieRowMapper());
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY DIRECTOR AND END YEAR ---------------- \\
	public List<Movie> getMoviesByDirectorAndEndYear(String director, int page, int endYear)
	{
		String selectMoviesByDirectorAndEndYear = "SELECT * FROM movie WHERE director = '" + director + "' AND "
				  + "year <= " + endYear + " LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(selectMoviesByDirectorAndEndYear, new FullMovieRowMapper());
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY DIRECTOR AND YEARS ---------------- \\
	public List<Movie> getMoviesByDirectorAndYears(String director, int page, int year, int endYear)
	{
		String selectMoviesByDirectorAndYears = "SELECT * FROM movie WHERE director = '" + director + "' AND "
				  + "year >= " + year + " AND year <= " + endYear + " LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(selectMoviesByDirectorAndYears, new FullMovieRowMapper());
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY YEAR ---------------- \\
	public List<Movie> getMoviesByYear(int year, int page)
	{
		String selectMovieByYear = "SELECT * FROM movie WHERE year = " + year + " LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(selectMovieByYear, new FullMovieRowMapper()); 
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY END YEAR ---------------- \\
	public List<Movie> getMoviesByEndYear(int endYear, int page)
	{
		String selectMovieByYear = "SELECT * FROM movie WHERE year <= " + endYear + " LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(selectMovieByYear, new FullMovieRowMapper()); 
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY YEARS ---------------- \\
	public List<Movie> getMoviesByYears(int year, int endYear, int page)
	{
		String selectMovieByYears = "SELECT * FROM movie WHERE year >= " + year + " AND year <= " + endYear + " LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(selectMovieByYears, new FullMovieRowMapper());
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY YEAR AND TYPE ---------------- \\
	public List<Movie> getMoviesByYearAndType(String type, int year, int page)
	{
		String selectMovieByYearAndType = "SELECT m.id AS id, m.title AS title, m.year AS year, m.director AS director, m.description AS description"
				+ " FROM movie m, movie_type mt WHERE mt.type='"+type+"' AND mt.movie_id = m.id AND m.year="+year
						+ " LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(selectMovieByYearAndType, new SmallMovieRowMapper());
		
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY END YEAR AND TYPE ---------------- \\
	public List<Movie> getMoviesByEndYearAndType(String type, int endYear, int page)
	{
		String selectMovieByEndYearAndType = "SELECT m.id AS id, m.title AS title, m.year AS year, m.director AS director, m.description AS description"
				+ " FROM movie m, movie_type mt WHERE mt.type='"+type+"' AND mt.movie_id = m.id AND m.year<="+endYear
						+ " LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(selectMovieByEndYearAndType, new SmallMovieRowMapper());
		
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES BY YEARS AND TYPE ---------------- \\
	public List<Movie> getMoviesByYearsAndType(String type, int year, int endYear, int page)
	{
		String selectMovieByYearsAndType = "SELECT m.id AS id, m.title AS title, m.year AS year, m.director AS director, m.description AS description"
				+ " FROM movie m, movie_type mt WHERE mt.type='"+type+"' AND mt.movie_id = m.id AND m.year>="+year+" AND m.year<="+endYear
						+ " LIMIT " + page + ", 10";
		List<Movie> movies = jdbcTemplate.query(selectMovieByYearsAndType, new SmallMovieRowMapper());
		
		int mL = movies.size();
		for(int i=0; i<mL; i++)
		{
			String selectTypes = "SELECT type FROM movie_type WHERE movie_id = '" + movies.get(i).getId() + "'";
			List<String> types = jdbcTemplate.query(selectTypes, new MovieIdRowMapper());
			movies.get(i).setTypes(types);
		}
		return movies;
	}
	
	// ---------------- GET MOVIES NAMES BY MOVIES ID ---------------- \\
	public List<String> getMoviesNamesByMovieID(List<UserRatingModel> ratings)
	{
		int rSize = ratings.size();
		List<String> movieID = new ArrayList<String>();
		for(int i=0; i<rSize; i++)
		{
			movieID.add( ratings.get(i).getMovieID() );
		}
		
		List<String> movieNames = new ArrayList<String>();
		for(int i=0; i<rSize; i++)
		{
			try { 
				String selectMovieNameByMovieID = "SELECT title FROM movie WHERE id='"+movieID.get(i)+"'";
				String movieName = jdbcTemplate.queryForObject(selectMovieNameByMovieID, new MovieIdRowMapper());
				movieNames.add(movieName);}
			catch(DataAccessException ex) { return null; }
		}
		if( movieNames.size() == 0 ) { return null; }
		return movieNames;
	}
	
	// ---------------- GET MOVIE NAME BY MOVIE ID ---------------- \\
	public String getMovieTitleByMovieID(String movieID)
	{
		try { 
			String selectMovieNameByMovieID = "SELECT title FROM movie WHERE id='"+movieID+"'";
			String movieName = jdbcTemplate.queryForObject(selectMovieNameByMovieID, new MovieIdRowMapper());
			return movieName;
		}catch(DataAccessException ex) { return null; }
	}
	
	// ---------------- GET USERNAME BY COMMENT ID ---------------- \\	
	public String getUsernameByCommentID(int commentID)
	{
		String selectUsernameByCommentID = "SELECT username FROM movie_comment WHERE comment_id="+commentID+" AND comment_type='mC'";
		try {	
			String username = jdbcTemplate.queryForObject(selectUsernameByCommentID, String.class);
			return username; 
		}catch(DataAccessException ex) { return null; }
	}
	
	// ---------------- GET USERNAME BY ROW ID ---------------- \\	
	public String getUsernameByRowID(int rowID)
	{
		String selectUsernameByRowID = "SELECT username FROM movie_comment WHERE row_id="+rowID;
		try {	
			String username = jdbcTemplate.queryForObject(selectUsernameByRowID, String.class);
			return username; 
		}catch(DataAccessException ex) { return null; }
	}
		
	// ---------------- GET USERNAMES BY COMMENT ID ---------------- \\	
	public List<String> getUsernamesByCommentID(int commentID)
	{
		String selectUsernamesByCommentID = "SELECT DISTINCT username FROM movie_comment WHERE comment_id="+commentID;
		List<String> usernames = jdbcTemplate.query(selectUsernamesByCommentID, new MovieIdRowMapper());
		return usernames;
	}
	
	// ---------------- GET ALL USERNAMES BY COMMENT ID ---------------- \\	
	public List<String> getAllUsernamesByCommentID(int commentID)
	{
		String selectUsernamesByCommentID = "SELECT username FROM movie_comment WHERE comment_id="+commentID;
		List<String> usernames = jdbcTemplate.query(selectUsernamesByCommentID, new MovieIdRowMapper());
		return usernames;
	}
	
	// ---------------- GET ALL ROW ID'S BY COMMENT ID ---------------- \\	
	public List<Integer> getAllRowIDsByCommentID(int commentID)
	{
		String selectRowIDs = "SELECT row_id FROM movie_comment WHERE comment_id="+commentID;
		List<Integer> rowIDs = jdbcTemplate.query(selectRowIDs, new MovieIdIntegerRowMapper());
		return rowIDs;
	}
	
	// ---------------- GET NUMBER OF LIKES UNDER THE COMMENT ---------------- \\	
	public int getCountOfLikes(int rowID)
	{
		String selectNumberOfLikes = "SELECT COUNT(*) FROM comment_likes WHERE comment_id="+rowID;
		int likes = jdbcTemplate.queryForObject(selectNumberOfLikes, Integer.class);
		return likes;
	}
	
	// ---------------- GET USERNAMES WHO LIKED COMMENT BY COMMENT ID ---------------- \\	
	public List<String> UsernamesThatLikedComment(int commentID)
	{
		String selectUsernamesByCommentID = "SELECT DISTINCT user_liked FROM comment_likes WHERE comment_id="+commentID;
		List<String> usernames = jdbcTemplate.query(selectUsernamesByCommentID, new MovieIdRowMapper());
		return usernames;
	}

	// ---------------- ADD MOVIE ---------------- \\
	public void addMovie(Movie movie)
	{
		List<String> movieTypes = new ArrayList<String>();
		for(int i=0; i<movie.getTypes().size(); i++) // to validate elements of list
		{
			if( !movie.getTypes().get(i).equals("") && movie.getTypes().get(i) != null )
			{
				movieTypes.add( movie.getTypes().get(i) ); // only valid types
			}
		}
		
		// If we have any type go through
		if( movieTypes.size() > 0 )
		{
			String addMovieInfo = "INSERT INTO movie VALUES('"+movie.getId()+"','"+movie.getTitle()+"',"+movie.getYear()+",'"+movie.getDirector()+"','"+movie.getDescription()+"',0);";
			List<String> addMovieTypes = new ArrayList<String>();
			for(int i=0; i<movieTypes.size(); i++)
			{
				addMovieTypes.add("INSERT INTO movie_type VALUES('"+movie.getId()+"','"+movieTypes.get(i)+"', null);");
			}
				
			jdbcTemplate.update(addMovieInfo); 
			for(int i=0; i<addMovieTypes.size(); i++)
			{
				jdbcTemplate.update(addMovieTypes.get(i)); 
			}
		} else{ System.out.println("Type field was not filled"); }
	}
	
	// ---------------- UPDATE MOVIE ---------------- \\
	public void updateMovie(String currentMovieID, Movie movie)
	{
		List<String> movieTypes = new ArrayList<String>();
		for(int i=0; i<movie.getTypes().size(); i++) // to validate elements of list
		{
			if( !movie.getTypes().get(i).equals("") && movie.getTypes().get(i) != null )
			{
				movieTypes.add( movie.getTypes().get(i) ); // only valid types
			}
		}
		
		// If we have any type go through
		if( movieTypes.size() > 0 )
		{
			String deleteOldTypes = "DELETE FROM movie_type WHERE movie_id = '" + movie.getId() + "'";
			String updateMovieInfo = "UPDATE movie SET id='"+movie.getId()+"', title='"+movie.getTitle()+"', year="+movie.getYear()+", director='"+movie.getDirector()+"', description='"+movie.getDescription()+"' WHERE id='"+currentMovieID+"'";
			List<String> updateMovieTypes = new ArrayList<String>();
			for(int i=0; i<movieTypes.size(); i++) // for each type create update statement
			{
				updateMovieTypes.add("INSERT INTO movie_type VALUES('"+movie.getId()+"','"+movieTypes.get(i)+"', null)");
			}
			
			jdbcTemplate.update( updateMovieInfo ); 
			jdbcTemplate.update( deleteOldTypes );
			for(int i=0; i<updateMovieTypes.size(); i++)
			{
				jdbcTemplate.update( updateMovieTypes.get(i) ); 
			}
		} else{ System.out.println("Type field was not filled"); }
	}
	
	// ---------------- DELETE MOVIE ---------------- \\
	public void deleteMovie(String movieID)
	{
		String deleteMovie = "DELETE FROM movie WHERE id = '" + movieID + "'";
		String deleteMovieTypes = "DELETE FROM movie_type WHERE movie_id = '" + movieID + "'";
		jdbcTemplate.update(deleteMovie);
		jdbcTemplate.update(deleteMovieTypes);
	}
	
	// ---------------- ADD MOVIE RATING ---------------- \\
	public void addMovieRating(String movieTitle, String movieID, String personID, int rating)
	{
		String addMovieRating = "INSERT INTO movie_rating VALUE (null,'"+movieID+"','"+personID+"',"+rating+",NOW())";
		String addActivity = "INSERT INTO friends_activity VALUE (null,'"+personID+"','"+movieID+"','rated ("+rating+") " +movieTitle+"',"+rating+",null,NOW(),null)";
		jdbcTemplate.update(addMovieRating);
		jdbcTemplate.update(addActivity);
		
		String selectMovieRating = "SELECT rate FROM movie_rating WHERE movie_id = '" + movieID + "'";
		List<Integer> ratings = jdbcTemplate.query(selectMovieRating, new MovieRatingRowMapper());
		double averageRating;
		int rSize = ratings.size(), rSum = 0;
		if( rSize == 0 ) { averageRating = 0.0;  }
		for(int i=0; i<rSize; i++)
		{
			rSum += ratings.get(i);
		}
		DecimalFormat df = new DecimalFormat("#.#");
		averageRating = (double)rSum/(double)rSize;
		averageRating = Double.parseDouble( df.format(averageRating).replace(',', '.') );
		String saveAverageRating = "UPDATE movie SET rate="+averageRating+" WHERE id='"+movieID+"'";
		jdbcTemplate.update(saveAverageRating);
		
		String addPointToLogged = "UPDATE user_account_info SET score=score+1 WHERE username='"+personID+"'";
		jdbcTemplate.update( addPointToLogged );
	}
	
	// ---------------- UPDATE MOVIE RATING ---------------- \\
	public void updateMovieRating(String movieTitle, String movieID, String personID, int rating)
	{
		String updateMovieRating = "UPDATE movie_rating SET rate="+rating+", time=NOW() WHERE movie_id='"+movieID+"' AND person_id='"+personID+"'";
		String addActivity = "INSERT INTO friends_activity VALUE (null,'"+personID+"','"+movieID+"','updated rate ("+rating+") of "+movieTitle+"',"+rating+",null,NOW(),null)";
		jdbcTemplate.update(updateMovieRating);
		jdbcTemplate.update(addActivity);
		
		String selectMovieRating = "SELECT rate FROM movie_rating WHERE movie_id = '" + movieID + "'";
		List<Integer> ratings = jdbcTemplate.query(selectMovieRating, new MovieRatingRowMapper());
		double averageRating;
		int rSize = ratings.size(), rSum = 0;
		if( rSize == 0 ) { averageRating = 0.0;  }
		for(int i=0; i<rSize; i++)
		{
			rSum += ratings.get(i);
		}
		DecimalFormat df = new DecimalFormat("#.#");
		averageRating = (double)rSum/(double)rSize;
		averageRating = Double.parseDouble( df.format(averageRating).replace(',', '.') );
		String saveAverageRating = "UPDATE movie SET rate="+averageRating+" WHERE id='"+movieID+"'";
		jdbcTemplate.update(saveAverageRating);
	}
	
	// ---------------- ADD MAIN COMMENT ---------------- \\
	public void addMainComment(String movieID, String comment, String loggedUsername, String movieTitle)
	{
		String addMovieComment = "INSERT INTO movie_comment SELECT null, MAX(comment_id)+1, '"+movieID+"', '"+loggedUsername+"', "
				+ "'mC', '"+comment+"', NOW(), 0 FROM movie_comment";
		String addActivity = "INSERT INTO friends_activity VALUE (null,'"+loggedUsername+"','"+movieID+"','commented \""+movieTitle+"\".',0,null,NOW(),null)";
		jdbcTemplate.update(addMovieComment);
		jdbcTemplate.update(addActivity);
		
		String add2PointsToLogged = "UPDATE user_account_info SET score=score+2 WHERE username='"+loggedUsername+"'";
		jdbcTemplate.update( add2PointsToLogged );
	}
	
	// ---------------- ADD REPLY COMMENT ---------------- \\
		public void addReplyComment(String movieID, int commentID, String comment, String loggedUsername, String movieTitle, List<String> usernames, List<Integer> counters)
		{
			String addMovieComment = "INSERT INTO movie_comment VALUE(null,"+commentID+",'"+movieID+"','"+loggedUsername+"','sC','"+comment+"', NOW(), 0)";
			String addActivity = "INSERT INTO friends_activity VALUE (null,'"+loggedUsername+"','"+movieID+"','commented \""+movieTitle+"\".',0,null,NOW(),null)";
			String addNotification = "INSERT INTO user_notification VALUE(null,'"+usernames.get(0)+"','"
					+ loggedUsername+"','"+movieID+"','replied on your comment under \""+movieTitle+"\".','reply',NOW(),null,'new')";
			
			jdbcTemplate.update(addMovieComment);
			jdbcTemplate.update(addActivity);
			jdbcTemplate.update(addNotification);
			
			String addOneToNotificationCounter = "UPDATE user_notification_counter SET notifications_number="+(counters.get(0)+1)+" WHERE username='"+usernames.get(0)+"'";
			jdbcTemplate.update( addOneToNotificationCounter );
			
			int usernameSize = usernames.size();
			if( usernameSize > 1 )
			{
				for(int i=1; i<usernameSize; i++)
				{
					String addNotification2 = "INSERT INTO user_notification VALUE(null,'"+usernames.get(i)+"','"
							+ loggedUsername+"','"+movieID+"','replied on the same comment under \""+movieTitle+"\".','reply',NOW(),null,'new')";
					jdbcTemplate.update(addNotification2);
					
					String addOneToNotificationCounter2 = "UPDATE user_notification_counter SET notifications_number="+(counters.get(i)+1)+" WHERE username='"+usernames.get(i)+"'";
					jdbcTemplate.update( addOneToNotificationCounter2 );
				}
			}
			
			String add2PointsToLogged = "UPDATE user_account_info SET score=score+2 WHERE username='"+loggedUsername+"'";
			jdbcTemplate.update( add2PointsToLogged );
		}
		
	// ---------------- DELETE MAIN AND REPLY COMMENTS ---------------- \\
	public void deleteMainAndReplyComments(int commentID)
	{
		List<Integer> rowIDs = this.getAllRowIDsByCommentID(commentID);
		for(int i=0; i<rowIDs.size(); i++)
		{
			String username = this.getUsernameByRowID( rowIDs.get(i) );
			String subtract2PointsToUser = "UPDATE user_account_info SET score=score-2 WHERE username='"+username+"'";
			jdbcTemplate.update( subtract2PointsToUser );
			
			List<String> usernamesThatLikedComment = this.UsernamesThatLikedComment( rowIDs.get(i) );
			int likesSize = usernamesThatLikedComment.size();
			
			for(int j=0; j<likesSize; j++)
			{
				String subtractPointToUser = "UPDATE user_account_info SET score=score-1 WHERE username='"+usernamesThatLikedComment.get(j)+"'";
				jdbcTemplate.update( subtractPointToUser );
			}
			
			String subtractLikesPointsToUser = "UPDATE user_account_info SET score=score-"+(likesSize*10)+" WHERE username='"+username+"'";
			jdbcTemplate.update( subtractLikesPointsToUser );
			
			String deleteCommentLikes = "DELETE FROM comment_likes WHERE comment_id="+rowIDs.get(i);
			jdbcTemplate.update(deleteCommentLikes);
		}
		
		String deleteCommentByCommentID = "DELETE FROM movie_comment WHERE comment_id="+commentID;
		jdbcTemplate.update(deleteCommentByCommentID);
	}
		
	// ---------------- DELETE REPLY COMMENT ---------------- \\
	public void deleteReplyComment(int rowID)
	{
		String username = this.getUsernameByRowID(rowID);
		String subtract2PointsToUser = "UPDATE user_account_info SET score=score-2 WHERE username='"+username+"'";
		jdbcTemplate.update( subtract2PointsToUser );
		
		List<String> usernamesThatLikedComment = this.UsernamesThatLikedComment(rowID);
		int likesSize = usernamesThatLikedComment.size();
		for(int i=0; i<likesSize; i++)
		{
			String subtractPointToUser = "UPDATE user_account_info SET score=score-1 WHERE username='"+usernamesThatLikedComment.get(i)+"'";
			jdbcTemplate.update( subtractPointToUser );
		}
		
		String subtractLikesPointsToUser = "UPDATE user_account_info SET score=score-"+(likesSize*10)+" WHERE username='"+username+"'";
		jdbcTemplate.update( subtractLikesPointsToUser );
		
		String deleteCommentLikes = "DELETE FROM comment_likes WHERE comment_id="+rowID;
		jdbcTemplate.update(deleteCommentLikes);
		
		String deleteCommentByRowID = "DELETE FROM movie_comment WHERE row_id="+rowID;
		jdbcTemplate.update(deleteCommentByRowID);
	}
	
	// ---------------- LIKE COMMENT ---------------- \\
	public void likeComment(int rowID, String loggedUsername, String commentUser, String movieID, String movieTitle, int numberOfNotifications)
	{
		String addPersonToCommentLikes = "INSERT INTO comment_likes VALUES (null,'"+commentUser+"',"+rowID+",'"+loggedUsername+"')";
		jdbcTemplate.update(addPersonToCommentLikes);
		
		int likes = this.getCountOfLikes(rowID);
		
		String updateCommentLikes = "UPDATE movie_comment SET likes="+likes+" WHERE row_id="+rowID;
		jdbcTemplate.update(updateCommentLikes);
		
		String addActivity = "INSERT INTO friends_activity VALUE (null,'"+loggedUsername+"','"+movieID+"','liked comment under \""+movieTitle+"\".',0,null,NOW(),"+rowID+")";
		jdbcTemplate.update(addActivity);
		
		String addPointToLogged = "UPDATE user_account_info SET score=score+1 WHERE username='"+loggedUsername+"'";
		String add10PointsToCommentUser = "UPDATE user_account_info SET score=score+10 WHERE username='"+commentUser+"'";
		jdbcTemplate.update( addPointToLogged );
		jdbcTemplate.update( add10PointsToCommentUser );
		
		if( !loggedUsername.equals(commentUser) )
		{
			String addNotification = "INSERT INTO user_notification VALUE(null,'"+commentUser+"','"
					+ loggedUsername+"','"+movieID+"','liked your comment under \""+movieTitle+"\".','like',NOW(),"+rowID+",'new')";
			jdbcTemplate.update(addNotification);
			
			String addOneToNotificationCounter = "UPDATE user_notification_counter SET notifications_number="+numberOfNotifications+" WHERE username='"+commentUser+"'";
			jdbcTemplate.update( addOneToNotificationCounter );
		}
	}
	
	// ---------------- UNLIKE COMMENT ---------------- \\
	public void unlikeComment(int rowID, String loggedUsername, String commentUser, String movieID, String movieTitle)
	{
		String removePersonFromCommentLikes = "DELETE FROM comment_likes WHERE comment_id="+rowID+" AND user_liked='"+loggedUsername+"'";
		jdbcTemplate.update(removePersonFromCommentLikes);
		
		int likes = this.getCountOfLikes(rowID);
		
		String updateCommentLikes = "UPDATE movie_comment SET likes="+likes+" WHERE row_id="+rowID;
		jdbcTemplate.update(updateCommentLikes);
		
		String subtractPointToLogged = "UPDATE user_account_info SET score=score-1 WHERE username='"+loggedUsername+"'";
		String subtract10PointsToCommentUser = "UPDATE user_account_info SET score=score-10 WHERE username='"+commentUser+"'";
		jdbcTemplate.update( subtractPointToLogged );
		jdbcTemplate.update( subtract10PointsToCommentUser );
		
		String deleteActivity = "DELETE FROM friends_activity WHERE username='"+loggedUsername+"' AND comment_id="+rowID;
		jdbcTemplate.update(deleteActivity);
		
		if( !loggedUsername.equals(commentUser) )
		{
			String deleteNotification = "DELETE FROM user_notification WHERE username='"+commentUser+"' AND fromUser='"+loggedUsername+"' AND type='like' AND comment_id='"+rowID+"'";
			jdbcTemplate.update(deleteNotification);
			
			int newCounter = userRepository.getNumberOfNewNotificationsByUsername(commentUser)-1;
			if( newCounter >= 0 )
			{
				String decreaseByOneNotificationCounter = "UPDATE user_notification_counter SET notifications_number="+newCounter+" WHERE username='"+commentUser+"'";
				jdbcTemplate.update( decreaseByOneNotificationCounter );
			}
		}
	}
	
	// ---------------- CHECK IF MOVIE IS IN DATABASE ---------------- \\
	public String isMovieInDatabase(String movieID)
	{
		String doMovieExists = "SELECT id FROM movie WHERE id = '" + movieID + "'";
		String movieIdValue;
		try {
			movieIdValue = jdbcTemplate.queryForObject(doMovieExists, String.class);
		}catch(DataAccessException ex) {  
			movieIdValue = null;
		}
		return movieIdValue;
	}
	
	// ---------------- CHECK IF MOVIE RATING CAN BE ADDED ---------------- \\
	public boolean canRatingBeAdded(String movieID, String personID)
	{
		String selectMovieRatingByMovieAndPerson = 
			"SELECT rate FROM movie_rating WHERE movie_id = '" + movieID + "' AND person_id = '" + personID + "'";
		try{
			jdbcTemplate.queryForObject(selectMovieRatingByMovieAndPerson, String.class);
			return false;
		}
		catch(DataAccessException e){ return true; }
	}
	
	// ---------------- CHECK IF COMMENT IS ALREADY LIKED ---------------- \\
	public boolean checkIfCommentAlreadyLiked(int rowID, String username)
	{
		String selectByUsername = "SELECT user_liked FROM comment_likes WHERE user_liked='"+username+"' AND comment_id="+rowID;
		try{
			if( jdbcTemplate.queryForObject(selectByUsername, String.class) == null )
			{
				return false;
			}
			return true;
		}
		catch(DataAccessException e){ return false; }
	}
	
	// ---------------- LAST PAGE GETTERS ---------------- \\
	public int getAllMoviesLastPage()
	{
		String selectAllMovies = "SELECT COUNT(*) FROM movie"; 
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMovies, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getMoviesByTypeLastPage(String movieType)
	{
		String selectAllMoviesByType = "SELECT COUNT(*) FROM movie_type WHERE type='" + movieType + "'";
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByType, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getMoviesByTitleLastPage(String title)
	{
		String selectAllMoviesByTitle = "SELECT COUNT(*) FROM movie WHERE title LIKE '%"+title+"%'";
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByTitle, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}

	public int getMoviesByDirectorLastPage(String director)
	{
		String selectAllMoviesByDirector = "SELECT COUNT(*) FROM movie WHERE director = '" + director + "'";
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByDirector, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getMoviesByDirectorAndTypeLastPage(String director, String type)
	{
		String selectAllMoviesByDirectorAndType = "SELECT COUNT(*) FROM movie m, movie_type mt WHERE "
				+ "mt.type='"+type+"' AND m.director='"+director+"' AND mt.movie_id=m.id";
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByDirectorAndType, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getMoviesByDirectorAndTypeAndYearLastPage(String director, String type, int year)
	{
		String selectAllMoviesByDirectorAndTypeAndYear = "SELECT COUNT(*) FROM movie m, movie_type mt WHERE "
				+ "mt.type='"+type+"' AND m.director='"+director+"' AND m.year="+year+" AND mt.movie_id=m.id";
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByDirectorAndTypeAndYear, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getMoviesByDirectorAndTypeAndEndYearLastPage(String director, String type, int endYear)
	{
		String selectAllMoviesByDirectorAndTypeAndEndYear = "SELECT COUNT(*) FROM movie m, movie_type mt WHERE "
				+ "mt.type='"+type+"' AND m.director='"+director+"' AND m.year<="+endYear+" AND mt.movie_id=m.id";
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByDirectorAndTypeAndEndYear, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getMoviesByDirectorAndTypeAndYearsLastPage(String director, String type, int year, int endYear)
	{
		String selectAllMoviesByDirectorAndTypeAndYears = "SELECT COUNT(*) FROM movie m, movie_type mt WHERE "
				+ "mt.type='"+type+"' AND m.director='"+director+"' AND m.year>="+year+" AND m.year<="+endYear+" AND mt.movie_id=m.id";
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByDirectorAndTypeAndYears, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getMoviesByDirectorAndYearLastPage(String director, int year)
	{
		String selectAllMoviesByDirectorAndYear = "SELECT COUNT(*) FROM movie WHERE director = '" + director + "' AND year = " + year;
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByDirectorAndYear, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getMoviesByDirectorAndEndYearLastPage(String director, int endYear)
	{
		String selectAllMoviesByDirectorAndEndYear = "SELECT COUNT(*) FROM movie WHERE director = '" + director + "' AND year <= " + endYear;
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByDirectorAndEndYear, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getMoviesByDirectorAndYearsLastPage(String director, int year, int endYear)
	{
		String selectAllMoviesByDirectorAndYears = "SELECT COUNT(*) FROM movie WHERE director = '" + director + "' AND year >= " + year + " AND year <= " + endYear;
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByDirectorAndYears, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getMoviesByYearLastPage(int year)
	{
		String selectAllMoviesByYear = "SELECT COUNT(*) FROM movie WHERE year=" + year + "";
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByYear, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getMoviesByEndYearLastPage(int endYear)
	{
		String selectAllMoviesByEndYear = "SELECT COUNT(*) FROM movie WHERE year<=" + endYear + "";
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByEndYear, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getMoviesByYearsLastPage(int year, int endYear)
	{
		String selectAllMoviesByYears = "SELECT COUNT(*) FROM movie WHERE year >= " + year + " AND year <= " + endYear;
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByYears, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getMoviesByYearAndTypeLastPage(int year, String type)
	{
		String selectAllMoviesByYearAndType = "SELECT COUNT(*) FROM movie m, movie_type mt WHERE "
				+ "mt.type='"+type+"' AND m.year="+year+" AND mt.movie_id=m.id";
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByYearAndType, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getMoviesByEndYearAndTypeLastPage(int endYear, String type)
	{
		String selectAllMoviesByEndYearAndType = "SELECT COUNT(*) FROM movie m, movie_type mt WHERE "
				+ "mt.type='"+type+"' AND m.year<="+endYear+" AND mt.movie_id=m.id";
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByEndYearAndType, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getMoviesByYearsAndTypeLastPage(int year, int endYear, String type)
	{
		String selectAllMoviesByYearsAndType = "SELECT COUNT(*) FROM movie m, movie_type mt WHERE "
				+ "mt.type='"+type+"' AND m.year>="+year+" AND m.year<="+endYear+" AND mt.movie_id=m.id";
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByYearsAndType, new MovieIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	 // ---------- ROW MAPPERS ---------- \\ 
	 private class FullMovieRowMapper implements RowMapper<Movie>
	 { 
		 public Movie mapRow(ResultSet rs, int rowNum) throws SQLException 
		 { 
			 Movie movie = new Movie(); 
			 movie.setId( rs.getString("id") );
			 movie.setTitle( rs.getString("title") ); 
			 movie.setYear( Integer.parseInt(rs.getString("year")) );
			 movie.setDirector( rs.getString("director") );
			 movie.setDescription( rs.getString("description") );
			 movie.setRating( Double.parseDouble(rs.getString("rate")) );
			 return movie; 
		 } 
	 }
	 
	 private class SmallMovieRowMapper implements RowMapper<Movie>
	 { 
		 public Movie mapRow(ResultSet rs, int rowNum) throws SQLException 
		 { 
			 Movie movie = new Movie(); 
			 movie.setId( rs.getString("id") );
			 movie.setTitle( rs.getString("title") ); 
			 movie.setYear( Integer.parseInt(rs.getString("year")) );
			 movie.setDirector( rs.getString("director") );
			 movie.setDescription( rs.getString("description") );
			 return movie; 
		 } 
	 }
	 
	 private class MovieCommentRowMapper implements RowMapper<MovieComment>
	 { 
		 public MovieComment mapRow(ResultSet rs, int rowNum) throws SQLException 
		 { 
			 MovieComment comment = new MovieComment(); 
			 comment.setRowID( Integer.parseInt(rs.getString("row_id")) );
			 comment.setComment( rs.getString("comment") );
			 comment.setCommentType( rs.getString("comment_type") );
			 comment.setUsername( rs.getString("username") );
			 comment.setCommentID( Integer.parseInt(rs.getString("comment_id")) );
			 comment.setTime( rs.getString("time") );
			 comment.setLikes( Integer.parseInt(rs.getString("likes")) );
			 return comment; 
		 } 
	 }
	 
	 private class MovieIdRowMapper implements RowMapper<String>
	 {
		 public String mapRow(ResultSet rs, int rowNum) throws SQLException 
		 { 
			 return rs.getString(1);
		 } 
	 }
	 
	 private class MovieIdIntegerRowMapper implements RowMapper<Integer>
	 {
		 public Integer mapRow(ResultSet rs, int rowNum) throws SQLException 
		 { 
			 return Integer.parseInt( rs.getString(1) );
		 } 
	 }
	 
	 private class MovieRatingRowMapper implements RowMapper<Integer>
	 {
		 public Integer mapRow(ResultSet rs, int rowNum) throws SQLException 
		 { 
			 return Integer.parseInt( rs.getString(1) );
		 } 
	 }
}