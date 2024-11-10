<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Product</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #e0eafc, #cfdef3);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        form {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            padding: 40px;
            max-width: 500px;
            width: 100%;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
        }

        input[type="text"],
        input[type="number"],
        textarea,
        select {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus,
        input[type="number"]:focus,
        select:focus,
        textarea:focus {
            border-color: #007bff;
            outline: none;
        }

        textarea {
            resize: vertical;
            height: 100px;
        }

        .order {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 15px 30px;
            font-size: 18px;
            cursor: pointer;
            transition: transform 0.3s ease, background-color 0.3s ease;
            position: relative;
            border-radius: 5px;
            outline: none;
            width: 100%;
        }

        .order:before {
            content: '🚀';
            font-size: 0;
            transition: font-size 0.3s ease;
            position: absolute;
            right: 10px;
            top: 10px;
        }

        .order.animate {
            background-color: #f39c12;
            transform: translateY(-100px);
            transition: transform 2s ease-out;
        }

        .order.animate:before {
            font-size: 24px;
        }

        .order.animate {
            transform: translateY(-500px) scale(0.5);
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            text-align: center;
            text-decoration: none;
            color: #007bff;
            font-weight: 600;
            transition: color 0.3s;
        }

        .back-link:hover {
            color: #0056b3;
        }
    </style>
    
    <script>
        // Function to validate form inputs
        function validateForm(event) {
            const name = document.getElementById('name').value;
            const price = document.getElementById('price').value;
            const stockQuantity = document.getElementById('stockQuantity').value;

            if (!name || !price || !stockQuantity) {
                alert('Please fill in all fields.');
                event.preventDefault(); // Prevent form submission
            }
        }

        // Event listeners for input fields and button animation
        window.onload = function() {
            document.getElementById('name').addEventListener('input', function() {
                if (this.value.length < 3) {
                    this.style.borderColor = 'red';
                } else {
                    this.style.borderColor = '#ddd';
                }
            });

            document.querySelector('form').addEventListener('submit', validateForm);

            var message = "${message}";
            if (message) {
                alert(message);
            }

            // Rocket animation for the submit button
            document.querySelector('.order').addEventListener('click', function(e) {
                let button = this;
                if (!button.classList.contains('animate')) {
                    button.classList.add('animate');
                    setTimeout(() => {
                        button.classList.remove('animate');
                    }, 2000);  // 2 seconds fly-off animation
                }
            });
        };
    </script>
</head>
<body>
    <form:form method="post" modelAttribute="product" action="${pageContext.request.contextPath}/seller/add-product">
        <h1>Add Product</h1>
        
        <label for="name">Product Name:</label>
        <input type="text" id="name" name="name" required>

        <label for="description">Description:</label>
        <textarea id="description" name="description" required></textarea>

        <label for="price">Price:</label>
        <input type="number" id="price" name="price" step="0.01" required>
        
        <label for="offer">Offer</label>
        <input type="number"id ="offer" name="offer" step="0.01" required>

        <label for="stockQuantity">Stock Quantity:</label>
        <input type="number" id="stockQuantity" name="stockQuantity" required>

        <label for="image">Image URL:</label>
        <input type="text" id="image" name="image" required>

        <label for="category">Category:</label>
        <select id="category" name="category" required>
            <option value="">Select Category</option>
            <option value="Accessories">Accessories</option>
            <option value="Electronics">Electronics</option>
            
            <option value="Others">Others</option>
        </select>

        <button type="submit" class="order">Submit</button>
        
        <a class="back-link" href="/seller/dashboard">Back to My Products</a>
    </form:form>
</body>
</html>