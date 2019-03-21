package com.olas.filmsinfoservice.user;

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
import org.springframework.web.context.request.WebRequest;

import com.olas.filmsinfoservice.exception.EmailExistsException;
import com.olas.filmsinfoservice.exception.UserIsAlreadyEnabledException;
import com.olas.filmsinfoservice.exception.UserNotRegisteredException;
import com.olas.filmsinfoservice.exception.UsernameExistsException;
import com.olas.filmsinfoservice.movie.MovieService;

@Controller
public class UserController 
{
	@Autowired
	private UserService userService;
	
	@Autowired
	private MovieService movieService;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginUser(
			@RequestParam(value = "error", required = false) String error, 
			@RequestParam(value = "banned", required = false) String banned,
			@RequestParam(value = "verifyEmail", required = false) String verifyEmail,
			@RequestParam(value = "logout", required = false) String logout,
			@RequestParam(value = "registered", required = false) String registered,
			@RequestParam(value = "activated", required = false) String activated,
			@RequestParam(value = "tokenDoesntExists", required = false) String tokenDoesntExists,
			@RequestParam(value = "tokenExpired", required = false) String tokenExpired,@RequestParam(value = "username",required = false) String username,
			@RequestParam(value = "passwordChanged", required = false) String passwordChanged,
			@RequestParam(value = "PasswordNotChanged", required = false) String PasswordNotChanged,
			Model model) 
	{
		if(error!=null){model.addAttribute("error", "Username or password is incorrect.");}
		if(banned!=null){model.addAttribute("banned", "Account is banned.");}
		if(verifyEmail!=null){model.addAttribute("verifyEmail", "Account is not activated, check your email.");}
		if (logout != null) {model.addAttribute("message", "Logged out from MoviesInfo successfully.");}
		if (registered != null) {model.addAttribute("registered", "Account registered successfully, verification email sent.");}
		if (activated != null) {model.addAttribute("activated", "Account activated successfully.");}
		if (tokenDoesntExists != null) {model.addAttribute("tokenDoesntExists", "This confirmatioion email doesn't exists.");}
		if (tokenExpired != null) {model.addAttribute("tokenExpired", "Confirmation email expired."); model.addAttribute("username", username);}
		if (passwordChanged != null) {model.addAttribute("passwordChanged", "Password changed successfully.");}
		if (PasswordNotChanged != null) {model.addAttribute("PasswordNotChanged", "Changing password failed.");}
		return "login";
	}
	
	@RequestMapping(value = "/user/{username}", method = RequestMethod.GET)
	public String userAccount(
			@RequestParam(value = "added", required = false) String added,
			@RequestParam(value = "deleted", required = false) String deleted,
			@PathVariable String username, Principal principal,
			Model model) throws UserNotRegisteredException 
	{
		UserModel userModel = userService.getUserByUsername(username);
		if( userModel == null ) { throw new UserNotRegisteredException(username); }
		model.addAttribute("userModel", userModel);
		
		UserInfoModel userInfoModel = userService.getUserInfoByUsername(username);
		model.addAttribute("userInfoModel", userInfoModel);
		
		int numberOfBadges = userService.getNumberOfBadgesByUsername(username);
		model.addAttribute("numberOfBadges", numberOfBadges);
		
		int numberOfRatings = userService.getNumberOfRatingsByUsername(username);
		model.addAttribute("numberOfRatings", numberOfRatings);
		
		int numberOfFriends = userService.getNumberOfFriendsByUsername(username);
		model.addAttribute("numberOfFriends", numberOfFriends);
		
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			model.addAttribute("isUserFriend", userService.isUserMyFriend(loggedUsername, username));
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
			
			if( loggedUsername.equals(username) )
			{
				Integer numberOfNewNotifications = userService.getNumberOfNewNotificationsByUsernameUpdate(loggedUsername);
				if( numberOfNewNotifications == null || numberOfNewNotifications == 0 ){}
				else if( numberOfNewNotifications > 9 ){model.addAttribute("numberOfNewNotifications", "9+");}
				else {model.addAttribute("numberOfNewNotifications", numberOfNewNotifications);}
			}
		}
		
		List<String> userRoles = userService.getUserRolesByUsername(username);
		model.addAttribute("userRoleSize", userRoles.size());
		
		int countOfGivenlikes = userService.getCountOfGivenLikesByUsername(username);
		model.addAttribute("countOfGivenlikes", countOfGivenlikes);
		
		int countOfReceivedLikes = userService.getCountOfReceivedLikesByUsername(username);
		model.addAttribute("countOfReceivedLikes", countOfReceivedLikes);
		
		int countOfComments = userService.getCountOfCommentsByUsername(username);
		model.addAttribute("countOfComments", countOfComments);
		
		userService.setUserScore(username, countOfGivenlikes, countOfReceivedLikes, countOfComments, numberOfRatings);
		
