

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Servlet implementation class MovieDetailServlet
 */
public class MovieDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    
    // Replace with your TMDb API key
    private static final String TMDB_API_KEY = "c6b25fabd0e6c73fb15c53e7c037cb02";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MovieDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String movieId = request.getParameter("id"); // Get movie ID from request
        if (movieId != null && !movieId.isEmpty()) {
            fetchMovieDetails(request, response, movieId);
        }	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	private void fetchMovieDetails(HttpServletRequest request, HttpServletResponse response, String movieId) throws IOException, ServletException {
		// Fetch movie details from TMDb API
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

		// Forward to movie detail JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("movieDetail.jsp");
		dispatcher.forward(request, response);
	}

}
