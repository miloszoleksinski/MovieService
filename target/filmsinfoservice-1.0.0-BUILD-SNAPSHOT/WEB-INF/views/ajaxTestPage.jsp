<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<title>Ajax page</title>
</head>
<body>
	Ajax page
	<div id="IDofMovie"></div>
</body>
<script type="text/javascript">
	function crunchifyAjax() 
	{
	    $.ajax({
	        url : 'searchBadges2',
	        success: function(data)
	        {
	        	var moviesID = "";
	        	var movies = [];
	        	for(var i=0; i<data.length; i++)
	        	{
	        		movies.push( JSON.parse( data[i] ) );
	        		moviesID += "<p>" + movies[i].id + "</p>";
	        	}
	        	$('#IDofMovie').html( moviesID );
	        }
	    });
	}
</script>
</html>