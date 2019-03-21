package com.olas.filmsinfoservice.person;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.olas.filmsinfoservice.exception.PersonNotFoundException;

@Service
public class PersonService 
{
	@Autowired
	private PersonRepository personRepository;
	
	public Person getPerson(String personId)
	{
		return personRepository.getPerson(personId);
	}
	
	public List<Person> getPeople(int page)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return personRepository.getPeople(page);
		}
	}
	
	public List<Person> getPeopleByYear(int page, int year)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return personRepository.getPeopleByYear(page, year);
		}
	}
	
	public List<Person> getPeopleByEndYear(int page, int endYear)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return personRepository.getPeopleByEndYear(page, endYear);
		}
	}
	
	public List<Person> getPeopleByYears(int page, int year, int endYear)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return personRepository.getPeopleByYears(page, year, endYear);
		}
	}
	
	public List<Person> getPeopleByName(int page, String name)
	{
		if(page < 0)
		{
			System.out.println( "Not valid page" );
			return null;
		}
		else
		{
			page *= 10;
			return personRepository.getPeopleByName(page, name);
		}
	}
	
	public void addPerson(Person person)
	{
		if( isPersonInDatabase(person.getId()) != true )
		{
			personRepository.addPerson(person);
		}
		else
		{
			System.out.println( "This person already exists in database" );
		}
	}
	
	public String updatePerson(String currentPersonId, Person person) throws PersonNotFoundException
	{
		if( isPersonInDatabase(currentPersonId) != true )
		{
			throw new PersonNotFoundException(currentPersonId);
		}
		else if( isPersonInDatabase(person.getId()) == true && !person.getId().equals(currentPersonId) )
		{
			return "redirect:/people/update/"+currentPersonId+"?personIDtaken";
		}
		else
		{
			personRepository.updatePerson(currentPersonId, person);
			return "redirect:/people?page=0";
		}
	}
	
	public void deletePerson(String personID)
	{
		personRepository.deletePerson(personID);
	}
	
	public boolean isPersonInDatabase(String personID)
	{
		return personRepository.isPersonInDatabase(personID) != null; // true if exists in database
	}
	
	public int getAllPeopleLastPage()
	{
		int countMovies = personRepository.getAllPeopleLastPage();
		return countLastPage(countMovies);
	}
	
	public int getAllPeopleByYearLastPage(int year)
	{
		int countMovies = personRepository.getAllPeopleByYearLastPage(year);
		return countLastPage(countMovies);
	}
	
	public int getAllPeopleByEndYearLastPage(int endYear)
	{
		int countMovies = personRepository.getAllPeopleByEndYearLastPage(endYear);
		return countLastPage(countMovies);
	}
	
	public int getAllPeopleByYearsLastPage(int year, int endYear)
	{
		int countMovies = personRepository.getAllPeopleByYearsLastPage(year, endYear);
		return countLastPage(countMovies);
	}
	
	public int getAllPeopleByNameLastPage(String name)
	{
		int countMovies = personRepository.getAllPeopleByNameLastPage(name);
		return countLastPage(countMovies);
	}
	
	public int countLastPage(int toCount)
	{
		toCount = (int) Math.ceil((double)toCount/(double)10);
		return toCount;
	}
	
	public List<Person> changeDateAndReturnPeople(List<Person> people)
	{
		for(int i=0; i<people.size(); i++)
		{
			String personDate = people.get(i).getBirth_date().trim().replace("-", " ");
			
			if( personDate.charAt(5) == '0' && personDate.charAt(6) == '0' )
			{
				personDate = personDate.substring(0, 4);
			}
			else
			{
				if( personDate.substring(5, 7).equals("01") ) { personDate = personDate.substring(0,5) + " January " + personDate.substring(7); }
				else if( personDate.substring(5, 7).equals("02") ) { personDate = personDate.substring(0,5) + " February " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("03") ) { personDate = personDate.substring(0,5) + " March " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("04") ) { personDate = personDate.substring(0,5) + " April " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("05") ) { personDate = personDate.substring(0,5) + " May " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("06") ) { personDate = personDate.substring(0,5) + " June " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("07") ) { personDate = personDate.substring(0,5) + " July " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("08") ) { personDate = personDate.substring(0,5) + " August " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("09") ) { personDate = personDate.substring(0,5) + " September " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("10") ) { personDate = personDate.substring(0,5) + " October " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("11") ) { personDate = personDate.substring(0,5) + " November " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("12") ) { personDate = personDate.substring(0,5) + " December " + personDate.substring(7); }	
			}
			people.get(i).setBirth_date(personDate);	
		}
		return people;
	}
	
	public Person changeDateAndReturnPerson(Person person)
	{
			String personDate = person.getBirth_date().trim().replace("-", " ");
			
			if( personDate.charAt(5) == '0' && personDate.charAt(6) == '0' )
			{
				personDate = personDate.substring(0, 4);
			}
			else
			{
				if( personDate.substring(5, 7).equals("01") ) { personDate = personDate.substring(0,5) + " January " + personDate.substring(7); }
				else if( personDate.substring(5, 7).equals("02") ) { personDate = personDate.substring(0,5) + " February " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("03") ) { personDate = personDate.substring(0,5) + " March " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("04") ) { personDate = personDate.substring(0,5) + " April " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("05") ) { personDate = personDate.substring(0,5) + " May " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("06") ) { personDate = personDate.substring(0,5) + " June " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("07") ) { personDate = personDate.substring(0,5) + " July " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("08") ) { personDate = personDate.substring(0,5) + " August " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("09") ) { personDate = personDate.substring(0,5) + " September " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("10") ) { personDate = personDate.substring(0,5) + " October " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("11") ) { personDate = personDate.substring(0,5) + " November " + personDate.substring(7); }	
				else if( personDate.substring(5, 7).equals("12") ) { personDate = personDate.substring(0,5) + " December " + personDate.substring(7); }	
			}
			person.setBirth_date(personDate);	
		return person;
	}
	
	public String chooseFilter(PersonFilterParams filterParams)
	{
		if( filterParams.getName() != null )
		{
			if( !filterParams.getName().equals("") )
			{
				return "redirect:/people?page=0&name="+filterParams.getName();
			}
			else
			{
				return "redirect:/people?page=0";
			}
		}
		
		Integer year=0;
		if( filterParams.getYear() != "" ) { year = Integer.parseInt( filterParams.getYear().trim() ); }
		Integer endYear=0;
		if( filterParams.getEndYear() != "" ) { endYear = Integer.parseInt( filterParams.getEndYear() ); } 
		String linkToReturn = "redirect:/people?page=0";
		if( (year>1800 && year<2200) ){ linkToReturn+="&year="+year; }
		if( (endYear>1800 && endYear<2200) ){ linkToReturn+="&endYear="+endYear; }
		return linkToReturn;
	}
}
