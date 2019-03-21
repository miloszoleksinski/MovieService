package com.olas.filmsinfoservice.person;

import java.security.Principal;
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

import com.olas.filmsinfoservice.exception.PersonNotFoundException;
import com.olas.filmsinfoservice.user.UserService;

@Controller
public class PersonController 
{
	@Autowired
	private PersonService personService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value = "/person/{personId}", method = RequestMethod.GET)
	public String getPerson(@PathVariable String personId, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		Person person = personService.getPerson(personId);
		model.addAttribute("person", personService.changeDateAndReturnPerson(person) );
		return "PersonPage";
	}
	
	@RequestMapping(value = "/people", method = RequestMethod.GET)
	public String redirectPeople(Model model, Principal principal) 
	{
		return "redirect:/people?page=0";
	}
	
	@RequestMapping(value = "/people", params = {"page"}, method = RequestMethod.GET)
	public String getPeople(@RequestParam( "page" ) int page, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("PersonFilterParams", new PersonFilterParams());
		List<Person> people = personService.getPeople(page);
		model.addAttribute("pageSize", personService.getAllPeopleLastPage() );
		model.addAttribute("people", personService.changeDateAndReturnPeople(people) );
		model.addAttribute("page", page);
		model.addAttribute("typeOfSite", "all");
		return "PeoplePage";
	}
	
	@RequestMapping(value = "/people", params = {"page","year"}, method = RequestMethod.GET)
	public String getPeopleByYear(@RequestParam( "page" ) int page, @RequestParam( "year" ) int year, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("PersonFilterParams", new PersonFilterParams());
		List<Person> people = personService.getPeopleByYear(page, year);
		model.addAttribute("pageSize", personService.getAllPeopleByYearLastPage(year) );
		model.addAttribute("people", personService.changeDateAndReturnPeople(people) );
		model.addAttribute("page", page);
		model.addAttribute("year", year);
		model.addAttribute("typeOfSite", "year");
		return "PeoplePage";
	}
	
	@RequestMapping(value = "/people", params = {"page","endYear"}, method = RequestMethod.GET)
	public String getPeopleByEndYear(@RequestParam( "page" ) int page, @RequestParam( "endYear" ) int endYear, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("PersonFilterParams", new PersonFilterParams());
		List<Person> people = personService.getPeopleByEndYear(page, endYear);
		model.addAttribute("pageSize", personService.getAllPeopleByEndYearLastPage(endYear) );
		model.addAttribute("people", personService.changeDateAndReturnPeople(people) );
		model.addAttribute("page", page);
		model.addAttribute("endYear", endYear);
		model.addAttribute("typeOfSite", "endYear");
		return "PeoplePage";
	}
	
	@RequestMapping(value = "/people", params = {"page","year","endYear"}, method = RequestMethod.GET)
	public String getPeopleByYears(@RequestParam( "page" ) int page, @RequestParam( "year" ) int year, @RequestParam( "endYear" ) int endYear, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		} 
	
		model.addAttribute("PersonFilterParams", new PersonFilterParams());
		List<Person> people = personService.getPeopleByYears(page, year, endYear);
		model.addAttribute("pageSize", personService.getAllPeopleByYearsLastPage(year, endYear) );
		model.addAttribute("people", personService.changeDateAndReturnPeople(people) );
		model.addAttribute("page", page);
		model.addAttribute("year", year);
		model.addAttribute("endYear", endYear);
		model.addAttribute("typeOfSite", "yearEndYear");
		return "PeoplePage";
	}
	
	@RequestMapping(value = "/people", params = {"page","name"}, method = RequestMethod.GET)
	public String getPeopleByName(@RequestParam( "page" ) int page, @RequestParam( "name" ) String name, Model model, Principal principal) 
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("PersonFilterParams", new PersonFilterParams());
		List<Person> people = personService.getPeopleByName(page, name);
		model.addAttribute("pageSize", personService.getAllPeopleByNameLastPage(name) );
		model.addAttribute("people", personService.changeDateAndReturnPeople(people) );
		model.addAttribute("page", page);
		model.addAttribute("name", name);
		model.addAttribute("typeOfSite", "name");
		return "PeoplePage"; // PeopleByNamePage
	}
	
	@RequestMapping(value = "/people/add", method = RequestMethod.GET)
	public String addPerson(Model model, Principal principal) 
	{
		if( principal != null )
		{
			String loggedUsername = principal.getName();
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("person", new Person());
		return "addPerson";
	}
	
	@RequestMapping(value = "/people/added", method = RequestMethod.POST)
	public String addedPerson(@Valid Person person, BindingResult bindingResult, Model model, Principal principal) 
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
			return "addPerson";
		}
		personService.addPerson(person);
		return "redirect:/people";
	}
	
	@RequestMapping(value="/updatePerson", method = RequestMethod.POST)
	public String redirectToUpdatePerson(@RequestParam String personID, Model model) throws PersonNotFoundException 
	{
		if( personID == null || personID.length() == 0 )
		{
			return "redirect:/adminPanel";
		}
		if( personService.isPersonInDatabase(personID) != true )
		{
			throw new PersonNotFoundException(personID);
		}
		return "redirect:/people/update/"+personID;
	}
	
	@RequestMapping(value = "/people/update/{currentPersonId}", method = RequestMethod.GET)
	public String updatePerson(
			@RequestParam(value="personIDtaken", required = false) String personIDtaken, 
			@PathVariable String currentPersonId, Model model, Principal principal) 
	{
		if(personIDtaken!=null){model.addAttribute("personIDtaken", "Person ID already taken");}

		if( principal != null )
		{
			String loggedUsername = principal.getName();
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		model.addAttribute("person", new Person());
		model.addAttribute("currentPersonId", currentPersonId);
		return "updatePerson";
	}
	
	@RequestMapping(value = "/people/updated/{currentPersonId}", method = RequestMethod.POST)
	public String updatedPerson(@PathVariable String currentPersonId, @Valid Person person, BindingResult bindingResult, Model model, Principal principal) throws PersonNotFoundException 
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
			return "updatePerson";
		}
		return personService.updatePerson(currentPersonId, person);
	}
	
	@RequestMapping(value="/deletePerson", method = RequestMethod.POST)
	public String redirectToDeletePerson(@RequestParam String personID, Model model) throws PersonNotFoundException 
	{
		if( personID == null || personID.length() == 0 )
		{
			return "redirect:/adminPanel";
		}
		if( personService.isPersonInDatabase(personID) != true )
		{
			throw new PersonNotFoundException(personID);
		}
		return "redirect:/people/delete/"+personID;
	}
	
	@RequestMapping(value = "/people/delete/{personID}", method = RequestMethod.GET)
	public String deletePerson(@PathVariable String personID, Model model) 
	{
		personService.deletePerson(personID);
		return "redirect:/people?page=0";
	}
	
	@RequestMapping(value = "/people/filtered", method = RequestMethod.POST)
	public String filteredMovies(PersonFilterParams personFilterParams, Model model)
	{
		return personService.chooseFilter(personFilterParams);
	}
}
