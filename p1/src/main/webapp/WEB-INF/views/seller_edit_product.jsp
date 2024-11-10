<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page import="com.rev.entity.*" %>
<%@ page import="com.rev.service.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Product</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        h1 {
            text-align: center;
            color: #333;
            margin: 20px 0;
        }
        .container {
            width: 90%;
            max-width: 600px;
            background: rgba(255, 255, 255, 0.8);
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
        }
        label {
            display: block;
            margin: 15px 0 5px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"],
        input[type="number"],
        textarea {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            transition: border 0.3s;
        }
        input[type="text"]:focus,
        input[type="number"]:focus,
        textarea:focus {
            border: 1px solid #007bff;
            outline: none;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            transition: background 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        window.onload = function() {
            const message = "${message}";
            if (message) {
                alert(message);
            }

            // Adding an event listener to the form submission
            const form = document.querySelector('form');
            form.addEventListener('submit', function(event) {
                const confirmation = confirm("Are you sure you want to update this product?");
                if (!confirmation) {
                    event.preventDefault();
                }
            });
        };
    </script>
</head>
<body>
    <div class="container">
        <h1>Edit Product</h1>
        <form:form method="post" modelAttribute="product" action="/seller/edit-product/${product.getProductId()}">
            <label for="name">Product Name:</label>
            <input type="text" id="name" name="name" value="${product.getName()}" required>

            <label for="description">Description:</label>
            <textarea id="description" name="description" required>${product.getDescription()}</textarea>

            <label for="stockQuantity">Quantity:</label>
            <input type="number" id="stockQuantity" name="stockQuantity" value="${product.getStockQuantity()}" required>

            <label for="image">Image URL:</label>
            <input type="text" id="image" name="image" value="${product.getImage()}" required>
            
            
            <label for="price">Price:</label>
            <input type="number" id="price" name="price" value="${product.getPrice()}" required>
            <label for="offer">Offer:</label>
            <input type="number" id="offer" name="offer" value="${product.getOffer()}" required>
            
            

            <input type="submit" value="Update Product">
        </form:form>

        <a class="back-link" href="/seller/dashboard">Back to Dashboard</a>
    </div>
</body>
</html>