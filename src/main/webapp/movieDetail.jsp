<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Details</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page 
	import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException , org.json.* , java.util.*"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto+Mono:ital,wght@0,100..700;1,100..700&display=swap"
	rel="stylesheet">

<style>
* {
	padding: 0;
	margin: 0 letter-spacing: 2px;
	font-family: "Roboto Mono", monospace;
	font-optical-sizing: auto;
	font-weight: 400;
	font-style: normal;
}

.movie-detail {
	display: flex;
	align-items: flex-start;
	margin: 20px;
}

.movie-detail img {
	margin-right: 20px;
	width: 300px;
	height: auto;
}

.movie-info-table {
	border-collapse: collapse;
	width: 100%;
}

.movie-info-table th, .movie-info-table td {
	text-align: left;
	padding: 10px;
	border-bottom: 1px solid #ddd;
}

.movie-info-table th {
	font-weight: bold;
	width: 150px;
}

.movie-info-table td {
	width: auto;
}

.review-section {
	margin-top: 30px;
	text-align: center;
}

.review-section h2 {
	font-size: 4rem;
}

.review-section textarea {
	width: 70%;
	height: 150px;
	margin-top: 10px;
}

.add-to-watchlist {
	padding: 10px 20px;
	background-color: #007BFF;
	color: white;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s;
}

.added-to-watchlist {
	background-color: #28a745;
}

.add-to-watchlist:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<jsp:include page="navbar.jsp" />

	<%
	Object movie = request.getAttribute("movie");
	Object genres = request.getAttribute("genres");
	Object reviews = request.getAttribute("reviews");
	%>

	<div class="movie-detail">
		<img
			src="https://image.tmdb.org/t/p/w500${movie.getString('poster_path')}"
			alt="${movie.getString('title')}">

		<table class="movie-info-table">
			<tr>
				<th>Title:</th>
				<td>${movie.getString('title')}</td>
			</tr>
			<tr>
				<th>Release Date:</th>
				<td>${movie.getString('release_date')}</td>
			</tr>
			<tr>
				<th>Runtime:</th>
				<td>${movie.getInt('runtime')}minutes</td>
			</tr>
			<tr>
				<th>Genre:</th>
				<td><c:forEach var="genre" items="${genres}">
                        ${genre}${genreStatus.index < fn:length(genres) - 1 ? ', ' : ''}
                    </c:forEach></td>
			</tr>
			<tr>
				<th>Popularity:</th>
				<td>${movie.getDouble('popularity')}</td>
			</tr>
			<tr>
				<th>Overview:</th>
				<td>${movie.getString('overview')}</td>
			</tr>
		</table>
	</div>

	<div class="review-section">
		<h2>Reviews</h2>
		<!-- Check if user is logged in before showing the review form -->
		<c:if test="${not empty sessionScope.username}">
			<form action="ReviewServlet" method="post">
				<input type="hidden" name="movieId" value="${movie.getInt('id')}">
				<label for="review">Write your review:</label><br>
				<textarea name="review" id="review" rows="4" cols="50" required></textarea>
				<br> <br> <input type="submit" value="Submit Review">
			</form>
		</c:if>

		<c:if test="${empty sessionScope.username}">
			<p>
				<a href="login.jsp">Log in</a> to write a review.
			</p>
		</c:if>

		<h3>Existing Reviews:</h3>
		<c:forEach var="review" items="${reviews}">
			<p>
				<strong>${review.getUsername()}</strong>: ${review.getContent()}
			</p>
		</c:forEach>
		</div>

		<jsp:include page="footer.jsp" />
</body>
</html>
