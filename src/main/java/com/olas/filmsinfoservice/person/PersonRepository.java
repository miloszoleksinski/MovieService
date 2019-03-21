package com.olas.filmsinfoservice.person;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class PersonRepository 
{
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public Person getPerson(String personId)
	{
		String selectPerson = "SELECT * FROM person WHERE id='"+personId+"'";
		Person person =  jdbcTemplate.queryForObject(selectPerson, new PersonRowMapper());
		return person;
	}
	
	public List<Person> getPeople(int page)
	{
		String selectPeople = "SELECT * FROM person LIMIT " + page + ", 10";
		List<Person> people =  jdbcTemplate.query(selectPeople, new PersonRowMapper());
		return people;
	}
	
	public List<Person> getPeopleByYear(int page, int year)
	{
		String selectPeopleByYear = "SELECT * FROM person WHERE YEAR(birth_date) = " + year + " LIMIT " + page + ", 10";
		List<Person> people =  jdbcTemplate.query(selectPeopleByYear, new PersonRowMapper());
		return people;
	}
	
	public List<Person> getPeopleByEndYear(int page, int endYear)
	{
		String selectPeopleByEndYear = "SELECT * FROM person WHERE YEAR(birth_date) <= " + endYear + " LIMIT " + page + ", 10";
		List<Person> people =  jdbcTemplate.query(selectPeopleByEndYear, new PersonRowMapper());
		return people;
	}
	
	public List<Person> getPeopleByYears(int page, int year, int endYear)
	{
		String selectPeopleByYears = "SELECT * FROM person WHERE YEAR(birth_date) >= "+year+" AND YEAR(birth_date) <= "+endYear+" LIMIT " + page + ", 10";
		List<Person> people =  jdbcTemplate.query(selectPeopleByYears, new PersonRowMapper());
		return people;
	}
	
	public List<Person> getPeopleByName(int page, String name)
	{
		String selectPeopleByName = "SELECT * FROM person WHERE name LIKE '%"+name+"%' LIMIT " + page + ", 10";
		List<Person> people =  jdbcTemplate.query(selectPeopleByName, new PersonRowMapper());
		return people;
	}
	
	public void addPerson(Person person)
	{
		
		String addPerson = "INSERT INTO person VALUE ('" + person.getId() + "','" + person.getName() + "','" +
						   person.getBirth_date() + "'," + person.getGrowth() + ",'" + person.getBorn() + "')"; 
		jdbcTemplate.update(addPerson);
	}
	
	public void updatePerson(String currentPersonId, Person person)
	{
		String updatePerson = "UPDATE person SET id='"+person.getId()+"',name='"+person.getName()+"',birth_date='"+
							  person.getBirth_date()+"',growth="+person.getGrowth()+",born='"+person.getBorn()+"'"+
							  " WHERE id='" + currentPersonId + "'";
		jdbcTemplate.update(updatePerson);
	}
	
	public void deletePerson(String personID)
	{
		String deletePerson = "DELETE FROM person WHERE id = '" + personID + "'";
		jdbcTemplate.update(deletePerson);
	}
	
	// ---------------- CHECK IF MOVIE IS IN DATABASE ---------------- \\
	public String isPersonInDatabase(String personID)
	{
		String doPersonExists = "SELECT id FROM person WHERE id = '" + personID + "'";
		String movieIdValue;
		try {
			movieIdValue = jdbcTemplate.queryForObject(doPersonExists, String.class);
		}catch(DataAccessException ex) {  
			movieIdValue = null;
		}
		return movieIdValue;
	}
	
	// ---------------- GET LAST PAGE ---------------- \\
	public int getAllPeopleLastPage()
	{
		String selectAllMovies = "SELECT COUNT(*) FROM person"; 
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMovies, new PersonIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getAllPeopleByYearLastPage(int year)	
	{
		String selectAllMoviesByYear = "SELECT COUNT(*) FROM person WHERE YEAR(birth_date) = " + year; 
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByYear, new PersonIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getAllPeopleByEndYearLastPage(int endYear)	
	{
		String selectAllMoviesByEndYear = "SELECT COUNT(*) FROM person WHERE YEAR(birth_date) <= " + endYear; 
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByEndYear, new PersonIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getAllPeopleByYearsLastPage(int year, int endYear)	
	{
		String selectAllMoviesByYears = "SELECT COUNT(*) FROM person WHERE YEAR(birth_date) >= " + year + " AND YEAR(birth_date) <= " + endYear; 
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByYears, new PersonIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getAllPeopleByNameLastPage(String name)
	{
		String selectAllMoviesByName = "SELECT COUNT(*) FROM person WHERE name LIKE '%"+name+"%'";
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMoviesByName, new PersonIdRowMapper());}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	 // ---------- ROW MAPPERS ---------- \\ 
	 private class PersonRowMapper implements RowMapper<Person>
	 { 
		 public Person mapRow(ResultSet rs, int rowNum) throws SQLException 
		 { 
			 Person person = new Person(); 
			 person.setId( rs.getString("id") );
			 person.setName( rs.getString("name") );
			 person.setBirth_date( rs.getString("birth_date") );
			 person.setGrowth( Integer.parseInt(rs.getString("growth")) );
			 person.setBorn( rs.getString("born") );
			 return person; 
		 } 
	 }
	 
	 private class PersonIdRowMapper implements RowMapper<String>
	 { 
		 public String mapRow(ResultSet rs, int rowNum) throws SQLException 
		 { 
			 return rs.getString(1);
		 } 
	 }
}
