package com.olas.filmsinfoservice.user;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.olas.filmsinfoservice.exception.EmailExistsException;
import com.olas.filmsinfoservice.exception.UserIsAlreadyEnabledException;
import com.olas.filmsinfoservice.exception.UserNotRegisteredException;
import com.olas.filmsinfoservice.exception.UsernameExistsException;

@Service
public class UserService 
{
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private UserRepository userRepository;
	
	public void registerNewUser(UserModel userModel, ConfirmToken confirmToken) throws EmailExistsException, UsernameExistsException
	{
		if( checkIfUsernameExists(userModel.getUsername()) )
		{
			throw new UsernameExistsException(userModel.getUsername());
		}
		if( checkIfEmailExists(userModel.getEmail()) )
		{
			throw new EmailExistsException(userModel.getEmail());
		}
		userModel.setPassword( passwordEncoder.encode(userModel.getPassword()) );
		userModel.setEnabled(false);
		userRepository.registerNewUser(userModel);
		userRepository.registerConfirmationToken(confirmToken);
	}
	
	public void sendRegisterConfirmationEmail(UserModel userModel, String appUrl, String token)
	{
		String subject = "Registration Confirm";
		String textToLink = "http://localhost:8080"+appUrl+"/registrationConfirm?token="+token+"&user="+userModel.getUsername();
		String confirmationUrl = "<a href=" + textToLink + ">Activate Account</a>";
		String message = "Confirm registered Account. There is a link: ";
		
		final String fromEmail = "moviesinfoservice@gmail.com";
		final String password = "moviesinfo123";
		final String emailTo = userModel.getEmail();
		
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
		props.put("mail.smtp.port", "587"); //TLS Port
		props.put("mail.smtp.auth", "true"); //enable authentication
		props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS
		
		Authenticator auth = new Authenticator() 
		{
			protected PasswordAuthentication getPasswordAuthentication() //override the getPasswordAuthentication method
			{
				return new PasswordAuthentication(fromEmail, password);
			}
		};
		Session session = Session.getInstance(props, auth);
		MimeMessage msg = new MimeMessage(session);
		try{
			msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
			msg.addHeader("format", "flowed");
			msg.addHeader("Content-Transfer-Encoding", "8bit");
			msg.setFrom(new InternetAddress("moviesinfoservice@gmail.com", "MoviesInfoService"));
			msg.setReplyTo(InternetAddress.parse("moviesinfoservice@gmail.com", false));
			msg.setSubject(subject, "UTF-8");
			msg.setContent(message + confirmationUrl, "text/html; charset=utf-8");
			msg.setSentDate(new Date());
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailTo, false));
			System.out.println("Message is ready");
			Transport.send(msg);
			System.out.println("email sent");
	    }catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void sendChangePasswordEmail(UserModel userModel, String appUrl, String token)
	{
		String subject = "Change password Confirm";
		String textToLink = "http://localhost:8080"+appUrl+"/changePasswordConfirm?token="+token+"&user="+userModel.getUsername();
		String confirmationUrl = "<a href=" + textToLink + ">Change password</a>";
		String message = "Confirm changing password. There is a link: ";
		
		final String fromEmail = "moviesinfoservice@gmail.com";
		final String password = "moviesinfo123";
		final String emailTo = userModel.getEmail();
		
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
		props.put("mail.smtp.port", "587"); //TLS Port
		props.put("mail.smtp.auth", "true"); //enable authentication
		props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS
		
		Authenticator auth = new Authenticator() 
		{
			protected PasswordAuthentication getPasswordAuthentication() //override the getPasswordAuthentication method
			{
				return new PasswordAuthentication(fromEmail, password);
			}
		};
		Session session = Session.getInstance(props, auth);
		MimeMessage msg = new MimeMessage(session);
		try{
			msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
			msg.addHeader("format", "flowed");
			msg.addHeader("Content-Transfer-Encoding", "8bit");
			msg.setFrom(new InternetAddress("moviesinfoservice@gmail.com", "MoviesInfoService"));
			msg.setReplyTo(InternetAddress.parse("moviesinfoservice@gmail.com", false));
			msg.setSubject(subject, "UTF-8");
			msg.setContent(message + confirmationUrl, "text/html; charset=utf-8");
			msg.setSentDate(new Date());
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailTo, false));
			System.out.println("Message is ready");
			Transport.send(msg);
			System.out.println("email sent");
	    }catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String sendPasswordEmail(String email, String appUrl) throws UserNotRegisteredException
	{
		UserModel userModel = this.getUserByEmail(email);
		if( userModel == null )
		{
			throw new UserNotRegisteredException(email);
		}
		ConfirmToken confirmToken = createNewConfirmToken(userModel.getUsername());
		userRepository.registerConfirmationToken(confirmToken);
		this.sendChangePasswordEmail(userModel, appUrl, confirmToken.getToken());
		return "redirect:/forgotPassword?emailSent";
	}
	
	public UserModel getUserByUsername(String username)
	{
		return userRepository.getUserByUsername(username);
	}
	
	public UserModel getUserByEmail(String email)
	{
		return userRepository.getUserByEmail(email);
	}
	
	public List<String> getUserRolesByUsername(String username)
	{
		return userRepository.getUserRolesByUsername(username);
	}
	
	public List<UserRatingModel> getUserRatingsByUsername(String username, int page)
	{
		return userRepository.getUserRatingsByUsername(username, page*10);
	}
	
	public Integer getNumberOfBadgesByUsername(String username)
	{
		return userRepository.getNumberOfBadgesByUsername(username);
	}
	
	public Integer getNumberOfBadgesByUsernameAndColor(String username, String color)
	{
		return userRepository.getNumberOfBadgesByUsernameAndColor(username, color);
	}
	
	public Integer getNumberOfRatingsByUsername(String username)
	{
		return userRepository.getNumberOfRatingsByUsername(username);
	}
	
	public List<String> getUserFriendsByUsernameAndPage(String username, int page)
	{
		return userRepository.getUserFriendsByUsernameAndPage(username, page*10);
	}
	
	public List<String> getUserFriendsByUsername(String username)
	{
		return userRepository.getUserFriendsByUsername(username);
	}
	
	public Integer getNumberOfFriendsByUsername(String username)
	{
		return userRepository.getNumberOfFriendsByUsername(username);
	}
	
	public Integer getNumberOfNewNotificationsByUsername(String username)
	{
		return userRepository.getNumberOfNewNotificationsByUsername(username);
	}
	
	public Integer getNumberOfNewNotificationsByUsernameUpdate(String username)
	{
		return userRepository.getNumberOfNewNotificationsByUsernameUpdate(username);
	}
	
	public List<UserNotificationModel> getUserNotificationsByUsername(String username, int page)
	{
		return userRepository.getUserNotificationsByUsername(username, page*10);
	}
	
	public List<UserNotificationModel> getUserFriendsActivityByUsername(String username, String userFriends, int page)
	{
		return userRepository.getUserFriendsActivityByUsername(username, userFriends, page*10);
	}
	
	public UserInfoModel getUserInfoByUsername(String username)
	{
		return userRepository.getUserInfoByUsername(username);
	}
	
	public List<String> getUsernamesOfAdmins()
	{
		return userRepository.getUsernamesOfAdmins();
	}
	
	public List<String> getUsernamesOfHosts()
	{
		return userRepository.getUsernamesOfHosts();
	}
	
	public List<UserAccountInfoModel> getBestUsers()
	{
		return userRepository.getBestUsers();
	}
	
	public List<UserBadgeModel> getAllBadges()
	{
		return userRepository.getAllBadges();
	}
	
	public List<UserBadgeModel> getAllBadgesByColor(String color)
	{
		return userRepository.getAllBadgesByColor(color);
	}
	
	public List<UserBadgeModel> getUserBadgesByUsername(String username)
	{
		return userRepository.getUserBadgesByUsername(username);
	}
	
	public List<UserBadgeModel> getUserBadgesByUsernameAndColor(String username, String color)
	{
		return userRepository.getUserBadgesByUsernameAndColor(username, color);
	}
	
	public List<UserBadgeModel> getUserBadgesByUsernameAndColorWithLimit(String username, String color, int limit)
	{
		return userRepository.getUserBadgesByUsernameAndColorWithLimit(username, color, limit);
	}
	
	public List<UserBadgeModel> getUserBadgesByTitle(String title)
	{
		return userRepository.getUserBadgesByTitle(title);
	}
	
	public int getCountOfGivenLikesByUsername(String username)
	{
		return userRepository.getCountOfGivenLikesByUsername(username);
	}
	
	public int getCountOfReceivedLikesByUsername(String username)
	{
		return userRepository.getCountOfReceivedLikesByUsername(username);
	}
	
	public int getCountOfCommentsByUsername(String username)
	{
		return userRepository.getCountOfCommentsByUsername(username);
	}
	
	public UserAccountInfoModel getUserAccountInfo(String username)
	{
		return userRepository.getUserAccountInfo(username);
	}
	
	public int getRankingOfUser(String username)
	{
		return userRepository.getRankingOfUser(username);
	}
	
	public int getRatingsLastPage(String username)
	{
		int num = userRepository.getRatingsLastPage(username);
		return this.countLastPage(num);
	}
	
	public int getFriendsLastPage(String username)
	{
		int num = userRepository.getFriendsLastPage(username);
		return this.countLastPage(num);
	}
	
	public int getNotificationsLastPage(String username)
	{
		int num = userRepository.getNotificationsLastPage(username);
		return this.countLastPage(num);
	}
	
	public int getActivityLastPage(String username, String userFriends)
	{
		int num = userRepository.getActivityLastPage(username, userFriends);
		return this.countLastPage(num);
	}
	
	public void setNewNotificationsCounterToZero(String username)
	{
		userRepository.setNewNotificationsCounterToZero(username);
	}
	
	public void setNewNotificationsToSeenNotifications(String username, int page)
	{
		userRepository.setNewNotificationsToSeenNotifications(username, page);
	}
	
	public void setUserScore(String username, int givenLikes, int receivedLikes, int writtenComments, int numberOfRatings)
	{
		int score = numberOfRatings + givenLikes + (writtenComments*2) + (receivedLikes * 10);
		userRepository.setUserScore(username, score);
	}
	
	public boolean checkIfUsernameExists(String username)
	{
		if( userRepository.findByUsername(username) != null )
		{
			if( userRepository.findByUsername(username).length() >= 1 )
			{
				return true; // true == exists
			}
		}
		return false;
	}
	
	public boolean checkIfEmailExists(String email)
	{
		if( userRepository.findByEmail(email) != null )
		{
			if( userRepository.findByEmail(email).length() >= 1 )
			{
				return true;
			}
		}
		return false;
	}
	
	public String changeUserPassword(String username, String password)
	{
		if(password.length() >= 1 && password.length() <= 20)
		{
			userRepository.changeUserPassword(username, passwordEncoder.encode(password));
			return "redirect:/login?passwordChanged";
		}
		return "redirect:/login?PasswordNotChanged";
	}
	
	public String changePasswordForLoggedUser(String username, String oldPassword, String newPassword) throws UserNotRegisteredException
	{
		UserModel userModel = this.getUserByUsername(username);
		if( userModel == null )
		{
			throw new UserNotRegisteredException(username);
		}
		
		if( passwordEncoder.matches(oldPassword, userModel.getPassword()) )
		{
			if(newPassword.length() >= 1 && newPassword.length() <= 20)
			{
				userRepository.changeUserPassword(username, passwordEncoder.encode(newPassword));
				return "redirect:/user/"+username+"/changePassword?passwordChanged";
			}
			else 
			{
				return "redirect:/user/"+username+"/changePassword?error";
			}
		}
		else
		{
			return "redirect:/user/"+username+"/changePassword?passwordDoesntMatch";
		}
	}
	
	public String banUser(String username)
	{
		if(username.equals("olas"))
		{
			return "redirect:/hostPanel?changeOlas";
		}
		UserModel userModel = this.getUserByUsername(username);
		if( userModel == null )
		{
			return "redirect:/hostPanel?cantBan";
		}
		List<String> roles = this.getUserRolesByUsername(username);
		if( roles.size() == 0 )
		{
			return "redirect:/hostPanel?alreadyBanned";
		}
		userRepository.banUser(username);
		return "redirect:/hostPanel?banned";
	}
	
	public String unbanUser(String username, String loggedUsername)
	{
		if(username.equals("olas"))
		{
			return "redirect:/hostPanel?changeOlas";
		}
		UserModel userModel = this.getUserByUsername(username);
		if( userModel == null )
		{
			return "redirect:/hostPanel?cantUnban";
		}
		List<String> roles = this.getUserRolesByUsername(username);
		if( roles.size() == 0 )
		{
			int currentNumberOfNotifications = userRepository.getNumberOfNewNotificationsByUsername(username);
			userRepository.unbanUser(username, loggedUsername, currentNumberOfNotifications);
			return "redirect:/hostPanel?unbanned";
		}
		return "redirect:/hostPanel?alreadyUnbanned";
	}
	
	public String takeAdmin(String username)
	{
		if(username.equals("olas"))
		{
			return "redirect:/hostPanel?changeOlas";
		}
		UserModel userModel = this.getUserByUsername(username);
		if( userModel == null )
		{
			return "redirect:/hostPanel?cantTakeAdmin";
		}
		List<String> roles = this.getUserRolesByUsername(username);
		if( roles.size() == 2 )
		{
			userRepository.takeAdmin(username);
			return "redirect:/hostPanel?adminTaken";	
		}
		else if( roles.size() == 3 )
		{
			return "redirect:/hostPanel?userIsHost";	
		}
		return "redirect:/hostPanel?noAdminRole";
	}
	
	public String giveAdmin(String username, String loggedUsername)
	{
		if(username.equals("olas"))
		{
			return "redirect:/hostPanel?changeOlas";
		}
		UserModel userModel = this.getUserByUsername(username);
		if( userModel == null )
		{
			return "redirect:/hostPanel?cantGiveAdmin";
		}
		List<String> roles = this.getUserRolesByUsername(username);
		if( roles.size() == 1 )
		{
			int currentNumberOfNotifications = userRepository.getNumberOfNewNotificationsByUsername(username);
			userRepository.giveAdmin(username, loggedUsername, currentNumberOfNotifications);
			return "redirect:/hostPanel?adminGiven";	
		}
		else if( roles.size() == 2 || roles.size() == 3 )
		{
			return "redirect:/hostPanel?alreadyAdmin";	
		}
		return "redirect:/hostPanel?wrongAdminRoles";
	}
	
	public String takeHost(String username)
	{
		if(username.equals("olas"))
		{
			return "redirect:/hostPanel?changeOlas";
		}
		UserModel userModel = this.getUserByUsername(username);
		if( userModel == null )
		{
			return "redirect:/hostPanel?cantTakeHost";
		}
		List<String> roles = this.getUserRolesByUsername(username);
		if( roles.size() == 3 )
		{
			userRepository.takeHost(username);
			return "redirect:/hostPanel?hostTaken";	
		}
		return "redirect:/hostPanel?userIsNotHost";
	}
	
	public String giveHost(String username, String loggedUsername)
	{
		if(username.equals("olas"))
		{
			return "redirect:/hostPanel?changeOlas";
		}
		UserModel userModel = this.getUserByUsername(username);
		if( userModel == null )
		{
			return "redirect:/hostPanel?cantGiveHost";
		}
		List<String> roles = this.getUserRolesByUsername(username);
		if( roles.size() == 2 )
		{
			int currentNumberOfNotifications = userRepository.getNumberOfNewNotificationsByUsername(username);
			userRepository.giveHost(username, loggedUsername, currentNumberOfNotifications);
			return "redirect:/hostPanel?hostGiven";	
		}
		else if( roles.size() == 3 )
		{
			return "redirect:/hostPanel?alreadyHost";	
		}
		return "redirect:/hostPanel?wrongHostRoles";
	}
	
	public void saveAboutMe(String username, String aboutMe)
	{
		userRepository.saveAboutMe(username, aboutMe);
	}
	
	public void saveFavMovies(String username, String favMovies)
	{
		userRepository.saveFavMovies(username, favMovies);
	}
	
	public void saveAge(String username, String age)
	{
		userRepository.saveAge(username, age);
	}
	
	public void saveDescription(String username, String description)
	{
		userRepository.saveDescription(username, description);
	}
	
	public void saveName(String username, String name)
	{
		userRepository.saveName(username, name);
	}
	
	public void addFriend(String loggedUsername, String username)
	{
		int currentNumberOfNotifications = userRepository.getNumberOfNewNotificationsByUsername(username);
		userRepository.addFriend(loggedUsername, username, currentNumberOfNotifications);
	}
	
	public void addProfileView(String username)
	{
		userRepository.addProfileView(username);
	}
	
	public void updateLastSeen(String username)
	{
		userRepository.updateLastSeen(username);
	}
	
	public void addProfileViewsBadgeIfPossible(int profileViews, String username)
	{
		userRepository.addProfileViewsBadgeIfPossible(profileViews, username);
	}
	
	public void addProfileInfoBadgeIfPossible(String username)
	{
		userRepository.addProfileInfoBadgeIfPossible(username);
	}
	
	public void addMovieRatingBadgeIfPossible(String username, int numberOfRatings)
	{
		userRepository.addMovieRatingBadgeIfPossible(username, numberOfRatings);
	}
	
	public void addMovieCommentBadgeIfPossible(String username, int numberOfComments)
	{
		userRepository.addMovieCommentBadgeIfPossible(username, numberOfComments);
	}
	
	public void addGivenLikesBadgeIfPossible(String username, int givenLikes)
	{
		userRepository.addGivenLikesBadgeIfPossible(username, givenLikes);
	}
	
	public void addUserPointsBadgeIfPossible(String username, int points)
	{
		userRepository.addUserPointsBadgeIfPossible(username, points);
	}
	
	public boolean isUserMyFriend(String loggedUsername, String username)
	{
		return userRepository.isUserMyFriend(loggedUsername, username);
	}
	
	public void deleteFriend(String loggedUsername, String username)
	{
		userRepository.deleteFriend(loggedUsername, username);
	}
	
	public int countLastPage(int toCount)
	{
		toCount = (int) Math.ceil((double)toCount/(double)10);
		return toCount;
	}
	
	// ---------------------------- CONFIRMATION TOKEN ---------------------------- \\
	public ConfirmToken createNewConfirmToken(String username)
	{
		String token = UUID.randomUUID().toString();
		
		Calendar cal = Calendar.getInstance();
		cal.setTimeInMillis( new Date().getTime() );
        cal.add(Calendar.MINUTE, 60*24);
        Date expiryDate = new Date( cal.getTimeInMillis() );
        
		long expiryTime = expiryDate.getTime();
		
		return new ConfirmToken(username, token, expiryTime);
	}
	
	public void registerConfirmationToken(ConfirmToken confirmToken)
	{
		userRepository.registerConfirmationToken(confirmToken);
	}
	
	public void deleteConfirmToken(String username, String token)
	{
		userRepository.deleteConfirmToken(username, token);
	}
	
	public ConfirmToken getConfirmTokenByUsername(String username, String token)
	{
		return userRepository.getConfirmTokenByUsername(username, token);
		
	}
	
	public String activateAccount(String username, String token)
	{
		ConfirmToken confirmToken = getConfirmTokenByUsername(username, token);
		if( confirmToken == null )
		{
			return "redirect:/login?tokenDoesntExists";
		}
		if( confirmToken.getExpiryTime() - new Date().getTime() <= 0 )
		{
			deleteConfirmToken(username, token);
			return "redirect:/login?tokenExpired&username="+username;
		}
		userRepository.activateAccount(username);
		deleteConfirmToken(username, token);
		return "redirect:/login?activated";
	}
	
	public String resendConfirmationEmail(String username, String appUrl)
			throws UserNotRegisteredException, UserIsAlreadyEnabledException
	{
		UserModel userModel = this.getUserByUsername(username);
		if( userModel == null )
		{
			throw new UserNotRegisteredException(username);
		}
		if( userModel.isEnabled() == true )
		{
			throw new UserIsAlreadyEnabledException(username);
		}
		ConfirmToken confirmToken = this.createNewConfirmToken(username);
		this.registerConfirmationToken(confirmToken);
		this.sendRegisterConfirmationEmail(userModel, appUrl, confirmToken.getToken());
		return "redirect:/login";
	}
	
	public String checkIfTokenExists(String username, String token)
	{
		ConfirmToken confirmToken = getConfirmTokenByUsername(username, token);
		if( confirmToken == null )
		{
			return "redirect:/forgotPassword?tokenDoesntExists";
		}
		if( confirmToken.getExpiryTime() - new Date().getTime() <= 0 )
		{
			deleteConfirmToken(username, token);
			return "redirect:/forgotPassword?tokenExpired";
		}
		deleteConfirmToken(username, token);
		return "takePassword";
	}
	
	public String convertTimeToUserNotificationDate(String time)
	{
		long timeAgo = 0;
		try {
			Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    Date parsedDate = dateFormat.parse(time);
		    Timestamp timeFromDB = new Timestamp(parsedDate.getTime());
		    timeAgo = currentTime.getTime() - timeFromDB.getTime();
		} catch(Exception e) {}
		
		long weeks = timeAgo/604800000;
		long days = timeAgo/86400000;
		long hours = timeAgo/3600000;
		long minutes = timeAgo/60000;
		long seconds = timeAgo/1000;
		
		if( weeks > 0) // 7days
		{
			if( weeks == 1 ){ return weeks + " week ago"; }
			return weeks + " weeks ago";
		}else if( days > 0 ) // 24hours
		{
			if( days == 1 ){ return days + " day ago"; }
			return days + " days ago";
		}else if( hours > 0 ) // 1 hour
		{
			if( hours == 1 ){ return hours + " hour ago"; }
			return hours + " hours ago";
		}else if( minutes > 0 ) // 1 minute
		{
			if( minutes == 1 ){ return minutes + " minute ago"; }
			return minutes + " minutes ago";
		}else if( seconds > 0 ) // 1 second
		{
			if( seconds == 1 ){ return seconds + " second ago"; }
			return seconds + " seconds ago";
		}
	    return "Now";
	}
	
	public String convertTimeToUserMembershipTime(String time)
	{
		long timeAgo = 0;
		try {
			Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    Date parsedDate = dateFormat.parse(time);
		    Timestamp timeFromDB = new Timestamp(parsedDate.getTime());
		    timeAgo = currentTime.getTime() - timeFromDB.getTime();
		} catch(Exception e) {}
		
		long weeks = timeAgo/604800000;
		long days = timeAgo/86400000;
		long hours = timeAgo/3600000;
		long minutes = timeAgo/60000;
		long seconds = timeAgo/1000;
		
		int months = (int)weeks/4;
		int monthWeeks = (int)weeks%4;
		
		if( months > 0 )
		{
			if( months == 1 )
			{
				if( monthWeeks == 1 ){ return "1 month, 1 week"; }
				else if( monthWeeks == 0 ){ return "1 month"; }
				return "1 month, " + monthWeeks + " weeks";
			}
			if( monthWeeks == 1 ){ return months + " months, 1 week"; }
			if( monthWeeks == 0 ){ return months + " months"; }
			return months + " months, " + monthWeeks + " weeks";
		}
		else if( weeks > 0) // 7days
		{
			if( weeks == 1 ){ return weeks + " week"; }
			return weeks + " weeks";
		}else if( days > 0 ) // 24hours
		{
			if( days == 1 ){ return days + " day"; }
			return days + " days";
		}else if( hours > 0 ) // 1 hour
		{
			if( hours == 1 ){ return hours + " hour"; }
			return hours + " hours";
		}else if( minutes > 0 ) // 1 minute
		{
			if( minutes == 1 ){ return minutes + " minute"; }
			return minutes + " minutes";
		}else if( seconds > 0 ) // 1 second
		{
			if( seconds == 1 ){ return "1 second"; }
			return seconds + " seconds";
		}
	    return "1 second";
	}
	
	public String convertTimeToLastSeenTime(String time)
	{
		long timeAgo = 0;
		try {
			Timestamp currentTime = new Timestamp(System.currentTimeMillis());
		    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		    Date parsedDate = dateFormat.parse(time);
		    Timestamp timeFromDB = new Timestamp(parsedDate.getTime());
		    timeAgo = currentTime.getTime() - timeFromDB.getTime();
		} catch(Exception e) {}
		
		long hours = timeAgo/3600000;
		long minutes = timeAgo/60000;
		
		if( hours > 23 )
		{
			int day = Integer.parseInt(time.substring(8, 10));
			int monthNum = Integer.parseInt(time.substring(5, 7));
			int year = Integer.parseInt(time.substring(0, 4));
			String month = new String();
			if(monthNum==1) 	 { month = "Jan";  } else if(monthNum==2) { month = "Feb"; }
			else if(monthNum==3) { month = "Mar";    } else if(monthNum==4) { month = "Apr"; }
			else if(monthNum==5) { month = "May";      } else if(monthNum==6) { month = "Jun"; }
			else if(monthNum==7) { month = "Jul";     } else if(monthNum==8) { month = "Aug"; }
			else if(monthNum==9) { month = "Sep";} else if(monthNum==10) { month = "Oct"; }
			else if(monthNum==11){ month = "Nov"; } else if(monthNum==12) { month = "Dec"; }
			
			if( hours >= 24 && hours <= 47 ) { return "Last seen yesterday, at " + time.substring(11,16); }
			return "Last seen " + day + " " + month + " " + year + ", at " + time.substring(11,16);
		}else if( hours > 0 ) // 60 minutes
		{
			if( hours == 1 ){ return "Last seen " + hours + " hour ago"; }
			return "Last seen " + hours + " hours ago";
		}else if( minutes > 0 ) // 60 seconds
		{
			if( minutes == 1 ){ return "Last seen " + minutes + " minute ago"; }
			return "Last seen " + minutes + " minutes ago";
		}
	    return "Active now";
	}
}