		userService.addProfileView(username);
		UserAccountInfoModel userAccountInfo = userService.getUserAccountInfo(username);
		userAccountInfo.setRegistrationTimestamp( userService.convertTimeToUserMembershipTime( userAccountInfo.getRegistrationTimestamp() ) );
		userAccountInfo.setLastSeenTimestamp( userService.convertTimeToLastSeenTime( userAccountInfo.getLastSeenTimestamp() ) );
		model.addAttribute("userAccountInfo", userAccountInfo);
		
		model.addAttribute("userRaking", userService.getRankingOfUser( username ));
		
		userService.addProfileViewsBadgeIfPossible( userAccountInfo.getAccountViews(), username );
		
		userService.addUserPointsBadgeIfPossible(username, userAccountInfo.getScore());
		
		List<UserBadgeModel> bronzeUserBadges = userService.getUserBadgesByUsernameAndColorWithLimit(username, "bronze", 3);
		model.addAttribute("bronzeUserBadges", bronzeUserBadges);
		
		List<UserBadgeModel> silverUserBadges = userService.getUserBadgesByUsernameAndColorWithLimit(username, "silver", 3);
		model.addAttribute("silverUserBadges", silverUserBadges);
		
		List<UserBadgeModel> goldUserBadges = userService.getUserBadgesByUsernameAndColorWithLimit(username, "gold", 3);
		model.addAttribute("goldUserBadges", goldUserBadges);
		
		return "userAccount";
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String registerUser(Model model,
			@RequestParam(value="mailError", required = false) String mailError, 
			@RequestParam(value = "nameError",required = false) String nameError) 
	{
		if(mailError!=null){model.addAttribute("mailError", "E-mail already taken");}
		if (nameError!=null) {model.addAttribute("nameError", "Username already taken");}
		model.addAttribute("userModel", new UserModel());
		return "register";
	}
	
	@RequestMapping(value = "/registered", method = RequestMethod.POST)
	public String registeredUser(@Valid UserModel userModel, BindingResult bindingResult, WebRequest request, Model model)
	{
		if (bindingResult.hasErrors()) 
		{
			System.out.println("Not valid data");
			return "/register";
		}
		
		try { 
			ConfirmToken confirmToken = userService.createNewConfirmToken(userModel.getUsername());
			userService.registerNewUser(userModel, confirmToken); 
			userService.sendRegisterConfirmationEmail(userModel, request.getContextPath(), confirmToken.getToken()); 
			} 
		catch ( UsernameExistsException e ) { e.printStackTrace(); return "redirect:/register?nameError"; }
		catch ( EmailExistsException e) { e.printStackTrace(); return "redirect:/register?mailError"; } 
		return "redirect:/login?registered";
	}
	
	@RequestMapping(value = "/registrationConfirm", params = {"user","token"}, method = RequestMethod.GET)
	public String confirmRegistration(@RequestParam( "user" ) String user,@RequestParam( "token" ) String token, Model model) 
	{
		return userService.activateAccount(user, token);
	}
	
	@RequestMapping(value = "/resendConfirmationEmail", method = RequestMethod.GET)
	public String resendConfirmationEmail(@RequestParam(value="username", required = false) String username, WebRequest request, Model model)
			throws UserNotRegisteredException, UserIsAlreadyEnabledException 
	{
		return userService.resendConfirmationEmail(username, request.getContextPath());
	}
	
	@RequestMapping(value = "/banUser", method = RequestMethod.POST)
	public String banUser(@RequestParam( "username" ) String username, Model model) 
	{
		return userService.banUser(username);
	}
	
	@RequestMapping(value = "/unbanUser", method = RequestMethod.POST)
	public String unbanUser(@RequestParam( "username" ) String username, Principal principal, Model model) 
	{
		String loggedUsername = principal.getName();
		return userService.unbanUser(username, loggedUsername);
	}
	
	@RequestMapping(value = "/takeAdmin", method = RequestMethod.POST)
	public String takeAdmin(@RequestParam( "username" ) String username, Model model) 
	{
		return userService.takeAdmin(username);
	}
	
	@RequestMapping(value = "/giveAdmin", method = RequestMethod.POST)
	public String giveAdmin(@RequestParam( "username" ) String username, Principal principal, Model model) 
	{
		String loggedUsername = principal.getName();
		return userService.giveAdmin(username, loggedUsername);
	}
	
	@RequestMapping(value = "/takeHost", method = RequestMethod.POST)
	public String takeHost(@RequestParam( "username" ) String username, Model model) 
	{
		return userService.takeHost(username);
	}
	
	@RequestMapping(value = "/giveHost", method = RequestMethod.POST)
	public String giveHost(@RequestParam( "username" ) String username, Principal principal, Model model) 
	{
		String loggedUsername = principal.getName();
		return userService.giveHost(username, loggedUsername);
	}
	
	@RequestMapping(value = "/adminPanel", method = RequestMethod.GET)
	public String adminPanel(Model model, Principal principal)
	{
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		return "adminPanel";
	}
	
