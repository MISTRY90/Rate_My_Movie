<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Results</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="org.json.*"%>
<%@ page import="java.util.List"%>
<style>
.movies-container {
	display: flex;
	flex-direction: row;
	flex-wrap: wrap;
	align-items: center;
	justify-content: space-evenly;
	gap: 20px;
}

.movie-card {
	width: 200px;
	border: 1px solid #ccc;
	padding: 10px;
	margin-right: 10px;
}

.movie-card img {
	width: 100%;
}
</style>
</head>
<body>
	<jsp:include page="navbar.jsp" />
	<%
	Object result = request.getAttribute("searchResults");
	if (result != null && result instanceof List) {
		List<JSONObject> searchResults = (List<JSONObject>) result;
	%>
	<div class="movies-container">
		<%
		for (JSONObject movie : searchResults) {
		%>
		<a href="MovieServlet?movieId=<%= movie.get("id")%>">
			<div class="movie-card">
				<img
					src="https://image.tmdb.org/t/p/w500<%=movie.get("poster_path")%>"
					alt="<%=movie.get("title")%>">
				<h2><%=movie.get("title")%></h2>
			</div>
		</a>
		<%
		}
		%>
	</div>
	<%
	} else {
	%>
	<p>No movies found.</p>
	<%
	}
	%>

	<jsp:include page="footer.jsp" />

</body>
</html>