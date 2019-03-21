<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="viewport" content="width=device-width, user-scalable=no"/>
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<Style>
		*{ margin: 0; padding: 0; box-sizing: border-box;}
		body{ width: 100%; background-color: black; }
		a{ text-decoration: none; color: black; }
		a:hover{ color: #e6ac00; transition: all 0.1s linear 0s; }
		h6{ height: 60px; }
		.fullContainer{ background-color: white; padding-bottom: 25px; }
		.submitButton{ color: black; margin: 4px; padding: 4px 8px; border: 0.2px solid black; transition: all 0.1s linear 0s; }
		.submitButton:hover{ color: white; background-color: black; cursor: pointer; }
		.error{ color: red; }
		.success{ color: green; }
		
		/*  MENU BAR  */
		.menuHeightBig{ height: 40px; }
		.menuHeightResponsive1{ height: 280px; }.menuHeightResponsive2{ height: 320px; }.menuHeightResponsive3{ height: 360px; }
		
		#menuBorder{ border-bottom: solid 0.6px #404040; transition: top 0.3s; position: fixed; width: 100%; background-color: black; z-index: 10;  }
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
		
		.movieDiv{ width: 80%; background-color: white; margin: auto; display: flex; border-bottom: 0.5px solid black;}
		.movieInfo{ padding: 20px; flex: 1; }
		.inline{ display: inline; }
		.movieTitle{ font-size: 1.7em; transition: all 0.1s linear 0s; }
		.movieTitle:hover{ color: #808080; }
		.desc{ color: #b3b3b3; display: inline; font-size: 1.1em; }
		.descOption{ color: #B8860B; }
		.pInfo{ font-size: 1.1em; display: inline; }
		.titleInline{ display: inline; }
		.titleInlineColor{ display: inline; color: #e6ac00; }
		
		.movieDescription{ width: 500px; margin: auto auto 10px auto; padding: 20px;  }
		.descriptionTitle{ text-align: center; font-size: 1.1em; margin-bottom: 6px; font-weight: bold; }
		
		.commentaryTopBorder{ padding-top: 30px; width: 60%; margin: auto; border-bottom: 0.5px solid black; }
		.movieCommentaryDiv{ text-align: center; margin: auto; width: 60%; padding-bottom: 15px; }
		.comments{ text-align: justify; }
		.mC{ padding: 5px; margin-top: 14px; border-radius: 5px; border: 0.5px solid lightgrey; background-color: #F8F8F8; }
		.sC{ padding: 5px; margin: 6px 2px 2px 40px; border-radius: 5px; border: 0.5px solid lightgrey; background-color: #F8F8F8; }
		.nick{ color: #e6ac00; font-size: 1.1em; }
		.nick:hover{ color: crimson; transition: all 0.1s linear 0s; }
		.commentTime{ display: inline; font-size: 0.8em; color: grey; }
		.like{ color: #565656; margin: 0 5px; }
		.liked{ color: #0000b3; margin: 0 5px; }
		.reply{ color: #565656; margin: 0 5px; }
		.delete{ color: #565656; margin: 0 5px; }
		.like:hover{ cursor: pointer; color: #0000b3; transition: all 0.1s linear 0s; margin: 0 0 0 10px; }
		.liked:hover{ cursor: pointer; color: #000080; transition: all 0.1s linear 0s; margin: 0 0 0 10px; }
		.reply:hover{ color: #1c1c1c; transition: all 0.1s linear 0s; margin: 0 0 0 10px; }
		.delete:hover{ color: #cc0000; transition: all 0.1s linear 0s; margin: 0 0 0 10px; }
		.CommentLikesPopup{ color: #565656; display: inline-block; -webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; -o-user-select: none; user-select: none;}
		.CommentLikesPopup:hover{ cursor: pointer; }
		.commentsTitle{ margin-top: 20px; margin-bottom: 20px; }
		.textareaComment{ height: 7em; width: 100%; max-width: 100%; max-height: 7em; min-width: 100%; min-height: 7em; }
		
		.disabledButton{ pointer-events: none; background-color: #b3b3b3; color: white; margin: 3px; padding: 2px 4px; border: 0.2px solid #00b300; transition: all 0.1s linear 0s; border-radius: 5px; -webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select: none;-o-user-select:none;user-select:none;}
		.disabledButton:hover{ color: white; background-color: #999999; cursor: pointer; }
		.disabledButton:focus{ box-shadow: 0 0 6px #808080; outline: none; }
		
		.footer{ background-color: black; width: 100%; border-top: solid 0.6px #404040; height: 60px; }
		.footerSpace{ width: 80%; margin:auto; height: 60px;}
		.footerText{ text-align: center; color: white; line-height: 60px; }
		
		.likesCon{ padding: 5px 0px 8px 0px; width: 30%; margin: auto; border: 0.5px solid lightgrey; border-radius: 5px; background-color: white; z-index: 1; position: absolute; left: 35%; }
		.titleBar{ display: flex; padding: 10px; margin: 2px 6px 10px 6px; border-radius: 5px; background-color: #F8F8F8; border: 0.5px solid lightgrey; }
		.title{ flex: 1; margin: auto; }
		.closeButton{ margin: auto; padding: 2px 5px 0px 5px; border-radius: 5px; background-color: white; border: 0.5px solid #bfbfbf; font-weight: 1900; -webkit-touch-callout: none; -webkit-user-select: none; -khtml-user-select: none; -moz-user-select: none; -ms-user-select: none; -o-user-select: none; user-select: none; }
		.closeButton:hover{ cursor: pointer; background-color: #F8F8F8; color: black; }
		.nickLike{ padding: 0px 14px; display: block; color: black; font-size: 1em; text-decoration: none; }
		.nickLike:hover{ color: crimson; transition: all 0.1s linear 0s; }
		
	.movieRateBlock{ margin: auto; padding-right: 20px; }
	.flexRating{ display: flex; flex-direction: row-reverse; }
	.inputHidden{ display: none; }
	.ratingLabel{ display: inline-block; overflow: hidden; text-indent: 9999px;  width: 1em;  white-space: nowrap; cursor: pointer; }
	.ratingLabel:before{ display: inline-block; text-indent: -9999px; content: '\2606'; color: #888; } 
	.ratingLabel:hover:before{ content: '\2605'; color: #e52; }
	
	#rating-10:checked + #rateTen:before{ content: '\2605'; color: #e52; }
	#rating-9:checked ~ #rateTen:before{ content: '\2605'; color: #e52; } #rating-9:checked + #rateNine:before{ content: '\2605'; color: #e52; }
	#rating-8:checked ~ #rateTen:before{ content: '\2605'; color: #e52; } #rating-8:checked ~ #rateNine:before{ content: '\2605'; color: #e52; }#rating-8:checked + #rateEight:before{ content: '\2605'; color: #e52; }
	#rating-7:checked ~ #rateTen:before{ content: '\2605'; color: #e52; } #rating-7:checked ~ #rateNine:before{ content: '\2605'; color: #e52; }#rating-7:checked ~ #rateEight:before{ content: '\2605'; color: #e52; }#rating-7:checked + #rateSeven:before{ content: '\2605'; color: #e52; }
	#rating-6:checked ~ #rateTen:before{ content: '\2605'; color: #e52; } #rating-6:checked ~ #rateNine:before{ content: '\2605'; color: #e52; }#rating-6:checked ~ #rateEight:before{ content: '\2605'; color: #e52; }#rating-6:checked ~ #rateSeven:before{ content: '\2605'; color: #e52; }#rating-6:checked + #rateSix:before{ content: '\2605'; color: #e52; }
	#rating-5:checked ~ #rateTen:before{ content: '\2605'; color: #e52; } #rating-5:checked ~ #rateNine:before{ content: '\2605'; color: #e52; }#rating-5:checked ~ #rateEight:before{ content: '\2605'; color: #e52; }#rating-5:checked ~ #rateSeven:before{ content: '\2605'; color: #e52; }#rating-5:checked ~ #rateSix:before{ content: '\2605'; color: #e52; }#rating-5:checked + #rateFive:before{ content: '\2605'; color: #e52; }
	#rating-4:checked ~ #rateTen:before{ content: '\2605'; color: #e52; } #rating-4:checked ~ #rateNine:before{ content: '\2605'; color: #e52; }#rating-4:checked ~ #rateEight:before{ content: '\2605'; color: #e52; }#rating-4:checked ~ #rateSeven:before{ content: '\2605'; color: #e52; }#rating-4:checked ~ #rateSix:before{ content: '\2605'; color: #e52; }#rating-4:checked ~ #rateFive:before{ content: '\2605'; color: #e52; }#rating-4:checked + #rateFour:before{ content: '\2605'; color: #e52; }
	#rating-3:checked ~ #rateTen:before{ content: '\2605'; color: #e52; } #rating-3:checked ~ #rateNine:before{ content: '\2605'; color: #e52; }#rating-3:checked ~ #rateEight:before{ content: '\2605'; color: #e52; }#rating-3:checked ~ #rateSeven:before{ content: '\2605'; color: #e52; }#rating-3:checked ~ #rateSix:before{ content: '\2605'; color: #e52; }#rating-3:checked ~ #rateFive:before{ content: '\2605'; color: #e52; }#rating-3:checked ~ #rateFour:before{ content: '\2605'; color: #e52; }#rating-3:checked + #rateThree:before{ content: '\2605'; color: #e52; }
	#rating-2:checked ~ #rateTen:before{ content: '\2605'; color: #e52; } #rating-2:checked ~ #rateNine:before{ content: '\2605'; color: #e52; }#rating-2:checked ~ #rateEight:before{ content: '\2605'; color: #e52; }#rating-2:checked ~ #rateSeven:before{ content: '\2605'; color: #e52; }#rating-2:checked ~ #rateSix:before{ content: '\2605'; color: #e52; }#rating-2:checked ~ #rateFive:before{ content: '\2605'; color: #e52; }#rating-2:checked ~ #rateFour:before{ content: '\2605'; color: #e52; }#rating-2:checked ~ #rateThree:before{ content: '\2605'; color: #e52; }#rating-2:checked + #rateTwo:before{ content: '\2605'; color: #e52; }
	#rating-1:checked ~ #rateTen:before{ content: '\2605'; color: #e52; } #rating-1:checked ~ #rateNine:before{ content: '\2605'; color: #e52; }#rating-1:checked ~ #rateEight:before{ content: '\2605'; color: #e52; }#rating-1:checked ~ #rateSeven:before{ content: '\2605'; color: #e52; }#rating-1:checked ~ #rateSix:before{ content: '\2605'; color: #e52; }#rating-1:checked ~ #rateFive:before{ content: '\2605'; color: #e52; }#rating-1:checked ~ #rateFour:before{ content: '\2605'; color: #e52; }#rating-1:checked ~ #rateThree:before{ content: '\2605'; color: #e52; }#rating-1:checked ~ #rateTwo:before{ content: '\2605'; color: #e52; }#rating-1:checked + #rateOne:before{ content: '\2605'; color: #e52; }
	
	#rateNine:hover ~ #rateTen:before{ content: '\2605'; color: #e52; }
	#rateEight:hover ~ #rateTen:before{ content: '\2605'; color: #e52; }#rateEight:hover ~ #rateNine:before{ content: '\2605'; color: #e52; }
	#rateSeven:hover ~ #rateTen:before{ content: '\2605'; color: #e52; }#rateSeven:hover ~ #rateNine:before{ content: '\2605'; color: #e52; }#rateSeven:hover ~ #rateEight:before{ content: '\2605'; color: #e52; }
	#rateSix:hover ~ #rateTen:before{ content: '\2605'; color: #e52; }#rateSix:hover ~ #rateNine:before{ content: '\2605'; color: #e52; }#rateSix:hover ~ #rateEight:before{ content: '\2605'; color: #e52; }#rateSix:hover ~ #rateSeven:before{ content: '\2605'; color: #e52; }
	#rateFive:hover ~ #rateTen:before{ content: '\2605'; color: #e52; }#rateFive:hover ~ #rateNine:before{ content: '\2605'; color: #e52; }#rateFive:hover ~ #rateEight:before{ content: '\2605'; color: #e52; }#rateFive:hover ~ #rateSeven:before{ content: '\2605'; color: #e52; }#rateFive:hover ~ #rateSix:before{ content: '\2605'; color: #e52; }
	#rateFour:hover ~ #rateTen:before{ content: '\2605'; color: #e52; }#rateFour:hover ~ #rateNine:before{ content: '\2605'; color: #e52; }#rateFour:hover ~ #rateEight:before{ content: '\2605'; color: #e52; }#rateFour:hover ~ #rateSeven:before{ content: '\2605'; color: #e52; }#rateFour:hover ~ #rateSix:before{ content: '\2605'; color: #e52; }#rateFour:hover ~ #rateFive:before{ content: '\2605'; color: #e52; }
	#rateThree:hover ~ #rateTen:before{ content: '\2605'; color: #e52; }#rateThree:hover ~ #rateNine:before{ content: '\2605'; color: #e52; }#rateThree:hover ~ #rateEight:before{ content: '\2605'; color: #e52; }#rateThree:hover ~ #rateSeven:before{ content: '\2605'; color: #e52; }#rateThree:hover ~ #rateSix:before{ content: '\2605'; color: #e52; }#rateThree:hover ~ #rateFive:before{ content: '\2605'; color: #e52; }#rateThree:hover ~ #rateFour:before{ content: '\2605'; color: #e52; }
	#rateTwo:hover ~ #rateTen:before{ content: '\2605'; color: #e52; }#rateTwo:hover ~ #rateNine:before{ content: '\2605'; color: #e52; }#rateTwo:hover ~ #rateEight:before{ content: '\2605'; color: #e52; }#rateTwo:hover ~ #rateSeven:before{ content: '\2605'; color: #e52; }#rateTwo:hover ~ #rateSix:before{ content: '\2605'; color: #e52; }#rateTwo:hover ~ #rateFive:before{ content: '\2605'; color: #e52; }#rateTwo:hover ~ #rateFour:before{ content: '\2605'; color: #e52; }#rateTwo:hover ~ #rateThree:before{ content: '\2605'; color: #e52; }
	#rateOne:hover ~ #rateTen:before{ content: '\2605'; color: #e52; }#rateOne:hover ~ #rateNine:before{ content: '\2605'; color: #e52; }#rateOne:hover ~ #rateEight:before{ content: '\2605'; color: #e52; }#rateOne:hover ~ #rateSeven:before{ content: '\2605'; color: #e52; }#rateOne:hover ~ #rateSix:before{ content: '\2605'; color: #e52; }#rateOne:hover ~ #rateFive:before{ content: '\2605'; color: #e52; }#rateOne:hover ~ #rateFour:before{ content: '\2605'; color: #e52; }#rateOne:hover ~ #rateThree:before{ content: '\2605'; color: #e52; }#rateOne:hover ~ #rateTwo:before{ content: '\2605'; color: #e52; }
	
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
	}
	@media only screen and (max-width: 700px) 
	{
		.movieDiv{ flex-direction: column; text-align: center; }
		.flexRating{ text-align: left; }
		.movieDescription{ width: 80%; margin: auto auto 10px auto; padding: 20px;  }
		
		.commentaryTopBorder{ width: 75%; }
		.movieCommentaryDiv{ width: 75%; }
		#rateButton{ margin: 4px 0px 4px 16px; }
		.flexRating{ margin-left: 4px; }
		
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
	<title>${movie.title} (${movie.year})</title>
</head>
<body>
	<div id="menuBorder" class="menuHeightBig">
		<div id="navContainer" class="navContainerBig">
			<div id="mobileMenuBar" class="mobileMenuBarBig">
				<a class="logo logobutton" id="menuButton" title="Menu" onClick="toggleMenuList(${rolesNumber})" ><i class="material-icons menuIcon">menu</i></a>
				<a class="logo logobutton" title="Home" id="homeButton" href="<c:url value="/"/>"><i class="material-icons homeIcon">home</i></a>
			</div>
			<div id="menuBar" class="menuBarBig">	
				<a class="logo logobutton menuButtonBigClass" title="Menu" id="menuButtonBig" onClick="toggleMenuList(${rolesNumber})" ><i class="material-icons menuIcon">menu</i></a>
				<a class="logo logobutton" title="Home" href="<c:url value="/"/>"><i class="material-icons homeIcon">home</i></a>
				<a class="option activelogobutton" title="Movies" href="<c:url value="/movies?page=0"/>">Movies</a>
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
		<div class="movieDiv" >
			<div class="movieInfo">
				<h3 class="inline"><a class="movieTitle" href="<c:url value="/movies/${movie.id}"/>">${movie.title} </a></h3>
				<p class="pInfo">(${movie.year})</p>
		
				<h3></h3>
		
				<p class="desc">director: <a class="descOption" href="<c:url value="/person/${directorLink}"/>">${movie.director}</a></p>
		
				<h3></h3>
		
				<p class="desc">type: </p> 
				<c:forEach items="${movie.types}" var="type" varStatus="myIndex">
	    	   			<c:if test="${myIndex.index != fn:length(movie.types)-1}">
	    					<p class="pInfo"><a class="descOption" href="<c:url value="/movies?page=0&type=${type}"/>">${type}</a>,</p>
	    				</c:if>
	    				<c:if test="${myIndex.index == fn:length(movie.types)-1}">
	    					<p class="inline"><a class="descOption" href="<c:url value="/movies?page=0&type=${type}"/>">${type}</a></p>
	    				</c:if>
				</c:forEach>
			</div>
			
			<sec:authorize access="isAnonymous()">
				<div class="movieRateBlock">
					<h2 class="titleInline">RATE: </h2><h2 class="titleInlineColor">${rating}</h2>
				</div>
			</sec:authorize>
			
			<sec:authorize access="isAuthenticated()">
				<div class="movieRateBlock">
					<h3 class="titleInline">RATE: </h3><h3 class="titleInlineColor">${rating}</h3>
					<c:if test="${not empty ratingNull}"><div class="error">${ratingNull}</div><h3></h3></c:if>
					<c:if test="${not empty rateUpdated}"><div class="success">${rateUpdated}</div><h3></h3></c:if>
					<c:if test="${not empty successRating}"><div class="success">${successRating}</div><h3></h3></c:if>
					<form method="POST" action="/SpringMvcExample/rateMovie/${movie.id}">
						<div class="flexRating">
							<input class="inputHidden" type="radio" id="rating-1" name="rating" value="10" /><label  class="ratingLabel"  for="rating-1" id="rateOne" title="rate 10">O</label>
							<input class="inputHidden" type="radio" id="rating-2" name="rating" value="9" /><label  class="ratingLabel"  for="rating-2" id="rateTwo" title="rate 9">O</label>
							<input class="inputHidden" type="radio" id="rating-3" name="rating" value="8" /><label  class="ratingLabel"  for="rating-3" id="rateThree" title="rate 8">O</label>
							<input class="inputHidden" type="radio" id="rating-4" name="rating" value="7" /><label  class="ratingLabel"  for="rating-4" id="rateFour" title="rate 7">O</label>
							<input class="inputHidden" type="radio" id="rating-5" name="rating" value="6" /><label  class="ratingLabel"  for="rating-5" id="rateFive" title="rate 6">O</label>
							<input class="inputHidden" type="radio" id="rating-6" name="rating" value="5" /><label  class="ratingLabel"  for="rating-6" id="rateSix" title="rate 5">O</label>
							<input class="inputHidden" type="radio" id="rating-7" name="rating" value="4" /><label  class="ratingLabel"  for="rating-7" id="rateSeven" title="rate 4">O</label>
							<input class="inputHidden" type="radio" id="rating-8" name="rating" value="3" /><label  class="ratingLabel"  for="rating-8" id="rateEight" title="rate 3">O</label>
							<input class="inputHidden" type="radio" id="rating-9" name="rating" value="2" /><label  class="ratingLabel"  for="rating-9" id="rateNine" title="rate 2">O</label>
							<input class="inputHidden" type="radio" id="rating-10" name="rating" value="1"/><label class="ratingLabel" for="rating-10" id="rateTen" title="rate 1">O</label>
						</div>
							<input class="submitButton" id="rateButton" type="submit" value="rate">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
				</div>
			</sec:authorize>
			
		</div>
		
		<div class="movieDescription">	
			<c:if test="${fn:length(movie.description) > 0}">
	    		<p class="descriptionTitle">Description</p>
	    		<p>${movie.description}</p>
	    	</c:if>
	    	<c:if test="${fn:length(movie.description) == 0}">
	    		<p class="descriptionTitle">Description not added</p>
	    	</c:if>
		</div>
		
		<h3 class="commentaryTopBorder"></h3>
		
		<div class="movieCommentaryDiv">
			<c:if test="${fn:length(movie.comments) == 0}">
				<h3 class="commentsTitle">Comments not added</h3>
				
				<sec:authorize access="isAuthenticated()">
					<c:if test="${not empty emptyComment}"><div class="error">${emptyComment}</div><h3></h3></c:if>
					<form method="POST" action="/SpringMvcExample/addMainComment?movieID=${movie.id}">
						<textarea class="textareaComment" name="comment" ></textarea>
						<h3 class="spaceBetweenInput"></h3>
						<input class="submitButton" name="submit" type="submit" value="comment" />
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
				</sec:authorize>
				
	    	</c:if>
	    	<c:if test="${fn:length(movie.comments) > 0}">
				<h3 class="commentsTitle">Comments</h3>
				
				<sec:authorize access="isAuthenticated()">
					<c:if test="${not empty emptyComment}"><div class="error">${emptyComment}</div><h3></h3></c:if>
					<form method="POST" action="/SpringMvcExample/addMainComment?movieID=${movie.id}">
						<textarea class="textareaComment" name="comment" ></textarea>
						<h3 class="spaceBetweenInput"></h3>
						<input class="submitButton" name="submit" type="submit" value="comment" />
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
				</sec:authorize>
				
				<div class="comments">
					<c:forEach items="${movie.comments}" var="comment" varStatus="i">
						<div class="${comment.commentType}">
							<a class="nick" href="/SpringMvcExample/user/${comment.username}" title="${comment.username}">${comment.username}</a>
							<c:if test="${not empty comment.time}"><div class="commentTime">&bull; ${comment.time}</div></c:if>
							<p> ${comment.comment}</p>  
							<c:if test="${comment.likes > 0}">
								<a class="CommentLikesPopup" onClick="displayLikes('likesContainer${i.index}')" title='Likes'>&#128077;${comment.likes}</a>
								<div class="likesPositionRelative"></div>
								<div class="likesCon" id="likesContainer${i.index}" style="display:none;">
									<div class="titleBar">
										<h4 class="title">Likes</h4>
										<a class="closeButton" onClick="displayLikes('likesContainer${i.index}')" title="Exit">&#10799;</a>
									</div>
									<c:forEach items="${usernamesLikedComments[i.index]}" var="username" varStatus="myIndex">
										<a class="nickLike" href="/SpringMvcExample/user/${username}" title="${username}">${username}</a>
									</c:forEach>
								</div>
							</c:if>
							<sec:authorize access="isAuthenticated()">
								<c:if test="${isCommentLiked[i.index] == false}"><a class="like" id="likeButtonNum${i.index}"  onClick="doBoth('/SpringMvcExample/likeComment?rowID=${comment.rowID}&movieID=${movie.id}&commentUser=${comment.username}&movieTitle=${movie.title}','likeButtonNum${i.index}')">Like</a></c:if>
								<c:if test="${isCommentLiked[i.index] == true}"><a class="liked" id="likedButtonNum${i.index}" onClick="doBoth('/SpringMvcExample/likeComment?rowID=${comment.rowID}&movieID=${movie.id}&commentUser=${comment.username}&movieTitle=${movie.title}','likedButtonNum${i.index}')">Liked</a></c:if>
								
								<a class="reply" href="${movie.title}?replyTo=${comment.commentID}">Reply</a>
								<c:if test="${comment.username == loggedUsername || userRoles == 2 || userRoles == 3}">
									<c:if test="${comment.commentType == 'mC' }">
										<a class="delete" href="/SpringMvcExample/deleteMainAndReplyComments?commentID=${comment.commentID}&movieID=${movie.id}">Delete</a>
									</c:if>
									<c:if test="${comment.commentType == 'sC' }">
										<a class="delete" href="/SpringMvcExample/deleteReplyComment?rowID=${comment.rowID}&movieID=${movie.id}">Delete</a>
									</c:if>
								</c:if>
								<c:if test="${not empty replyTo}">
									<c:if test="${replyTo == comment.commentID && comment.commentType == 'mC' }">
										<form method="POST" action="/SpringMvcExample/addReplyComment?movieID=${movie.id}&commentID=${comment.commentID}">
											<textarea class="textareaComment" name="comment" ></textarea>
											<h3 class="spaceBetweenInput"></h3>
											<input class="submitButton" name="submit" type="submit" value="comment" />
											<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										</form>
									</c:if>
								</c:if>
							</sec:authorize>
						</div>
					</c:forEach>
				</div>
	    	</c:if>
		</div>
		
	</div>

	<div class="footer">
		<div class="footerSpace">
			<p class="footerText">COPYRIGHT © MOVIEINFO</p>
		</div>
	</div>
<script>
 	function displayLikes(id) 
 	{
	 	var likes = document.getElementById(id);
		 if ( likes.style.display === "none" ) { likes.style.display = "block"; }
		 else{ likes.style.display = "none"; }
	 }
 
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
			if( rolesNumber == 2 ){ menuHeight.className = "menuHeightResponsive2"; menuBorder.className = "menuHeightResponsive2"; }
			else if( rolesNumber == 3 ){ menuHeight.className = "menuHeightResponsive3"; menuBorder.className = "menuHeightResponsive3"; }
			else{ menuHeight.className = "menuHeightResponsive1"; menuBorder.className = "menuHeightResponsive1"; }
				
			navContainer.className = "navContainerResponsive";
			mobileMenuBar.className = "mobileMenuBarResponsive";
			menuBar.className = "menuBarResponsive";
			flexNavbar.className = "flexNavbarResponsive";
			userNavbar.className = "userNavbarResponsive";
				
			menuButtonBig.className = "logo logobutton menuButtonBigResponsive";
		}
		else{ 
			menuHeight.className = "menuHeightBig";
			menuBorder.className = "menuHeightBig";
			
			navContainer.className = "navContainerBig";
			mobileMenuBar.className = "mobileMenuBarBig";
			menuBar.className = "menuBarBig";
			flexNavbar.className = "flexNavbarBig";
			userNavbar.className = "userNavbarBig";
			
			menuButtonBig.className = "logo logobutton menuButtonBigClass";
		}
	}
	
	// jquery ajax, like/unlike comment
	function ajaxLikeOrUnlikeComment(parametersForLikeUnlike, callback) 
	{
	    $.ajax({
	        url : parametersForLikeUnlike,               
	        success: function(data){  },
	        complete: function (data) { callback(); }
	    });
	}
	
	// disable button after click
	function turnButton(buttonID)
	{
		var button = document.getElementById( buttonID );
		button.className = "disabledButton";
	}
	
	function doBoth(parametersForLikeUnlike, buttonID)
	{
		turnButton(buttonID);
		ajaxLikeOrUnlikeComment(parametersForLikeUnlike, function(){ location.reload(); });
	}
</script>
</body>
</html>