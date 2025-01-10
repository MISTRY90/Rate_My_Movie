import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/userServlet")
public class userServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private String jdbcURL = "jdbc:mysql://localhost:3306/test";
    private String jdbcUsername = "root";
    private String jdbcPassword = "RDBMSisdull3#";

    // Constructor
    public userServlet() {
        super();
    }

    // Handles GET requests (usually for login page forwarding)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }

    // Handles POST requests for registration and login
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equalsIgnoreCase(action)) {
            handleRegistration(request, response);
        } else if ("login".equalsIgnoreCase(action)) {
            handleLogin(request, response);
        }else if ("logout".equalsIgnoreCase(action)) {
            handleLogout(request, response);
        }
    }

    // Handle User Registration
    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        try (Connection con = getConnection()) {
            // Check if the username already exists
            String queryCheck = "SELECT * FROM users WHERE username = ?";
            PreparedStatement psCheck = con.prepareStatement(queryCheck);
            psCheck.setString(1, username);
            ResultSet rsCheck = psCheck.executeQuery();

            if (rsCheck.next()) {
                response.sendRedirect("registration.jsp?error=Username already exists");
            } else {
                // Insert new user into the database
                String queryInsert = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
                PreparedStatement psInsert = con.prepareStatement(queryInsert);
                psInsert.setString(1, username);
                psInsert.setString(2, email);
                psInsert.setString(3, password); // Optionally hash the password

                int result = psInsert.executeUpdate();

                if (result > 0) {
                    response.sendRedirect("login.jsp?success=Registration successful! Please login.");
                } else {
                    response.sendRedirect("registration.jsp?error=Registration failed, try again.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Registration failed", e);
        }
    }

    // Handle User Login
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection con = getConnection()) {
            // Query to check user credentials
            String query = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Login successful, create session and redirect
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                response.sendRedirect(request.getContextPath() + "/MovieServlet");
                } else {
                response.sendRedirect("login.jsp?error=Invalid username or password");
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Login failed", e);
        }
    }
    
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false); // Get session, don't create if not present
        if (session != null) {
            session.invalidate(); // Invalidate the session to log out
        }
        response.sendRedirect("login.jsp?message=Logged out successfully.");
    }
    

    // Establish connection to the database
    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }
}
