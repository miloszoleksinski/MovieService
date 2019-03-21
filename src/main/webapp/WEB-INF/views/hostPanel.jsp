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
	*{ margin: 0; padding: 0; box-sizing: border-box; box-sizing: border-box; }
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
	
	
	.fullContainer{ background-color: white; text-align: center; width: 100%; padding-bottom: 233px; padding-top: 20px; }
	.title{ text-align: center; margin: 11px; font-size: 1.8em; }
	.operationTitle{ margin: 12px; font-size: 1.5em; }
	.smallerOperationTitle{ margin: 5px; }
	.operationContainer{ display: flex; flex-wrap: wrap; }
	.userOperations{ flex: 1; border-right: solid 0.6px black; padding: 2%; }
	.adminOperations{ flex: 1; border-right: solid 0.6px black; border-left: solid 0.6px black; padding: 2%; }
	.hostOperations{ flex: 1; border-left: solid 0.6px black; padding: 2%; }
	.bothOperations{ display: flex; }
	.takeOperation{ flex: 1; }
	.giveOperation{ flex: 1; }
	.takeButton{ background-color: #cc0000; color: white; margin: 4px; padding: 4px 8px; border: 0.2px solid #990000; transition: all 0.1s linear 0s; border-radius: 5px; }
	.takeButton:hover{ background-color: #b30000; color: white; cursor: pointer; }
	.takeButton:focus{ box-shadow: 0 0 6px #990000; outline: none; }
	.giveButton{ background-color: #009900; color: white; margin: 4px; padding: 4px 8px; border: 0.2px solid #006600; transition: all 0.1s linear 0s; border-radius: 5px; }
	.giveButton:hover{ background-color: #008000; color: white; cursor: pointer; }
	.giveButton:focus{ box-shadow: 0 0 6px #006600; outline: none; }
		
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
	@media only screen and (max-width: 1180px) 
	{
		.adminOperations{ border-right: 0.6px solid white; }
		.hostOperations{ border-left: 0.6px solid white; }
	}
	@media only screen and (max-width: 930px) 
	{
		.navContainerBig{ flex-direction: column; }
		.mobileMenuBarBig{ display: flex; }
		.menuBarBig{ display: none; }.flexNavbarBig{ display: none; }.userNavbarBig{ display: none; }
		
		#menuButton{ display: inline-block; height: 40px; flex: 1; padding: 8px 0; }
		#homeButton{ text-align: center; flex: 8; padding: 8px 0; }
	}
	@media only screen and (max-width: 800px) 
	{
		.operationContainer{ flex-direction: column; }
		.adminOperations{ border: 0; }
		.hostOperations{ border: 0; }
		.userOperations{ border: 0; }
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
<title>Host Panel</title>
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
						<div class="middleBar"></div>
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
						<a class="option logobutton" title="Moderator privileges" href="<c:url value="/adminPanel"/>" >Admin</a>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_HOST')">
						<a class="option activelogobutton" title="Host privileges" href="<c:url value="/hostPanel"/>" >Host</a>
					</sec:authorize>
				</div>
			</sec:authorize>
		</div>
	</div>
	
	<h6 class="menuHeightBig" id="menuHeight"></h6>
	
	<div class="fullContainer">
		<h3 class="title">Host Panel</h3>
		<c:if test="${not empty changeOlas}"><div class="error">${changeOlas}</div><h3 class="spaceBetweenInput"></h3></c:if>
		<div class="operationContainer">
			<div class="userOperations">
				<h3 class="operationTitle">Operations on User</h3>
				<div class="bothOperations">
					<div class="takeOperation">
						<h4 class="smallerOperationTitle">Ban user</h4>
						<c:if test="${not empty cantBan}"><div class="error">${cantBan}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<c:if test="${not empty banned}"><div class="succes">${banned}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<c:if test="${not empty alreadyBanned}"><div class="error">${alreadyBanned}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<form method="POST" action="banUser">	
							<p>Username:</p> <input class="inline" type='text' name="username" >
							<h3></h3>
							<input class="takeButton" name="submit" type="submit" value="Ban" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>
					<div class="giveOperation">
						<h4 class="smallerOperationTitle">Unban user</h4>
						<c:if test="${not empty cantUnban}"><div class="error">${cantUnban}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<c:if test="${not empty unbanned}"><div class="succes">${unbanned}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<c:if test="${not empty alreadyUnbanned}"><div class="error">${alreadyUnbanned}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<form method="POST" action="unbanUser">	
							<p>Username:</p> <input class="inline" type='text' name="username" >
							<h3></h3>
							<input class="giveButton" name="submit" type="submit" value="Unban" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>
				</div>  
			</div>
			<div class="adminOperations">
				<h3 class="operationTitle">Operations on Admin</h3>
				<div class="bothOperations">
					<div class="takeOperation">
						<h4 class="smallerOperationTitle">Take admin</h4>
						<c:if test="${not empty cantTakeAdmin}"><div class="error">${cantTakeAdmin}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<c:if test="${not empty adminTaken}"><div class="succes">${adminTaken}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<c:if test="${not empty noAdminRole}"><div class="error">${noAdminRole}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<c:if test="${not empty userIsHost}"><div class="error">${userIsHost}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<form method="POST" action="takeAdmin">	
							<p>Username:</p> <input class="inline" type='text' name="username" >
							<h3></h3>
							<input class="takeButton" name="submit" type="submit" value="Take" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>
					<div class="giveOperation">
						<h4 class="smallerOperationTitle">Give admin</h4>
						<c:if test="${not empty cantGiveAdmin}"><div class="error">${cantGiveAdmin}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<c:if test="${not empty adminGiven}"><div class="succes">${adminGiven}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<c:if test="${not empty alreadyAdmin}"><div class="error">${alreadyAdmin}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<c:if test="${not empty wrongAdminRoles}"><div class="error">${wrongAdminRoles}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<form method="POST" action="giveAdmin">	
							<p>Username:</p> <input class="inline" type='text' name="username" >
							<h3></h3>
							<input class="giveButton" name="submit" type="submit" value="Give" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>
				</div>
			</div>
			<div class="hostOperations">
				<h3 class="operationTitle">Operations on Host</h3>
				<div class="bothOperations">
					<div class="takeOperation">
						<h4 class="smallerOperationTitle">Take host</h4>
						<c:if test="${not empty cantTakeHost}"><div class="error">${cantTakeHost}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<c:if test="${not empty hostTaken}"><div class="succes">${hostTaken}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<c:if test="${not empty userIsNotHost}"><div class="error">${userIsNotHost}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<form method="POST" action="takeHost">	
							<p>Username:</p> <input class="inline" type='text' name="username" >
							<h3></h3>
							<input class="takeButton" name="submit" type="submit" value="Take" />
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						</form>
					</div>
					<div class="giveOperation">
						<h4 class="smallerOperationTitle">Give host</h4>
						<c:if test="${not empty cantGiveHost}"><div class="error">${cantGiveHost}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<c:if test="${not empty hostGiven}"><div class="succes">${hostGiven}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<c:if test="${not empty alreadyHost}"><div class="error">${alreadyHost}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<c:if test="${not empty wrongHostRoles}"><div class="error">${wrongHostRoles}</div><h3 class="spaceBetweenInput"></h3></c:if>
						<form method="POST" action="giveHost">	
							<p>Username:</p> <input class="inline" type='text' name="username" >
							<h3></h3>
							<input class="giveButton" name="submit" type="submit" value="Give" />
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