<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="springForm"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="viewport" content="width=device-width, user-scalable=no"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<style>
	*{ margin: 0; padding: 0; box-sizing: border-box;}
	body{ width: 100%; background-color: black; }
	a{ text-decoration: none; color: black; }
	a:hover{ color: #e6ac00; transition: all 0.1s linear 0s; }
	h6{ height: 60px; }
	.fullContainer{ background-color: white; padding: 40px 0; }
	
	.typeTopMargin{ margin-top: 5px; }
	.submitButton{ color: black; margin: 4px; padding: 4px 8px; border: 0.2px solid black; transition: all 0.1s linear 0s; }
	.submitButton:hover{ color: white; background-color: black; cursor: pointer; }
	.filterTitle{ font-size: 1.1em; margin-bottom: 2px; }
	.title{ padding: 11px; }
	.filterDiv{ width: 80%; background-color: white; margin: auto; padding-bottom: 20px; text-align: center; }
	
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
	
	.peopleDiv{ width: 80%; background-color: white; margin: auto; border-right: solid 0.6px #404040; border-left: solid 0.6px #404040; }
	.personInfoWithAll{ height: 84px; margin: 5px 15px; }
	.personInfoWithoutHeight{ height: 69px; margin: 5px 15px; }
	.inline{ display: inline;}
	.desc{ color: #b3b3b3; display: inline; }
	.descOption{ display: inline; }
	.personName:hover{ color: #808080; }
	
	.paginationContainer{ width: 80%; margin: auto; background-color: white; padding: 15px 0; }
	.aloneDiv{ width: 60px; margin: auto;  }
	.buttonDiv0{ width: 80px; margin: auto;  }
	.buttonDiv1{ width: 116px; margin: auto;  }
	.buttonDiv2{ width: 157px; margin: auto;  }
	.aloneButton{ 
		border: 0.5px solid black; 
		appearance: button; 
		text-decoration: none; 
		background-color: black; 
		color: white; 
		padding: 6px 12px 6px 12px;
		font-size: 25px; 
		text-align: center;
	}
	.leftButton{ 
		border: 0.5px solid black; 
		appearance: button; 
		text-decoration: none; 
		background-color: white; 
		color: black; 
		padding:  6px 8px 6px 12px; 
		font-size: 25px; 
		font-weight: bold;
		text-align: center;
	}
	.rightButton{ 
		border: 0.5px solid black; 
		appearance: button; 
		text-decoration: none; 
		background-color: white; 
		color: black; 
		padding:  6px 14px 6px 13px; 
		font-size: 25px; 
		font-weight: bold;
		text-align: center;
	}
	.middleButton{ 
		border: 0.5px solid black; 
		appearance: button; 
		text-decoration: none; 
		background-color: white; 
		color: black; 
		padding: 6px 6px 6px 12px;
		font-size: 25px; 
		text-align: center;
	}
	.middleButtonPage0{
		color:white;
		background-color: black;
	}
	.currentPageButton{ 
		border: 0.5px solid black; 
		appearance: button; 
		text-decoration: none; 
		background-color: black; 
		color: white; 
		padding: 6px 6px 6px 12px;
		font-size: 25px; 
		text-align: center;
	}
	.lastPageButton{ 
		border: 0.5px solid black; 
		appearance: button; 
		text-decoration: none; 
		background-color: black; 
		color: white; 
		padding: 6px 12px 6px 12px;
		font-size: 25px; 
		text-align: center;
	}
	.spaceButton{ padding: 2px; }
	.aloneButton:hover{ background-color: black; color: white; }
	.rightButton:hover{ background-color: black; color: white; }
	.leftButton:hover{ background-color: black; color: white; }
	.middleButton:hover{ background-color: black; color: white; }
	.currentPageButton:hover{ background-color: black; color: white; }
	.lastPageButton:hover{ background-color: black; color: white; }
	.error{ text-align: center; }
	
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
	@media only screen and (max-width: 930px) 
	{
		.navContainerBig{ flex-direction: column; }
		.mobileMenuBarBig{ display: flex; }
		.menuBarBig{ display: none; }.flexNavbarBig{ display: none; }.userNavbarBig{ display: none; }
		
		#menuButton{ display: inline-block; height: 40px; flex: 1; padding: 8px 0; }
		#homeButton{ text-align: center; flex: 8; padding: 8px 0; }
		
		.peopleDiv{ width: 90%; }
		.personInfoWithAll{ height: 100%; }
	}
	@media only screen and (max-width: 800px) 
	{
		.peopleDiv{ width: 96%; text-align: center; }
	}
		@media only screen and (max-width: 700px) 
	{
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
<title>People</title>
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
				<a class="option activelogobutton" title="People" href="<c:url value="/people?page=0"/>">People</a>
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
		<div class="filterDiv" >
			<springForm:form method="POST" modelAttribute="PersonFilterParams" action="people/filtered">
				<h2 class="title">Search people</h2>
				<h3></h3>
				<p class="filterTitle typeTopMargin">Name</p>
				<springForm:input path="name" placeholder="Name" />
				<input class="submitButton" type="submit" value="Search">
			</springForm:form>
		</div>
	
		<div class="peopleDiv" >
			<hr/>
			<c:forEach items="${people}" var="person">
				
				<c:choose>
					<c:when test="${person.growth > 50}">
	 					<div class="personInfoWithAll">
							<h2 class="inline"><a class="personName" href="<c:url value="/person/${person.id}"/>">${person.name}</a></h2>
							<h3></h3>
	    					<p class="desc">Growth: </p>  <p class="descOption">${person.growth}</p> <p class="inline"> cm</p>
							<h3></h3>
							<p class="desc">Birth date: </p>  <p class="descOption">${person.birth_date}</p>
							<h3></h3>
							<p class="desc">Born in: </p>  <p class="descOption">${person.born}</p> 
						</div>
	  				</c:when>
  				
	  				<c:otherwise>
	  					<div class="personInfoWithoutHeight">
							<h2 class="inline"><a class="personName" href="<c:url value="/person/${person.id}"/>">${person.name}</a></h2>
							<h3></h3>
	    					<p class="desc">Birth date: </p>  <p class="descOption">${person.birth_date}</p>
							<h3></h3>
							<p class="desc">Born in: </p>  <p class="descOption">${person.born}</p> 
						</div>
	  				</c:otherwise>
	  			</c:choose>
				
				<hr/>
			</c:forEach>	
		</div>
	
		<c:choose>
			<c:when test="${typeOfSite == 'all'}">
				<div class="paginationContainer">
					<c:choose>
						<c:when test="${pageSize == 0}">
	 						<h2 class="error">Unfortunately, we did not find the results.</h2>
							<h3 class="error">Change filter criteria</h3>
	  					</c:when>
	  					<c:when test="${page > pageSize-1}">
	  						<h2 class="error" >Error occured</h2>
	  						<h3 class="error" >Page does not exists</h3>
	  					</c:when>
			 			<c:when test="${pageSize == 1}">
	 						<div class="aloneDiv">
								<a class="aloneButton" href="<c:url value="/people?page=0"/>"> 1 </a>
							</div>
	  					</c:when>
	 					<c:when test="${page == 0}">
	 						<div class="buttonDiv0">
								<a class="middleButton middleButtonPage0" href="<c:url value="/people?page=0"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="rightButton" href="<c:url value="/people?page=${page+1}"/>"> &gt; </a>
							</div>
	  					</c:when>
	  					<c:when test="${page == pageSize-1}">
	  						<div class="buttonDiv1">
	        					<a class="leftButton" href="<c:url value="/people?page=${page-1}"/>"> &lt; </a>
								<a class="spaceButton"></a>
								<a class="middleButton" href="<c:url value="/people?page=0"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="lastPageButton" href="<c:url value="/people?page=${page}"/>"> ${page+1} </a>
							</div>
	  					</c:when>
	  					<c:when test="${page > 0}">
	  						<div class="buttonDiv2">
	        					<a class="leftButton" href="<c:url value="/people?page=${page-1}"/>"> &lt; </a>
								<a class="spaceButton"></a>
								<a class="middleButton" href="<c:url value="/people?page=0"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="currentPageButton" href="<c:url value="/people?page=${page}"/>"> ${page+1} </a>
								<a class="spaceButton"></a>
								<a class="rightButton" href="<c:url value="/people?page=${page+1}"/>"> &gt; </a>
							</div>
	  					</c:when>
					</c:choose>
				</div>
			</c:when>
			<c:when test="${typeOfSite == 'name'}">
				<div class="paginationContainer">
					<c:choose>
						<c:when test="${pageSize == 0}">
	 						<h2 class="error">Unfortunately, we did not find the results.</h2>
							<h3 class="error">Change filter criteria</h3>
	  					</c:when>
	  					<c:when test="${page > pageSize-1}">
	  						<h2 class="error" >Error occured</h2>
	  						<h3 class="error" >Page does not exists</h3>
	  					</c:when>
			 			<c:when test="${pageSize == 1}">
	 						<div class="aloneDiv">
								<a class="aloneButton" href="<c:url value="/people?page=0&name=${name}"/>"> 1 </a>
							</div>
	  					</c:when>
	 					<c:when test="${page == 0}">
	 						<div class="buttonDiv0">
								<a class="middleButton middleButtonPage0" href="<c:url value="/people?page=0&name=${name}"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="rightButton" href="<c:url value="/people?page=${page+1}&name=${name}"/>"> &gt; </a>
							</div>
	  					</c:when>
	  					<c:when test="${page == pageSize-1}">
	  						<div class="buttonDiv1">
	        					<a class="leftButton" href="<c:url value="/people?page=${page-1}&name=${name}"/>"> &lt; </a>
								<a class="spaceButton"></a>
								<a class="middleButton" href="<c:url value="/people?page=0&name=${name}"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="lastPageButton" href="<c:url value="/people?page=${page}&name=${name}"/>"> ${page+1} </a>
							</div>
	  					</c:when>
	  					<c:when test="${page > 0}">
	  						<div class="buttonDiv2">
	        					<a class="leftButton" href="<c:url value="/people?page=${page-1}&name=${name}"/>"> &lt; </a>
								<a class="spaceButton"></a>
								<a class="middleButton" href="<c:url value="/people?page=0&name=${name}"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="currentPageButton" href="<c:url value="/people?page=${page}&name=${name}"/>"> ${page+1} </a>
								<a class="spaceButton"></a>
								<a class="rightButton" href="<c:url value="/people?page=${page+1}&name=${name}"/>"> &gt; </a>
							</div>
	  					</c:when>
					</c:choose>
				</div>
			</c:when>
			<c:when test="${typeOfSite == 'year'}">
				<div class="paginationContainer">
					<c:choose>
						<c:when test="${pageSize == 0}">
	 						<h2 class="error">Unfortunately, we did not find the results.</h2>
							<h3 class="error">Change filter criteria</h3>
	  					</c:when>
	  					<c:when test="${page > pageSize-1}">
	  						<h2 class="error" >Error occured</h2>
	  						<h3 class="error" >Page does not exists</h3>
	  					</c:when>
			 			<c:when test="${pageSize == 1}">
	 						<div class="aloneDiv">
								<a class="aloneButton" href="<c:url value="/people?page=0&year=${year}"/>"> 1 </a>
							</div>
	  					</c:when>
	 					<c:when test="${page == 0}">
	 						<div class="buttonDiv0">
								<a class="middleButton middleButtonPage0" href="<c:url value="/people?page=0&year=${year}"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="rightButton" href="<c:url value="/people?page=${page+1}&year=${year}"/>"> &gt; </a>
							</div>
	  					</c:when>
	  					<c:when test="${page == pageSize-1}">
	  						<div class="buttonDiv1">
	        					<a class="leftButton" href="<c:url value="/people?page=${page-1}&year=${year}"/>"> &lt; </a>
								<a class="spaceButton"></a>
								<a class="middleButton" href="<c:url value="/people?page=0&year=${year}"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="lastPageButton" href="<c:url value="/people?page=${page}&year=${year}"/>"> ${page+1} </a>
							</div>
	  					</c:when>
	  					<c:when test="${page > 0}">
	  						<div class="buttonDiv2">
	        					<a class="leftButton" href="<c:url value="/people?page=${page-1}&year=${year}"/>"> &lt; </a>
								<a class="spaceButton"></a>
								<a class="middleButton" href="<c:url value="/people?page=0&year=${year}"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="currentPageButton" href="<c:url value="/people?page=${page}&year=${year}"/>"> ${page+1} </a>
								<a class="spaceButton"></a>
								<a class="rightButton" href="<c:url value="/people?page=${page+1}&year=${year}"/>"> &gt; </a>
							</div>
	  					</c:when>
					</c:choose>
				</div>
			</c:when>
			<c:when test="${typeOfSite == 'endYear'}">
				<div class="paginationContainer">
					<c:choose>
						<c:when test="${pageSize == 0}">
	 						<h2 class="error">Unfortunately, we did not find the results.</h2>
							<h3 class="error">Change filter criteria</h3>
	  					</c:when>
	  					<c:when test="${page > pageSize-1}">
	  						<h2 class="error" >Error occured</h2>
	  						<h3 class="error" >Page does not exists</h3>
	  					</c:when>
			 			<c:when test="${pageSize == 1}">
	 						<div class="aloneDiv">
								<a class="aloneButton" href="<c:url value="/people?page=0&endYear=${endYear}"/>"> 1 </a>
							</div>
	  					</c:when>
	 					<c:when test="${page == 0}">
	 						<div class="buttonDiv0">
								<a class="middleButton middleButtonPage0" href="<c:url value="/people?page=0&endYear=${endYear}"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="rightButton" href="<c:url value="/people?page=${page+1}&endYear=${endYear}"/>"> &gt; </a>
							</div>
	  					</c:when>
	  					<c:when test="${page == pageSize-1}">
	  						<div class="buttonDiv1">
	        					<a class="leftButton" href="<c:url value="/people?page=${page-1}&endYear=${endYear}"/>"> &lt; </a>
								<a class="spaceButton"></a>
								<a class="middleButton" href="<c:url value="/people?page=0&endYear=${endYear}"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="lastPageButton" href="<c:url value="/people?page=${page}&endYear=${endYear}"/>"> ${page+1} </a>
							</div>
	  					</c:when>
	  					<c:when test="${page > 0}">
	  						<div class="buttonDiv2">
	        					<a class="leftButton" href="<c:url value="/people?page=${page-1}&endYear=${endYear}"/>"> &lt; </a>
								<a class="spaceButton"></a>
								<a class="middleButton" href="<c:url value="/people?page=0&endYear=${endYear}"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="currentPageButton" href="<c:url value="/people?page=${page}&endYear=${endYear}"/>"> ${page+1} </a>
								<a class="spaceButton"></a>
								<a class="rightButton" href="<c:url value="/people?page=${page+1}&endYear=${endYear}"/>"> &gt; </a>
							</div>
	  					</c:when>
					</c:choose>
				</div>
			</c:when>
			<c:when test="${typeOfSite == 'yearEndYear'}">
				<div class="paginationContainer">
					<c:choose>
						<c:when test="${pageSize == 0}">
	 						<h2 class="error">Unfortunately, we did not find the results.</h2>
							<h3 class="error">Change filter criteria</h3>
	  					</c:when>
	  					<c:when test="${page > pageSize-1}">
	  						<h2 class="error" >Error occured</h2>
	  						<h3 class="error" >Page does not exists</h3>
	  					</c:when>
			 			<c:when test="${pageSize == 1}">
	 						<div class="aloneDiv">
								<a class="aloneButton" href="<c:url value="/people?page=0&year=${year}&endYear=${endYear}"/>"> 1 </a>
							</div>
	  					</c:when>
	 					<c:when test="${page == 0}">
	 						<div class="buttonDiv0">
								<a class="middleButton middleButtonPage0" href="<c:url value="/people?page=0&year=${year}&endYear=${endYear}"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="rightButton" href="<c:url value="/people?page=${page+1}&year=${year}&endYear=${endYear}"/>"> &gt; </a>
							</div>
	  					</c:when>
	  					<c:when test="${page == pageSize-1}">
	  						<div class="buttonDiv1">
	        					<a class="leftButton" href="<c:url value="/people?page=${page-1}&year=${year}&endYear=${endYear}"/>"> &lt; </a>
								<a class="spaceButton"></a>
								<a class="middleButton" href="<c:url value="/people?page=0&year=${year}&endYear=${endYear}"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="lastPageButton" href="<c:url value="/people?page=${page}&year=${year}&endYear=${endYear}"/>"> ${page+1} </a>
							</div>
	  					</c:when>
	  					<c:when test="${page > 0}">
	  						<div class="buttonDiv2">
	        					<a class="leftButton" href="<c:url value="/people?page=${page-1}&year=${year}&endYear=${endYear}"/>"> &lt; </a>
								<a class="spaceButton"></a>
								<a class="middleButton" href="<c:url value="/people?page=0&year=${year}&endYear=${endYear}"/>"> 1 </a>
								<a class="spaceButton"></a>
								<a class="currentPageButton" href="<c:url value="/people?page=${page}&year=${year}&endYear=${endYear}"/>"> ${page+1} </a>
								<a class="spaceButton"></a>
								<a class="rightButton" href="<c:url value="/people?page=${page+1}&year=${year}&endYear=${endYear}"/>"> &gt; </a>
							</div>
	  					</c:when>
					</c:choose>
				</div>
			</c:when>
		</c:choose>
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