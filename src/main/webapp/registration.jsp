<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:ital,wght@0,100..700;1,100..700&display=swap"
        rel="stylesheet">
    <title>Movie Review Sign Up</title>
    <style>
        :root {
            --font-size: 16px;
            --form-shadow: #ccc;
            --form-primary-highlight: #f00;
            --form-secondary-highlight: #0f0;
            --form-bg: #fff;
            --font-color: #333;
        }

        * {
            padding: 0;
            margin: 0;
            letter-spacing: 2px;
            font-family: "Roboto Mono", monospace;
            font-optical-sizing: auto;
            font-weight: 400;
            font-style: normal;
        }

        body {
            height: 100vh;
            background-color: rgb(255, 225, 225);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 65rem;
            height: 80vh;
            background-color: rgb(255, 255, 255);
            border-radius: 30px;

            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-between;
        }

        .registration {
            width: 50%;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            gap: 40px;
        }

        form {
            height: 60%;
            display: flex;
            flex-direction: column;
            gap: 5px;
            width: 60%;
        }

        .user-box {
            position: relative;
        }

        .user-box input {
            width: 100%;
            padding: 10px 0;
            font-size: 16px;
            color: #000000;
            margin-bottom: 30px;
            border: none;
            border-bottom: 2px solid #000000;
            outline: none;
            background: transparent;
        }

        .user-box label {
            position: absolute;
            top: 0;
            left: 0;
            padding: 10px 0;
            font-size: 16px;
            color: #000000;
            pointer-events: none;
            transition: .5s;
        }

        .user-box input:focus~label,
        .user-box input:valid~label {
            top: -20px;
            left: 0;
            color: #505050;
            font-size: 12px;
        }

        button {
            width: 15rem;
            display: block;
            margin: 0 auto;
            line-height: calc(var(--font-size) * 2);
            padding: 0 20px;
            background: var(--form-shadow);
            letter-spacing: 2px;
            transition: 0.2s all ease-in-out;
            outline: none;
            border: 1px solid rgba(0, 0, 0, 1);
            box-shadow: 3px 3px 1px 1px var(--form-primary-highlight), 3px 3px 1px 2px rgba(0, 0, 0, 1);
        }

        button:hover {
            background: rgba(0, 0, 0, 1);
            color: white;
            border: 1px solid rgba(0, 0, 0, 1);
        }

        ::selection {
            background: var(--form-secondary-highlight);
        }

        input:-webkit-autofill,
        input:-webkit-autofill:hover,
        input:-webkit-autofill:focus {
            border-bottom: 5px solid var(--form-primary-highlight);
            -webkit-text-fill-color: var(--font-color);
            -webkit-box-shadow: 0 0 0px 1000px var(--form-bg) inset;
            transition: background-color 5000s ease-in-out 0s;
        }



        .pic {
            width: 34rem;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 30px;
        }

        img {
            width: 20rem;
        }

        a{
            color: #000000;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="registration">
            <h2>Sign Up</h2>
            <form action="userServlet" method="POST">
                <input type="hidden" name="action" value="register">
                <div class="user-box">
                    <input type="text" id="username" name="username" required>
                    <label> Username</label>
                </div>

                <div class="user-box">
                    <input type="email" id="email" name="email" required>
                    <label>Email</label>
                </div>
                <div class="user-box">
                    <input type="password" id="password" name="password" required>
                    <label>Password</label>
                </div>
                <div class="user-box">
                    <input type="password" id="password*" name="password*" required>
                    <label>Confirm Password</label>
                </div>
                <button type="submit">Register</button>
            </form>
        </div>
        <div class="pic">
            <img src="images/register.jpeg" alt="">
            <p><a href="">I am already a member</a></p>
        </div>
    </div>
</body>

</html>