	@RequestMapping(value = "/hostPanel", method = RequestMethod.GET)
	public String hostPanel(
			@RequestParam(value="cantBan", required = false) String cantBan, 
			@RequestParam(value="banned", required = false) String banned,
			@RequestParam(value="alreadyBanned", required = false) String alreadyBanned,
			
			@RequestParam(value="cantUnban", required = false) String cantUnban, 
			@RequestParam(value="unbanned", required = false) String unbanned, 
			@RequestParam(value="alreadyUnbanned", required = false) String alreadyUnbanned, 
			
			@RequestParam(value="cantTakeAdmin", required = false) String cantTakeAdmin, 
			@RequestParam(value="adminTaken", required = false) String adminTaken, 
			@RequestParam(value="noAdminRole", required = false) String noAdminRole,
			@RequestParam(value="userIsHost", required = false) String userIsHost,
			
			@RequestParam(value="cantGiveAdmin", required = false) String cantGiveAdmin, 
			@RequestParam(value="adminGiven", required = false) String adminGiven, 
			@RequestParam(value="wrongAdminRoles", required = false) String wrongAdminRoles, 
			@RequestParam(value="alreadyAdmin", required = false) String alreadyAdmin,
			
			@RequestParam(value="cantTakeHost", required = false) String cantTakeHost, 
			@RequestParam(value="hostTaken", required = false) String hostTaken, 
			@RequestParam(value="userIsNotHost", required = false) String userIsNotHost,
			
			@RequestParam(value="cantGiveHost", required = false) String cantGiveHost, 
			@RequestParam(value="hostGiven", required = false) String hostGiven, 
			@RequestParam(value="alreadyHost", required = false) String alreadyHost,
			@RequestParam(value="wrongHostRoles", required = false) String wrongHostRoles,
			
			@RequestParam(value="changeOlas", required = false) String changeOlas, 
			Model model, Principal principal)
	{
		if(cantBan!=null){model.addAttribute("cantBan", "User doesn't exists in database.");}
		if(banned!=null) {model.addAttribute("banned", "User banned.");}
		if(alreadyBanned!=null) {model.addAttribute("alreadyBanned", "User is already banned.");}
		
		if(cantUnban!=null){model.addAttribute("cantUnban", "User doesn't exists in database.");}
		if(unbanned!=null) {model.addAttribute("unbanned", "User unbanned.");}
		if(alreadyUnbanned!=null) {model.addAttribute("alreadyUnbanned", "User is not banned.");}
		
		if(cantTakeAdmin!=null) {model.addAttribute("cantTakeAdmin", "User doesn't exists in database.");}
		if(adminTaken!=null){model.addAttribute("adminTaken", "Admin taken successfully.");}
		if(noAdminRole!=null) {model.addAttribute("noAdminRole", "User is not an Admin.");}
		if(userIsHost!=null) {model.addAttribute("userIsHost", "First take Host-role to take Admin-role.");}
		
		if(cantGiveAdmin!=null) {model.addAttribute("cantGiveAdmin", "User doesn't exists in database.");}
		if(adminGiven!=null){model.addAttribute("adminGiven", "Admin given successfully.");}
		if(wrongAdminRoles!=null) {model.addAttribute("wrongAdminRoles", "User must have User-role to gain Admin-role.");}
		if(alreadyAdmin!=null) {model.addAttribute("alreadyAdmin", "User already is an Admin.");}
		
		if(cantTakeHost!=null){model.addAttribute("cantTakeHost", "User doesn't exists in database.");}
		if(hostTaken!=null) {model.addAttribute("hostTaken", "Host taken successfully.");}
		if(userIsNotHost!=null) {model.addAttribute("userIsNotHost", "User is not a Host.");}
		
		if(cantGiveHost!=null){model.addAttribute("cantGiveHost", "User doesn't exists in database.");}
		if(hostGiven!=null) {model.addAttribute("hostGiven", "Host given successfully.");}
		if(alreadyHost!=null) {model.addAttribute("alreadyHost", "User already is an Host.");}
		if(wrongHostRoles!=null) {model.addAttribute("wrongHostRoles", "User must have Admin-role to gain Host-role.");}
		
		if(changeOlas!=null) {model.addAttribute("changeOlas", "Olas is main Host, you can't change his role.");}
		
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		return "hostPanel";
	}
	
