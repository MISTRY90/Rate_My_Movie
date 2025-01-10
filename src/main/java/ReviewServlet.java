import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONObject;
@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handles POST request to add new reviews
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String movieId = request.getParameter("movieId");
        String reviewContent = request.getParameter("review");
        String username = (String) request.getSession().getAttribute("username");

        try {
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "RDBMSisdull3#");
            PreparedStatement ps = conn.prepareStatement("INSERT INTO reviews (movieId, userId, content) VALUES (?, ?, ?)");
            ps.setInt(1, Integer.parseInt(movieId));
            ps.setInt(2, getUserIdByUsername(conn, username));  // Fetch the userId based on username
            ps.setString(3, reviewContent);
            ps.executeUpdate();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect back to the movie detail page after adding the review
        response.sendRedirect("MovieDetailServlet?id=" + movieId);
    }
   

    // Method to get the user ID based on the username
    private int getUserIdByUsername(Connection conn, String username) throws Exception {
        PreparedStatement ps = conn.prepareStatement("SELECT id FROM users WHERE username = ?");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("id");
        }
        return -1;  // Return -1 if the user is not found
    }

    private void test() {
    }
}
