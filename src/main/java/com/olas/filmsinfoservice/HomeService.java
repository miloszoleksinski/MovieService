package com.olas.filmsinfoservice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olas.filmsinfoservice.movie.Movie;

@Service
public class HomeService 
{
	@Autowired
	private HomeRepository homeRepository;
	
	public List<Movie> get9MoviesWithGreatestRating()
	{
		return homeRepository.get9MoviesWithGreatestRating();
	}
	
	public List<Movie> get9NewestMovies()
	{
		return homeRepository.get9NewestMovies();
	}
	
	public List<Movie> get9MoviesAddedLately()
	{
		return homeRepository.get9MoviesAddedLately();
	}
}
