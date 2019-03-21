package com.olas.filmsinfoservice;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.olas.filmsinfoservice.movie.Movie;

@Repository
public class HomeRepository 
{
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public List<Movie> get9MoviesWithGreatestRating()
	{
		String selectMovies = "SELECT * FROM movie ORDER BY rate DESC LIMIT 9";
		List<Movie> movies = jdbcTemplate.query(selectMovies, new FullMovieRowMapper());
		return movies;
	}
	
	public List<Movie> get9NewestMovies()
	{
		String selectMovies = "SELECT * FROM movie ORDER BY year DESC LIMIT 9";
		List<Movie> movies = jdbcTemplate.query(selectMovies, new FullMovieRowMapper());
		return movies;
	}
	
	public List<Movie> get9MoviesAddedLately()
	{
		String selectMovies = "SELECT * FROM movie ORDER BY id DESC LIMIT 9";
		List<Movie> movies = jdbcTemplate.query(selectMovies, new FullMovieRowMapper());
		return movies;
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
}
