# Rate My Movie 🎥

**Rate My Movie** is a Java-based web application designed to provide users with a platform to search for movies, post reviews, and maintain a personal watchlist. Built using J2EE, JSP, and JDBC, this application integrates with the TMDb API for movie data and MySQL for persistent storage.

---

## 📌 Features

- **Search Movies:** Fetch movie details, including title, poster, and synopsis, using the TMDb API.
- **Post Reviews:** Users can write and view reviews for movies.
- **Watchlist Management:** Add movies to a personal watchlist for easy access later.
- **User Authentication:** Secure login system to manage personalized experiences.
- **UI:** Interactive JSP pages powered by Java Servlets to display movie details and user data.

---

## 💻 Technologies Used

### Backend
- **Java Servlets**: Handle HTTP requests and business logic.
- **JDBC**: Database connectivity for managing user and review data.
- **J2EE**: Web framework for application development.

### Frontend
- **JSP (Java Server Pages)**: Dynamic web pages for user interaction.
- **HTML/CSS**: Structuring and styling the web interface.

### Database
- **MySQL**: Relational database for data storage and persistence.

### API Integration
- **TMDb API**: Fetching movie details.

---

## 🚀 How to Run the Project

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/your-username/rate-my-movie.git
   cd rate-my-movie

2. **Set Up Database**
        Import the provided SQL schema to MySQL.
        Update database credentials in the project configuration.

3. **Deploy on Tomcat**
        Place the project in the webapps directory of your Tomcat server.
        Start the server and access the application at http://localhost:8080/rate-my-movie.

4.  **API Key Setup**
        Sign up on the TMDb website to get an API key.
        Add the API key to the project configuration file.

## 📂 Project Structure

    src/: Contains Java servlet files for business logic.
    webapp/: Includes JSP files, CSS, and other frontend assets.
    WEB-INF/: Deployment descriptor and configuration files.
    SQL/: Database schema for MySQL setup.
