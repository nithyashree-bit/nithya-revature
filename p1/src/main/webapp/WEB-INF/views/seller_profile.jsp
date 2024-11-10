<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Profile</title>
    <link rel="stylesheet" type="text/css" href="styles.css"> <!-- Link to your CSS file -->
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4; /* Soft light background */
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h2 {
            text-align: center;
            color: #444;
            margin-bottom: 20px;
            animation: fadeIn 1s;
        }

        form {
            background: white; /* Solid white background for the form */
            border-radius: 12px;
            padding: 30px;
            max-width: 400px;
            width: 100%;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Soft shadow for depth */
            animation: slideIn 0.5s;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc; /* Light gray border */
            border-radius: 6px;
            transition: border 0.3s;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border: 2px solid #4CAF50; /* Green border on focus */
            outline: none;
        }

        input[type="submit"] {
            background-color: #4CAF50; /* Green background for submit button */
            color: white;
            border: none;
            border-radius: 6px;
            padding: 10px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            transition: background-color 0.3s, transform 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #45a049; /* Darker green on hover */
            transform: translateY(-2px); /* Slight upward movement on hover */
        }

        p {
            text-align: center;
            margin-top: 20px;
        }

        a {
            color: #4CAF50;
            text-decoration: none;
            transition: color 0.3s;
        }

        a:hover {
            color: #388e3c; /* Darker green on link hover */
        }

        /* Success and Error messages */
        .success-message, .error-message {
            padding: 10px;
            text-align: center;
            border-radius: 4px;
            margin-bottom: 20px;
            animation: fadeIn 1s;
        }

        .success-message {
            background-color: #dff0d8;
            color: #3c763d;
            border: 1px solid #d6e9c6;
        }

        .error-message {
            background-color: #f2dede;
            color: #a94442;
            border: 1px solid #ebccd1;
        }

        /* Animation Keyframes */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes slideIn {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <div>
        <h2>Sellers Profile</h2>

       <%--  <!-- Display success and error messages -->
        <c:if test="${not empty successMessage}">
            <div class="success-message">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if> --%>

        <form action="${pageContext.request.contextPath}/seller/updateProfile" method="post">
            <label for="email">Email:</label>
            <input type="text" name="email" value="${seller.email}" required/>

            <label for="phoneNumber">Phone Number:</label>
            <input type="text" name="phoneNumber" value="${seller.phoneNumber}" required/>

            <label for="address">Address:</label>
            <input type="text" name="address" value="${seller.address}" required/>

            <label for="password">Password:</label>
            <input type="password" name="password"/>

            <input type="submit" id="submitButton" value="Update Profile"/>
        </form>

        <p><a href="/seller/dashboard">Back to Dashboard</a></p>
    </div>

    <script>
        document.getElementById("submitButton").addEventListener("click", function(event) {
            event.preventDefault(); // Prevent form submission for animation effect
            this.classList.add("rocket"); // Add rocket animation class
            setTimeout(() => {
                this.closest("form").submit(); // Submit form after animation
            }, 1500); // Delay to match animation duration
        });
    </script>
</body>
</html>
