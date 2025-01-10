<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="org.json.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>Home - Trending Movies</title>
<style>
/* Navbar and Footer Styling */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	letter-spacing: 2px;
	font-family: "Roboto Mono", monospace;
	font-optical-sizing: auto;
	font-weight: 400;
	font-style: normal;
}

/* Trending Movies Section */
.trending-section {
	padding: 20px;
}

.movie-scroll {
	display: flex;
	overflow-x: auto;
	gap: 10px;
}

.movie-card {
	flex: 0 0 auto;
	width: 200px;
	border: 1px solid #ccc;
	padding: 10px;
	margin-right: 10px;
}

.movie-card img {
	width: 100%;
	height: auto;
}

a {
	text-decoration:none;
	color:black;
}

h1 {
	text-align: center;
}

.genres-section {
	padding: 20px;
}

.genre {
	margin-bottom: 10px;
}

.genre h2 {
	font-size: 24px;
}

.genre-movies {
	display: flex;
	overflow-x: auto;
	gap: 10px;
}
</style>
</head>
<body>
	<!-- Include Navbar -->
	<jsp:include page="navbar.jsp" />

	<!-- Setup Variabes -->
	<%
	Object trendingMovies = request.getAttribute("trendingMovies");
	Object actionMovies = request.getAttribute("actionMovies");
	Object comedyMovies = request.getAttribute("comedyMovies");
	%>

	<!-- Trending Movies Section -->
	<div class="trending-section">
		<h1>Trending Movies</h1>
		<div class="movie-scroll">
			<c:forEach var="movie" items="${trendingMovies}">
				<a href="MovieServlet?movieId=${movie.getInt('id')}">
					<div class="movie-card">
						<img
							src="https://image.tmdb.org/t/p/w500${movie.getString('poster_path')}"
							alt="${movie.getString('title')}">
						<h3>${movie.getString('title')}
							(${movie.getString('release_date').substring(0, 4)})</h3>
					</div>
				</a>
			</c:forEach>
		</div>
	</div>

	<!-- Genres Section -->
	<div class="genres-section">
		<div class="genre">
			<h2>Action Movies</h2>
			<div class="genre-movies">
				<c:forEach var="movie" items="${actionMovies}">
					<a href="MovieServlet?movieId=${movie.getInt('id')}">
						<div class="movie-card">
							<img
								src="https://image.tmdb.org/t/p/w500${movie.getString('poster_path')}"
								alt="${movie.getString('title')}">
							<h3>${movie.getString('title')}
								(${movie.getString('release_date').substring(0, 4)})</h3>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>

		<div class="genre">
			<h2>Comedy Movies</h2>
			<div class="genre-movies">
				<c:forEach var="movie" items="${comedyMovies}">
					<a href="MovieServlet?movieId=${movie.getInt('id')}">
						<div class="movie-card">
							<img
								src="https://image.tmdb.org/t/p/w500${movie.getString('poster_path')}"
								alt="${movie.getString('title')}">
							<h3>${movie.getString('title')}
								(${movie.getString('release_date').substring(0, 4)})</h3>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>

		<!-- Add more genres similarly -->
	</div>

	<!-- Include Footer -->
	<jsp:include page="footer.jsp" />
</body>
</html>
