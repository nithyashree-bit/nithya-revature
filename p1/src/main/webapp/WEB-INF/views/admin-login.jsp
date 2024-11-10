<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <style>
        @import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        html, body {
            display: grid;
            height: 100%;
            width: 100%;
            place-items: center;
            background: white;
        }

        .wrapper {
            align-items: center;
            width: 400px;
            max-width: 100%;
            background: #fff;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0px 15px 20px rgba(0, 0, 0, 0.1);
        }

        .wrapper .title {
            font-size: 25px;
            font-weight: 600;
            text-align: center;
            margin-bottom: 20px;
        }

        .field {
            padding: 10px;
            margin-top: 20px;
        }

        .field input {
            height: 50px;
            width: 100%;
            outline: none;
            padding-left: 15px;
            border-radius: 15px;
            border: 1px solid lightgrey;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .field input:focus {
            border-color: #1a75ff;
        }

        .btn {
            height: 50px;
            width: 100%;
            border-radius: 15px;
            position: relative;
            overflow: hidden;
            margin-top: 20px;
        }

        .btn .btn-layer {
            height: 100%;
            width: 300%;
            position: absolute;
            left: -100%;
            background: grey;
            border-radius: 15px;
            transition: all 0.4s ease;
        }

        .btn:hover .btn-layer {
            left: 0;
        }

        .btn input[type="submit"] {
            height: 100%;
            width: 100%;
            z-index: 1;
            position: relative;
            background: none;
            border: none;
            color: #fff;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
        }

        .error-message {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="wrapper">
    <div class="title">Admin Login</div>
    <form action="/admin/login" method="post">
        <div class="field">
            <input type="text" id="username" name="username" placeholder="Username" required>
        </div>
        <div class="field">
            <input type="password" id="password" name="password" placeholder="Password" required>
        </div>
        <div class="field btn">
            <div class="btn-layer"></div>
            <input type="submit" value="Login">
        </div>
        <c:if test="${not empty error}">
            <p class="error-message">${error}</p>
        </c:if>
    </form>
</div>
</body>
</html>