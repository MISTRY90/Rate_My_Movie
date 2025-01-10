import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MovieServlet")
public class MovieServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Replace with your TMDb API key
    private static final String TMDB_API_KEY = "c6b25fabd0e6c73fb15c53e7c037cb02";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get session, don't create if not present

        // Check if user is logged in
        if (session != null && session.getAttribute("username") != null) {
            String movieId = request.getParameter("movieId");
            String searchQuery = request.getParameter("search"); // Get the search query from the form

            if (searchQuery != null && !searchQuery.isEmpty()) {
                // If a search query is provided, perform the search
                searchMovies(request, response, searchQuery);
            } else if (movieId != null && !movieId.isEmpty()) {
                // If movieId is provided, fetch movie details
                fetchMovieDetails(request, response, movieId);
            } else {
                // Otherwise, fetch trending movies and movies by genre
                fetchTrendingMovies(request);
                fetchMoviesByGenre(request);

                // Forward to home.jsp to display movies
                RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            // If user is not logged in, redirect to login page
            response.sendRedirect("login.jsp?error=Please log in to view movies.");
        }
    }

    // Fetch trending movies using TMDb API
    private void fetchTrendingMovies(HttpServletRequest request) throws IOException {
        String apiUrl = "https://api.themoviedb.org/3/trending/movie/week?api_key=" + TMDB_API_KEY;

        JSONArray trendingMoviesArray = fetchMoviesFromTMDb(apiUrl);
        List<JSONObject> trendingMoviesList = jsonArrayToList(trendingMoviesArray); 
        request.setAttribute("trendingMovies", trendingMoviesList);
    }

    // Fetch movies by genre using TMDb API
    private void fetchMoviesByGenre(HttpServletRequest request) throws IOException {
        String actionUrl = "https://api.themoviedb.org/3/discover/movie?api_key=" + TMDB_API_KEY + "&with_genres=28"; // Action genre
        String comedyUrl = "https://api.themoviedb.org/3/discover/movie?api_key=" + TMDB_API_KEY + "&with_genres=35"; // Comedy genre

        JSONArray actionMoviesArray = fetchMoviesFromTMDb(actionUrl);
        JSONArray comedyMoviesArray = fetchMoviesFromTMDb(comedyUrl);

        List<JSONObject> actionMoviesList = jsonArrayToList(actionMoviesArray);
        List<JSONObject> comedyMoviesList = jsonArrayToList(comedyMoviesArray);

        // Set attributes for genres
        request.setAttribute("actionMovies", actionMoviesList);
        request.setAttribute("comedyMovies", comedyMoviesList);
    }

    // Fetch specific movie details using TMDb API
    private void fetchMovieDetails(HttpServletRequest request, HttpServletResponse response, String movieId) throws IOException, ServletException {
    	String apiUrl = "https://api.themoviedb.org/3/movie/" + movieId + "?api_key=" + TMDB_API_KEY;
		URL url = new URL(apiUrl);
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setRequestMethod("GET");

		BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		StringBuffer responseContent = new StringBuffer();
		String inputLine;

		while ((inputLine = reader.readLine()) != null) {
			responseContent.append(inputLine);
		}
		reader.close();

		JSONObject movie = new JSONObject(responseContent.toString());

		// Extract movie details
		request.setAttribute("movie", movie);

		// Extract genres as a List
		JSONArray genresArray = movie.getJSONArray("genres");
		List<String> genres = new ArrayList<>();
		for (int i = 0; i < genresArray.length(); i++) {
			JSONObject genreObj = genresArray.getJSONObject(i);
			genres.add(genreObj.getString("name"));
		}

		// Set genres as a request attribute
		request.setAttribute("genres", genres);
		
		// Fetch reviews
		Connection conn;
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "RDBMSisdull3#");
			PreparedStatement ps = conn.prepareStatement("SELECT u.username, r.content FROM reviews r JOIN users u ON r.userId = u.id WHERE r.movieId = ?");
			ps.setInt(1, Integer.parseInt(movieId));
			ResultSet rs = ps.executeQuery();
			
			List<Review> reviews = new ArrayList<>();
			while (rs.next()) {
				String username = rs.getString("username");
				String content = rs.getString("content");
				System.out.print(username);
				reviews.add(new Review(username, content));
			}
			// Set the reviews as a request attribute
			request.setAttribute("reviews", reviews);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// Forward to movie detail JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("movieDetail.jsp");
		dispatcher.forward(request, response);
    }

    // Helper method to fetch movies from TMDb API
    private JSONArray fetchMoviesFromTMDb(String apiUrl) throws IOException {
        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");

        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        StringBuffer responseContent = new StringBuffer();
        String inputLine;

        while ((inputLine = reader.readLine()) != null) {
            responseContent.append(inputLine);
        }
        reader.close();

        JSONObject jsonObject = new JSONObject(responseContent.toString());
        return jsonObject.getJSONArray("results");
    }

    // Helper method to fetch a single movie from TMDb API
    private JSONObject fetchMovieFromTMDb(String apiUrl) throws IOException {
        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");

        BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        StringBuffer responseContent = new StringBuffer();
        String inputLine;

        while ((inputLine = reader.readLine()) != null) {
            responseContent.append(inputLine);
        }
        reader.close();

        return new JSONObject(responseContent.toString());
    }
    
    private void searchMovies(HttpServletRequest request, HttpServletResponse response, String query) throws ServletException, IOException {
        String apiUrl = "https://api.themoviedb.org/3/search/movie?api_key=" + TMDB_API_KEY + "&query=" + query;
        
        JSONArray searchResults = fetchMoviesFromTMDb(apiUrl);
        List<JSONObject> searchMoviesList = jsonArrayToList(searchResults);

        // Set search results as an attribute
        request.setAttribute("searchResults", searchMoviesList);

        // Forward to search results JSP page (or reuse home.jsp)
        RequestDispatcher dispatcher = request.getRequestDispatcher("searchResults.jsp");
        dispatcher.forward(request, response);
    }

    // Helper method to convert JSONArray to List<JSONObject>
    private List<JSONObject> jsonArrayToList(JSONArray jsonArray) {
        List<JSONObject> list = new ArrayList<>();
        for (int i = 0; i < jsonArray.length(); i++) {
            list.add(jsonArray.getJSONObject(i));
        }
        return list;
    }
    
    public class Review {
        private String username;
        private String content;

        public Review(String username, String content) {
            this.username = username;
            this.content = content;
        }

        public String getUsername() {
            return username;
        }

        public String getContent() {
            return content;
        }
    }
}
