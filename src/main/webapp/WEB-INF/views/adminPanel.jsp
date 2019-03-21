<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<meta name="viewport" content="width=device-width, user-scalable=no"/>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<Style>
	*{ margin: 0; padding: 0; box-sizing: border-box; }
	body{ width: 100%; background-color: black; position: relative; }
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
	
	
	.fullContainer{ background-color: white; text-align: center; width: 100%; padding-bottom: 250px; padding-top: 20px; }
	.adminContainer{ text-align: center; display: flex; flex-wrap: wrap; margin-bottom: 20px; }
	.databaseOperation1{ flex: 1; border-right: 1px solid black; }
	.databaseOperation2{ flex: 1; border-left: 1px solid black; }
	.title{ text-align: center; margin: 11px; font-size: 1.8em; }
	.operationTitle{ margin: 12px; font-size: 1.5em; }
	.smallerOperationTitle{ margin: 5px; }
	.bothOperations{ display: flex; }
	.updateOperation{ flex: 1; }
	.deleteOperation{ flex: 1; } /* #e7e7e7   */
	.addButton{ padding: 4px 8px; margin: 3px; background-color: #003399; color: white; border: 0.2px solid #000099; transition: all 0.1s linear 0s; text-align: center; text-decoration: none; border-radius: 5px; }
	.addButton:hover{ color: white; background-color: #002b80; }
	.addButton:focus{ box-shadow: 0 0 6px #000033; }
	.updateButton{ background-color: #009900; color: white; margin: 3px; padding: 4px 8px; border: 0.2px solid #00b300; transition: all 0.1s linear 0s; border-radius: 5px; }
	.updateButton:hover{ color: white; background-color: #008000; cursor: pointer; }
	.updateButton:focus{ box-shadow: 0 0 6px #006600; outline: none; }
	.deleteButton{ background-color: #cc0000; color: white; margin: 3px; padding: 4px 8px; border: 0.2px solid #cc0000; transition: all 0.1s linear 0s; border-radius: 5px; }
	.deleteButton:hover{ color: white; background-color: #b30000; cursor: pointer; }
	.deleteButton:focus{ box-shadow: 0 0 6px #990000; outline: none; }
	
	.footer{ background-color: black; width: 100%; border-top: solid 0.6px #404040; height: 60px; }
	.footerSpace{ width: 80%; margin:auto; height: 60px;}
	.footerText{ text-align: center; color: white; line-height: 60px; }
	
	#moderatorsListOverlay{ height: 100%; background: grey; position: absolute; top: 0; right: 0; bottom: 0; left: 0; background-color: rgba(0,0,0,0.7); z-index: 20; }
	.enabled{ display: block }
	.disabled{ display: none; }
	.contentOfTheOverlayUsers{ background-color: rgba(128,128,128,0); position: fixed; left: 15%; top: 10%; height: 80%; width: 70%; background-color: white; color: black; border-radius: 5px; padding-bottom: 20px; }
	.moderators{ overflow-y:auto; height: 400px; width: 95%; margin: 30px auto auto auto; border: 1px solid #bfbfbf; border-radius: 5px; text-align: left; display: flex; flex-wrap: wrap; align-content: flex-start; }
	
	.moderatorsTitleDiv{ margin: 15px 5px; text-align: center; position: relative; }
	.closeButtonDiv{ width: 22px; height: 21px; position: absolute; top: 7px; right: 2.5%; }
	.closeButton{ padding: 2px 6px 4px 6px; border-radius: 5px; background-color: white; border: 0.5px solid #bfbfbf; font-weight: 1900; -webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; -o-user-select: none; user-select: none; }
	.closeButton:hover{ cursor: pointer; background-color: #F8F8F8; color: black; }
	
	.moderatorsButton:hover{ cursor: pointer; }
	
	.rolesContainer{ display: flex; width: 100%; text-align: center; }
	#admins{ flex: 1; border-top: solid 1px rgb(232, 232, 232); }
	#hosts{  flex: 1; border-top: solid 1px rgb(232, 232, 232);  }
	.tableTitle{ width: 100%; padding: 9px; border-bottom: solid 0.6px rgb(232, 232, 232); border-left: solid 1px rgb(232, 232, 232); border-right: solid 1px rgb(232, 232, 232); }
	.usernameColumn{ display: block; border-right: solid 1px rgb(232, 232, 232); border-left: solid 1px rgb(232, 232, 232); border-bottom: solid 0.6px rgb(232, 232, 232); width: 100%; height: 30px; line-height: 30px; }
	
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
	@media only screen and (max-width: 930px) 
	{
		.navContainerBig{ flex-direction: column; }
		.mobileMenuBarBig{ display: flex; }
		.menuBarBig{ display: none; }.flexNavbarBig{ display: none; }.userNavbarBig{ display: none; }
		
		#menuButton{ display: inline-block; height: 40px; flex: 1; padding: 8px 0; }
		#homeButton{ text-align: center; flex: 8; padding: 8px 0; }
		
		.adminContainer{ flex-direction: column; }
		.databaseOperation1{ border: 0; }
		.databaseOperation2{ border: 0; }
		.bothOperations{ width: 80%; margin: auto; }
	}
	@media only screen and (max-width: 700px) 
	{
		#menuButton{ flex: 1; }
		#homeButton{ flex: 7; }
	}
	@media only screen and (max-width: 600px) 
	{
		.bothOperations{ width: 100%; }
	
		#menuButton{ flex: 1; }
		#homeButton{ flex: 6; }
	}
	@media only screen and (max-width: 550px) 
	{
		#menuButton{ flex: 1; }
		#homeButton{ flex: 4; }
	}
</Style>
<title>Admin Panel</title>
</head>
<body>
	<div id="moderatorsListOverlay" class="disabled">
		<div class="contentOfTheOverlayUsers">
			<div class="moderatorsTitleDiv">
				<h3 style="font-size:1.8em;font-weight:400;">Moderators</h3>
				<div class="closeButtonDiv"><a class="closeButton" onClick="toggleModerators()" title="Exit">&#10799;</a></div>
				<div id="moderatorsID" class="moderators">
					<div class="rolesContainer">
						<div id="admins">
						</div>
						<div id="hosts">
						</div>
					</div>
				</div>
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
					<a class="option logobutton" title="My account" href="<c:url value="/user/${user.username}"/>">myAccount</a>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<a class="option activelogobutton" title="Moderator privileges" href="<c:url value="/adminPanel"/>" >Admin</a>
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
		<h3 class="title">Admin Panel</h3>
		<div class="adminContainer">
		
			<div class="databaseOperation1">
				<h3 class="operationTitle">Movies</h3>
				
				<a class="addButton" href="<c:url value="/movies/add"/>" >Add Movie</a><h3></h3>
				
				<div class="bothOperations">
					<div class="updateOperation">
						<h4 class="smallerOperationTitle">Update Movie</h4>
						<form method="POST" action="updateMovie">	
							<p>Movie ID:</p> <input class="inline" type='text' name="movieID" >
							<h3></h3>
							<input class="updateButton" name="submit" type="submit" value="Update" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>
					<div class="deleteOperation">
						<h4 class="smallerOperationTitle">Delete Movie</h4>
						<form method="POST" action="deleteMovie">	
							<p>Movie ID:</p> <input class="inline" type='text' name="movieID" >
							<h3></h3>
							<input class="deleteButton" name="submit" type="submit" value="Delete" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>
				</div>
			</div>
			
			<div class="databaseOperation2">
				<h3 class="operationTitle">People</h3>
				
				<a class="addButton" href="<c:url value="/people/add"/>" >Add Person</a><h3></h3>
				
				<div class="bothOperations">
					<div class="updateOperation">
						<h4 class="smallerOperationTitle">Update Person</h4>
						<form method="POST" action="updatePerson">	
							<p>Person ID:</p> <input class="inline" type='text' name="personID" >
							<h3></h3>
							<input class="updateButton" name="submit" type="submit" value="Update" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>
					<div class="deleteOperation">
						<h4 class="smallerOperationTitle">Delete Person</h4>
						<form method="POST" action="deletePerson">	
							<p>Person ID:</p> <input class="inline" type='text' name="personID" >
							<h3></h3>
							<input class="deleteButton" name="submit" type="submit" value="Delete" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>
				</div>
			</div>
			
		</div>
		<a class="moderatorsButton" onClick="toggleModerators()" title="All moderators">Moderators list</a>
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
	
	// jquery ajax, get admins
	function getAdmins() 
	{
	    $.ajax({
	        url : '/SpringMvcExample/moderators/listOfAdmins',
	        success: function(data)
	        {
	        	var moderatorsHTML = "<h3 class='tableTitle'>Admins</h3>";
	        	var dataLength = data.length;
	        	for(var i=0; i<dataLength; i++)
	        	{
	        		moderatorsHTML += "<a class='usernameColumn' href='<c:url value='/user/"+data[i]+"'/>'>"+data[i]+"</a>";
	        	}
	        	$('#admins').html( moderatorsHTML );
	        }
	    });
	}
	
	// jquery ajax, get hosts
	function getHosts() 
	{
	    $.ajax({
	        url : '/SpringMvcExample/moderators/listOfHosts',
	        success: function(data)
	        {
	        	var moderatorsHTML = "<h3 class='tableTitle'>Hosts</h3>";
	        	var dataLength = data.length;
	        	for(var i=0; i<dataLength; i++)
	        	{
	        		moderatorsHTML += "<a class='usernameColumn' href='<c:url value='/user/"+data[i]+"'/>'>"+data[i]+"</a>";
	        	}
	        	$('#hosts').html( moderatorsHTML );
	        }
	    });
	}
	
	// turn overlay of moderators
	function toggleModerators()
	{
		var body = document.getElementsByTagName("BODY")[0];
		var bestUsersOverlay = document.getElementById( "moderatorsListOverlay" );
		
		if( bestUsersOverlay.className == "disabled" ) { bestUsersOverlay.className = "enabled"; body.style.overflow = "hidden"; }
		else{ bestUsersOverlay.className = "disabled"; body.style.overflow = "auto"; }
		
		getAdmins();
		getHosts();
	}
	
	$( "#moderatorsListOverlay" ).on('click', function(e) {
		if (e.target === this)
		{
			toggleModerators();
		}
	});
</script>
</body>
</html>