<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<meta name="viewport" content="width=device-width, user-scalable=no"/>
<Style>
	*{ margin: 0; padding: 0; box-sizing: border-box; }
	body{ width: 100%; background-color: black; }
	a{ text-decoration: none; color: black; }
	a:hover{ color: #e6ac00; transition: all 0.1s linear 0s; }
	h6{ height: 60px; }
	.error{ color: red; }
	.succes{ color: green; }
	
	/*  MENU BAR  */
	.menuHeightBig{ height: 40px; }
	.menuHeightResponsive1{ height: 280px; }.menuHeightResponsive2{ height: 320px; }.menuHeightResponsive3{ height: 360px; }
	
	#menuBorder{ border-bottom: solid 0.6px #404040; transition: top 0.3s; position: fixed; height: 40px; width: 100%; background-color: black; z-index: 10;  }
	#navContainer{ margin: auto; width: 100%; background-color: black; display: flex; }
	.navContainerBig{ flex-direction: row; }
	.navContainerResponsive{ flex-direction: column; }
	
	#mobileMenuBar{ margin: auto; flex: 1; width: 100%; }
	.mobileMenuBarBig{ display: none; flex-direction: row; }
	.mobileMenuBarResponsive{ display: none; }
	#menuBar{ width: 100%; margin: auto; flex: 1; }
	.menuBarBig{ display: flex; flex-direction: row; }
	.menuBarResponsive{ display: flex; flex-direction: column; }
	#flexNavbar{ flex: 6; margin: auto; }
	.flexNavbarBig{ display: block;}
	.flexNavbarResponsive{ display: none; }
	#userNavbar{ width: 100%; margin: auto; flex: 1; }
	.userNavbarBig{ display: flex; flex-direction: row-reverse; }
	.userNavbarResponsive{ display: flex; flex-direction: column-reverse; }
	
	.logo{ height: 40px; flex: 1; padding: 8px 15px; font-size: 1.3em; font-weight: bold; text-align: center; width: 100%; -webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none; }
	.logo:hover .menuIcon{ color: #e6ac00; } .logo:hover .homeIcon{ color: #e6ac00; }
	.option{ height: 40px; flex: 1; padding: 0px 15px; font-size: 1.2em; font-weight: bold; width: 100%; text-align: center; -webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;}
	.logobutton{ color: white; line-height: 40px; text-align: center; width: 100%; height: 100%; }
	.activelogobutton{ line-height: 40px; color: #e6ac00; }
	.menuIcon{ font-size:1.4em;color:white;margin:-2px 0 -3px 0;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none; }
 	.homeIcon{ font-size:1.4em;color:white;margin:-2px 0 -3px 0;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none; }
	#menuButton:hover{ cursor: pointer; }
	#menuButtonBig:hover{ cursor: pointer; }
	.menuButtonBigClass{ display: none; }
	.menuButtonBigResponsive{ display: block; }
	/*  MENU BAR  */
	
	.fullContainer{ background-color: white; text-align: center; width: 100%; height: 100%; padding-bottom: 60px; }
	.userContainer{ width: 80%; text-align: justify; padding: 2%; margin: auto; }
	.userBar{ display: flex; border-top: 0.5px solid rgb(232, 232, 232); border-bottom: 0.5px solid rgb(232, 232, 232); }
	.userBarOption{ flex: 1; text-align: center; padding: 7px 3px; font-size: 1.1em; }
	.host{ display: inline; color: red; }
	.mod{ display: inline; color: green; }
	.user{ display: inline; color: blue; }
	.usernameDiv{ padding: 10px; }
	.titleUsername{ display: inline; font-size: 1.7em; }
	.activeBarOption{ color: #e6ac00; }
	
	#circle{ display: inline-block; width: 20px; height: 20px; border-radius: 10px; background-color: crimson; color: white; margin: auto; }
	
	.aboutAndStatsUserFlex{ display: flex; width: 75%; margin: auto; flex-wrap: wrap; }
	.aboutUserContainer{ flex: 3; margin: 0 1% 1% 1%; border: 1px solid rgb(232, 232, 232); padding: 0 2% 2% 2%; text-align: left; }
	.userStatsContainer{ flex: 2; margin: 0 1% 1% 1%; border: 1px solid rgb(232, 232, 232); padding: 0 2% 2% 2%; }
	.aboutUserTitle{ font-size: 1.25em; padding: 16px 8px; margin-bottom: 8px; text-align: center; border-bottom: 1px solid rgb(232, 232, 232); color: #e6ac00; }
	.aboutUserStatsDisplay{ display: flex; flex-wrap: wrap; }
	.userAccountInfoDisplay{ text-align: left; padding: 5px; }
	.aboutUserStatsDiv{ flex: 1; padding: 3px; }
	.userAccountInfoDiv{ padding: 3px; display: flex; }
	.userDescription{ color: #6a737c; font-size: 1.2em; }
	.aboutUserPar{ padding: 3px; }
	.aboutEmptyUserPar{ padding: 3px; text-align: center; }
	.userStatsData{ font-weight: bold; }
	.dataAfterIcon{ padding-left: 10px; }
	.activeCircle{ height: 0.7em; width: 0.7em; border-radius: 50%; background-color: #66cc00; margin: 0.25em 0px 0px 4px; }
	
	.userBadgesWrap{ width: 75%; margin: auto; }
	.userBadgesContainer{ width: 98%; border: 1px solid rgb(232, 232, 232); margin: 1%; }
	.userBadgesFlex{ display: flex; }
	.userBadges{ width: 100%; display: flex; }
	.badge{ flex: 1; }
	#silverBadge{ border-left: 1px solid rgb(232, 232, 232); border-right: 1px solid rgb(232, 232, 232); }
	.badgeIconDiv{ padding: 8px; border-bottom: 1px solid rgb(232, 232, 232); }
	.badgeIconDiv:hover{ cursor: pointer; }
	.badgeTextDiv{ padding: 15px; display: flex; flex-direction: column; }
	.userBadgesTitle{ font-size: 1.25em; padding: 16px 8px; text-align: center; border-bottom: 1px solid rgb(232, 232, 232); color: #e6ac00; }
	.numberOfBadgesTitle{ color: #848d95; }
	.badgeDiv{ padding: 6px 10px; display: inline-block; }
	.badgePar{ transition: all 0.3s; background-color: #2f3337; color: white; padding: 6px 8px; text-align: center; display: inline-block; border-radius: 5px; }
	.badgePar:hover{ cursor: pointer; background-color: black; }
	.circle{ display: inline-block; height: 8px; width: 8px; border-radius: 50%; margin-right: 8px; }
	#bronzeCircle{ background-color: #b35900; }
	#silverCircle{ background-color: silver; }
	#goldCircle{ background-color: gold; }
	.badgesLinkDiv{ width: 98%; text-align: right; margin: 1%;}
	
	.addFriendButton{ background-color: #009900; color: white; margin: 3px; padding: 4px 8px; border: 0.2px solid #00b300; transition: all 0.1s linear 0s; border-radius: 5px; }
	.addFriendButton:hover{ color: white; background-color: #008000; cursor: pointer; }
	.addFriendButton:focus{ box-shadow: 0 0 6px #006600; outline: none; }
	.deleteFriendButton{ background-color: #cc0000; color: white; margin: 3px; padding: 4px 8px; border: 0.2px solid #cc0000; transition: all 0.1s linear 0s; border-radius: 5px; }
	.deleteFriendButton:hover{ color: white; background-color: #b30000; cursor: pointer; }
	.deleteFriendButton:focus{ box-shadow: 0 0 6px #990000; outline: none; }
	.disabledButton{ pointer-events: none; background-color: #b3b3b3; color: white; margin: 3px; padding: 4px 8px; border: 0.2px solid #00b300; transition: all 0.1s linear 0s; border-radius: 5px; -webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;}
	.disabledButton:hover{ color: white; background-color: #999999; cursor: pointer; }
	.disabledButton:focus{ box-shadow: 0 0 6px #808080; outline: none; }
		
	.footer{ background-color: black; width: 100%; border-top: solid 0.6px #404040; height: 60px; }
	.footerSpace{ width: 80%; margin:auto; height: 60px;}
	.footerText{ text-align: center; color: white; line-height: 60px; }

	@media only screen and (min-width: 930px) 
	{
		.navContainerResponsive{ flex-direction: row; }
		.mobileMenuBarResponsive{ display: none; }
		.menuBarResponsive{ display: flex; flex-direction: row; }.flexNavbarResponsive{ display: block; }.userNavbarResponsive{ display: flex; flex-direction: row-reverse; }
		.menuButtonBigResponsive{ display: none; }
		
		.menuHeightResponsive1{ height: 40px; }
		.menuHeightResponsive2{ height: 40px; }
		.menuHeightResponsive3{ height: 40px; }
	}
	@media only screen and (max-width: 1100px) 
	{
		.userContainer{ width: 90%; padding: 2%; }
	}
	@media only screen and (max-width: 930px) 
	{
		.navContainerBig{ flex-direction: column; }
		.mobileMenuBarBig{ display: flex; }
		.menuBarBig{ display: none; }.flexNavbarBig{ display: none; }.userNavbarBig{ display: none; }
		
		#menuButton{ display: inline-block; height: 40px; flex: 1; padding: 8px 0; }
		#homeButton{ text-align: center; flex: 8; padding: 8px 0; }
	
		.aboutUserContainer{ flex: 1; }
		.userStatsContainer{ flex: 1; }
	}
	@media only screen and (max-width: 800px) 
	{
		.aboutAndStatsUserFlex{ flex-direction: column; }  
	}
	@media only screen and (max-width: 800px) 
	{
		.aboutUserContainer{ margin-bottom: 1%; }
		.userStatsContainer{ margin-top: 1%; }
	}
	@media only screen and (max-width: 700px) 
	{
		.usernameDiv{ text-align: center; }
		.userContainer{ width: 90%; }
		.userBar{ flex-direction: column; border-bottom: 0px; }
		.userBarOption{ border-bottom: 0.5px solid rgb(232, 232, 232); }
		
		.aboutAndStatsUserFlex{ width: 90%; padding: 2% 1% 1% 1%; }
		.userBadgesWrap{ width: 90%; padding: 1%; }
		.aboutUserContainer{ margin-bottom: 2%; }
		.userStatsContainer{ margin-top: 2%; }
		
		#menuButton{ flex: 1; }
		#homeButton{ flex: 7; }
	}
	@media only screen and (max-width: 600px) 
	{
		#menuButton{ flex: 1; }
		#homeButton{ flex: 6; }
	}
	@media only screen and (max-width: 550px) 
	{
		#menuButton{ flex: 1; }
		#homeButton{ flex: 4; }
	}
</Style>
<title>${userModel.username}</title>
</head>
<body>
	<div id="menuBorder">
		<div id="navContainer" class="navContainerBig">
			<div id="mobileMenuBar" class="mobileMenuBarBig">
				<a class="logo logobutton" id="menuButton" title="Menu" onClick="toggleMenuList(${rolesNumber})" ><i class="material-icons menuIcon">menu</i></a>
				<a class="logo logobutton" title="Home" id="homeButton" href="<c:url value="/"/>"><i class="material-icons homeIcon">home</i></a>
			</div>
			<div id="menuBar" class="menuBarBig">	
				<a class="logo logobutton menuButtonBigClass" title="Menu" id="menuButtonBig" onClick="toggleMenuList(${rolesNumber})" ><i class="material-icons menuIcon">menu</i></a>
				<a class="logo logobutton" title="Home" href="<c:url value="/"/>"><i class="material-icons homeIcon">home</i></a>
				<a class="option logobutton" title="Movies" href="<c:url value="/movies?page=0"/>">Movies</a>
				<a class="option logobutton" title="Filter Movies/People" href="<c:url value="/filter"/>">Filter</a>
				<a class="option logobutton" title="People" href="<c:url value="/people?page=0"/>">People</a>
			</div>
			<div id="flexNavbar" class="flexNavbarBig"></div>
			<sec:authorize access="isAnonymous()"> <!-- access="hasRole('ROLE_ANONYMOUS')" -->
			<div id="userNavbar" class="userNavbarBig">
				<a class="option logobutton" title="Become one of us!" href="<c:url value="/register"/>">SignUp</a>
				<a class="option logobutton" title="Login" href="<c:url value="/login"/>">Login</a>
			</div>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<div id="userNavbar" class="userNavbarBig">
					<form id="logout" action="/SpringMvcExample/logout" method="post" >
 						 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
					<c:if test="${pageContext.request.userPrincipal.name != null}">
						<a class="option logobutton" title="Logout" href="javascript:document.getElementById('logout').submit()">Logout</a>
					</c:if>
					<sec:authentication var="user" property="principal" />
					<a class="option activelogobutton" title="My account" href="<c:url value="/user/${user.username}"/>">myAccount</a>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<a class="option logobutton" title="Moderator privileges" href="<c:url value="/adminPanel"/>" >Admin</a>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_HOST')">
						<a class="option logobutton" title="Host privileges" href="<c:url value="/hostPanel"/>" >Host</a>
					</sec:authorize>
				</div>
			</sec:authorize>
		</div>
	</div>
	
	<h6 class="menuHeightBig" id="menuHeight"></h6>
	
	<div class="fullContainer">	
		<div class="userContainer" >
			<div class="usernameDiv">
				<h3 class="titleUsername"> ${userModel.username}</h3>
				<c:if test="${userRoleSize == 3}"><div class="host">[host]</div></c:if>
				<c:if test="${userRoleSize == 2}"><div class="mod">[mod]</div></c:if>
				<c:if test="${userRoleSize == 1}"><div class="user">[user]</div></c:if>
				<sec:authorize access="isAuthenticated()">
					<c:if test="${userModel.username != user.username}">
						<c:if test="${isUserFriend == true}">
							<a class="deleteFriendButton" id="deleteFriendMainButton" onClick="turnButton('deleteFriendMainButton')" href="<c:url value="/user/${userModel.username}/deleteFriend"/>" >Delete friend</a><h3></h3>
						</c:if>
						<c:if test="${isUserFriend == false}">
							<a class="addFriendButton" id="addFriendMainButton" onClick="turnButton('addFriendMainButton')" href="<c:url value="/user/${userModel.username}/addFriend"/>" >Add friend</a><h3></h3>
						</c:if>		
					</c:if>
				</sec:authorize>
				<c:if test="${not empty userInfoModel.description}">
					<p class="userDescription">${userInfoModel.description}</p>
				</c:if>
			</div>
		
		<!-- rgb(232, 232, 232); -->
			<div class="userBar">
				<a class="userBarOption activeBarOption" href="<c:url value="/user/${userModel.username}"/>" >About me</a>
				<a class="userBarOption" href="<c:url value="/user/${userModel.username}/badges"/>" >Badges (${numberOfBadges})</a>
				<a class="userBarOption" href="<c:url value="/user/${userModel.username}/ratings?page=0"/>" >Ratings (${numberOfRatings})</a>
				<a class="userBarOption" href="<c:url value="/user/${userModel.username}/friends?page=0"/>" >Friends (${numberOfFriends})</a>
				<c:if test="${user.username == userModel.username}">
					<a class="userBarOption" href="<c:url value="/user/${userModel.username}/friendsActivity?page=0"/>" >Friends Activity</a>
					<a class="userBarOption" href="<c:url value="/user/${userModel.username}/notifications?page=0"/>" >Notifications 
					<c:if test="${not empty numberOfNewNotifications}">
						<div id="circle">${numberOfNewNotifications}</div>
					</c:if></a>
					<a class="userBarOption" href="<c:url value="/user/${userModel.username}/editAccount"/>" >Edit account</a>
				</c:if>
			</div>
		</div>
		
		<div class="aboutAndStatsUserFlex">
			<div class="aboutUserContainer">
				<c:if test="${not empty userInfoModel}">
					<h3 class="aboutUserTitle">About me</h3>
					
					<c:if test="${not empty userInfoModel.name}">
						<p class="aboutUserPar">Name: ${userInfoModel.name}</p>
					</c:if>
						
					<c:if test="${userInfoModel.age != 0}">
						<p class="aboutUserPar">Age: ${userInfoModel.age}</p>
					</c:if>
							
					<c:if test="${not empty userInfoModel.favMovies}">
						<p class="aboutUserPar">Favourite movie: ${userInfoModel.favMovies}</p>
					</c:if>
					
					<c:if test="${not empty userInfoModel.aboutMe}">
						<p class="aboutUserPar">About me: ${userInfoModel.aboutMe}</p>
					</c:if>
					
					<c:if test="${empty userInfoModel.name && userInfoModel.age == 0 && empty userInfoModel.favMovies  && empty userInfoModel.aboutMe}">
						<p class="aboutEmptyUserPar">Apparently, this user prefers to stay hidden.</p>
					</c:if>
				</c:if> 
				<c:if test="${empty userInfoModel}">
					<h3 class="aboutUserTitle">About me</h3>
					<p class="aboutEmptyUserPar">Apparently, this user prefers to stay hidden.</p>
				</c:if>
			</div>
			<div class="userStatsContainer">
				<h3 class="aboutUserTitle">My stats</h3>
				
				<div class="aboutUserStatsDisplay">
					<div class="aboutUserStatsDiv"><h3 class="userStatsData">${countOfGivenlikes}</h3><p class="aboutUserStatsPar">Given Likes</p></div>
					<div class="aboutUserStatsDiv"><h3 class="userStatsData">${countOfReceivedLikes}</h3><p class="aboutUserStatsPar">Received Likes</p></div>
					<div class="aboutUserStatsDiv"><h3 class="userStatsData">${countOfComments}</h3><p class="aboutUserStatsPar">Written comments</p></div>
				</div>
					
				<div class="userAccountInfoDisplay">
					<div class="userAccountInfoDiv">
						<i class="material-icons" style="font-size:1.4em;color:#9199a1;margin-top:-2px;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">restore</i>
						<p class="dataAfterIcon">Member for ${userAccountInfo.registrationTimestamp}</p>
					</div>
					<div class="userAccountInfoDiv">
						<i class="material-icons" style="font-size:1.4em;color:#9199a1;margin-top:-2px;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">visibility</i>
						<p class="dataAfterIcon">${userAccountInfo.accountViews} profile views</p>
					</div>
					<div class="userAccountInfoDiv">
						<i class="material-icons" style="font-size:1.4em;color:#9199a1;margin-top:-2px;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">schedule</i>
						<p class="dataAfterIcon">${userAccountInfo.lastSeenTimestamp}</p>
						<c:if test="${userAccountInfo.lastSeenTimestamp == 'Active now'}">
							<span class="activeCircle"></span> 
						</c:if>
					</div>
					<div class="userAccountInfoDiv">
						<c:choose>
							<c:when test="${userAccountInfo.score >= 10000}"><i class="material-icons" style="font-size:1.4em;color:crimson;margin-top:-2px;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">star</i></c:when>
							<c:when test="${userAccountInfo.score >= 5000}"><i class="material-icons" style="font-size:1.4em;color:gold;margin-top:-2px;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">star</i></c:when>
							<c:when test="${userAccountInfo.score >= 1000}"><i class="material-icons" style="font-size:1.4em;color:#33cc33;margin-top:-2px;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">star</i></c:when>
							<c:when test="${userAccountInfo.score >= 500 }"><i class="material-icons" style="font-size:1.4em;color:#0000e6;margin-top:-2px;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">star</i></c:when>
							<c:otherwise><i class="material-icons" style="font-size:1.4em;color:#9199a1;margin-top:-2px;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">star</i></c:otherwise>
						</c:choose>
						<p class="dataAfterIcon">${userAccountInfo.score} points</p>
					</div>
					<div class="userAccountInfoDiv">
						<c:choose>
							<c:when test="${userRaking == 1}"><i class="material-icons" style="font-size:1.4em;color:crimson;margin-top:-2px;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">poll</i></c:when>
							<c:when test="${userRaking <= 10}"><i class="material-icons" style="font-size:1.4em;color:gold;margin-top:-2px;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">poll</i></c:when>
							<c:when test="${userRaking <= 50}"><i class="material-icons" style="font-size:1.4em;color:#33cc33;margin-top:-2px;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">poll</i></c:when>
							<c:when test="${userRaking <= 100 }"><i class="material-icons" style="font-size:1.4em;color:#0000e6;margin-top:-2px;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">poll</i></c:when>
							<c:otherwise><i class="material-icons" style="font-size:1.4em;color:#9199a1;margin-top:-2px;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">poll</i></c:otherwise>
						</c:choose>
						<a class="dataAfterIcon" title="List of top 100 users" href="/SpringMvcExample/bestUsers/list">Rank ${userRaking}</a>
					</div>
				</div>
			
			</div>
		</div>
		
		<div class="userBadgesWrap">
			<div class="userBadgesContainer">
				<h3 class="userBadgesTitle"><span class="numberOfBadgesTitle">${numberOfBadges}</span> Badges</h3>
				<div class="userBadgesFlex">
					<div class="userBadges">
						<div class="badge" id="goldBadge">
							<div class="badgeIconDiv" id="goldIcon" title="Gold badges">
								<i class="material-icons" style="font-size:1.6em;color:gold;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">stars</i>
							</div>
							<div class="badgeTextDiv">
								<c:forEach items="${goldUserBadges}" var="goldBadge" varStatus="i">
									<div class="badgeDiv">
										<p class="badgePar" title="${goldBadge.badgeInfo}"><a class="circle" id="goldCircle"></a>${goldBadge.badgeTitle}</p>
									</div>
								</c:forEach>
							</div>
						</div>
						<div class="badge" id="silverBadge">
							<div class="badgeIconDiv" id="silverIcon" title="Silver badges">
								<i class="material-icons" style="font-size:1.6em;color:silver;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">stars</i>
							</div>
							<div class="badgeTextDiv">
								<c:forEach items="${silverUserBadges}" var="silverBadge" varStatus="i">
									<div class="badgeDiv">
										<p class="badgePar" title="${silverBadge.badgeInfo}"><a class="circle" id="silverCircle"></a>${silverBadge.badgeTitle}</p>
									</div>
								</c:forEach>
							</div>
						</div>
						<div class="badge" id="bronzeBadge">
							<div class="badgeIconDiv" id="bronzeIcon" title="Bronze badges">	
								<i class="material-icons" style="font-size:1.6em;color:#b35900;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;">stars</i>
							</div>
							<div class="badgeTextDiv">
								<c:forEach items="${bronzeUserBadges}" var="bronzeBadge" varStatus="i">
									<div class="badgeDiv">
										<p class="badgePar" title="${bronzeBadge.badgeInfo}"><a class="circle" id="bronzeCircle"></a>${bronzeBadge.badgeTitle}</p>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="badgesLinkDiv">
				<a href="<c:url value="${userModel.username}/badges"/>" >view all badges &#8594;</a>
			</div>
		</div>
		
	</div>
	
	<div class="footer">
		<div class="footerSpace">
			<p class="footerText">COPYRIGHT © MOVIEINFO</p>
		</div>
	</div>
<script>
	//------------------------------ TOGGLE (ON/OFF) MENU HAMBURGER ------------------------------ \\
	var menuBorder = document.getElementById("menuBorder");
	var navContainer = document.getElementById("navContainer");
	var mobileMenuBar = document.getElementById("mobileMenuBar");
	var userNavbar = document.getElementById("userNavbar");
	var flexNavbar = document.getElementById("flexNavbar");
	var menuBar = document.getElementById("menuBar");
	var menuHeight = document.getElementById("menuHeight");
	var menuButtonBig = document.getElementById("menuButtonBig");
	
	function toggleMenuList(rolesNumber) 
	{
		if ( navContainer.className === "navContainerBig" ) 
		{
			if( rolesNumber == 2 ){ menuHeight.className = "menuHeightResponsive2"; }
			else if( rolesNumber == 3 ){ menuHeight.className = "menuHeightResponsive3"; }
			else{ menuHeight.className = "menuHeightResponsive1"; }
				
			navContainer.className = "navContainerResponsive";
			mobileMenuBar.className = "mobileMenuBarResponsive";
			menuBar.className = "menuBarResponsive";
			flexNavbar.className = "flexNavbarResponsive";
			userNavbar.className = "userNavbarResponsive";
				
			menuButtonBig.className = "logo logobutton menuButtonBigResponsive";
		}
		else{ 
			menuHeight.className = "menuHeightBig";
			
			navContainer.className = "navContainerBig";
			mobileMenuBar.className = "mobileMenuBarBig";
			menuBar.className = "menuBarBig";
			flexNavbar.className = "flexNavbarBig";
			userNavbar.className = "userNavbarBig";
			
			menuButtonBig.className = "logo logobutton menuButtonBigClass";
		}
	}
	
	function turnButton(buttonID)
	{
		var button = document.getElementById( buttonID );
		button.className = "disabledButton";
	}
</script>
</body>
</html>