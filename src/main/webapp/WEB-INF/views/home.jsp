<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	.inline{ display: inline; }
	.fullContainer{ background-color: white; padding: 40px 0; }
	
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
 	.homeIcon{ font-size:1.4em;color:#e6ac00;margin:-2px 0 -3px 0;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none; }
	#menuButton:hover{ cursor: pointer; }
	#menuButtonBig:hover{ cursor: pointer; }
	.menuButtonBigClass{ display: none; }
	.menuButtonBigResponsive{ display: block; }
	/*  MENU BAR  */
	
	.Title{ text-align: center; }
	.smallerTitle{ text-align: center; height: 30px; margin: 30px 10px 0px 10px; }
	
	.SliderContainer{ width: 80%; height: 110px; margin: 0px auto 40px auto; border: 2px solid #e6e6e6; text-align: center; }
	.SliderFlex{ height: 100%; width: 100%; display: flex; position: relative; }
	.backgroundInsideSlider{ width: 100%; }
	.ThreeThingsDiv{ height: 110px; width: 90%; display: flex; position: absolute; left: 5%; transition: 0.8s opacity, 0.8s margin; }
	.sliderInfoContainer{ flex: 1; text-align: center; height: 110px; padding: 10px; margin: auto; }
	.borderBar{ border: 1px solid #e6e6e6; margin: auto; height: 90px; margin-top: 10px; }
	#bestMoviesDiv1{ margin-left: 0px; }#bestMoviesDiv2{ margin-left: -15px; z-index: -1; opacity: 0; }#bestMoviesDiv3{ z-index: -1; opacity: 0; }
	#newestMoviesDiv1{ margin-left: 0px; }#newestMoviesDiv2{ margin-left: -15px; z-index: -1; opacity: 0; }#newestMoviesDiv3{ z-index: -1; opacity: 0; }
	#lastlyAddedMovieDiv1{ margin-left: 0px; }#lastlyAddedMovieDiv2{ margin-left: -15px; z-index: -1; opacity: 0; }#lastlyAddedMovieDiv3{ z-index: -1; opacity: 0; }
	.sliderCircles{ width: 57px; height: 19px; margin: 3px auto auto auto; display: flex; } .sliderCircles:hover{ cursor: pointer; }
	.sliderCircleContainer{ width: 19px; height: 19px; display: block; }
	.sliderCircle{ width: 11px; height: 11px; border-radius: 50%; border: 2px solid #bbb; margin: 4px; display: inline-block; transition: 0.8s all; } 
	
	#bestMoviesCircle1{ background-color: #bbb; width: 13px; height: 13px; margin: 3px; }
	#newestMoviesCircle1{ background-color: #bbb; width: 13px; height: 13px; margin: 3px; }
	#lastlyAddedMovieCircle1{ background-color: #bbb; width: 13px; height: 13px; margin: 3px; }
	
	.sliderNumber{ color: #e6ac00; font-size: 1.5em; }
	.sliderInfoTitle{ display: inline; }
	.sliderInfoYear{ display: inline; font-size: 0.9em; }
	.sliderInfoDirector{ padding-top: 3px; }
	.sliderInfo{ font-weight: bold; }
	.ratingStar{ overflow: hidden; text-indent: 9999px; white-space: nowrap; width: 1em; }
	.ratingStar:before{ content: '\2605'; color: #e52; }
	
	.leftButton{  width: 5%; height: 100%; font-size: 5em; font-weight: bold; color: #e6e6e6; z-index: 5; -webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; -o-user-select: none; user-select: none; }.leftButton:hover{ cursor: pointer; }
	.rightButton{ width: 5%; height: 100%; font-size: 5em; font-weight: bold; color: #e6e6e6; z-index: 5; -webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; -o-user-select: none; user-select: none; } .rightButton:hover{ cursor: pointer; }
	
	.footer{ background-color: black; width: 100%; border-top: solid 0.6px #404040; height: 60px; }
	.footerSpace{ width: 80%; margin: auto; height: 60px;}
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
	@media only screen and (max-width: 980px) 
	{
		.SliderContainer{ width: 90%; }
	}
	@media only screen and (max-width: 930px) 
	{
		.SliderContainer{ width: 95%; }
		.SliderContainer{ height: 120px; }
		.borderBar{ height: 100px; }
		.leftButton{ height: 116px; padding-top: 5px; }
		.rightButton{ height: 116px; padding-top: 5px; }
		
		.navContainerBig{ flex-direction: column; }
		.mobileMenuBarBig{ display: flex; }
		.menuBarBig{ display: none; }.flexNavbarBig{ display: none; }.userNavbarBig{ display: none; }
		
		#menuButton{ display: inline-block; height: 40px; flex: 1; padding: 8px 0; }
		#homeButton{ text-align: center; flex: 8; padding: 8px 0; }
	}
	@media only screen and (max-width: 800px) 
	{
		.SliderContainer{ height: 130px; }
		.borderBar{ height: 110px; }
		.leftButton{ height: 126px; padding-top: 10px; }
		.rightButton{ height: 126px; padding-top: 10px; }
	}
	@media only screen and (max-width: 750px) 
	{
		.SliderContainer{ height: 140px; }
		.borderBar{ height: 120px; }
		.leftButton{ height: 136px; padding-top: 15px; }
		.rightButton{ height: 136px; padding-top: 15px; }
	}
	@media only screen and (max-width: 700px) 
	{
		.SliderContainer{ height: 150px; }
		.borderBar{ height: 130px; }
		.leftButton{ height: 146px; padding-top: 20px; }
		.rightButton{ height: 146px; padding-top: 20px; }
		
		#menuButton{ flex: 1; }
		#homeButton{ flex: 7; }
	}
	@media only screen and (max-width: 650px) 
	{
		.SliderContainer{ height: 160px; }
		.borderBar{ height: 140px; }
		.leftButton{ height: 156px; padding-top: 25px; }
		.rightButton{ height: 156px; padding-top: 25px; }
	}
	@media only screen and (max-width: 600px) 
	{
		.SliderContainer{ height: 170px; }
		.borderBar{ height: 150px; }
		.leftButton{ height: 166px; padding-top: 30px; }
		.rightButton{ height: 166px; padding-top: 30px; }
		
		#menuButton{ flex: 1; }
		#homeButton{ flex: 6; }
	}
	@media only screen and (max-width: 550px) 
	{
		.SliderContainer{ height: 180px; }
		.borderBar{ height: 160px; }
		.leftButton{ height: 176px; padding-top: 35px; }
		.rightButton{ height: 176px; padding-top: 35px; }
		
		#menuButton{ flex: 1; }
		#homeButton{ flex: 4; }
	}
	@media only screen and (max-width: 500px) 
	{
		.ThreeThingsDiv{ width: 86%; left: 7%; }
		.leftButton{ width: 7%; }
		.rightButton{ width: 7%; }
	}
</style>
<title>MovieInfo</title>
</head>
<body>
	<div id="menuBorder">
		<div id="navContainer" class="navContainerBig">
			<div id="mobileMenuBar" class="mobileMenuBarBig">
				<a class="logo logobutton" id="menuButton" title="Menu" onClick="toggleMenuList(${rolesNumber})" ><i class="material-icons menuIcon">menu</i></a>
				<a class="logo activelogobutton" title="Home" id="homeButton" href="<c:url value="/"/>"><i class="material-icons homeIcon">home</i></a>
			</div>
			<div id="menuBar" class="menuBarBig">	
				<a class="logo logobutton menuButtonBigClass" title="Menu" id="menuButtonBig" onClick="toggleMenuList(${rolesNumber})" ><i class="material-icons menuIcon">menu</i></a>
				<a class="logo activelogobutton" title="Home" href="<c:url value="/"/>"><i class="material-icons homeIcon">home</i></a>
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
	
		<div class="Title">
			Welcome to MovieInfo
		</div>
			
		<h3 class="smallerTitle">TOP 9 rated movies</h3>
		<div class="SliderContainer">
			<div class="SliderFlex">
				<a class="leftButton" onClick="previousBestMoviesSlide()"> &#8249; </a>
				<div class="backgroundInsideSlider"></div>
				<div class="ThreeThingsDiv" id="bestMoviesDiv1">
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">1.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${bestMovies[0].id}">${bestMovies[0].title}</a></h4> 
						<p class="sliderInfoYear">${bestMovies[0].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${directorLink[0]}"> ${bestMovies[0].director}</a></p>
						<c:choose>
							<c:when test="${bestMovies[0].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${bestMovies[0].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">2.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${bestMovies[1].id}">${bestMovies[1].title}</a></h4> 
						<p class="sliderInfoYear">${bestMovies[1].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${directorLink[1]}"> ${bestMovies[1].director}</a></p>
						<c:choose>
							<c:when test="${bestMovies[1].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${bestMovies[1].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">3.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${bestMovies[2].id}">${bestMovies[2].title}</a></h4> 
						<p class="sliderInfoYear">${bestMovies[2].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${directorLink[2]}"> ${bestMovies[2].director}</a></p>
						<c:choose>
							<c:when test="${bestMovies[2].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${bestMovies[2].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="ThreeThingsDiv" id="bestMoviesDiv2">
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">4.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${bestMovies[3].id}">${bestMovies[3].title}</a></h4> 
						<p class="sliderInfoYear">${bestMovies[3].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${directorLink[3]}"> ${bestMovies[3].director}</a></p>
						<c:choose>
							<c:when test="${bestMovies[3].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${bestMovies[3].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">5.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${bestMovies[4].id}">${bestMovies[4].title}</a></h4> 
						<p class="sliderInfoYear">${bestMovies[4].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${directorLink[4]}"> ${bestMovies[4].director}</a></p>
						<c:choose>
							<c:when test="${bestMovies[4].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${bestMovies[4].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">6.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${bestMovies[5].id}">${bestMovies[5].title}</a></h4> 
						<p class="sliderInfoYear">${bestMovies[5].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${directorLink[5]}"> ${bestMovies[5].director}</a></p>
						<c:choose>
							<c:when test="${bestMovies[5].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${bestMovies[5].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="ThreeThingsDiv" id="bestMoviesDiv3">
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">7.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${bestMovies[6].id}">${bestMovies[6].title}</a></h4> 
						<p class="sliderInfoYear">${bestMovies[6].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${directorLink[6]}"> ${bestMovies[6].director}</a></p>
						<c:choose>
							<c:when test="${bestMovies[6].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${bestMovies[6].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">8.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${bestMovies[7].id}">${bestMovies[7].title}</a></h4> 
						<p class="sliderInfoYear">${bestMovies[7].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${directorLink[7]}"> ${bestMovies[7].director}</a></p>
						<c:choose>
							<c:when test="${bestMovies[7].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${bestMovies[7].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">9.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${bestMovies[8].id}">${bestMovies[8].title}</a></h4> 
						<p class="sliderInfoYear">${bestMovies[8].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${directorLink[8]}"> ${bestMovies[8].director}</a></p>
						<c:choose>
							<c:when test="${bestMovies[8].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${bestMovies[8].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<a class="rightButton" onClick="nextBestMoviesSlide()"> &#8250; </a>
			</div>
			<div class="sliderCircles">
				<a class="sliderCircleContainer" onClick="changeBestMovieCircle(1)"><span class="sliderCircle" id="bestMoviesCircle1"></span></a>
				<a class="sliderCircleContainer" onClick="changeBestMovieCircle(2)"><span class="sliderCircle" id="bestMoviesCircle2"></span></a>
				<a class="sliderCircleContainer" onClick="changeBestMovieCircle(3)"><span class="sliderCircle" id="bestMoviesCircle3"></span></a>
			</div>
		</div>
		
		<h3 class="smallerTitle">9 newest movies</h3>
		<div class="SliderContainer">
			<div class="SliderFlex">
				<a class="leftButton" onClick="previousNewestMoviesSlide()"> &#8249; </a>
				<div class="backgroundInsideSlider"></div>
				<div class="ThreeThingsDiv" id="newestMoviesDiv1">
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">1.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${newMovies[0].id}">${newMovies[0].title}</a></h4> 
						<p class="sliderInfoYear">${newMovies[0].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${newestMovieDirectorLink[0]}"> ${newMovies[0].director}</a></p>
						<c:choose>
							<c:when test="${newMovies[0].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${newMovies[0].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">2.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${newMovies[1].id}">${newMovies[1].title}</a></h4> 
						<p class="sliderInfoYear">${newMovies[1].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${newestMovieDirectorLink[1]}"> ${newMovies[1].director}</a></p>
						<c:choose>
							<c:when test="${newMovies[1].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${newMovies[1].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">3.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${newMovies[2].id}">${newMovies[2].title}</a></h4> 
						<p class="sliderInfoYear">${newMovies[2].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${newestMovieDirectorLink[2]}"> ${newMovies[2].director}</a></p>
						<c:choose>
							<c:when test="${newMovies[2].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${newMovies[2].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="ThreeThingsDiv" id="newestMoviesDiv2">
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">4.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${newMovies[3].id}">${newMovies[3].title}</a></h4> 
						<p class="sliderInfoYear">${newMovies[3].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${newestMovieDirectorLink[3]}"> ${newMovies[3].director}</a></p>
						<c:choose>
							<c:when test="${newMovies[3].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${newMovies[3].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">5.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${newMovies[4].id}">${newMovies[4].title}</a></h4> 
						<p class="sliderInfoYear">${newMovies[4].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${newestMovieDirectorLink[4]}"> ${newMovies[4].director}</a></p>
						<c:choose>
							<c:when test="${newMovies[4].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${newMovies[4].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">6.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${newMovies[5].id}">${newMovies[5].title}</a></h4> 
						<p class="sliderInfoYear">${newMovies[5].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${newestMovieDirectorLink[5]}"> ${newMovies[5].director}</a></p>
						<c:choose>
							<c:when test="${newMovies[5].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${newMovies[5].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="ThreeThingsDiv" id="newestMoviesDiv3">
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">7.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${newMovies[6].id}">${newMovies[6].title}</a></h4> 
						<p class="sliderInfoYear">${newMovies[6].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${newestMovieDirectorLink[6]}"> ${newMovies[6].director}</a></p>
						<c:choose>
							<c:when test="${newMovies[6].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${newMovies[6].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">8.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${newMovies[7].id}">${newMovies[7].title}</a></h4> 
						<p class="sliderInfoYear">${newMovies[7].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${newestMovieDirectorLink[7]}"> ${newMovies[7].director}</a></p>
						<c:choose>
							<c:when test="${newMovies[7].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${newMovies[7].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">9.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${newMovies[8].id}">${newMovies[8].title}</a></h4> 
						<p class="sliderInfoYear">${newMovies[8].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${newestMovieDirectorLink[8]}"> ${newMovies[8].director}</a></p>
						<c:choose>
							<c:when test="${newMovies[8].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${newMovies[8].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<a class="rightButton" onClick="nextNewestMoviesSlide()"> &#8250; </a>
			</div>
			<div class="sliderCircles">
				<a class="sliderCircleContainer" onClick="changeNewestMovieCircle(1)"><span class="sliderCircle" id="newestMoviesCircle1"></span></a>
				<a class="sliderCircleContainer" onClick="changeNewestMovieCircle(2)"><span class="sliderCircle" id="newestMoviesCircle2"></span></a>
				<a class="sliderCircleContainer" onClick="changeNewestMovieCircle(3)"><span class="sliderCircle" id="newestMoviesCircle3"></span></a>
			</div>
		</div>
		
		<h3 class="smallerTitle">9 lastly added movies</h3>
		<div class="SliderContainer">
			<div class="SliderFlex">
				<a class="leftButton" onClick="previousLastlyAddedMovieSlide()"> &#8249; </a>
				<div class="backgroundInsideSlider"></div>
				<div class="ThreeThingsDiv" id="lastlyAddedMovieDiv1">
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">1.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${latelyAddedMovies[0].id}">${latelyAddedMovies[0].title}</a></h4> 
						<p class="sliderInfoYear">${latelyAddedMovies[0].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${latelYaddedMovieDirectorLink[0]}"> ${latelyAddedMovies[0].director}</a></p>
						<c:choose>
							<c:when test="${latelyAddedMovies[0].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${latelyAddedMovies[0].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">2.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${latelyAddedMovies[1].id}">${latelyAddedMovies[1].title}</a></h4> 
						<p class="sliderInfoYear">${latelyAddedMovies[1].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${latelYaddedMovieDirectorLink[1]}"> ${latelyAddedMovies[1].director}</a></p>
						<c:choose>
							<c:when test="${latelyAddedMovies[1].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${latelyAddedMovies[1].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">3.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${latelyAddedMovies[2].id}">${latelyAddedMovies[2].title}</a></h4> 
						<p class="sliderInfoYear">${latelyAddedMovies[2].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${latelYaddedMovieDirectorLink[2]}"> ${latelyAddedMovies[2].director}</a></p>
						<c:choose>
							<c:when test="${latelyAddedMovies[2].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${latelyAddedMovies[2].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="ThreeThingsDiv" id="lastlyAddedMovieDiv2">
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">4.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${latelyAddedMovies[3].id}">${latelyAddedMovies[3].title}</a></h4> 
						<p class="sliderInfoYear">${latelyAddedMovies[3].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${latelYaddedMovieDirectorLink[3]}"> ${latelyAddedMovies[3].director}</a></p>
						<c:choose>
							<c:when test="${latelyAddedMovies[3].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${latelyAddedMovies[3].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">5.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${latelyAddedMovies[4].id}">${latelyAddedMovies[4].title}</a></h4> 
						<p class="sliderInfoYear">${latelyAddedMovies[4].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${latelYaddedMovieDirectorLink[4]}"> ${latelyAddedMovies[4].director}</a></p>
						<c:choose>
							<c:when test="${latelyAddedMovies[4].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${latelyAddedMovies[4].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">6.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${latelyAddedMovies[5].id}">${latelyAddedMovies[5].title}</a></h4> 
						<p class="sliderInfoYear">${latelyAddedMovies[5].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${latelYaddedMovieDirectorLink[5]}"> ${latelyAddedMovies[5].director}</a></p>
						<c:choose>
							<c:when test="${latelyAddedMovies[5].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${latelyAddedMovies[5].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="ThreeThingsDiv" id="lastlyAddedMovieDiv3">
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">7.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${latelyAddedMovies[6].id}">${latelyAddedMovies[6].title}</a></h4> 
						<p class="sliderInfoYear">${latelyAddedMovies[6].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${latelYaddedMovieDirectorLink[6]}"> ${latelyAddedMovies[6].director}</a></p>
						<c:choose>
							<c:when test="${latelyAddedMovies[6].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${latelyAddedMovies[6].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">8.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${latelyAddedMovies[7].id}">${latelyAddedMovies[7].title}</a></h4> 
						<p class="sliderInfoYear">${latelyAddedMovies[7].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${latelYaddedMovieDirectorLink[7]}"> ${latelyAddedMovies[7].director}</a></p>
						<c:choose>
							<c:when test="${latelyAddedMovies[7].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${latelyAddedMovies[7].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="borderBar"></div>
					<div class="sliderInfoContainer">
						<h3 class="inline sliderNumber">9.</h3>
						<h4 class="sliderInfoTitle"><a href="movies/${latelyAddedMovies[8].id}">${latelyAddedMovies[8].title}</a></h4> 
						<p class="sliderInfoYear">${latelyAddedMovies[8].year}</p>
						<p class="sliderInfoDirector">Director:<a href="person/${latelYaddedMovieDirectorLink[8]}"> ${latelyAddedMovies[8].director}</a></p>
						<c:choose>
							<c:when test="${latelyAddedMovies[8].rating != 0.0}">
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> ${latelyAddedMovies[8].rating}</p>
							</c:when>
							<c:otherwise>
								<p class="sliderInfo"><label class="ratingStar" title="Rating"></label> Not rated yet</p>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<a class="rightButton" onClick="nextLastlyAddedMovieSlide()"> &#8250; </a>
			</div>
			<div class="sliderCircles">
				<a class="sliderCircleContainer" onClick="changeLastlyAddedMovieCircle(1)"><span class="sliderCircle" id="lastlyAddedMovieCircle1"></span></a>
				<a class="sliderCircleContainer" onClick="changeLastlyAddedMovieCircle(2)"><span class="sliderCircle" id="lastlyAddedMovieCircle2"></span></a>
				<a class="sliderCircleContainer" onClick="changeLastlyAddedMovieCircle(3)"><span class="sliderCircle" id="lastlyAddedMovieCircle3"></span></a>
			</div>
		</div>
	</div>
	
	<div class="footer">
		<div class="footerSpace">
			<p class="footerText">COPYRIGHT © MOVIEINFO</p>
		</div>
	</div>
</body>
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
	
    //--------------------------------------------------------------------------\\
	//------------------------------ BEST MOVIES ------------------------------ \\
	//--------------------------------------------------------------------------\\
	var currentBestMoviesSlide = 1;
	var movie1 = document.getElementById("bestMoviesDiv1");
	var movie2 = document.getElementById("bestMoviesDiv2");
	var movie3 = document.getElementById("bestMoviesDiv3");
	
	var bestMoviesCircle1 = document.getElementById("bestMoviesCircle1");
	var bestMoviesCircle2 = document.getElementById("bestMoviesCircle2");
	var bestMoviesCircle3 = document.getElementById("bestMoviesCircle3");
	
	// ------------------------------ NEXT BEST MOVIES SLIDE ------------------------------ \\
	function nextBestMoviesSlide() {
		if( currentBestMoviesSlide === 1 ) 
		{
			currentBestMoviesSlide++;
			movie1.style.opacity = "0";movie1.style.zIndex = "-1"; 
			movie2.style.opacity = "1";movie2.style.zIndex = "1"; 
			movie3.style.opacity = "0";movie3.style.zIndex = "-1"; 
			
			movie1.style.marginLeft = "-15px";
			movie2.style.marginLeft = "0px";
			movie3.style.marginLeft = "-15px";
			
			bestMoviesCircle1.style.backgroundColor = "white";
			bestMoviesCircle1.style.width = "11px";
			bestMoviesCircle1.style.height = "11px";
			bestMoviesCircle1.style.margin = "4px";
			
			bestMoviesCircle2.style.backgroundColor = "#bbb";
			bestMoviesCircle2.style.width = "13px";
			bestMoviesCircle2.style.height = "13px";
			bestMoviesCircle2.style.margin = "3px";
			
			bestMoviesCircle3.style.backgroundColor = "white";
			bestMoviesCircle3.style.width = "11px";
			bestMoviesCircle3.style.height = "11px";
			bestMoviesCircle3.style.margin = "4px";
		}
		else if( currentBestMoviesSlide === 2 )
		{
			currentBestMoviesSlide++;
			movie1.style.opacity = "0";movie1.style.zIndex = "-1"; 
			movie2.style.opacity = "0";movie2.style.zIndex = "-1"; 
			movie3.style.opacity = "1";movie3.style.zIndex = "1"; 
			
			movie1.style.marginLeft = "-15px";
			movie2.style.marginLeft = "-15px";
			movie3.style.marginLeft = "0px";
			
			bestMoviesCircle1.style.backgroundColor = "white";
			bestMoviesCircle1.style.width = "11px";
			bestMoviesCircle1.style.height = "11px";
			bestMoviesCircle1.style.margin = "4px";
			
			bestMoviesCircle2.style.backgroundColor = "white";
			bestMoviesCircle2.style.width = "11px";
			bestMoviesCircle2.style.height = "11px";
			bestMoviesCircle2.style.margin = "4px";
			
			bestMoviesCircle3.style.backgroundColor = "#bbb";
			bestMoviesCircle3.style.width = "13px";
			bestMoviesCircle3.style.height = "13px";
			bestMoviesCircle3.style.margin = "3px";
		}
		else if( currentBestMoviesSlide === 3 )
		{
			currentBestMoviesSlide = 1;
			movie1.style.opacity = "1";movie1.style.zIndex = "1"; 
			movie2.style.opacity = "0";movie2.style.zIndex = "-1"; 
			movie3.style.opacity = "0";movie3.style.zIndex = "-1"; 
			
			movie1.style.marginLeft = "0px";
			movie2.style.marginLeft = "-15px";
			movie3.style.marginLeft = "-15px";
			
			bestMoviesCircle1.style.backgroundColor = "#bbb";
			bestMoviesCircle1.style.width = "13px";
			bestMoviesCircle1.style.height = "13px";
			bestMoviesCircle1.style.margin = "3px";
			
			bestMoviesCircle2.style.backgroundColor = "white";
			bestMoviesCircle2.style.width = "11px";
			bestMoviesCircle2.style.height = "11px";
			bestMoviesCircle2.style.margin = "4px";
			
			bestMoviesCircle3.style.backgroundColor = "white";
			bestMoviesCircle3.style.width = "11px";
			bestMoviesCircle3.style.height = "11px";
			bestMoviesCircle3.style.margin = "4px";
		}
	}
	
	// ------------------------------ PREVIOUS BEST MOVIES SLIDE ------------------------------ \\
	function previousBestMoviesSlide() {
		if( currentBestMoviesSlide === 1 ) 
		{
			currentBestMoviesSlide = 3;
			movie1.style.opacity = "0";movie1.style.zIndex = "-1"; 
			movie2.style.opacity = "0";movie2.style.zIndex = "-1"; 
			movie3.style.opacity = "1";movie3.style.zIndex = "1"; 
			
			movie1.style.marginLeft = "-15px";
			movie2.style.marginLeft = "-15px";
			movie3.style.marginLeft = "0px";
			
			bestMoviesCircle1.style.backgroundColor = "white";
			bestMoviesCircle1.style.width = "11px";
			bestMoviesCircle1.style.height = "11px";
			bestMoviesCircle1.style.margin = "4px";
			
			bestMoviesCircle2.style.backgroundColor = "white";
			bestMoviesCircle2.style.width = "11px";
			bestMoviesCircle2.style.height = "11px";
			bestMoviesCircle2.style.margin = "4px";
			
			bestMoviesCircle3.style.backgroundColor = "#bbb";
			bestMoviesCircle3.style.width = "13px";
			bestMoviesCircle3.style.height = "13px";
			bestMoviesCircle3.style.margin = "3px";
		}
		else if( currentBestMoviesSlide === 2 )
		{
			currentBestMoviesSlide--;
			movie1.style.opacity = "1";movie1.style.zIndex = "1"; 
			movie2.style.opacity = "0";movie2.style.zIndex = "-1"; 
			movie3.style.opacity = "0";movie3.style.zIndex = "-1"; 
			
			movie1.style.marginLeft = "0px";
			movie2.style.marginLeft = "-15px";
			movie3.style.marginLeft = "-15px";
			
			bestMoviesCircle1.style.backgroundColor = "#bbb";
			bestMoviesCircle1.style.width = "13px";
			bestMoviesCircle1.style.height = "13px";
			bestMoviesCircle1.style.margin = "3px";
			
			bestMoviesCircle2.style.backgroundColor = "white";
			bestMoviesCircle2.style.width = "11px";
			bestMoviesCircle2.style.height = "11px";
			bestMoviesCircle2.style.margin = "4px";
			
			bestMoviesCircle3.style.backgroundColor = "white";
			bestMoviesCircle3.style.width = "11px";
			bestMoviesCircle3.style.height = "11px";
			bestMoviesCircle3.style.margin = "4px";
		}
		else if( currentBestMoviesSlide === 3 )
		{
			currentBestMoviesSlide--;
			movie1.style.opacity = "0";movie1.style.zIndex = "-1"; 
			movie2.style.opacity = "1";movie2.style.zIndex = "1"; 
			movie3.style.opacity = "0";movie3.style.zIndex = "-1"; 
			
			movie1.style.marginLeft = "-15px";
			movie2.style.marginLeft = "0px";
			movie3.style.marginLeft = "-15px";
			
			bestMoviesCircle1.style.backgroundColor = "white";
			bestMoviesCircle1.style.width = "11px";
			bestMoviesCircle1.style.height = "11px";
			bestMoviesCircle1.style.margin = "4px";
			
			bestMoviesCircle2.style.backgroundColor = "#bbb";
			bestMoviesCircle2.style.width = "13px";
			bestMoviesCircle2.style.height = "13px";
			bestMoviesCircle2.style.margin = "3px";
			
			bestMoviesCircle3.style.backgroundColor = "white";
			bestMoviesCircle3.style.width = "11px";
			bestMoviesCircle3.style.height = "11px";
			bestMoviesCircle3.style.margin = "4px";
		}
	}
	
	// ------------------------------ CHANGE BEST MOVIES SLIDE BY CIRCLE ------------------------------ \\
	function changeBestMovieCircle(sliderNumber)
	{
		if( sliderNumber === 1 )
		{
			currentBestMoviesSlide = 1;
			movie1.style.opacity = "1";movie1.style.zIndex = "1"; 
			movie2.style.opacity = "0";movie2.style.zIndex = "-1"; 
			movie3.style.opacity = "0";movie3.style.zIndex = "-1"; 
			
			movie1.style.marginLeft = "0px";
			movie2.style.marginLeft = "-15px";
			movie3.style.marginLeft = "-15px";
			
			bestMoviesCircle1.style.backgroundColor = "#bbb";
			bestMoviesCircle1.style.width = "13px";
			bestMoviesCircle1.style.height = "13px";
			bestMoviesCircle1.style.margin = "3px";
			
			bestMoviesCircle2.style.backgroundColor = "white";
			bestMoviesCircle2.style.width = "11px";
			bestMoviesCircle2.style.height = "11px";
			bestMoviesCircle2.style.margin = "4px";
			
			bestMoviesCircle3.style.backgroundColor = "white";
			bestMoviesCircle3.style.width = "11px";
			bestMoviesCircle3.style.height = "11px";
			bestMoviesCircle3.style.margin = "4px";
		}
		else if( sliderNumber === 2 )
		{
			currentBestMoviesSlide = 2;
			movie1.style.opacity = "0";movie1.style.zIndex = "-1"; 
			movie2.style.opacity = "1";movie2.style.zIndex = "1"; 
			movie3.style.opacity = "0";movie3.style.zIndex = "-1"; 
			
			movie1.style.marginLeft = "-15px";
			movie2.style.marginLeft = "0px";
			movie3.style.marginLeft = "-15px";
			
			bestMoviesCircle1.style.backgroundColor = "white";
			bestMoviesCircle1.style.width = "11px";
			bestMoviesCircle1.style.height = "11px";
			bestMoviesCircle1.style.margin = "4px";
			
			bestMoviesCircle2.style.backgroundColor = "#bbb";
			bestMoviesCircle2.style.width = "13px";
			bestMoviesCircle2.style.height = "13px";
			bestMoviesCircle2.style.margin = "3px";
			
			bestMoviesCircle3.style.backgroundColor = "white";
			bestMoviesCircle3.style.width = "11px";
			bestMoviesCircle3.style.height = "11px";
			bestMoviesCircle3.style.margin = "4px";
		}
		else{
			currentBestMoviesSlide = 3;
			movie1.style.opacity = "0";movie1.style.zIndex = "-1"; 
			movie2.style.opacity = "0";movie2.style.zIndex = "-1"; 
			movie3.style.opacity = "1";movie3.style.zIndex = "1"; 
			
			movie1.style.marginLeft = "-15px";
			movie2.style.marginLeft = "-15px";
			movie3.style.marginLeft = "0px";
			
			bestMoviesCircle1.style.backgroundColor = "white";
			bestMoviesCircle1.style.width = "11px";
			bestMoviesCircle1.style.height = "11px";
			bestMoviesCircle1.style.margin = "4px";
			
			bestMoviesCircle2.style.backgroundColor = "white";
			bestMoviesCircle2.style.width = "11px";
			bestMoviesCircle2.style.height = "11px";
			bestMoviesCircle2.style.margin = "4px";
			
			bestMoviesCircle3.style.backgroundColor = "#bbb";
			bestMoviesCircle3.style.width = "13px";
			bestMoviesCircle3.style.height = "13px";
			bestMoviesCircle3.style.margin = "3px";
		}
	}
	
	
	
	//-----------------------------------------------------------------------------\\
	// ------------------------------ NEWEST MOVIES ------------------------------ \\
	//-----------------------------------------------------------------------------\\
	var currentNewestMoviesSlide = 1;
	var newestMovie1 = document.getElementById("newestMoviesDiv1");
	var newestMovie2 = document.getElementById("newestMoviesDiv2");
	var newestMovie3 = document.getElementById("newestMoviesDiv3");

	var newestMoviesCircle1 = document.getElementById("newestMoviesCircle1");
	var newestMoviesCircle2 = document.getElementById("newestMoviesCircle2");
	var newestMoviesCircle3 = document.getElementById("newestMoviesCircle3");
	
	// ------------------------------ NEXT NEWEST MOVIES SLIDE ------------------------------ \\
	function nextNewestMoviesSlide() {
		if( currentNewestMoviesSlide === 1 ) 
		{
			currentNewestMoviesSlide++;
			newestMovie1.style.opacity = "0";newestMovie1.style.zIndex = "-1"; 
			newestMovie2.style.opacity = "1";newestMovie2.style.zIndex = "1"; 
			newestMovie3.style.opacity = "0";newestMovie3.style.zIndex = "-1"; 
			
			newestMovie1.style.marginLeft = "-15px";
			newestMovie2.style.marginLeft = "0px";
			newestMovie3.style.marginLeft = "-15px";
			
			newestMoviesCircle1.style.backgroundColor = "white";
			newestMoviesCircle1.style.width = "11px";
			newestMoviesCircle1.style.height = "11px";
			newestMoviesCircle1.style.margin = "4px";
			
			newestMoviesCircle2.style.backgroundColor = "#bbb";
			newestMoviesCircle2.style.width = "13px";
			newestMoviesCircle2.style.height = "13px";
			newestMoviesCircle2.style.margin = "3px";
			
			newestMoviesCircle3.style.backgroundColor = "white";
			newestMoviesCircle3.style.width = "11px";
			newestMoviesCircle3.style.height = "11px";
			newestMoviesCircle3.style.margin = "4px";
		}
		else if( currentNewestMoviesSlide === 2 )
		{
			currentNewestMoviesSlide++;
			newestMovie1.style.opacity = "0";newestMovie1.style.zIndex = "-1"; 
			newestMovie2.style.opacity = "0";newestMovie2.style.zIndex = "-1"; 
			newestMovie3.style.opacity = "1";newestMovie3.style.zIndex = "1"; 
			
			newestMovie1.style.marginLeft = "-15px";
			newestMovie2.style.marginLeft = "-15px";
			newestMovie3.style.marginLeft = "0px";
			
			newestMoviesCircle1.style.backgroundColor = "white";
			newestMoviesCircle1.style.width = "11px";
			newestMoviesCircle1.style.height = "11px";
			newestMoviesCircle1.style.margin = "4px";
			
			newestMoviesCircle2.style.backgroundColor = "white";
			newestMoviesCircle2.style.width = "11px";
			newestMoviesCircle2.style.height = "11px";
			newestMoviesCircle2.style.margin = "4px";
			
			newestMoviesCircle3.style.backgroundColor = "#bbb";
			newestMoviesCircle3.style.width = "13px";
			newestMoviesCircle3.style.height = "13px";
			newestMoviesCircle3.style.margin = "3px";
		}
		else if( currentNewestMoviesSlide === 3 )
		{
			currentNewestMoviesSlide = 1;
			newestMovie1.style.opacity = "1";newestMovie1.style.zIndex = "1"; 
			newestMovie2.style.opacity = "0";newestMovie2.style.zIndex = "-1"; 
			newestMovie3.style.opacity = "0";newestMovie3.style.zIndex = "-1"; 
			
			newestMovie1.style.marginLeft = "0px";
			newestMovie2.style.marginLeft = "-15px";
			newestMovie3.style.marginLeft = "-15px";
			
			newestMoviesCircle1.style.backgroundColor = "#bbb";
			newestMoviesCircle1.style.width = "13px";
			newestMoviesCircle1.style.height = "13px";
			newestMoviesCircle1.style.margin = "3px";
			
			newestMoviesCircle2.style.backgroundColor = "white";
			newestMoviesCircle2.style.width = "11px";
			newestMoviesCircle2.style.height = "11px";
			newestMoviesCircle2.style.margin = "4px";
			
			newestMoviesCircle3.style.backgroundColor = "white";
			newestMoviesCircle3.style.width = "11px";
			newestMoviesCircle3.style.height = "11px";
			newestMoviesCircle3.style.margin = "4px";
		}
	}
	
	// ------------------------------ PREVIOUS NEWEST MOVIES SLIDE ------------------------------ \\
	function previousNewestMoviesSlide() {
		if( currentNewestMoviesSlide === 1 ) 
		{
			currentNewestMoviesSlide = 3;
			newestMovie1.style.opacity = "0";newestMovie1.style.zIndex = "-1"; 
			newestMovie2.style.opacity = "0";newestMovie2.style.zIndex = "-1"; 
			newestMovie3.style.opacity = "1";newestMovie3.style.zIndex = "1"; 
			
			newestMovie1.style.marginLeft = "-15px";
			newestMovie2.style.marginLeft = "-15px";
			newestMovie3.style.marginLeft = "0px";
			
			newestMoviesCircle1.style.backgroundColor = "white";
			newestMoviesCircle1.style.width = "11px";
			newestMoviesCircle1.style.height = "11px";
			newestMoviesCircle1.style.margin = "4px";
			
			newestMoviesCircle2.style.backgroundColor = "white";
			newestMoviesCircle2.style.width = "11px";
			newestMoviesCircle2.style.height = "11px";
			newestMoviesCircle2.style.margin = "4px";
			
			newestMoviesCircle3.style.backgroundColor = "#bbb";
			newestMoviesCircle3.style.width = "13px";
			newestMoviesCircle3.style.height = "13px";
			newestMoviesCircle3.style.margin = "3px";
		}
		else if( currentNewestMoviesSlide === 2 )
		{
			currentNewestMoviesSlide--;
			newestMovie1.style.opacity = "1";newestMovie1.style.zIndex = "1"; 
			newestMovie2.style.opacity = "0";newestMovie2.style.zIndex = "-1"; 
			newestMovie3.style.opacity = "0";newestMovie3.style.zIndex = "-1"; 
			
			newestMovie1.style.marginLeft = "0px";
			newestMovie2.style.marginLeft = "-15px";
			newestMovie3.style.marginLeft = "-15px";
			
			newestMoviesCircle1.style.backgroundColor = "#bbb";
			newestMoviesCircle1.style.width = "13px";
			newestMoviesCircle1.style.height = "13px";
			newestMoviesCircle1.style.margin = "3px";
			
			newestMoviesCircle2.style.backgroundColor = "white";
			newestMoviesCircle2.style.width = "11px";
			newestMoviesCircle2.style.height = "11px";
			newestMoviesCircle2.style.margin = "4px";
			
			newestMoviesCircle3.style.backgroundColor = "white";
			newestMoviesCircle3.style.width = "11px";
			newestMoviesCircle3.style.height = "11px";
			newestMoviesCircle3.style.margin = "4px";
		}
		else if( currentNewestMoviesSlide === 3 )
		{
			currentNewestMoviesSlide--;
			newestMovie1.style.opacity = "0";newestMovie1.style.zIndex = "-1"; 
			newestMovie2.style.opacity = "1";newestMovie2.style.zIndex = "1"; 
			newestMovie3.style.opacity = "0";newestMovie3.style.zIndex = "-1"; 
			
			newestMovie1.style.marginLeft = "-15px";
			newestMovie2.style.marginLeft = "0px";
			newestMovie3.style.marginLeft = "-15px";
			
			newestMoviesCircle1.style.backgroundColor = "white";
			newestMoviesCircle1.style.width = "11px";
			newestMoviesCircle1.style.height = "11px";
			newestMoviesCircle1.style.margin = "4px";
			
			newestMoviesCircle2.style.backgroundColor = "#bbb";
			newestMoviesCircle2.style.width = "13px";
			newestMoviesCircle2.style.height = "13px";
			newestMoviesCircle2.style.margin = "3px";
			
			newestMoviesCircle3.style.backgroundColor = "white";
			newestMoviesCircle3.style.width = "11px";
			newestMoviesCircle3.style.height = "11px";
			newestMoviesCircle3.style.margin = "4px";
		}
	}
	
	// ------------------------------ CHANGE NEWEST MOVIES SLIDE BY CIRCLE ------------------------------ \\
	function changeNewestMovieCircle(sliderNumber)
	{
		if( sliderNumber === 1 )
		{
			currentNewestMoviesSlide = 1;
			newestMovie1.style.opacity = "1";newestMovie1.style.zIndex = "1"; 
			newestMovie2.style.opacity = "0";newestMovie2.style.zIndex = "-1"; 
			newestMovie3.style.opacity = "0";newestMovie3.style.zIndex = "-1"; 
			
			newestMovie1.style.marginLeft = "0px";
			newestMovie2.style.marginLeft = "-15px";
			newestMovie3.style.marginLeft = "-15px";
			
			newestMoviesCircle1.style.backgroundColor = "#bbb";
			newestMoviesCircle1.style.width = "13px";
			newestMoviesCircle1.style.height = "13px";
			newestMoviesCircle1.style.margin = "3px";
			
			newestMoviesCircle2.style.backgroundColor = "white";
			newestMoviesCircle2.style.width = "11px";
			newestMoviesCircle2.style.height = "11px";
			newestMoviesCircle2.style.margin = "4px";
			
			newestMoviesCircle3.style.backgroundColor = "white";
			newestMoviesCircle3.style.width = "11px";
			newestMoviesCircle3.style.height = "11px";
			newestMoviesCircle3.style.margin = "4px";
		}
		else if( sliderNumber === 2 )
		{
			currentNewestMoviesSlide = 2;
			newestMovie1.style.opacity = "0";newestMovie1.style.zIndex = "-1"; 
			newestMovie2.style.opacity = "1";newestMovie2.style.zIndex = "1"; 
			newestMovie3.style.opacity = "0";newestMovie3.style.zIndex = "-1"; 
			
			newestMovie1.style.marginLeft = "-15px";
			newestMovie2.style.marginLeft = "0px";
			newestMovie3.style.marginLeft = "-15px";
			
			newestMoviesCircle1.style.backgroundColor = "white";
			newestMoviesCircle1.style.width = "11px";
			newestMoviesCircle1.style.height = "11px";
			newestMoviesCircle1.style.margin = "4px";
			
			newestMoviesCircle2.style.backgroundColor = "#bbb";
			newestMoviesCircle2.style.width = "13px";
			newestMoviesCircle2.style.height = "13px";
			newestMoviesCircle2.style.margin = "3px";
			
			newestMoviesCircle3.style.backgroundColor = "white";
			newestMoviesCircle3.style.width = "11px";
			newestMoviesCircle3.style.height = "11px";
			newestMoviesCircle3.style.margin = "4px";
		}
		else{
			currentNewestMoviesSlide = 3;
			newestMovie1.style.opacity = "0";newestMovie1.style.zIndex = "-1"; 
			newestMovie2.style.opacity = "0";newestMovie2.style.zIndex = "-1"; 
			newestMovie3.style.opacity = "1";newestMovie3.style.zIndex = "1"; 
			
			newestMovie1.style.marginLeft = "-15px";
			newestMovie2.style.marginLeft = "-15px";
			newestMovie3.style.marginLeft = "0px";
			
			newestMoviesCircle1.style.backgroundColor = "white";
			newestMoviesCircle1.style.width = "11px";
			newestMoviesCircle1.style.height = "11px";
			newestMoviesCircle1.style.margin = "4px";
			
			newestMoviesCircle2.style.backgroundColor = "white";
			newestMoviesCircle2.style.width = "11px";
			newestMoviesCircle2.style.height = "11px";
			newestMoviesCircle2.style.margin = "4px";
			
			newestMoviesCircle3.style.backgroundColor = "#bbb";
			newestMoviesCircle3.style.width = "13px";
			newestMoviesCircle3.style.height = "13px";
			newestMoviesCircle3.style.margin = "3px";
		}
	}
	
	
	//-----------------------------------------------------------------------------\\
	// ------------------------------ LASTLY ADDED MOVIES ------------------------------ \\
	//-----------------------------------------------------------------------------\\
	var currentLastlyAddedMovieSlide = 1;
	var lastlyAddedMovie1 = document.getElementById("lastlyAddedMovieDiv1");
	var lastlyAddedMovie2 = document.getElementById("lastlyAddedMovieDiv2");
	var lastlyAddedMovie3 = document.getElementById("lastlyAddedMovieDiv3");
	
	var lastlyAddedMovieCircle1 = document.getElementById("lastlyAddedMovieCircle1");
	var lastlyAddedMovieCircle2 = document.getElementById("lastlyAddedMovieCircle2");
	var lastlyAddedMovieCircle3 = document.getElementById("lastlyAddedMovieCircle3");
	
	// ------------------------------ NEXT LASTLY ADDED MOVIES SLIDE ------------------------------ \\
	function nextLastlyAddedMovieSlide() {
		if( currentLastlyAddedMovieSlide === 1 ) 
		{
			currentLastlyAddedMovieSlide++;
			lastlyAddedMovie1.style.opacity = "0";lastlyAddedMovie1.style.zIndex = "-1"; 
			lastlyAddedMovie2.style.opacity = "1";lastlyAddedMovie2.style.zIndex = "1"; 
			lastlyAddedMovie3.style.opacity = "0";lastlyAddedMovie3.style.zIndex = "-1"; 
			
			lastlyAddedMovie1.style.marginLeft = "-15px";
			lastlyAddedMovie2.style.marginLeft = "0px";
			lastlyAddedMovie3.style.marginLeft = "-15px";
			
			lastlyAddedMovieCircle1.style.backgroundColor = "white";
			lastlyAddedMovieCircle1.style.width = "11px";
			lastlyAddedMovieCircle1.style.height = "11px";
			lastlyAddedMovieCircle1.style.margin = "4px";
			
			lastlyAddedMovieCircle2.style.backgroundColor = "#bbb";
			lastlyAddedMovieCircle2.style.width = "13px";
			lastlyAddedMovieCircle2.style.height = "13px";
			lastlyAddedMovieCircle2.style.margin = "3px";
			
			lastlyAddedMovieCircle3.style.backgroundColor = "white";
			lastlyAddedMovieCircle3.style.width = "11px";
			lastlyAddedMovieCircle3.style.height = "11px";
			lastlyAddedMovieCircle3.style.margin = "4px";
		}
		else if( currentLastlyAddedMovieSlide === 2 )
		{
			currentLastlyAddedMovieSlide++;
			lastlyAddedMovie1.style.opacity = "0";lastlyAddedMovie1.style.zIndex = "-1"; 
			lastlyAddedMovie2.style.opacity = "0";lastlyAddedMovie2.style.zIndex = "-1"; 
			lastlyAddedMovie3.style.opacity = "1";lastlyAddedMovie3.style.zIndex = "1"; 
			
			lastlyAddedMovie1.style.marginLeft = "-15px";
			lastlyAddedMovie2.style.marginLeft = "-15px";
			lastlyAddedMovie3.style.marginLeft = "0px";
			
			lastlyAddedMovieCircle1.style.backgroundColor = "white";
			lastlyAddedMovieCircle1.style.width = "11px";
			lastlyAddedMovieCircle1.style.height = "11px";
			lastlyAddedMovieCircle1.style.margin = "4px";
			
			lastlyAddedMovieCircle2.style.backgroundColor = "white";
			lastlyAddedMovieCircle2.style.width = "11px";
			lastlyAddedMovieCircle2.style.height = "11px";
			lastlyAddedMovieCircle2.style.margin = "4px";
			
			lastlyAddedMovieCircle3.style.backgroundColor = "#bbb";
			lastlyAddedMovieCircle3.style.width = "13px";
			lastlyAddedMovieCircle3.style.height = "13px";
			lastlyAddedMovieCircle3.style.margin = "3px";
		}
		else if( currentLastlyAddedMovieSlide === 3 )
		{
			currentLastlyAddedMovieSlide = 1;
			lastlyAddedMovie1.style.opacity = "1";lastlyAddedMovie1.style.zIndex = "1"; 
			lastlyAddedMovie2.style.opacity = "0";lastlyAddedMovie2.style.zIndex = "-1"; 
			lastlyAddedMovie3.style.opacity = "0";lastlyAddedMovie3.style.zIndex = "-1"; 
			
			lastlyAddedMovie1.style.marginLeft = "0px";
			lastlyAddedMovie2.style.marginLeft = "-15px";
			lastlyAddedMovie3.style.marginLeft = "-15px";
			
			lastlyAddedMovieCircle1.style.backgroundColor = "#bbb";
			lastlyAddedMovieCircle1.style.width = "13px";
			lastlyAddedMovieCircle1.style.height = "13px";
			lastlyAddedMovieCircle1.style.margin = "3px";
			
			lastlyAddedMovieCircle2.style.backgroundColor = "white";
			lastlyAddedMovieCircle2.style.width = "11px";
			lastlyAddedMovieCircle2.style.height = "11px";
			lastlyAddedMovieCircle2.style.margin = "4px";
			
			lastlyAddedMovieCircle3.style.backgroundColor = "white";
			lastlyAddedMovieCircle3.style.width = "11px";
			lastlyAddedMovieCircle3.style.height = "11px";
			lastlyAddedMovieCircle3.style.margin = "4px";
		}
	}
	
	// ------------------------------ PREVIOUS LASTLY ADDED MOVIES SLIDE ------------------------------ \\
	function previousLastlyAddedMovieSlide() {
		if( currentLastlyAddedMovieSlide === 1 ) 
		{
			currentLastlyAddedMovieSlide = 3;
			lastlyAddedMovie1.style.opacity = "0";lastlyAddedMovie1.style.zIndex = "-1"; 
			lastlyAddedMovie2.style.opacity = "0";lastlyAddedMovie2.style.zIndex = "-1"; 
			lastlyAddedMovie3.style.opacity = "1";lastlyAddedMovie3.style.zIndex = "1"; 
			
			lastlyAddedMovie1.style.marginLeft = "-15px";
			lastlyAddedMovie2.style.marginLeft = "-15px";
			lastlyAddedMovie3.style.marginLeft = "0px";
			
			lastlyAddedMovieCircle1.style.backgroundColor = "white";
			lastlyAddedMovieCircle1.style.width = "11px";
			lastlyAddedMovieCircle1.style.height = "11px";
			lastlyAddedMovieCircle1.style.margin = "4px";
			
			lastlyAddedMovieCircle2.style.backgroundColor = "white";
			lastlyAddedMovieCircle2.style.width = "11px";
			lastlyAddedMovieCircle2.style.height = "11px";
			lastlyAddedMovieCircle2.style.margin = "4px";
			
			lastlyAddedMovieCircle3.style.backgroundColor = "#bbb";
			lastlyAddedMovieCircle3.style.width = "13px";
			lastlyAddedMovieCircle3.style.height = "13px";
			lastlyAddedMovieCircle3.style.margin = "3px";
		}
		else if( currentLastlyAddedMovieSlide === 2 )
		{
			currentLastlyAddedMovieSlide--;
			lastlyAddedMovie1.style.opacity = "1";lastlyAddedMovie1.style.zIndex = "1"; 
			lastlyAddedMovie2.style.opacity = "0";lastlyAddedMovie2.style.zIndex = "-1"; 
			lastlyAddedMovie3.style.opacity = "0";lastlyAddedMovie3.style.zIndex = "-1"; 
			
			lastlyAddedMovie1.style.marginLeft = "0px";
			lastlyAddedMovie2.style.marginLeft = "-15px";
			lastlyAddedMovie3.style.marginLeft = "-15px";
			
			lastlyAddedMovieCircle1.style.backgroundColor = "#bbb";
			lastlyAddedMovieCircle1.style.width = "13px";
			lastlyAddedMovieCircle1.style.height = "13px";
			lastlyAddedMovieCircle1.style.margin = "3px";
			
			lastlyAddedMovieCircle2.style.backgroundColor = "white";
			lastlyAddedMovieCircle2.style.width = "11px";
			lastlyAddedMovieCircle2.style.height = "11px";
			lastlyAddedMovieCircle2.style.margin = "4px";
			
			lastlyAddedMovieCircle3.style.backgroundColor = "white";
			lastlyAddedMovieCircle3.style.width = "11px";
			lastlyAddedMovieCircle3.style.height = "11px";
			lastlyAddedMovieCircle3.style.margin = "4px";
		}
		else if( currentLastlyAddedMovieSlide === 3 )
		{
			currentLastlyAddedMovieSlide = 2;
			lastlyAddedMovie1.style.opacity = "0";lastlyAddedMovie1.style.zIndex = "-1"; 
			lastlyAddedMovie2.style.opacity = "1";lastlyAddedMovie2.style.zIndex = "1"; 
			lastlyAddedMovie3.style.opacity = "0";lastlyAddedMovie3.style.zIndex = "-1"; 
			
			lastlyAddedMovie1.style.marginLeft = "-15px";
			lastlyAddedMovie2.style.marginLeft = "0px";
			lastlyAddedMovie3.style.marginLeft = "-15px";
			
			lastlyAddedMovieCircle1.style.backgroundColor = "white";
			lastlyAddedMovieCircle1.style.width = "11px";
			lastlyAddedMovieCircle1.style.height = "11px";
			lastlyAddedMovieCircle1.style.margin = "4px";
			
			lastlyAddedMovieCircle2.style.backgroundColor = "#bbb";
			lastlyAddedMovieCircle2.style.width = "13px";
			lastlyAddedMovieCircle2.style.height = "13px";
			lastlyAddedMovieCircle2.style.margin = "3px";
			
			lastlyAddedMovieCircle3.style.backgroundColor = "white";
			lastlyAddedMovieCircle3.style.width = "11px";
			lastlyAddedMovieCircle3.style.height = "11px";
			lastlyAddedMovieCircle3.style.margin = "4px";
		}
	}
	
	// ------------------------------ CHANGE LASTLY ADDED MOVIE SLIDE BY CIRCLE ------------------------------ \\
	function changeLastlyAddedMovieCircle(sliderNumber)
	{
		if( sliderNumber === 1 )
		{
			currentLastlyAddedMovieSlide = 1;
			lastlyAddedMovie1.style.opacity = "1";lastlyAddedMovie1.style.zIndex = "1"; 
			lastlyAddedMovie2.style.opacity = "0";lastlyAddedMovie2.style.zIndex = "-1"; 
			lastlyAddedMovie3.style.opacity = "0";lastlyAddedMovie3.style.zIndex = "-1"; 
			
			lastlyAddedMovie1.style.marginLeft = "0px";
			lastlyAddedMovie2.style.marginLeft = "-15px";
			lastlyAddedMovie3.style.marginLeft = "-15px";
			
			lastlyAddedMovieCircle1.style.backgroundColor = "#bbb";
			lastlyAddedMovieCircle1.style.width = "13px";
			lastlyAddedMovieCircle1.style.height = "13px";
			lastlyAddedMovieCircle1.style.margin = "3px";
			
			lastlyAddedMovieCircle2.style.backgroundColor = "white";
			lastlyAddedMovieCircle2.style.width = "11px";
			lastlyAddedMovieCircle2.style.height = "11px";
			lastlyAddedMovieCircle2.style.margin = "4px";
			
			lastlyAddedMovieCircle3.style.backgroundColor = "white";
			lastlyAddedMovieCircle3.style.width = "11px";
			lastlyAddedMovieCircle3.style.height = "11px";
			lastlyAddedMovieCircle3.style.margin = "4px";
		}
		else if( sliderNumber === 2 )
		{
			currentLastlyAddedMovieSlide = 2;
			lastlyAddedMovie1.style.opacity = "0";lastlyAddedMovie1.style.zIndex = "-1"; 
			lastlyAddedMovie2.style.opacity = "1";lastlyAddedMovie2.style.zIndex = "1"; 
			lastlyAddedMovie3.style.opacity = "0";lastlyAddedMovie3.style.zIndex = "-1"; 
			
			lastlyAddedMovie1.style.marginLeft = "-15px";
			lastlyAddedMovie2.style.marginLeft = "0px";
			lastlyAddedMovie3.style.marginLeft = "-15px";
			
			lastlyAddedMovieCircle1.style.backgroundColor = "white";
			lastlyAddedMovieCircle1.style.width = "11px";
			lastlyAddedMovieCircle1.style.height = "11px";
			lastlyAddedMovieCircle1.style.margin = "4px";
			
			lastlyAddedMovieCircle2.style.backgroundColor = "#bbb";
			lastlyAddedMovieCircle2.style.width = "13px";
			lastlyAddedMovieCircle2.style.height = "13px";
			lastlyAddedMovieCircle2.style.margin = "3px";
			
			lastlyAddedMovieCircle3.style.backgroundColor = "white";
			lastlyAddedMovieCircle3.style.width = "11px";
			lastlyAddedMovieCircle3.style.height = "11px";
			lastlyAddedMovieCircle3.style.margin = "4px";
		}
		else{
			currentLastlyAddedMovieSlide = 3;
			lastlyAddedMovie1.style.opacity = "0";lastlyAddedMovie1.style.zIndex = "-1"; 
			lastlyAddedMovie2.style.opacity = "0";lastlyAddedMovie2.style.zIndex = "-1"; 
			lastlyAddedMovie3.style.opacity = "1";lastlyAddedMovie3.style.zIndex = "1"; 
			
			lastlyAddedMovie1.style.marginLeft = "-15px";
			lastlyAddedMovie2.style.marginLeft = "-15px";
			lastlyAddedMovie3.style.marginLeft = "0px";
			
			lastlyAddedMovieCircle1.style.backgroundColor = "white";
			lastlyAddedMovieCircle1.style.width = "11px";
			lastlyAddedMovieCircle1.style.height = "11px";
			lastlyAddedMovieCircle1.style.margin = "4px";
			
			lastlyAddedMovieCircle2.style.backgroundColor = "white";
			lastlyAddedMovieCircle2.style.width = "11px";
			lastlyAddedMovieCircle2.style.height = "11px";
			lastlyAddedMovieCircle2.style.margin = "4px";
			
			lastlyAddedMovieCircle3.style.backgroundColor = "#bbb";
			lastlyAddedMovieCircle3.style.width = "13px";
			lastlyAddedMovieCircle3.style.height = "13px";
			lastlyAddedMovieCircle3.style.margin = "3px";
		}
	}
</script>
</html>