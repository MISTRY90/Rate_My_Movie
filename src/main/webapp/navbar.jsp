<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%
    String username = null;
    if (session != null) {
        username = (String) session.getAttribute("username");
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto+Mono:ital,wght@0,100..700;1,100..700&display=swap"
	rel="stylesheet">
<style>
* {
	padding: 0;
	margin: 0;
	
}

nav {
	height: 7vh;
	display: flex;
	flex-direction: row;
	background-color: white;
}

img {
	width: 6rem;
	margin-right: auto;
}

.rest {
	width: 50%;
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: space-evenly;
}

.nav-item {
	display: flex;
	flex-direction: row;
	justify-content: center;
	align-items: center;
	gap: 7px;
}

.nav-item svg {
	width: 1.5rem;
}

a {
	text-decoration: none;
	color: black;
	font-size: 16px;
	letter-spacing: 2px;
	font-family: "Roboto Mono", monospace;
	font-optical-sizing: auto;
	font-weight: 400;
	font-style: normal;
}
.login{
margin-right: 10px;
}

</style>
</head>

<body>
	<nav>
		<img src="images/image-removebg-preview.png" alt="">
		<div class="rest">
			<a href="MovieServlet">Home</a>
			<div class="nav-item">
				<svg viewBox="0 0 24 24" fill="none"
					xmlns="http://www.w3.org/2000/svg">
                    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                <g id="SVGRepo_tracerCarrier" stroke-linecap="round"
						stroke-linejoin="round"></g>
                <g id="SVGRepo_iconCarrier">
                    <path
						d="M16.6725 16.6412L21 21M19 11C19 15.4183 15.4183 19 11 19C6.58172 19 3 15.4183 3 11C3 6.58172 6.58172 3 11 3C15.4183 3 19 6.58172 19 11Z"
						stroke="#000000" stroke-width="2" stroke-linecap="round"
						stroke-linejoin="round"></path>
                </g>
            </svg>
				<a href="movieSearch.jsp">Search</a>
			</div>
			<div class="nav-item">
				<svg viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg"
					fill="#000000">
                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                <g id="SVGRepo_tracerCarrier" stroke-linecap="round"
						stroke-linejoin="round"></g>
                <g id="SVGRepo_iconCarrier">
                    <path d="M0 0h48v48H0z" fill="none"></path>
                    <g id="Shopicon">
                        <path
						d="M31.278,25.525C34.144,23.332,36,19.887,36,16c0-6.627-5.373-12-12-12c-6.627,0-12,5.373-12,12 c0,3.887,1.856,7.332,4.722,9.525C9.84,28.531,5,35.665,5,44h38C43,35.665,38.16,28.531,31.278,25.525z M16,16c0-4.411,3.589-8,8-8 s8,3.589,8,8c0,4.411-3.589,8-8,8S16,20.411,16,16z M24,28c6.977,0,12.856,5.107,14.525,12H9.475C11.144,33.107,17.023,28,24,28z">
                    </path>
                </g>
            </g>
        </svg>
				 <% if (username != null) { %>
                    <form action="userServlet" method="post">
                        <input type="hidden" name="action" value="logout" />
                        <p> <%=username%>
                        <button type="submit">Logout</button>
                    </form>
                <% } else { %>
                    <form action="userServlet" method="post">
                        <input type="hidden" name="action" value="login" />
                        <button type="submit">Login/SignUp</button>
                    </form>
                <% } %>
			</div>
		</div>
	</nav>
</body>

</html>
