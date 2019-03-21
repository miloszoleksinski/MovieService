package com.olas.filmsinfoservice.user;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class UserRepository 
{
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public void registerNewUser(UserModel userModel)
	{
		String registerNewUser = "INSERT INTO user VALUE('"+userModel.getUsername()+"','"+userModel.getEmail()+"','"+userModel.getPassword()+"','"+userModel.isEnabled()+"')";
		String addRoleUSER = "INSERT INTO user_role VALUE(null,'"+userModel.getUsername()+"','ROLE_USER')";
		String createNotificationsCounter = "INSERT INTO user_notification_counter VALUE ('"+userModel.getUsername()+"',0)";
		String registerAccountInfo = "INSERT INTO user_account_info VALUE('"+userModel.getUsername()+"',NOW(),0,NOW())";
		
		jdbcTemplate.update(registerNewUser);
		jdbcTemplate.update(addRoleUSER);
		jdbcTemplate.update(createNotificationsCounter);
		jdbcTemplate.update(registerAccountInfo);
	}
	
	public void changeUserPassword(String username, String password)
	{
		String changeUserPassword = "UPDATE user SET password='"+password+"' WHERE username='"+username+"'";
		jdbcTemplate.update(changeUserPassword);
	}
	
	public UserModel getUserByUsername(String username)
	{
		String selectUserByUsername = "SELECT * FROM user WHERE username='"+username+"'";
		UserModel userModel = null;
		try { userModel = jdbcTemplate.queryForObject(selectUserByUsername, new UserRowMapper()); }
		catch(DataAccessException e) { return null; }
		return userModel;
	}
	
	public UserModel getUserByEmail(String email)
	{
		String selectUserByUsername = "SELECT * FROM user WHERE email='"+email+"'";
		UserModel userModel = null;
		try { userModel = jdbcTemplate.queryForObject(selectUserByUsername, new UserRowMapper()); }
		catch(DataAccessException e) { return null; }
		return userModel;
	}
	
	public List<String> getUserRolesByUsername(String username)
	{
		String selectRolesByUsername = "SELECT user_role FROM user_role WHERE username='"+username+"'";
		List<String> roles = jdbcTemplate.query(selectRolesByUsername, new UserColumnRowMapper());
		return roles;
	}
	
	public List<UserRatingModel> getUserRatingsByUsername(String username, int page)
	{
		String selectRatingsByUsername = "SELECT movie_id, rate, time FROM movie_rating WHERE person_id='"+username+"' ORDER BY row_id DESC LIMIT "+page+", 10";
		List<UserRatingModel> ratings = jdbcTemplate.query(selectRatingsByUsername, new UserRatingsRowMapper());
		return ratings;
	}
	
	public Integer getNumberOfBadgesByUsername(String username)
	{
		String selectNumberOfBadgesByUsername = "SELECT COUNT(*) FROM user_badges WHERE username='"+username+"'";
		String numberOfBadges = jdbcTemplate.queryForObject(selectNumberOfBadgesByUsername, String.class);
		return Integer.parseInt(numberOfBadges);
	}
	
	public Integer getNumberOfBadgesByUsernameAndColor(String username, String color)
	{
		String selectNumberOfBadgesByUsernameAndColor = "SELECT COUNT(*) FROM user_badges WHERE username='"+username+"' AND badge_color='"+color+"'";
		String numberOfBadges = jdbcTemplate.queryForObject(selectNumberOfBadgesByUsernameAndColor, String.class);
		return Integer.parseInt(numberOfBadges);
	}
	
	public Integer getNumberOfRatingsByUsername(String username)
	{
		String selectNumberOfRatingsByUsername = "SELECT COUNT(*) FROM movie_rating WHERE person_id='"+username+"'";
		String numberOfRatings = jdbcTemplate.queryForObject(selectNumberOfRatingsByUsername, String.class);
		return Integer.parseInt(numberOfRatings);
	}
	
	public List<String> getUserFriendsByUsernameAndPage(String username, int page)
	{
		String selectFriendsByUsername = "SELECT user_friend FROM user_friend WHERE username='"+username+"' LIMIT "+page+", 10";
		List<String> friends = jdbcTemplate.query(selectFriendsByUsername, new UserColumnRowMapper());
		return friends;
	}
	
	public List<String> getUserFriendsByUsername(String username)
	{
		String selectFriendsByUsername = "SELECT user_friend FROM user_friend WHERE username='"+username+"'";
		List<String> friends = jdbcTemplate.query(selectFriendsByUsername, new UserColumnRowMapper());
		return friends;
	}
	
	public Integer getNumberOfFriendsByUsername(String username)
	{
		String selectFriendsByUsername = "SELECT COUNT(*) FROM user_friend WHERE username='"+username+"'";
		String numberOfFriends = jdbcTemplate.queryForObject(selectFriendsByUsername, String.class);
		return Integer.parseInt(numberOfFriends);
	}
	
	public Integer getNumberOfNewNotificationsByUsername(String username)
	{
		String selectFriendsByUsername = "SELECT notifications_number FROM user_notification_counter WHERE username='"+username+"'";
		try {
			String numberOfFriends = jdbcTemplate.queryForObject(selectFriendsByUsername, String.class);
			return Integer.parseInt(numberOfFriends);
		}catch(DataAccessException ex) { return 0; }
	}
	
	public Integer getNumberOfNewNotificationsByUsernameUpdate(String username)
	{
		String selectFriendsByUsername = "SELECT COUNT(*) FROM user_notification WHERE username='"+username+"' AND seen='new'";
		try {
			String numberOfFriends = jdbcTemplate.queryForObject(selectFriendsByUsername, String.class);
			return Integer.parseInt(numberOfFriends);
		}catch(DataAccessException ex) { return 0; }
	}
	
	public List<UserNotificationModel> getUserNotificationsByUsername(String username, int page)
	{
		String selectNotificationByUsername = "SELECT fromUser, movieID, notification, type, time, seen FROM user_notification WHERE username='"+username+"' AND fromUser!='"+username+"' ORDER BY row_id DESC LIMIT "+page+", 10";
		List<UserNotificationModel> notifications = jdbcTemplate.query(selectNotificationByUsername, new UserNotificationsRowMapper());
		return notifications;
	}
	
	public List<UserNotificationModel> getUserFriendsActivityByUsername(String username, String userFriends, int page)
	{
		String selectNotificationByUsername = "SELECT username, movieID, notification, rate, added_username, time FROM friends_activity WHERE "+userFriends+" ORDER BY row_id DESC LIMIT "+page+", 10";
		List<UserNotificationModel> notifications = jdbcTemplate.query(selectNotificationByUsername, new UserActivityRowMapper());
		return notifications;
	}
	
	public UserInfoModel getUserInfoByUsername(String username)
	{
		String selectUserInfoByUsername = "SELECT * FROM user_info WHERE username='"+username+"'";
		UserInfoModel userInfoModel = null;
		try { userInfoModel = jdbcTemplate.queryForObject(selectUserInfoByUsername, new UserInfoRowMapper()); }
		catch(DataAccessException e) { return null; }
		return userInfoModel;
	}
	
	public List<String> getUsernamesOfAdmins()
	{
		String selectAdmins = "SELECT username FROM user_role GROUP BY username HAVING COUNT(*)=2";
		List<String> admins = jdbcTemplate.query(selectAdmins, new UserColumnRowMapper());
		return admins;
	}
	
	public List<String> getUsernamesOfHosts()
	{
		String selectHosts = "SELECT username FROM user_role GROUP BY username HAVING COUNT(*)=3";
		List<String> hosts = jdbcTemplate.query(selectHosts, new UserColumnRowMapper());
		return hosts;
	}
	
	public List<UserAccountInfoModel> getBestUsers()
	{
		String selectBestUsers = "SELECT * FROM user_account_info ORDER BY score DESC LIMIT 100";
		List<UserAccountInfoModel> bestUsers =  jdbcTemplate.query(selectBestUsers, new UserAccountInfoRowMapper());
		return bestUsers;
	}
	public List<UserBadgeModel> getAllBadges()
	{
		String selectUserBadges = "SELECT * FROM all_badges";
		List<UserBadgeModel> userBadges = jdbcTemplate.query(selectUserBadges, new UserBadgesRowMapper());
		return userBadges;
	}
	
	public List<UserBadgeModel> getAllBadgesByColor(String color)
	{
		String selectUserBadges = "SELECT * FROM all_badges WHERE badge_color='"+color+"'";
		List<UserBadgeModel> userBadges = jdbcTemplate.query(selectUserBadges, new UserBadgesRowMapper());
		return userBadges;
	}
	
	public List<UserBadgeModel> getUserBadgesByUsername(String username)
	{
		String selectUserBadges = "SELECT * FROM user_badges WHERE username='"+username+"'";
		List<UserBadgeModel> userBadges = jdbcTemplate.query(selectUserBadges, new UserBadgesRowMapper());
		return userBadges;
	}
	
	public List<UserBadgeModel> getUserBadgesByUsernameAndColor(String username, String color)
	{
		String selectUserBadges = "SELECT * FROM user_badges WHERE username='"+username+"' AND badge_color='"+color+"'";
		List<UserBadgeModel> userBadges = jdbcTemplate.query(selectUserBadges, new UserBadgesRowMapper());
		return userBadges;
	}
	
	public List<UserBadgeModel> getUserBadgesByUsernameAndColorWithLimit(String username, String color, int limit)
	{
		String selectUserBadges = "SELECT * FROM user_badges WHERE username='"+username+"' AND badge_color='"+color+"' LIMIT " + limit;
		List<UserBadgeModel> userBadges = jdbcTemplate.query(selectUserBadges, new UserBadgesRowMapper());
		return userBadges;
	}
	
	public List<UserBadgeModel> getUserBadgesByTitle(String title)
	{
		String selectUserBadges = "SELECT * FROM all_badges WHERE badge_title LIKE '%"+title+"%' OR badge_info LIKE '%"+title+"%'";
		List<UserBadgeModel> userBadges = jdbcTemplate.query(selectUserBadges, new UserBadgesRowMapper());
		return userBadges;
	}
	
	public int getCountOfGivenLikesByUsername(String username)
	{
		String selectCountOfGivenLikes = "SELECT COUNT(*) FROM comment_likes WHERE user_liked='"+username+"'";
		String countGivenLikes = "";
		try { countGivenLikes = jdbcTemplate.queryForObject(selectCountOfGivenLikes, String.class);}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countGivenLikes );
	}
	
	public int getCountOfReceivedLikesByUsername(String username)
	{
		String selectCountOfGivenLikes = "SELECT COUNT(*) FROM comment_likes WHERE comment_of_user='"+username+"'";
		String countReceivedLikes = "";
		try { countReceivedLikes = jdbcTemplate.queryForObject(selectCountOfGivenLikes, String.class);}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countReceivedLikes );
	}
	
	public int getCountOfCommentsByUsername(String username)
	{
		String selectCountOfComments = "SELECT COUNT(*) FROM movie_comment WHERE username='"+username+"'";
		String countComments = "";
		try { countComments = jdbcTemplate.queryForObject(selectCountOfComments, String.class);}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countComments );
	}
	
	public UserAccountInfoModel getUserAccountInfo(String username)
	{
		String selectUserAccountInfo = "SELECT * from user_account_info WHERE username='"+username+"'";
		try { return jdbcTemplate.queryForObject(selectUserAccountInfo, new UserAccountInfoRowMapper());}
		catch(DataAccessException ex) { return null; }
	}
	
	public int getRankingOfUser(String username)
	{
		String selectRankingOfUser = "SELECT username FROM user_account_info ORDER BY score DESC";
		List<String> userRanking = jdbcTemplate.query(selectRankingOfUser, new UserColumnRowMapper());
		for(int i=0; i<userRanking.size(); i++)
		{
			if( userRanking.get(i).equals(username) )
			{
				return i+1;
			}
		}
		return 0;
	}
	
	public int getRatingsLastPage(String username)
	{
		String selectAllMovies = "SELECT COUNT(*) FROM movie_rating WHERE person_id='"+username+"'"; 
		String countMovies = "";
		try { countMovies = jdbcTemplate.queryForObject(selectAllMovies, String.class);}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countMovies );
	}
	
	public int getFriendsLastPage(String username)
	{
		String selectAllFriends = "SELECT COUNT(*) FROM user_friend WHERE username='"+username+"'"; 
		String countFriends = "";
		try { countFriends = jdbcTemplate.queryForObject(selectAllFriends, String.class);}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countFriends );
	}
	
	public int getNotificationsLastPage(String username)
	{
		String selectAllNotifications = "SELECT COUNT(*) FROM user_notification WHERE username='"+username+"'"; 
		String countNotifications = "";
		try { countNotifications = jdbcTemplate.queryForObject(selectAllNotifications, String.class);}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countNotifications );
	}
	
	public int getActivityLastPage(String username, String userFriends)
	{
		String selectAllNotifications = "SELECT COUNT(*) FROM friends_activity WHERE "+userFriends; 
		String countNotifications = "";
		try { countNotifications = jdbcTemplate.queryForObject(selectAllNotifications, String.class);}
		catch(DataAccessException ex) { return 0; }
		return Integer.parseInt( countNotifications );
	}
	
	public String findByUsername(String username)
	{
		String selectByUsername = "SELECT username FROM user WHERE username='"+username+"'";
		String dbUsername = "";
		try { dbUsername = jdbcTemplate.queryForObject(selectByUsername, String.class); }
		catch(DataAccessException e) { return null; }
		return dbUsername;
	}
	
	public String findByEmail(String email)
	{
		String selectByUsername = "SELECT email FROM user WHERE email='"+email+"'";
		String dbEmail = "";
		try { dbEmail = jdbcTemplate.queryForObject(selectByUsername, String.class); }
		catch(DataAccessException e) { return null; }		
		return dbEmail;
	}
	
	public void setNewNotificationsCounterToZero(String username)
	{
		String updateNotificationsCounter = "UPDATE user_notification_counter SET notifications_number=0 WHERE username='"+username+"'";
		jdbcTemplate.update( updateNotificationsCounter );
	}
	
	public void setNewNotificationsToSeenNotifications(String username, int page)
	{
		//String updateNotificationsCounter = "UPDATE user_notification SET seen='seen' WHERE username='"+username+"'";
		String updateNotificationsCounter = "UPDATE user_notification SET seen='seen' WHERE row_id IN "
				+ "(SELECT * FROM (SELECT row_id FROM user_notification WHERE username='"+username+"' "
				+ "ORDER BY row_id DESC LIMIT "+page+", 10) AS t)";
		jdbcTemplate.update( updateNotificationsCounter );
	}
	
	public void setUserScore(String username, int score)
	{
		String setUserScore = "UPDATE user_account_info SET score="+score+" WHERE username='"+username+"'";
		jdbcTemplate.update(setUserScore);
	}
	
	public void banUser(String username)
	{
		String deleteRolesFromUser = "DELETE FROM user_role WHERE username='"+username+"'";
		jdbcTemplate.update( deleteRolesFromUser );
	}
	
	public void unbanUser(String username, String loggedUsername, int currentNumberOfNotifications)
	{
		String addUserRoleToUnbanned = "INSERT INTO user_role VALUE(null,'"+username+"','ROLE_USER')";
		String addUnbanNotification = "INSERT INTO user_notification VALUE (null,'"+username+"','"+loggedUsername+"',null,'unbanned your account.','unban',NOW(),null,'new')";

		jdbcTemplate.update( addUserRoleToUnbanned );
		jdbcTemplate.update( addUnbanNotification );
		
		int newCounter = currentNumberOfNotifications + 1;
		String addOneToNotificationCounter = "UPDATE user_notification_counter SET notifications_number="+newCounter+" WHERE username='"+username+"'";
		jdbcTemplate.update( addOneToNotificationCounter );
	}
	
	public void takeAdmin(String username)
	{
		String deleteRolesFromUser = "DELETE FROM user_role WHERE username='"+username+"'";
		String insertUserRole = "INSERT INTO user_role VALUE(null,'"+username+"','ROLE_USER')";
		String deleteAdminNotification = "DELETE FROM user_notification WHERE username='"+username+"' AND type='admin'";
		jdbcTemplate.update( deleteRolesFromUser );
		jdbcTemplate.update( insertUserRole );
		jdbcTemplate.update( deleteAdminNotification );
		
		int newCounter = this.getNumberOfNewNotificationsByUsername(username)-1;
		if( newCounter >= 0 )
		{
			String decreaseByOneNotificationCounter = "UPDATE user_notification_counter SET notifications_number="+newCounter+" WHERE username='"+username+"'";
			jdbcTemplate.update( decreaseByOneNotificationCounter );
		}
	}
	
	public void giveAdmin(String username, String loggedUsername, int currentNumberOfNotifications)
	{
		String deleteRolesFromUser = "DELETE FROM user_role WHERE username='"+username+"'";
		String insertUserAndAdminRole = 
				"INSERT INTO user_role VALUES(null,'"+username+"','ROLE_USER'), (null,'"+username+"','ROLE_ADMIN')";
		String giveAdminNotification = "INSERT INTO user_notification VALUE (null,'"+username+"','"+loggedUsername+"',null,'gave you an admin privileges.','admin',NOW(),null,'new')";
		jdbcTemplate.update( deleteRolesFromUser );
		jdbcTemplate.update( insertUserAndAdminRole );
		jdbcTemplate.update( giveAdminNotification );
		
		int newCounter = currentNumberOfNotifications + 1;
		String addOneToNotificationCounter = "UPDATE user_notification_counter SET notifications_number="+newCounter+" WHERE username='"+username+"'";
		jdbcTemplate.update( addOneToNotificationCounter );
	}
	
	public void takeHost(String username)
	{
		String deleteRolesFromUser = "DELETE FROM user_role WHERE username='"+username+"'";
		String insertUserAndAdminRole = 
				"INSERT INTO user_role VALUES(null,'"+username+"','ROLE_USER'), (null,'"+username+"','ROLE_ADMIN')";
		String deleteAdminNotification = "DELETE FROM user_notification WHERE username='"+username+"' AND type='host'";
		jdbcTemplate.update( deleteRolesFromUser );
		jdbcTemplate.update( insertUserAndAdminRole );
		jdbcTemplate.update( deleteAdminNotification );
		
		int newCounter = this.getNumberOfNewNotificationsByUsername(username)-1;
		if( newCounter >= 0 )
		{
			String decreaseByOneNotificationCounter = "UPDATE user_notification_counter SET notifications_number="+newCounter+" WHERE username='"+username+"'";
			jdbcTemplate.update( decreaseByOneNotificationCounter );
		}
	}
	
	public void giveHost(String username, String loggedUsername, int currentNumberOfNotifications)
	{
		String deleteRolesFromUser = "DELETE FROM user_role WHERE username='"+username+"'";
		String insertUserAndAdminAndHostRole = 
				"INSERT INTO user_role VALUES"
				+ " (null,'"+username+"','ROLE_USER'),"
				+ " (null,'"+username+"','ROLE_ADMIN'),"
				+ " (null,'"+username+"','ROLE_HOST')";
		String giveAdminNotification = "INSERT INTO user_notification VALUE (null,'"+username+"','"+loggedUsername+"',null,'gave you an host privileges.','host',NOW(),null,'new')";
		jdbcTemplate.update( deleteRolesFromUser );
		jdbcTemplate.update( insertUserAndAdminAndHostRole );
		jdbcTemplate.update( giveAdminNotification );
		
		int newCounter = currentNumberOfNotifications + 1;
		String addOneToNotificationCounter = "UPDATE user_notification_counter SET notifications_number="+newCounter+" WHERE username='"+username+"'";
		jdbcTemplate.update( addOneToNotificationCounter );
	}
	
	public void saveAboutMe(String username, String aboutMe)
	{
		String checkIfAlreadyAdded = "SELECT COUNT(*) FROM user_info WHERE username='"+username+"'";
		String countResult = "";
		try { countResult = jdbcTemplate.queryForObject(checkIfAlreadyAdded, String.class);}
		catch(DataAccessException ex) { countResult = "0"; }
		if( Integer.parseInt(countResult) == 1 )
		{
			String updateAboutMe = "UPDATE user_info SET about_me='"+aboutMe+"' WHERE username='"+username+"'";
			jdbcTemplate.update(updateAboutMe);
		}
		else
		{
			String addAboutMe = "INSERT INTO user_info VALUE ('"+username+"',null,0,null,'"+aboutMe+",null')";
			jdbcTemplate.update(addAboutMe);
		}
	}
	
	public void saveFavMovies(String username, String favMovies)
	{
		String checkIfAlreadyAdded = "SELECT COUNT(*) FROM user_info WHERE username='"+username+"'";
		String countResult = "";
		try { countResult = jdbcTemplate.queryForObject(checkIfAlreadyAdded, String.class);}
		catch(DataAccessException ex) { countResult = "0"; }
		if( Integer.parseInt(countResult) == 1 )
		{
			String updateFavMovies = "UPDATE user_info SET favourite_movie='"+favMovies+"' WHERE username='"+username+"'";
			jdbcTemplate.update(updateFavMovies);
		}
		else
		{
			String addFavMovies = "INSERT INTO user_info VALUE ('"+username+"',null,0,'"+favMovies+"',null,null)";
			jdbcTemplate.update(addFavMovies);
		}
	}
	
	public void saveAge(String username, String age)
	{
		String checkIfAlreadyAdded = "SELECT COUNT(*) FROM user_info WHERE username='"+username+"'";
		String countResult = "";
		try { countResult = jdbcTemplate.queryForObject(checkIfAlreadyAdded, String.class);}
		catch(DataAccessException ex) { countResult = "0"; }
		if( Integer.parseInt(countResult) == 1 )
		{
			String updateAge = "UPDATE user_info SET age="+age+" WHERE username='"+username+"'";
			jdbcTemplate.update(updateAge);
		}
		else
		{
			String addAge = "INSERT INTO user_info VALUE ('"+username+"',null,"+age+",null,null,null)";
			jdbcTemplate.update(addAge);
		}
	}
	
	public void saveDescription(String username, String description)
	{
		String checkIfAlreadyAdded = "SELECT COUNT(*) FROM user_info WHERE username='"+username+"'";
		String countResult = "";
		try { countResult = jdbcTemplate.queryForObject(checkIfAlreadyAdded, String.class);}
		catch(DataAccessException ex) { countResult = "0"; }
		if( Integer.parseInt(countResult) == 1 )
		{
			String updateName = "UPDATE user_info SET description='"+description+"' WHERE username='"+username+"'";
			jdbcTemplate.update(updateName);
		}
		else
		{
			String addName = "INSERT INTO user_info VALUE ('"+username+"',null,0,null,null,'"+description+"')";
			jdbcTemplate.update(addName);
		}
	}
	
	public void saveName(String username, String name)
	{
		String checkIfAlreadyAdded = "SELECT COUNT(*) FROM user_info WHERE username='"+username+"'";
		String countResult = "";
		try { countResult = jdbcTemplate.queryForObject(checkIfAlreadyAdded, String.class);}
		catch(DataAccessException ex) { countResult = "0"; }
		if( Integer.parseInt(countResult) == 1 )
		{
			String updateName = "UPDATE user_info SET name='"+name+"' WHERE username='"+username+"'";
			jdbcTemplate.update(updateName);
		}
		else
		{
			String addName = "INSERT INTO user_info VALUE ('"+username+"','"+name+"',0,null,null,null)";
			jdbcTemplate.update(addName);
		}
	}
	
	public void addFriend(String loggedUsername, String username, int currentNumberOfNotifications)
	{
		String addToFriends = "INSERT INTO user_friend VALUE (null,'"+loggedUsername+"','"+username+"')";
		String addFriendNotification = "INSERT INTO user_notification VALUE (null,'"+username+"','"+loggedUsername+"',null,'added you to friends.','friend',NOW(),null,'new')";
		String addFriendActivity = "INSERT INTO friends_activity VALUE (null,'"+loggedUsername+"',null,'added "+username+" to friends.',0,'"+username+"',NOW(),null)";
		jdbcTemplate.update(addToFriends);
		jdbcTemplate.update(addFriendNotification);
		jdbcTemplate.update(addFriendActivity);
		
		int newCounter = currentNumberOfNotifications + 1;
		String addOneToNotificationCounter = "UPDATE user_notification_counter SET notifications_number="+newCounter+" WHERE username='"+username+"'";
		jdbcTemplate.update( addOneToNotificationCounter );
	}
	
	public void deleteFriend(String loggedUsername, String username)
	{
		String deleteFromFriends = "DELETE FROM user_friend WHERE username='"+loggedUsername+"' AND user_friend='"+username+"'";
		String deleteFriendNotification = "DELETE FROM user_notification WHERE username='"+username+"' AND fromUser='"+loggedUsername+"' AND type='friend'";
		String deleteFriendActivity = "DELETE FROM friends_activity WHERE username='"+loggedUsername+"' AND added_username='"+username+"'";
		jdbcTemplate.update(deleteFromFriends);
		jdbcTemplate.update(deleteFriendNotification);
		jdbcTemplate.update(deleteFriendActivity);
		
		int newCounter = this.getNumberOfNewNotificationsByUsername(username)-1;
		if( newCounter >= 0 )
		{
			String decreaseByOneNotificationCounter = "UPDATE user_notification_counter SET notifications_number="+newCounter+" WHERE username='"+username+"'";
			jdbcTemplate.update( decreaseByOneNotificationCounter );
		}
	}
	
	public void addProfileView(String username)
	{
		String addOneViewToProfile = "UPDATE user_account_info SET profile_views=profile_views+1 WHERE username='"+username+"'";
		jdbcTemplate.update(addOneViewToProfile);
	}
	
	public void updateLastSeen(String username)
	{
		String updateLastSeen = "UPDATE user_account_info SET last_seen=NOW() WHERE username='"+username+"'";
		jdbcTemplate.update(updateLastSeen);
	}
	
	public void addLikeBadgesIfPossible(String username, int likes, int commentID)
	{
		if( likes == 10 )
		{
			String isBronzeBadgeAlreadyAdded = "SELECT COUNT(*) FROM user_badges WHERE badge_color='bronze' AND comment_id="+commentID;
			if( jdbcTemplate.queryForObject(isBronzeBadgeAlreadyAdded, Integer.class) == 0 )
			{
				String addBronzeBadge = "INSERT INTO user_badges VALUE (null,"+commentID+",'"+username+"','bronze','Already 10 people liked your comment!','Good comment',null);";
				jdbcTemplate.update(addBronzeBadge);
			}
		}else if( likes == 50 )
		{
			String isSilverBadgeAlreadyAdded = "SELECT  COUNT(*) FROM user_badges WHERE badge_color='silver' AND comment_id="+commentID;
			if( jdbcTemplate.queryForObject(isSilverBadgeAlreadyAdded, Integer.class) == 0 )
			{
				String addSilverBadge = "INSERT INTO user_badges VALUE (null,"+commentID+",'"+username+"','silver','Already 50 people liked your comment!','Popular comment',null);";
				jdbcTemplate.update(addSilverBadge);
			}
		}
		else if( likes == 100 )
		{
			String isGoldBadgeAlreadyAdded = "SELECT  COUNT(*) FROM user_badges WHERE badge_color='gold' AND comment_id="+commentID;
			if( jdbcTemplate.queryForObject(isGoldBadgeAlreadyAdded, Integer.class) == 0 )
			{
				String addGoldBadge = "INSERT INTO user_badges VALUE (null,"+commentID+",'"+username+"','gold','Already 100 people liked your comment!','Famous comment',null);";
				jdbcTemplate.update(addGoldBadge);
			}
		}
	}
	
	public void addProfileViewsBadgeIfPossible(int profileViews, String username)
	{
		if( profileViews == 1000 )
		{
			String addBronzeBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','bronze','Profile with 1.000 views!','Popular profile',null);";
			jdbcTemplate.update(addBronzeBadge);
		}
		else if( profileViews == 5000 )
		{
			String addSilverBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','silver','Profile with 5.000 views!','Notable profile',null);";
			jdbcTemplate.update(addSilverBadge);
		}
		else if( profileViews == 10000 )
		{
			String addGoldBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','gold','Profile with 10.000 views!','Famous profile',null);";
			jdbcTemplate.update(addGoldBadge);
		}
	}
	
	public void addProfileInfoBadgeIfPossible(String username)
	{
		String isAccountInfoAlreadyFilled = "SELECT COUNT(*) FROM user_badges WHERE username='"+username+"' AND badge_type='account_information'";
		if( jdbcTemplate.queryForObject(isAccountInfoAlreadyFilled, Integer.class) == 0 )
		{
			String addProfileInfoBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','bronze','Account status updated!','Autobiographer','account_information');";
			jdbcTemplate.update(addProfileInfoBadge);
		}
	}
	
	public void addMovieRatingBadgeIfPossible(String username, int numberOfRatings)
	{
		if( numberOfRatings == 20 )
		{
			String addMovieRatingBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','bronze','Rated 20 movies!','Amateur critic',null);";
			jdbcTemplate.update(addMovieRatingBadge);
		}
		else if( numberOfRatings == 100 )
		{
			String addMovieRatingBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','silver','Rated 100 movies!','Movie critic',null);";
			jdbcTemplate.update(addMovieRatingBadge);
		}
		else if( numberOfRatings == 1000 )
		{
			String addMovieRatingBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','gold','Rated 1.000 movies!','Movie expert',null);";
			jdbcTemplate.update(addMovieRatingBadge);
		}
	}
	
	public void addMovieCommentBadgeIfPossible(String username, int numberOfComments)
	{
		if( numberOfComments == 10 )
		{
			String isBadgeAlreadyAdded = "SELECT COUNT(*) FROM user_badges WHERE username='"+username+"' AND badge_color='bronze' AND badge_type='movie_comment'";
			if( jdbcTemplate.queryForObject(isBadgeAlreadyAdded, Integer.class) == 0 )
			{
				String addMovieCommentBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','bronze','Left 10 comments!','Aspiring commentator','movie_comment');";
				jdbcTemplate.update(addMovieCommentBadge);
			}
		}
		else if( numberOfComments == 100 )
		{
			String isBadgeAlreadyAdded = "SELECT COUNT(*) FROM user_badges WHERE username='"+username+"' AND badge_color='silver' AND badge_type='movie_comment'";
			if( jdbcTemplate.queryForObject(isBadgeAlreadyAdded, Integer.class) == 0 )
			{
				String addMovieCommentBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','silver','Left 100 comments!','Commentator','movie_comment');";
				jdbcTemplate.update(addMovieCommentBadge);
			}
		}
		else if( numberOfComments == 1000 )
		{
			String isBadgeAlreadyAdded = "SELECT COUNT(*) FROM user_badges WHERE username='"+username+"' AND badge_color='silver' AND badge_type='movie_comment'";
			if( jdbcTemplate.queryForObject(isBadgeAlreadyAdded, Integer.class) == 0 )
			{
				String addMovieCommentBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','silver','Left 1.000 comments!','Old commentator','movie_comment');";
				jdbcTemplate.update(addMovieCommentBadge);
			}
		}
	}
	
	public void addGivenLikesBadgeIfPossible(String username, int givenLikes)
	{
		if( givenLikes == 10 )
		{
			String isBadgeAlreadyAdded = "SELECT COUNT(*) FROM user_badges WHERE username='"+username+"' AND badge_color='bronze' AND badge_type='given_likes'";
			if( jdbcTemplate.queryForObject(isBadgeAlreadyAdded, Integer.class) == 0 )
			{
				String addGivenLikesBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','bronze','Left 10 likes!','Young supporter','given_likes');";
				jdbcTemplate.update(addGivenLikesBadge);
			}
		}
		else if( givenLikes == 100 )
		{
			String isBadgeAlreadyAdded = "SELECT COUNT(*) FROM user_badges WHERE username='"+username+"' AND badge_color='silver' AND badge_type='given_likes'";
			if( jdbcTemplate.queryForObject(isBadgeAlreadyAdded, Integer.class) == 0 )
			{
				String addGivenLikesBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','silver','Left 100 likes!','Supporter','given_likes');";
				jdbcTemplate.update(addGivenLikesBadge);
			}
		}
		else if( givenLikes == 1000 )
		{
			String isBadgeAlreadyAdded = "SELECT COUNT(*) FROM user_badges WHERE username='"+username+"' AND badge_color='gold' AND badge_type='given_likes'";
			if( jdbcTemplate.queryForObject(isBadgeAlreadyAdded, Integer.class) == 0 )
			{
				String addGivenLikesBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','gold','Left 1.000 likes!','Old supporter','given_likes');";
				jdbcTemplate.update(addGivenLikesBadge);
			}
		}
	}
	
	public void addUserPointsBadgeIfPossible(String username, int points)
	{
		if( points >= 100000 )
		{
			String isBadgeAlreadyAdded = "SELECT COUNT(*) FROM user_badges WHERE username='"+username+"' AND badge_color='gold' AND badge_type='user_points' ";
			if( jdbcTemplate.queryForObject(isBadgeAlreadyAdded, Integer.class) == 0 )
			{
				String addRegisterDateBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','gold','Reach 100.000 points!','Professor','user_points');";
				jdbcTemplate.update(addRegisterDateBadge);
			}
		}
		else if( points >= 10000 )
		{
			String isBadgeAlreadyAdded = "SELECT COUNT(*) FROM user_badges WHERE username='"+username+"' AND badge_color='silver' AND badge_type='user_points'";
			if( jdbcTemplate.queryForObject(isBadgeAlreadyAdded, Integer.class) == 0 )
			{
				String addRegisterDateBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','silver','Reach 10.000 points!','Master','user_points');";
				jdbcTemplate.update(addRegisterDateBadge);
			}	
		}
		else if( points >= 100 )
		{
			String isBadgeAlreadyAdded = "SELECT COUNT(*) FROM user_badges WHERE username='"+username+"' AND badge_color='bronze' AND badge_type='user_points'";
			if( jdbcTemplate.queryForObject(isBadgeAlreadyAdded, Integer.class) == 0 )
			{
				String addRegisterDateBadge = "INSERT INTO user_badges VALUE (null,null,'"+username+"','bronze','Reach 100 points!','Student','user_points');";
				jdbcTemplate.update(addRegisterDateBadge);
			}
		}
	}
	
	public boolean isUserMyFriend(String loggedUsername, String username)
	{
		String isUserFriend = "SELECT COUNT(*) FROM user_friend WHERE username='"+loggedUsername+"' AND user_friend='"+username+"'";
		String countResult = "";
		try { countResult = jdbcTemplate.queryForObject(isUserFriend, String.class);}
		catch(DataAccessException ex) { countResult = "0"; }
		if( Integer.parseInt(countResult) == 1 )
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	// ---------- ROW MAPPERS ---------- \\ 
	private class UserRowMapper implements RowMapper<UserModel>
	{ 
		public UserModel mapRow(ResultSet rs, int rowNum) throws SQLException 
		{ 
			UserModel user = new UserModel(); 
			user.setUsername( rs.getString("username") );
			user.setEmail( rs.getString("email") );
			user.setPassword( rs.getString("password") );
			if( rs.getString( "enabled" ).equals("false") ) { user.setEnabled( false ); }
			else if( rs.getString( "enabled" ).equals("true") ) { user.setEnabled( true ); }
			return user; 
		} 
	}
	
	private class UserAccountInfoRowMapper implements RowMapper<UserAccountInfoModel>
	{ 
		public UserAccountInfoModel mapRow(ResultSet rs, int rowNum) throws SQLException 
		{ 
			UserAccountInfoModel UserAccountInfo = new UserAccountInfoModel(); 
			UserAccountInfo.setUsername( rs.getString("username") );
			UserAccountInfo.setRegistrationTimestamp( rs.getString("registration_timestamp") );
			UserAccountInfo.setAccountViews( Integer.parseInt(rs.getString("profile_views")) );
			UserAccountInfo.setLastSeenTimestamp( rs.getString("last_seen") );
			UserAccountInfo.setScore( Integer.parseInt(rs.getString("score")) );
			return UserAccountInfo; 
		} 
	}
	
	private class UserInfoRowMapper implements RowMapper<UserInfoModel>
	{ 
		public UserInfoModel mapRow(ResultSet rs, int rowNum) throws SQLException 
		{ 
			UserInfoModel userInfo = new UserInfoModel(); 
			String name = rs.getString("name");
			int age = Integer.parseInt(rs.getString("age"));
			String favMovie = rs.getString("favourite_movie");
			String aboutMe = rs.getString("about_me");
			String description = rs.getString("description");
			
			userInfo.setName( name );
			userInfo.setAge( age );
			userInfo.setFavMovies( favMovie );
			userInfo.setAboutMe( aboutMe );
			userInfo.setDescription( description );
			return userInfo; 
		} 
	}
	
	private class UserRatingsRowMapper implements RowMapper<UserRatingModel>
	{ 
		public UserRatingModel mapRow(ResultSet rs, int rowNum) throws SQLException 
		{ 
			UserRatingModel rating = new UserRatingModel(); 
			rating.setMovieID( rs.getString("movie_id") );
			rating.setMovieRate( Integer.parseInt(rs.getString("rate")) );
			rating.setTime( rs.getString("time") );
			return rating; 
		} 
	}
	
	private class UserNotificationsRowMapper implements RowMapper<UserNotificationModel>
	{ 
		public UserNotificationModel mapRow(ResultSet rs, int rowNum) throws SQLException 
		{ 
			UserNotificationModel notification = new UserNotificationModel();
			notification.setFromUser( rs.getString("fromUser") );
			notification.setMovieID( rs.getString("movieID") );
			notification.setNotification( rs.getString("notification") );
			notification.setType( rs.getString("type") );
			notification.setTime( rs.getString("time") );
			notification.setSeen( rs.getString("seen") );
			return notification; 
		} 
	}
	
	private class UserActivityRowMapper implements RowMapper<UserNotificationModel>
	{ 
		public UserNotificationModel mapRow(ResultSet rs, int rowNum) throws SQLException 
		{ 
			UserNotificationModel notification = new UserNotificationModel();
			notification.setFromUser( rs.getString("username") );
			notification.setMovieID( rs.getString("movieID") );
			notification.setNotification( rs.getString("notification") );
			notification.setRate( Integer.parseInt(rs.getString("rate")) );
			notification.setAddedFriend( rs.getString("added_username") );
			notification.setTime( rs.getString("time") );
			return notification; 
		} 
	}
	
	private class UserBadgesRowMapper implements RowMapper<UserBadgeModel>
	{ 
		public UserBadgeModel mapRow(ResultSet rs, int rowNum) throws SQLException 
		{ 
			UserBadgeModel badge = new UserBadgeModel(); 
			badge.setBadgeColor( rs.getString("badge_color") );
			badge.setBadgeInfo( rs.getString("badge_info") );
			badge.setBadgeTitle( rs.getString("badge_title") );
			return badge; 
		} 
	}
	
	private class TokenRowMapper implements RowMapper<ConfirmToken>
	{ 
		public ConfirmToken mapRow(ResultSet rs, int rowNum) throws SQLException 
		{ 
			ConfirmToken confirmToken = new ConfirmToken(); 
			confirmToken.setUsername( rs.getString("username") );
			confirmToken.setToken( rs.getString("token") );
			confirmToken.setExpiryTime( Long.parseLong(rs.getString("expiryTime")) );
			return confirmToken; 
		} 
	}
	
	private class UserColumnRowMapper implements RowMapper<String>
	{
		public String mapRow(ResultSet rs, int rowNum) throws SQLException 
		{ 
			return rs.getString(1);
		} 
	}
	
	// ---------------------------- CONFIRMATION TOKEN ---------------------------- \\
	public ConfirmToken getConfirmTokenByUsername(String username, String token)
	{
		String selectConfirmTokenByUsername = "SELECT * FROM confirmToken WHERE username='"+username+"' AND token='"+token+"'";
		ConfirmToken confirmToken = new ConfirmToken();
		try { confirmToken = jdbcTemplate.queryForObject(selectConfirmTokenByUsername, new TokenRowMapper()); }
		catch(DataAccessException e) { return null; }
		return confirmToken;
	}
	
	public void registerConfirmationToken(ConfirmToken confirmToken)
	{
		String addConfirmationToken = "INSERT INTO confirmToken VALUE(null,'"+confirmToken.getUsername()+"','"+confirmToken.getToken()+"',"+confirmToken.getExpiryTime()+")";
		jdbcTemplate.update(addConfirmationToken);
	}
	
	public void deleteConfirmToken(String username, String token)
	{
		String deleteConfirmToken = "DELETE FROM confirmToken WHERE username='"+username+"' AND token='"+token+"'";
		jdbcTemplate.update(deleteConfirmToken);
	}
	
	public void activateAccount(String username)
	{
		String enableAccount = "UPDATE user SET enabled='true' WHERE username='"+username+"'";
		jdbcTemplate.update(enableAccount);
		System.out.println("activated");
	}
}