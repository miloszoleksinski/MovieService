<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<meta name="viewport" content="width=device-width, user-scalable=no"/>
	<style>
		*{ margin: 0; padding: 0; box-sizing: border-box;}
		body{ width: 100%; background-color: black; }
		a{ text-decoration: none; color: black; }
		a:hover{ color: #e6ac00; transition: all 0.1s linear 0s; }
		h6{ height: 60px; }
		.fullContainer{ background-color: white; width: 100%; height: 100%; padding: 40px 0 140px 0; }
		
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
		
		.bestUsersContainer{ width: 50%; margin: auto; text-align: center; border: solid 1px rgb(232, 232, 232); }
		.tableTitle{ width: 100%; padding: 9px; color: #e6ac00; border-bottom: solid 0.6px rgb(232, 232, 232); }
		.usernameColumn{ border-bottom: solid 0.6px rgb(232, 232, 232); width: 100%; display: flex; text-align: left; }
		
		.userCounter{ border-right: 1.3px solid rgb(232, 232, 232); text-align: center; padding: 6px; flex: 12; }
		.userUsername{ padding: 6px 4px 6px 8px; flex: 76; }
		.userScore{ border-left: 1.3px solid rgb(232, 232, 232); text-align: center; padding: 6px; flex: 12; }
		
		.userCounterTab{ font-weight: bold; border-right: 1.3px solid rgb(232, 232, 232); text-align: center; padding: 6px; flex: 12; text-align: center; }
		.userUsernameTab{ font-weight: bold; padding: 6px 4px 6px 8px; flex: 76; text-align: center; }
		.userScoreTab{ font-weight: bold; border-left: 1.3px solid rgb(232, 232, 232); text-align: center; padding: 6px; flex: 12; text-align: center; }
		
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
	@media only screen and (max-width: 1000px) 
	{
		.bestUsersContainer{ width: 80%; }
	}
	@media only screen and (max-width: 930px) 
	{
		.navContainerBig{ flex-direction: column; }
		.mobileMenuBarBig{ display: flex; }
		.menuBarBig{ display: none; }.flexNavbarBig{ display: none; }.userNavbarBig{ display: none; }
			
		#menuButton{ display: inline-block; height: 40px; flex: 1; padding: 8px 0; }
		#homeButton{ text-align: center; flex: 8; padding: 8px 0; }
			
		.fullContainer{ padding: 40px 2% 60px 2%; }
		.bestUsersContainer{ width: 85%; }
	}
	@media only screen and (max-width: 700px) 
	{
	 	.fullContainer{ padding: 40px 2%; }
	 	.bestUsersContainer{ width: 90%; }
	 		
	 	.userCounter{ flex: 18; }
		.userUsername{ flex: 64; }
		.userScore{ flex: 18; }
		
		.userCounterTab{ flex: 18; }
		.userUsernameTab{flex: 64; }
		.userScoreTab{ flex: 18; }
			
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
	</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MovieInfo</title>
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
					<a class="option logobutton" title="My account" href="<c:url value="/user/${user.username}"/>">myAccount</a>
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
		<div class="bestUsersContainer">
			<h3 class="tableTitle">TOP 100</h3>
			<div class="usernameColumn">
				<p class="userCounterTab">number</p>
				<p class="userUsernameTab">username</p>
				<p class="userScoreTab">score</p>
			</div>
				
			<c:forEach items="${bestUsers}" var="user" varStatus="i">
				<div class="usernameColumn">
					<p class="userCounter" id="counter${i.index+1}">${i.index+1}</p>
					<a class="userUsername" href="<c:url value="/user/${user.username}"/>">${user.username}</a>
					<p class="userScore">${user.score}</p>
				</div>
			</c:forEach>
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
</script>
</body>
</html>