<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<meta name="viewport" content="width=device-width, user-scalable=no"/>
<Style>
	*{ margin: 0; padding: 0; box-sizing: border-box;}
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
	
	.fullContainer{ background-color: white; text-align: center; width: 100%; padding-bottom: 40px; }
	.userContainer{ width: 80%; text-align: justify; padding: 2%; margin: auto; }
	.userBar{ display: flex; border-top: 0.5px solid rgb(232, 232, 232); border-bottom: 0.5px solid rgb(232, 232, 232); }
	.userBarOption{ flex: 1; text-align: center; padding: 7px 3px; font-size: 1.1em; }
	.host{ display: inline; color: red; }
	.mod{ display: inline; color: green; }
	.user{ display: inline; color: blue; }
	.usernameDiv{ padding: 10px; }
	.titleUsername{ display: inline; font-size: 1.7em; }
	.userDescription{ color: #6a737c; font-size: 1.2em; }
	.titleBorder{ width: 100%; padding: 16px 8px; border-left: 0.5px solid rgb(232, 232, 232); border-right: 0.5px solid rgb(232, 232, 232); border-top: 0.5px solid rgb(232, 232, 232); }
	.title{ text-align: center;  color: #e6ac00; }
	.activeBarOption{ color: #e6ac00; }
	
	#circle{ display: inline-block; width: 20px; height: 20px; border-radius: 10px; background-color: crimson; color: white; margin: auto; }
	
	.userNotifications{ width: 50%; margin: auto; }
	.wholeUserNotification{ height: 50px; display: flex; width: 100%; padding: 7px 9px; border-top: solid 0.5px rgb(232, 232, 232); border-left: solid 0.5px rgb(232, 232, 232); border-right: solid 0.5px rgb(232, 232, 232); }
	.flexNotifications{ display: flex; flex-direction: column; }
	.notificationBorder{ width: 100%; padding: 0 8px; border: solid 0.5px rgb(232, 232, 232); margin-bottom: 30px; }
	.singleNotification{ display: inline-block; text-align: left; width: 100%; }
	.activeNotification{ color: #e6ac00; }
	.activeNotification:hover{ color: #e52; transition: all 0.1s linear 0s; }
	.movieLink:hover{ color: #e52; transition: all 0.1s linear 0s; }
	.commentTime{ font-size: 0.8em; color: grey; text-align: left; width: 100%; padding-top: 2px; }
	
	.aloneDiv{   width: 130px; margin: auto;  }
	.buttonDiv0{ width: 130px; margin: auto;  }
	.buttonDiv1{ width: 140px; margin: auto;  }
	.buttonDiv2{ width: 220px; margin: auto;  }
	.aloneButton{ border: 0.5px solid black;appearance: button; text-decoration: none; background-color: black; color: white; padding: 6px 12px 6px 12px;font-size: 25px; text-align: center;}
	.leftButton{ border: 0.5px solid black; appearance: button; text-decoration: none; background-color: white; color: black; padding:  6px 8px 6px 12px; font-size: 25px; font-weight: bold;text-align: center;}
	.rightButton{ border: 0.5px solid black; appearance: button; text-decoration: none; background-color: white; color: black; padding:  6px 14px 6px 13px; font-size: 25px; font-weight: bold;text-align: center;}
	.middleButton{ border: 0.5px solid black; appearance: button; text-decoration: none; background-color: white; color: black; padding: 6px 6px 6px 12px;font-size: 25px; text-align: center;}
	.middleButtonPage0{color:white;background-color: black;}
	.currentPageButton{ border: 0.5px solid black; appearance: button; text-decoration: none; background-color: black; color: white; padding: 6px 6px 6px 12px;font-size: 25px; text-align: center;}
	.lastPageButton{ border: 0.5px solid black; appearance: button; text-decoration: none; background-color: black; color: white; 	padding: 6px 12px 6px 12px;font-size: 25px; text-align: center;}
	.spaceButton{ padding: 2px; }
	.aloneButton:hover{ background-color: black; color: white; }
	.rightButton:hover{ background-color: black; color: white; }
	.leftButton:hover{ background-color: black; color: white; }
	.middleButton:hover{ background-color: black; color: white; }
	.currentPageButton:hover{ background-color: black; color: white; }
	.lastPageButton:hover{ background-color: black; color: white; }
		
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
	}
	@media only screen and (max-width: 700px) 
	{
		.usernameDiv{ text-align: center; }
		.userContainer{ width: 90%; padding: 2%; }
		.userBar{ flex-direction: column; border-bottom: 0px; }
		.userBarOption{ border-bottom: 0.5px solid rgb(232, 232, 232); }
		
		.userNotifications{ width: 90%; padding: 2%; }
		
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${userModel.username} Notifications</title>
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
				<c:if test="${not empty userInfoModel.description}">
					<p class="userDescription">${userInfoModel.description}</p>
				</c:if>
			</div>
		
			<div class="userBar">
				<a class="userBarOption" href="<c:url value="/user/${userModel.username}"/>" >About me</a>
				<a class="userBarOption" href="<c:url value="/user/${userModel.username}/badges"/>" >Badges (${numberOfBadges})</a>
				<a class="userBarOption" href="<c:url value="/user/${userModel.username}/ratings?page=0"/>" >Ratings (${numberOfRatings})</a>
				<a class="userBarOption" href="<c:url value="/user/${userModel.username}/friends?page=0"/>" >Friends (${numberOfFriends})</a>
				<c:if test="${user.username == userModel.username}">
					<a class="userBarOption" href="<c:url value="/user/${userModel.username}/friendsActivity?page=0"/>" >Friends Activity</a>
					<a class="userBarOption activeBarOption" href="<c:url value="/user/${userModel.username}/notifications?page=0"/>" >Notifications 
					<c:if test="${not empty numberOfNewNotifications}">
						<div id="circle">${numberOfNewNotifications}</div>
					</c:if></a>
					<a class="userBarOption" href="<c:url value="/user/${userModel.username}/editAccount"/>" >Edit account</a>
				</c:if>
			</div>	
		</div>
			
		<div class="userNotifications">
			<c:choose>
				<c:when test="${not empty noNotifications}">
					<p>${noNotifications}</p>
				</c:when>
				<c:when test="${not empty pageDoesntExists}">
					<h3>Error occured</h3>
					<p>${pageDoesntExists}</p>
				</c:when>
				<c:otherwise>
					<div class="titleBorder">
						<h3 class="title">Notifications</h3>
					</div>
					<c:forEach items="${notifications}" var="notification" varStatus="i">
						<div class="wholeUserNotification">
							<c:if test="${notification.seen == 'new'}">
								<div style="margin:auto 10px auto 0;text-align:center;background-color:crimson;height:6px;width:6px;border-radius:50%;"></div>
							</c:if>
							<div class="flexNotifications">
								<sec:authorize access="isAuthenticated()">
									<c:choose>
										<c:when test="${ notification.type == 'reply' || notification.type == 'like' }">
											<p class="singleNotification">
												<a class="activeNotification" href="<c:url value="/user/${notification.fromUser}"/>">${notification.fromUser}</a>
												<a class="movieLink" href="<c:url value="/movies/${notification.movieID}"/>"> ${notification.notification}</a>
											</p>
										</c:when>
										<c:otherwise>
											<p class="singleNotification">
												<a class="activeNotification" href="<c:url value="/user/${notification.fromUser}"/>">${notification.fromUser}</a>
												 ${notification.notification}
											</p>
										</c:otherwise>		
									</c:choose>
									<c:if test="${not empty notification.time}">
										<div class="commentTime">&bull; ${notification.time}</div>
									</c:if>	
								</sec:authorize>
							</div>
						</div>
					</c:forEach>
					<div class="notificationBorder"></div>
					
					<c:choose>
						<c:when test="${notificationPages == 1}">
 							<div class="aloneDiv">
								<a class="aloneButton" href="<c:url value="/user/${userModel.username}/notifications?page=0"/>"> 1 </a>
							</div>
  						</c:when>
 						<c:when test="${page == 0}">
 							<div class="buttonDiv0">
								<a class="middleButton middleButtonPage0" href="<c:url value="/user/${userModel.username}/notifications?page=0"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="rightButton" href="<c:url value="/user/${userModel.username}/notifications?page=${page+1}"/>"> &gt; </a>
							</div>
  						</c:when>
  						<c:when test="${page == notificationPages-1}">
  							<div class="buttonDiv1">
        						<a class="leftButton" href="<c:url value="/user/${userModel.username}/notifications?page=${page-1}"/>"> &lt; </a>
								<a class="spaceButton"></a>
								<a class="middleButton" href="<c:url value="/user/${userModel.username}/notifications?page=0"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="lastPageButton" href="<c:url value="/user/${userModel.username}/notifications?page=${page}"/>"> ${page+1} </a>
							</div>
  						</c:when>
  						<c:when test="${page > 0}">
  							<div class="buttonDiv2">
        						<a class="leftButton" href="<c:url value="/user/${userModel.username}/notifications?page=${page-1}"/>"> &lt; </a>
								<a class="spaceButton"></a>
								<a class="middleButton" href="<c:url value="/user/${userModel.username}/notifications?page=0"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="currentPageButton" href="<c:url value="/user/${userModel.username}/notifications?page=${page}"/>"> ${page+1} </a>
								<a class="spaceButton"></a>
								<a class="rightButton" href="<c:url value="/user/${userModel.username}/notifications?page=${page+1}"/>"> &gt; </a>
							</div>
  						</c:when>
					</c:choose>
					
				</c:otherwise>
			</c:choose>
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