	// --------------------- CHANGE LOGGED USER PASSWORD REQUESTS --------------------- \\
	@RequestMapping(value = "/user/{username}/changePassword", method = RequestMethod.GET)
	public String getOldAndNewPassword(
			@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "passwordDoesntMatch", required = false) String passwordDoesntMatch,
			@RequestParam(value = "passwordChanged", required = false) String passwordChanged,
			@PathVariable String username,
			Principal principal,
			Model model) 
	{
		String loggedUsername = principal.getName();
		int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
		model.addAttribute("rolesNumber", rolesNumber);
			
		userService.updateLastSeen(loggedUsername);
		if( !loggedUsername.equals(username) )
		{
			return "redirect:/user/"+loggedUsername+"/changePassword";
		}
		if(error!=null){model.addAttribute("error", "Password should be 1-20 characters long.");}
		if(passwordDoesntMatch!=null){model.addAttribute("passwordDoesntMatch", "Current password doesn't match.");}
		if (passwordChanged != null) {model.addAttribute("passwordChanged", "Password changed successfully.");}
		model.addAttribute("username", username);
		return "getOldAndNewPassword";
	}
	
	@RequestMapping(value = "/user/{username}/changedPassword", method = RequestMethod.POST)
	public String changePasswordForLoggedUser(
			@RequestParam String oldPassword, 
			@RequestParam String newPassword, 
			@PathVariable String username,
			Principal principal,
			Model model) throws UserNotRegisteredException 
	{
		String loggedUsername = principal.getName();
		if( !loggedUsername.equals(username) )
		{
			return "redirect:/user/"+loggedUsername+"/changePassword";
		}
		return userService.changePasswordForLoggedUser(username, oldPassword, newPassword);
	}
	
	// --------------------- CHANGE (FORGOT) PASSWORD REQUESTS --------------------- \\
	@RequestMapping(value = "/forgotPassword", method = RequestMethod.GET)
	public String forgotPassword(
			@RequestParam(value="emailSent", required = false) String emailSent,
			@RequestParam(value="tokenDoesntExists", required = false) String tokenDoesntExists, 
			@RequestParam(value = "tokenExpired",required = false) String tokenExpired,
			Model model, Principal principal) 
	{
		if(emailSent!=null){model.addAttribute("emailSent", "Email with password sent.");}
		if(tokenDoesntExists!=null){model.addAttribute("tokenDoesntExists", "Token doesn't exists.");}
		if(tokenExpired!=null){model.addAttribute("tokenExpired", "Email expired.");}
		
		if( principal != null )
		{
			String loggedUsername = principal.getName();
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
		}
		
		return "ForgotPassword";
	}
	
	@RequestMapping(value = "/sendEmailPassword", method = RequestMethod.POST)
	public String sendEmailPassword(@RequestParam String email, WebRequest request, Model model) throws UserNotRegisteredException 
	{
		return userService.sendPasswordEmail(email, request.getContextPath());
	}
	
	@RequestMapping(value = "/changePasswordConfirm", params = {"user","token"}, method = RequestMethod.GET)
	public String confirmChangePassword(@RequestParam( "user" ) String user, @RequestParam( "token" ) String token, Model model) 
	{
		model.addAttribute("username", user);
		return userService.checkIfTokenExists(user, token);
	}
	
	@RequestMapping(value = "/changePassword", params = {"username"}, method = RequestMethod.POST)
	public String changePassword(@RequestParam String password, @RequestParam( "username" ) String username, Model model) 
	{
		return userService.changeUserPassword(username, password);
	}
	
	//--------------------------------------------------------------------\\
	// --------------------- USER ACCOUNT REQUESTS --------------------- \\ 
	//--------------------------------------------------------------------\\
	@RequestMapping(value = "/user/{username}/ratings", params = {"page"}, method = RequestMethod.GET)
	public String userRatings(Principal principal, @PathVariable String username, @RequestParam( "page" ) int page, Model model) throws UserNotRegisteredException 
	{
		UserModel userModel = userService.getUserByUsername(username);
		if( userModel == null ) { throw new UserNotRegisteredException(username); }
		model.addAttribute("userModel", userModel);
		
		List<String> userRoles = userService.getUserRolesByUsername(username);
		model.addAttribute("userRoleSize", userRoles.size());
		
		UserInfoModel userInfoModel = userService.getUserInfoByUsername(username);
		model.addAttribute("userInfoModel", userInfoModel);
		
		int numberOfBadges = userService.getNumberOfBadgesByUsername(username);
		model.addAttribute("numberOfBadges", numberOfBadges);
		
		int numberOfRatings = userService.getNumberOfRatingsByUsername(username);
		model.addAttribute("numberOfRatings", numberOfRatings);
		
		int numberOfFriends = userService.getNumberOfFriendsByUsername(username);
		model.addAttribute("numberOfFriends", numberOfFriends);
		
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			model.addAttribute("isUserFriend", userService.isUserMyFriend(loggedUsername, username));
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
			
			if( loggedUsername.equals(username) )
			{
				Integer numberOfNewNotifications = userService.getNumberOfNewNotificationsByUsernameUpdate(loggedUsername);
				if( numberOfNewNotifications == null || numberOfNewNotifications == 0 ){}
				else if( numberOfNewNotifications > 9 ){model.addAttribute("numberOfNewNotifications", "9+");}
				else {model.addAttribute("numberOfNewNotifications", numberOfNewNotifications);}
			}
		}
		model.addAttribute("page", page);
		
		int ratingPages = userService.getRatingsLastPage(username);
		if( ratingPages == 0 ) { model.addAttribute("notRated", "Did not rated any movies."); }
		else if( page > ratingPages-1 ) { model.addAttribute("pageDoesntExists", "Page does not exists."); } 
		else
		{
			model.addAttribute("ratingPages", ratingPages);
			
			List<UserRatingModel> ratings = userService.getUserRatingsByUsername(username, page);
			for(int i=0; i<ratings.size(); i++)
			{
				String time = ratings.get(i).getTime();
				if( time != null )
				{
					ratings.get(i).setTime( userService.convertTimeToUserNotificationDate(time) );
				}
			} 
			model.addAttribute("ratings", ratings);
			
			List<String> moviesNames = movieService.getMoviesNamesByMovieID(ratings);
			model.addAttribute("moviesNames", moviesNames);
		}
		return "userRatingsPage";
	}
	
	@RequestMapping(value = "/user/{username}/editAccount", method = RequestMethod.GET)//formatError
	public String userEditAccount(
			@RequestParam(value="formatError", required = false) String formatError,
			@PathVariable String username, Principal principal, Model model)
	{
		if(formatError!=null){model.addAttribute("formatError", "Input must be number.");}
		
		String loggedUsername = principal.getName();
		userService.updateLastSeen(loggedUsername);
		
		int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
		model.addAttribute("rolesNumber", rolesNumber);
		
		if( !loggedUsername.equals(username) ) { return "redirect:/user/"+loggedUsername+"/editAccount"; }
		else{
			Integer numberOfNewNotifications = userService.getNumberOfNewNotificationsByUsernameUpdate(loggedUsername);
			if( numberOfNewNotifications == null || numberOfNewNotifications == 0 ){}
			else if( numberOfNewNotifications > 9 ){model.addAttribute("numberOfNewNotifications", "9+");}
			else {model.addAttribute("numberOfNewNotifications", numberOfNewNotifications);}
		}
		
		int numberOfBadges = userService.getNumberOfBadgesByUsername(username);
		model.addAttribute("numberOfBadges", numberOfBadges);
		
		int numberOfRatings = userService.getNumberOfRatingsByUsername(username);
		model.addAttribute("numberOfRatings", numberOfRatings);
		
		int numberOfFriends = userService.getNumberOfFriendsByUsername(username);
		model.addAttribute("numberOfFriends", numberOfFriends);
		
		UserModel userModel = userService.getUserByUsername(username);
		model.addAttribute("userModel", userModel);
		
		List<String> userRoles = userService.getUserRolesByUsername(username);
		model.addAttribute("userRoleSize", userRoles.size());
		
		UserInfoModel userInfoModel = userService.getUserInfoByUsername(username);
		model.addAttribute("userInfoModel", userInfoModel);
		
		return "editAccount";
	}
	
	@RequestMapping(value = "/user/{username}/editAccount/saveAboutUser", method = RequestMethod.POST)
	public String userSaveAbout(
			@RequestParam( "aboutMe" ) String aboutMe,
			@PathVariable String username, Principal principal,
			Model model)
	{
		String loggedUsername = principal.getName();
		if( !loggedUsername.equals(username) ) { return "redirect:/user/"+loggedUsername+"/editAccount"; }

		userService.saveAboutMe(username, aboutMe);
		userService.addProfileInfoBadgeIfPossible(loggedUsername);
		return "redirect:/user/"+username+"/editAccount";
	}
	
	@RequestMapping(value = "/user/{username}/editAccount/saveFavMovies", method = RequestMethod.POST)
	public String userFavMovies(
			@RequestParam( "favMovies" ) String favMovies,
			@PathVariable String username, Principal principal,
			Model model)
	{
		String loggedUsername = principal.getName();
		if( !loggedUsername.equals(username) ) { return "redirect:/user/"+loggedUsername+"/editAccount"; }

		userService.saveFavMovies(username, favMovies);
		userService.addProfileInfoBadgeIfPossible(loggedUsername);
		return "redirect:/user/"+username+"/editAccount";
	}
	
	@RequestMapping(value = "/user/{username}/editAccount/saveAge", method = RequestMethod.POST)
	public String userAge(
			@RequestParam( "age" ) String age,
			@PathVariable String username, Principal principal,
			Model model)
	{
		String loggedUsername = principal.getName();
		if( !loggedUsername.equals(username) ) { return "redirect:/user/"+loggedUsername+"/editAccount"; }
		
		try{ Integer.parseInt(age); }
		catch(NumberFormatException ex) { return "redirect:/user/"+username+"/editAccount?formatError"; }
		
		userService.saveAge(username, age);
		userService.addProfileInfoBadgeIfPossible(loggedUsername);
		return "redirect:/user/"+username+"/editAccount";
	}
	
	@RequestMapping(value = "/user/{username}/editAccount/saveDescription", method = RequestMethod.POST)
	public String userDescription(
			@RequestParam( "description" ) String description,
			@PathVariable String username, Principal principal,
			Model model)
	{
		String loggedUsername = principal.getName();
		if( !loggedUsername.equals(username) ) { return "redirect:/user/"+loggedUsername+"/editAccount"; }

		userService.saveDescription(username, description);
		userService.addProfileInfoBadgeIfPossible(loggedUsername);
		return "redirect:/user/"+username+"/editAccount";
	}
	
	@RequestMapping(value = "/user/{username}/editAccount/saveName", method = RequestMethod.POST)
	public String userName(
			@RequestParam( "name" ) String name,
			@PathVariable String username, Principal principal,
			Model model)
	{
		String loggedUsername = principal.getName();
		if( !loggedUsername.equals(username) ) { return "redirect:/user/"+loggedUsername+"/editAccount"; }

		userService.saveName(username, name);
		userService.addProfileInfoBadgeIfPossible(loggedUsername);
		return "redirect:/user/"+username+"/editAccount";
	}
	
	@RequestMapping(value = "/user/{username}/addFriend", method = RequestMethod.GET)
	public String addFriend(
			@RequestParam(value="userN", required = false) String userN,
			@RequestParam(value="redir", required = false) String redir,
			@RequestParam(value="page", required = false) String page,
			@PathVariable String username, Principal principal,
			Model model) throws UserNotRegisteredException
	{
		String loggedUsername = principal.getName();
		if( loggedUsername.equals(username) ) { return "redirect:/user/"+loggedUsername; }
		
		UserModel userModel = userService.getUserByUsername(username);
		if( userModel == null ) { throw new UserNotRegisteredException(username); }
		
		userService.addFriend(loggedUsername, username);
		
		if( userN != null && redir != null && page != null ) { return "redirect:/user/"+userN+"/"+redir+"?page="+page; }
		else if( redir != null && page != null ) { return "redirect:/user/"+username+"/"+redir+"?page="+page; }
		return "redirect:/user/"+username+"?added";
	}
	
	@RequestMapping(value = "/user/{username}/deleteFriend", method = RequestMethod.GET)
	public String deleteFriend(
			@RequestParam(value="userN", required = false) String userN,
			@RequestParam(value="redir", required = false) String redir,
			@RequestParam(value="page", required = false) String page,
			@PathVariable String username, Principal principal,
			Model model) throws UserNotRegisteredException
	{
		String loggedUsername = principal.getName();
		if( loggedUsername.equals(username) ) { return "redirect:/user/"+loggedUsername; }
		
		UserModel userModel = userService.getUserByUsername(username);
		if( userModel == null ) { throw new UserNotRegisteredException(username); }
		
		userService.deleteFriend(loggedUsername, username);
		
		if( userN != null && redir != null && page != null ) { return "redirect:/user/"+userN+"/"+redir+"?page="+page; }
		else if( redir != null && page != null ) { return "redirect:/user/"+username+"/"+redir+"?page="+page; }
		return "redirect:/user/"+username+"?deleted";
	}
	
	@RequestMapping(value = "/user/{username}/friends", params = {"page"}, method = RequestMethod.GET)
	public String userFriends(Principal principal, @PathVariable String username, @RequestParam( "page" ) int page, Model model) throws UserNotRegisteredException 
	{
		UserModel userModel = userService.getUserByUsername(username);
		if( userModel == null ) { throw new UserNotRegisteredException(username); }
		model.addAttribute("userModel", userModel);
		
		List<String> userRoles = userService.getUserRolesByUsername(username);
		model.addAttribute("userRoleSize", userRoles.size());
		
		UserInfoModel userInfoModel = userService.getUserInfoByUsername(username);
		model.addAttribute("userInfoModel", userInfoModel);
		
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			model.addAttribute("isUserFriend", userService.isUserMyFriend(loggedUsername, username));
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
			
			if( loggedUsername.equals(username) )
			{
				Integer numberOfNewNotifications = userService.getNumberOfNewNotificationsByUsernameUpdate(loggedUsername);
				if( numberOfNewNotifications == null || numberOfNewNotifications == 0 ){}
				else if( numberOfNewNotifications > 9 ){model.addAttribute("numberOfNewNotifications", "9+");}
				else {model.addAttribute("numberOfNewNotifications", numberOfNewNotifications);}
			}
		}
		model.addAttribute("page", page);
		
		int numberOfBadges = userService.getNumberOfBadgesByUsername(username);
		model.addAttribute("numberOfBadges", numberOfBadges);
		
		int numberOfRatings = userService.getNumberOfRatingsByUsername(username);
		model.addAttribute("numberOfRatings", numberOfRatings);
		
		int numberOfFriends = userService.getNumberOfFriendsByUsername(username);
		model.addAttribute("numberOfFriends", numberOfFriends);
		
		int friendPages = userService.getFriendsLastPage(username);
		if( friendPages == 0 ) { model.addAttribute("notAdded", "Did not added any friends."); }
		else if( page > friendPages-1 ) { model.addAttribute("pageDoesntExists", "Page does not exists."); } 
		else
		{
			model.addAttribute("friendPages", friendPages);
			
			List<String> friends = userService.getUserFriendsByUsernameAndPage(username, page);
			model.addAttribute("friends", friends);
			
			if( principal != null)
			{
				String loggedUsername = principal.getName();
				List<Boolean> areUserFriendsMyFriends = new ArrayList<Boolean>();
				for(int i=0; i<friends.size(); i++)
				{
					areUserFriendsMyFriends.add( userService.isUserMyFriend(loggedUsername, friends.get(i)) );
				}
				model.addAttribute("areUserFriendsMyFriends", areUserFriendsMyFriends);
			}
		} 
		return "userFriendsPage";
	}
	
	@RequestMapping(value = "/user/{username}/notifications", params = {"page"}, method = RequestMethod.GET)
	public String userNotifications(
			@PathVariable String username, @RequestParam( "page" ) int page, Principal principal,
			Model model) throws UserNotRegisteredException
	{
		String loggedUsername = principal.getName();
		userService.updateLastSeen(loggedUsername);
		if( !loggedUsername.equals(username) ) { return "redirect:/user/"+loggedUsername+"/notifications?page=0"; }
		else{
			Integer numberOfNewNotifications = userService.getNumberOfNewNotificationsByUsernameUpdate(loggedUsername);
			if( numberOfNewNotifications == null || numberOfNewNotifications == 0 ){}
			else if( numberOfNewNotifications > 9 ){model.addAttribute("numberOfNewNotifications", "9+");}
			else {model.addAttribute("numberOfNewNotifications", numberOfNewNotifications);}
		}
		
		int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
		model.addAttribute("rolesNumber", rolesNumber);
		
		UserModel userModel = userService.getUserByUsername(username);
		if( userModel == null ) { throw new UserNotRegisteredException(username); }
		model.addAttribute("userModel", userModel);
		
		int numberOfBadges = userService.getNumberOfBadgesByUsername(username);
		model.addAttribute("numberOfBadges", numberOfBadges);
		
		int numberOfRatings = userService.getNumberOfRatingsByUsername(username);
		model.addAttribute("numberOfRatings", numberOfRatings);
		
		int numberOfFriends = userService.getNumberOfFriendsByUsername(username);
		model.addAttribute("numberOfFriends", numberOfFriends);
		
		List<String> userRoles = userService.getUserRolesByUsername(username);
		model.addAttribute("userRoleSize", userRoles.size());
		
		UserInfoModel userInfoModel = userService.getUserInfoByUsername(username);
		model.addAttribute("userInfoModel", userInfoModel);
		
		model.addAttribute("page", page);
		
		int notificationPages = userService.getNotificationsLastPage(username);
		if( notificationPages == 0 ) { model.addAttribute("noNotifications", "No notifications yet."); }
		else if( page > notificationPages-1 ) { model.addAttribute("pageDoesntExists", "Page does not exists."); } 
		else
		{
			model.addAttribute("notificationPages", notificationPages);
			
			List<UserNotificationModel> notifications = userService.getUserNotificationsByUsername(username, page);
			for(int i=0; i<notifications.size(); i++)
			{
				String time = notifications.get(i).getTime();
				if( time != null )
				{
					notifications.get(i).setTime( userService.convertTimeToUserNotificationDate(time) );
				}
			} 
			model.addAttribute("notifications", notifications);
			userService.setNewNotificationsToSeenNotifications(username, page*10);
		}
		
		return "userNotifications";
	}
	
	@RequestMapping(value = "/user/{username}/friendsActivity", params = {"page"}, method = RequestMethod.GET)
	public String friendsActivity(
			@PathVariable String username, @RequestParam( "page" ) int page, Principal principal,
			Model model) throws UserNotRegisteredException
	{
		String loggedUsername = principal.getName();
		userService.updateLastSeen(loggedUsername);
		if( !loggedUsername.equals(username) ) { return "redirect:/user/"+loggedUsername+"/friendsActivity?page=0"; }
		else{
			Integer numberOfNewNotifications = userService.getNumberOfNewNotificationsByUsernameUpdate(loggedUsername);
			if( numberOfNewNotifications == null || numberOfNewNotifications == 0 ){}
			else if( numberOfNewNotifications > 9 ){model.addAttribute("numberOfNewNotifications", "9+");}
			else {model.addAttribute("numberOfNewNotifications", numberOfNewNotifications);}
		}
		
		int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
		model.addAttribute("rolesNumber", rolesNumber);
		
		UserModel userModel = userService.getUserByUsername(username);
		if( userModel == null ) { throw new UserNotRegisteredException(username); }
		model.addAttribute("userModel", userModel);
		
		int numberOfBadges = userService.getNumberOfBadgesByUsername(username);
		model.addAttribute("numberOfBadges", numberOfBadges);
		
		int numberOfRatings = userService.getNumberOfRatingsByUsername(username);
		model.addAttribute("numberOfRatings", numberOfRatings);
		
		int numberOfFriends = userService.getNumberOfFriendsByUsername(username);
		model.addAttribute("numberOfFriends", numberOfFriends);
		
		List<String> userRoles = userService.getUserRolesByUsername(username);
		model.addAttribute("userRoleSize", userRoles.size());
		
		UserInfoModel userInfoModel = userService.getUserInfoByUsername(username);
		model.addAttribute("userInfoModel", userInfoModel);
		
		model.addAttribute("page", page);
		
		int friendPages = userService.getFriendsLastPage(username);
		if( friendPages == 0 ){ model.addAttribute("noActivity", "Activity not found."); }
		else
		{
			List<String> friends = userService.getUserFriendsByUsername(username);
			StringBuilder everyFriendActivity = new StringBuilder();
			int fSize = friends.size();
			for(int i=0; i<fSize; i++)
			{
				if( i < fSize-1 ) { everyFriendActivity.append("username='"+friends.get(i)+"' OR "); }
				else { everyFriendActivity.append("username='"+friends.get(i)+"'"); } 
			}
			int activityPages = userService.getActivityLastPage(username, everyFriendActivity.toString());
			if( activityPages == 0 ) { model.addAttribute("noActivity", "Activity not found."); }
			else if( page > activityPages-1 ) { model.addAttribute("pageDoesntExists", "Page does not exists."); } 
			else
			{
				model.addAttribute("activityPages", activityPages);
				
				List<UserNotificationModel> activity = userService.getUserFriendsActivityByUsername(username, everyFriendActivity.toString(), page);
				for(int i=0; i<activity.size(); i++)
				{
					String time = activity.get(i).getTime();
					if( time != null )
					{
						activity.get(i).setTime( userService.convertTimeToUserNotificationDate(time) );
					}
				} 
				model.addAttribute("activity", activity);
			}
		}
		return "userFriendsActivity";
	}
	
	@RequestMapping(value = "user/{username}/badges", method = RequestMethod.GET)
	public String allUserBadgesList(Principal principal, @PathVariable String username, Model model) throws UserNotRegisteredException
	{
		UserModel userModel = userService.getUserByUsername(username);
		if( userModel == null ) { throw new UserNotRegisteredException(username); }
		model.addAttribute("userModel", userModel);
		
		if( principal != null)
		{
			String loggedUsername = principal.getName();
			userService.updateLastSeen(loggedUsername);
			model.addAttribute("isUserFriend", userService.isUserMyFriend(loggedUsername, username));
			
			int rolesNumber = userService.getUserRolesByUsername(loggedUsername).size();
			model.addAttribute("rolesNumber", rolesNumber);
			
			if( loggedUsername.equals(username) )
			{
				Integer numberOfNewNotifications = userService.getNumberOfNewNotificationsByUsernameUpdate(loggedUsername);
				if( numberOfNewNotifications == null || numberOfNewNotifications == 0 ){}
				else if( numberOfNewNotifications > 9 ){model.addAttribute("numberOfNewNotifications", "9+");}
				else {model.addAttribute("numberOfNewNotifications", numberOfNewNotifications);}
			}
		}
		
		List<String> userRoles = userService.getUserRolesByUsername(username);
		model.addAttribute("userRoleSize", userRoles.size());
		
		UserInfoModel userInfoModel = userService.getUserInfoByUsername(username);
		model.addAttribute("userInfoModel", userInfoModel);
		
		int numberOfBadges = userService.getNumberOfBadgesByUsername(username);
		model.addAttribute("numberOfBadges", numberOfBadges);
		
		int numberOfRatings = userService.getNumberOfRatingsByUsername(username);
		model.addAttribute("numberOfRatings", numberOfRatings);
		
		int numberOfFriends = userService.getNumberOfFriendsByUsername(username);
		model.addAttribute("numberOfFriends", numberOfFriends);
		
		int numberOfGoldBadges = userService.getNumberOfBadgesByUsernameAndColor(username, "gold");
		model.addAttribute("numberOfGoldBadges", numberOfGoldBadges);
		
		int numberOfSilverBadges = userService.getNumberOfBadgesByUsernameAndColor(username, "silver");
		model.addAttribute("numberOfSilverBadges", numberOfSilverBadges);
		
		int numberOfBronzeBadges = userService.getNumberOfBadgesByUsernameAndColor(username, "bronze");
		model.addAttribute("numberOfBronzeBadges", numberOfBronzeBadges);
		
		List<UserBadgeModel> allBadges = userService.getAllBadges();
		model.addAttribute("allBadges", allBadges);
		
		List<UserBadgeModel> bronzeBadges = userService.getAllBadgesByColor("bronze");
		model.addAttribute("bronzeBadges", bronzeBadges);
		
		List<UserBadgeModel> silverBadges = userService.getAllBadgesByColor("silver");
		model.addAttribute("silverBadges", silverBadges);
		
		List<UserBadgeModel> goldBadges = userService.getAllBadgesByColor("gold");
		model.addAttribute("goldBadges", goldBadges);
		
		List<UserBadgeModel> badges = userService.getUserBadgesByUsername(username);
		model.addAttribute("badges", badges);
		
		int badgesSize = badges.size();
		if( badgesSize > 0 ) { model.addAttribute("lastBadge", badges.get(badgesSize-1) ); }
		
		UserAccountInfoModel userAccountInfo = userService.getUserAccountInfo(username);
		model.addAttribute("userAccountInfo", userAccountInfo);
		model.addAttribute("userRaking", userService.getRankingOfUser( username ));
		
		int countOfGivenlikes = userService.getCountOfGivenLikesByUsername(username);
		model.addAttribute("countOfGivenlikes", countOfGivenlikes);
		
		int countOfReceivedLikes = userService.getCountOfReceivedLikesByUsername(username);
		model.addAttribute("countOfReceivedLikes", countOfReceivedLikes*10);
		
		int countOfComments = userService.getCountOfCommentsByUsername(username);
		model.addAttribute("countOfComments", countOfComments*2);
		
		return "userAllBadges";
	}
}
