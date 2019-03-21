<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<meta name="viewport" content="width=device-width, user-scalable=no"/>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<title>Badges</title>
<style>
	*{ margin: 0; padding: 0; box-sizing: border-box; }
	body{ width: 100%; background-color: black; height: 100%; position: relative; }
	a{ text-decoration: none; color: black; }
	a:hover{ color: #e6ac00; transition: all 0.1s linear 0s; }

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
	.userDescription{ color: #6a737c; font-size: 1.2em; }
	
	.userBadgesFlex{ display: flex; width: 64%; margin: auto; }
	.userBadgeFlexOut{ padding-bottom: 1%; flex: 1; }
	.userBadgeFlexIn{ border: 1px solid rgb(232, 232, 232); background-color: #fafafb; border-radius: 5px; padding: 2%; height: 155px; }
	.userBadgeFlexTitle{ color: #9199a1; text-align: left; padding: 2% 1%; }
	#userPointsDiv{ margin-right: 1%; }
	#userBadgesNumberDiv{ margin-left: 1%; }
	
	.badgeDivFlexCon1{ display: flex; }
	.badgeDivFlex1{ flex: 1; }
	
	.userReputationDiv{ display: flex; }
	.reputationFlex1{ flex: 2; }
	.reputationFlex2{ flex: 3; }
	.reputationField{ text-align: left; }
	.reputationFieldNumber{ font-weight: bold; }
	.userPoints{ text-align: left; padding: 0 1%; font-weight: 500; font-size: 2.2em; }
	.userRank{ text-align: left; padding: 1% 2%; }
	#rankListLink{ color: #07C; font-size: 0.85em; font-weight: bold; }
	#rankListLink:hover{ color: #3af; }
	
	.userBadges{ text-align: center; padding: 1% 2%; }
	.badgesListLink{  color: #07C; font-size: 0.85em; font-weight: bold; line-height: 42px; }
	.badgesListLink:hover{ color: #3af; cursor: pointer; }
	
	.numberOfBadges{ display: flex; margin-bottom: 15px; }
	.badge{ padding: 4px; flex: 1; border-radius: 3px; font-weight: bold; color: #535a60; -webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none; }
	#goldBadge{ background-color: #fffae6; border: 1px solid #ece5c6; margin: 3px 3px 3px 6px; }
	#silverBadge{ border: 1px solid #dddee0; background-color: #eaebec; margin: 3px; }
	#bronzeBadge{ border: 1px solid #f0decb; background-color: #f8e9dd; margin: 3px 6px 3px 3px; }
	.badge:hover{ cursor: pointer; }
	.noBadgesYet{ padding: 12px; }
	
	.badgeOut{ width: 65%; margin: auto; }
	.badgeIn{ width: 98%; border: 1px solid rgb(232, 232, 232); margin: 2% 1%; padding: 0 1%; }
	.badgesDiv{ padding: 10px 6px; display: flex; flex-wrap: wrap; }
	.badgeDiv{ padding: 6px 10px; display: inline-block;  }
	.badgePar{ transition: all 0.3s; background-color: #2f3337; color: white; padding: 6px 8px; text-align: center; display: inline-block; border-radius: 5px; }
	.badgePar:hover{ cursor: pointer; background-color: black; }
	.userBadgesTitle{ font-size: 1.25em; padding: 16px 8px; text-align: center; border-bottom: 1px solid rgb(232, 232, 232); color: #e6ac00; }
	.userBadgesNumber{ color: #848d95; text-align: left; }
	.circle{ display: inline-block; height: 8px; width: 8px; border-radius: 50%; margin-bottom: 1px;  }
	#bronzeCircle{ background-color: #b35900; margin-right: 3px; }
	#silverCircle{ background-color: silver; margin-right: 3px; }
	#goldCircle{ background-color: gold; margin-right: 3px; }
	#bronzeCircleNum{ background-color: #b35900; margin-right: 6px; }
	#silverCircleNum{ background-color: silver; margin-right: 6px; }
	#goldCircleNum{ background-color: gold; margin-right: 6px; }
	.emptyBadgeDiv{ height: 30px; }
	
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
	
	#badgesOverlay{ height: 100%; background: grey; position: absolute; top: 0; right: 0; bottom: 0; left: 0; background-color: rgba(0,0,0,0.7); z-index: 20; }
	.enabled{ display: block }
	.disabled{ display: none; }
	.contentOfTheOverlay{ background-color: rgba(128,128,128,0); position: fixed; left: 15%; top: 7%; height: 86%; width: 70%; background-color: white; color: black; border-radius: 5px; padding-bottom: 20px; }
	
	.allBadgesTitleDiv{ margin: 15px 5px; text-align: center; position: relative; }
	.closeButtonDiv{ width: 22px; height: 21px; position: absolute; top: 7px; right: 2.5%; }
	.closeButton{ padding: 2px 6px 4px 6px; border-radius: 5px; background-color: white; border: 0.5px solid #bfbfbf; font-weight: 1900; -webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; -o-user-select: none; user-select: none; }
	.closeButton:hover{ cursor: pointer; background-color: #F8F8F8; color: black; }
	
	.filterBadgesDiv{ display: flex; width: 95%; margin: auto; }
	.searchBadges{ flex: 15; height: 30px; margin: auto auto 20px auto; position: relative; }
	.searchBadgesOption{ flex: 1; height: 30px; line-height: 30px; margin: 0px 2px 2px 2px; }
	.searchBadgesOption:hover{ cursor: pointer; }
	.searchBadgesOption a{ color: #6a737c; padding: 0 8px 4px; }
	.searchBadgesOption:hover a{ color: #3b4045; border-bottom: 2px solid rgba(244,128,36,0.5); }
	.searchBadgesOption .activeBadgesOption{ color: #3b4045; border-bottom: 2px solid #F48024; }
	.searchBadgesOption:hover .activeBadgesOption{ color: #0c0d0e; border-bottom: 2px solid #F48024; }
	.searchButton{ color: rgba(0,0,0,0.2); position: absolute; right: 0; top: 0; line-height: 30px; padding: 0 3px; transition: all 0.2s; -webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;}
	.searchButton:hover{ cursor: pointer; color: rgba(0,0,0,0.35); }
	.searchButton:active{ color: rgba(0,0,0,0.5); }
	#badgeName{ width: 100%; height: 30px; line-height: 30px; padding: 0 5px; border-radius: 5px; border: 1px solid #bfbfbf; }
	
	.allBadges{ overflow-y:auto; height: 400px; width: 95%; margin: auto; border: 1px solid #bfbfbf; border-radius: 5px; text-align: left; display: flex; flex-wrap: wrap; align-content: flex-start; }
	.allBadge{ transition: all 0.2s; padding: 10px 5px; border: 1px solid rgb(232, 232, 232); text-align: center; height: 100px; width: 33.33%; }
	.allBadge:hover{ cursor: pointer; background-color: #fafafb; box-shadow: 0px 2px 5px 2px rgba(191,191,191,1); }
	.allBadgesTitle{ width: 240px; margin: auto; border-radius: 5px; }
	#bronzeBadgesTitle{ border: 1.5px solid #D1A684; }#silverBadgesTitle{ border: 1.5px solid silver; }#goldBadgesTitle{ border: 1.5px solid #FFCC01; }
	.allBadgesInfo{ width: 240px; margin: auto; padding-top: 8px; }
	
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
	@media only screen and (max-width: 1200px) 
	{
		.allBadge{ width: 50%; } 
	}
	@media only screen and (max-width: 1100px) 
	{
		.userContainer{ width: 90%; padding: 2%; }
		.userBadgesFlex{ width: 79%; }
		.badgeOut{ width: 80%; }
	}
	@media only screen and (max-width: 930px) 
	{
		.navContainerBig{ flex-direction: column; }
		.mobileMenuBarBig{ display: flex; }
		.menuBarBig{ display: none; }.flexNavbarBig{ display: none; }.userNavbarBig{ display: none; }
		
		#menuButton{ display: inline-block; height: 40px; flex: 1; padding: 8px 0; }
		#homeButton{ text-align: center; flex: 8; padding: 8px 0; }
		
		.userBadgesFlex{ width: 84%; }
		.badgeOut{ width: 85%; }
	}
	@media only screen and (max-width: 800px) 
	{
		.userBadgesFlex{ flex-direction: column; width: 69%; }
		.badgeOut{ width: 70%; }
		#userPointsDiv{ margin: 2% 0; }
		#userBadgesNumberDiv{ margin: 1% 0; }
		
		.allBadge{ width: 100%; } 
	}
	@media only screen and (max-width: 700px) 
	{
		.usernameDiv{ text-align: center; }
		.userBar{ flex-direction: column; border-bottom: 0px; }
		.userBarOption{ border-bottom: 0.5px solid rgb(232, 232, 232); }
	
		#menuButton{ flex: 1; }
		#homeButton{ flex: 7; }
	}
	@media only screen and (max-width: 600px) 
	{
		#menuButton{ flex: 1; }
		#homeButton{ flex: 6; }
		
		.userBadgesFlex{ width: 84%; }
		.badgeOut{ width: 85%; }
	}
	@media only screen and (max-width: 550px) 
	{
		#menuButton{ flex: 1; }
		#homeButton{ flex: 4; }
	}
</style>
</head>
<body>
	<div id="badgesOverlay" class="disabled">
		<div class="contentOfTheOverlay">
			<div class="allBadgesTitleDiv">
				<h3 style="font-size:1.8em;font-weight:400;">Badges</h3>
				<div class="closeButtonDiv"><a class="closeButton" onClick="toggleAllBadges()" title="Exit">&#10799;</a></div>
			</div>
			<div class="filterBadgesDiv">
				<div onClick="changeActiveBadgesOption('bronzeBadgesOption')" class="searchBadgesOption"><a id="bronzeBadgesOption">Bronze</a></div>
				<div onClick="changeActiveBadgesOption('silverBadgesOption')" class="searchBadgesOption"><a id="silverBadgesOption">Silver</a></div>
				<div onClick="changeActiveBadgesOption('goldBadgesOption')" class="searchBadgesOption"><a id="goldBadgesOption">Gold</a></div>
				<div onClick="changeActiveBadgesOption('allBadgesOption')" class="searchBadgesOption"><a id="allBadgesOption" class="activeBadgesOption">All</a></div>
				<div class="searchBadges"> <form><input type="text" id="badgeName" name="Search for a badge"/></form> <i onClick="crunchifyAjax();changeActiveBadgesOption('searchBadgesOption');" id="searchBadgesOption1" class="material-icons searchButton">search</i> </div>
			</div>
			<div id="allBadgesID" class="allBadges">
				<c:forEach items="${allBadges}" var="badge" varStatus="i">
					<div class="allBadge">
						<c:if test="${badge.badgeColor == 'bronze'}"><p class="allBadgesTitle" id="bronzeBadgesTitle"><a class="circle" id="bronzeCircleNum"></a>${badge.badgeTitle}</p></c:if>
						<c:if test="${badge.badgeColor == 'silver'}"><p class="allBadgesTitle" id="silverBadgesTitle"><a class="circle" id="silverCircleNum"></a>${badge.badgeTitle}</p></c:if>
						<c:if test="${badge.badgeColor == 'gold'}"><p class="allBadgesTitle" id="goldBadgesTitle"><a class="circle" id="goldCircleNum"></a>${badge.badgeTitle}</p></c:if>
						<p class="allBadgesInfo">${badge.badgeInfo}</p>
					</div>
				</c:forEach>
			</div>
			<div id="bronzeBadgesID" class="disabled">
				<c:forEach items="${bronzeBadges}" var="badge" varStatus="i">
					<div class="allBadge">
						<c:if test="${badge.badgeColor == 'bronze'}"><p class="allBadgesTitle" id="bronzeBadgesTitle"><a class="circle" id="bronzeCircleNum"></a>${badge.badgeTitle}</p></c:if>
						<c:if test="${badge.badgeColor == 'silver'}"><p class="allBadgesTitle" id="silverBadgesTitle"><a class="circle" id="silverCircleNum"></a>${badge.badgeTitle}</p></c:if>
						<c:if test="${badge.badgeColor == 'gold'}"><p class="allBadgesTitle" id="goldBadgesTitle"><a class="circle" id="goldCircleNum"></a>${badge.badgeTitle}</p></c:if>
						<p class="allBadgesInfo">${badge.badgeInfo}</p>
					</div>
				</c:forEach>
			</div>
			<div id="silverBadgesID" class="disabled">
				<c:forEach items="${silverBadges}" var="badge" varStatus="i">
					<div class="allBadge">
						<c:if test="${badge.badgeColor == 'bronze'}"><p class="allBadgesTitle" id="bronzeBadgesTitle"><a class="circle" id="bronzeCircleNum"></a>${badge.badgeTitle}</p></c:if>
						<c:if test="${badge.badgeColor == 'silver'}"><p class="allBadgesTitle" id="silverBadgesTitle"><a class="circle" id="silverCircleNum"></a>${badge.badgeTitle}</p></c:if>
						<c:if test="${badge.badgeColor == 'gold'}"><p class="allBadgesTitle" id="goldBadgesTitle"><a class="circle" id="goldCircleNum"></a>${badge.badgeTitle}</p></c:if>
						<p class="allBadgesInfo">${badge.badgeInfo}</p>
					</div>
				</c:forEach>
			</div>
			<div id="goldBadgesID" class="disabled">
				<c:forEach items="${goldBadges}" var="badge" varStatus="i">
					<div class="allBadge">
						<c:if test="${badge.badgeColor == 'bronze'}"><p class="allBadgesTitle" id="bronzeBadgesTitle"><a class="circle" id="bronzeCircleNum"></a>${badge.badgeTitle}</p></c:if>
						<c:if test="${badge.badgeColor == 'silver'}"><p class="allBadgesTitle" id="silverBadgesTitle"><a class="circle" id="silverCircleNum"></a>${badge.badgeTitle}</p></c:if>
						<c:if test="${badge.badgeColor == 'gold'}"><p class="allBadgesTitle" id="goldBadgesTitle"><a class="circle" id="goldCircleNum"></a>${badge.badgeTitle}</p></c:if>
						<p class="allBadgesInfo">${badge.badgeInfo}</p>
					</div>
				</c:forEach>
			</div>
			<div id="searchBadgesID" class="disabled">
			</div>
		</div>
	</div>

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
				<a class="userBarOption" href="<c:url value="/user/${userModel.username}"/>" >About me</a>
				<a class="userBarOption activeBarOption" href="<c:url value="/user/${userModel.username}/badges"/>" >Badges (${numberOfBadges})</a>
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
		
		<div class="userBadgesFlex">
			<div class="userBadgeFlexOut" id="userPointsDiv">
				<div class="userBadgeFlexIn">
					<h5 class="userBadgeFlexTitle">REPUTATION</h5>
					<div class="userReputationDiv">
						<div class="reputationFlex1">
							<h2 class="userPoints">${userAccountInfo.score}</h2>
							<p class="userRank"><a id="rankListLink" title="List of top 100 users" href="/SpringMvcExample/bestUsers/list">Rank ${userRaking} overall</a></p>
						</div>
						<div class="reputationFlex2">
							<div class="reputationFlex">
							<p class="reputationField"><span class="reputationFieldNumber">${countOfGivenlikes}</span> <c:if test="${countOfGivenlikes==1}">point</c:if><c:if test="${countOfGivenlikes!=1}">points</c:if> for given likes</p>
							<p class="reputationField"><span class="reputationFieldNumber">${countOfReceivedLikes}</span> points for received likes</p>
							<p class="reputationField"><span class="reputationFieldNumber">${countOfComments}</span> points for written comments</p>
							<p class="reputationField"><span class="reputationFieldNumber">${numberOfRatings}</span> <c:if test="${numberOfRatings==1}">point</c:if><c:if test="${numberOfRatings!=1}">points</c:if> for movie ratings</p>
						</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="userBadgeFlexOut" id="userBadgesNumberDiv">
				<div class="userBadgeFlexIn">
					<h5 class="userBadgeFlexTitle">BADGES</h5>
					<div class="numberOfBadges">
						<p id="goldBadge" class="badge" title="${numberOfGoldBadges} gold badges"><a class="circle" id="goldCircleNum"></a>${numberOfGoldBadges}</p>
						<p id="silverBadge" class="badge" title="${numberOfSilverBadges} silver badges"><a class="circle" id="silverCircleNum"></a>${numberOfSilverBadges}</p>
						<p id="bronzeBadge" class="badge" title="${numberOfBronzeBadges} bronze badges"><a class="circle" id="bronzeCircleNum"></a>${numberOfBronzeBadges}</p>
					</div>
					<c:if test="${numberOfBadges == 0}">
						<div class="badgeDivFlexCon1">
							<div class="noBadgesYet badgeDivFlex1">This user has not earned any badge yet</div>
							<div class="badgeDivFlex1">
								<p class="userBadges"><a onClick="toggleAllBadges()" class="badgesListLink" title="List of all badges avaiable to get">All badges</a></p>
							</div>
						</div>
					</c:if>
					<c:if test="${numberOfBadges > 0}">
						<div class="badgeDivFlexCon1">
							<div class="badgeDiv badgeDivFlex1">
								<p style="display:inline-block;padding-right:7px;">Newest</p>
								<p class="badgePar" title="${lastBadge.badgeInfo}">
									<c:if test="${lastBadge.badgeColor == 'gold'}"><a class="circle" id="goldCircle"></a></c:if>
									<c:if test="${lastBadge.badgeColor == 'silver'}"><a class="circle" id="silverCircle"></a></c:if>
									<c:if test="${lastBadge.badgeColor == 'bronze'}"><a class="circle" id="bronzeCircle"></a></c:if>
								${lastBadge.badgeTitle}</p>
							</div>
							<div class="badgeDivFlex1">
								<p class="userBadges"><a onClick="toggleAllBadges()" class="badgesListLink" title="List of all badges avaiable to get" >All badges</a></p>
							</div>
						</div>
					</c:if>
				</div>
			</div>
		</div>
		
		
		<div class="badgeOut">
			<div class="badgeIn">
				<h3 class="userBadgesTitle"><span class="userBadgesNumber">${numberOfBadges}</span> Badges</h3>
				<div class="badgesDiv">
					<c:if test="${numberOfBadges == 0}"><div class="emptyBadgeDiv"></div></c:if>
					<c:forEach items="${badges}" var="badge" varStatus="i">
						<div class="badgeDiv">
							<p class="badgePar" title="${badge.badgeInfo}">
								<c:if test="${badge.badgeColor == 'gold'}"><a class="circle" id="goldCircle"></a></c:if>
								<c:if test="${badge.badgeColor == 'silver'}"><a class="circle" id="silverCircle"></a></c:if>
								<c:if test="${badge.badgeColor == 'bronze'}"><a class="circle" id="bronzeCircle"></a></c:if>
							${badge.badgeTitle}</p>
						</div>
					</c:forEach>
				</div>
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
	
	function toggleAllBadges()
	{
		var body = document.getElementsByTagName("BODY")[0];
		
		var badgesOverlay = document.getElementById( "badgesOverlay" );
		if( badgesOverlay.className == "disabled" ) { badgesOverlay.className = "enabled"; body.style.overflow = "hidden"; }
		else{ badgesOverlay.className = "disabled"; body.style.overflow = "auto"; }
	}
	
	function changeActiveBadgesOption(badgesOptionID)
	{
		var bronzeBadgesOption = document.getElementById( "bronzeBadgesOption" );
		var silverBadgesOption = document.getElementById( "silverBadgesOption" );
		var goldBadgesOption = document.getElementById( "goldBadgesOption" );
		var allBadgesOption = document.getElementById( "allBadgesOption" );
		var searchBadgesOption = document.getElementById( "searchBadgesOption1" );
		
		var badgesOption = document.getElementById( badgesOptionID );
		
		var bronzeBadgesID = document.getElementById( "bronzeBadgesID" );
		var silverBadgesID = document.getElementById( "silverBadgesID" );
		var goldBadgesID = document.getElementById( "goldBadgesID" );
		var allBadgesID = document.getElementById( "allBadgesID" );
		var searchBadgesID = document.getElementById( "searchBadgesID" );
		
		if( 'bronzeBadgesOption' == badgesOptionID )
		{
			silverBadgesOption.className = "";goldBadgesOption.className = "";
			allBadgesOption.className = "";bronzeBadgesOption.className = "activeBadgesOption";
			
			silverBadgesID.className = "disabled";goldBadgesID.className = "disabled";
			allBadgesID.className = "disabled";bronzeBadgesID.className = "allBadges";
			searchBadgesID.className = "disabled";
		}
		else if( 'silverBadgesOption' == badgesOptionID )
		{
			bronzeBadgesOption.className = "";goldBadgesOption.className = "";
			allBadgesOption.className = "";silverBadgesOption.className = "activeBadgesOption";
			
			silverBadgesID.className = "allBadges";goldBadgesID.className = "disabled";
			allBadgesID.className = "disabled";bronzeBadgesID.className = "disabled";
			searchBadgesID.className = "disabled";
		}
		else if( 'goldBadgesOption' == badgesOptionID )
		{
			bronzeBadgesOption.className = "";silverBadgesOption.className = "";
			allBadgesOption.className = "";goldBadgesOption.className = "activeBadgesOption";
			
			silverBadgesID.className = "disabled";goldBadgesID.className = "allBadges";
			allBadgesID.className = "disabled";bronzeBadgesID.className = "disabled";
			searchBadgesID.className = "disabled";
		}
		else if( 'allBadgesOption' == badgesOptionID )
		{
			bronzeBadgesOption.className = "";silverBadgesOption.className = "";
			goldBadgesOption.className = "";allBadgesOption.className = "activeBadgesOption";
			
			silverBadgesID.className = "disabled";goldBadgesID.className = "disabled";
			allBadgesID.className = "allBadges";bronzeBadgesID.className = "disabled";
			searchBadgesID.className = "disabled";
		}
		else if( 'searchBadgesOption' == badgesOptionID )
		{
			bronzeBadgesOption.className = "";silverBadgesOption.className = "";
			goldBadgesOption.className = "";allBadgesOption.className = "";
			
			silverBadgesID.className = "disabled";goldBadgesID.className = "disabled";
			allBadgesID.className = "disabled";bronzeBadgesID.className = "disabled";
			searchBadgesID.className = "allBadges";
		}
	}
	
	function crunchifyAjax() 
	{
	    $.ajax({
	        url : '/SpringMvcExample/searchBadges2',
	        data : { badgeName : $('#badgeName').val() },
	        success: function(data)
	        {
	        	var badgesID = "";
	        	var badges = [];
	        	for(var i=0; i<data.length; i++)
	        	{
	        		badges.push( JSON.parse( data[i] ) );
	        		badgesID += "<div class='allBadge'>";
	        		if( badges[i].badgeColor == "bronze" ){ badgesID += "<p class='allBadgesTitle' id='bronzeBadgesTitle'><a class='circle' id='bronzeCircleNum'></a>" + badges[i].badgeTitle + "</p>"; }
	        		if( badges[i].badgeColor == "silver" ){ badgesID += "<p class='allBadgesTitle' id='silverBadgesTitle'><a class='circle' id='silverCircleNum'></a>" + badges[i].badgeTitle + "</p>"; }
	        		if( badges[i].badgeColor == "gold" ){ badgesID += "<p class='allBadgesTitle' id='goldBadgesTitle'><a class='circle' id='goldCircleNum'></a>" + badges[i].badgeTitle + "</p>"; }
	        		badgesID += "<p class='allBadgesInfo'>" + badges[i].badgeInfo + "</p> </div>";
	        	}
	        	$('#searchBadgesID').html( badgesID );
	        }
	    });
	}
</script>
</body>
</html>