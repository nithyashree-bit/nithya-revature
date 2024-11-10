<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.rev.entity.*" %>
<%@ page import="com.rev.service.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Products</title>
    <link rel="stylesheet" type="text/css" href="../../assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../../assets/css/font-awesome.css">
    <link rel="stylesheet" href="../../assets/css/templatemo-revshop.css">
    <link rel="stylesheet" href="../../assets/css/owl-carousel.css">
    <link rel="stylesheet" href="../../assets/css/lightbox.css">
    <style>
        body {
            background: linear-gradient(to right, #f5f7fa, #c3cfe2);
            margin: 0;
            font-family: 'Arial', sans-serif;
            color: #333;
        }

        main {
            padding: 40px 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Product Grid */
        .product-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            padding: 20px 0;
        }

        /* Product Card */
        .product-card {
            border-radius: 12px;
            overflow: hidden;
            background-color: #fff;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid #ddd;
            animation: fadeInUp 0.5s ease;
        }

        .product-card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .product-card img {
            width: 100%;
            max-height: 200px;
            object-fit: contain;
            padding: 10px;
            transition: transform 0.3s ease;
        }

        .product-card:hover img {
            transform: scale(1.1);
        }

        /* Product Details */
        .product-details {
            padding: 15px;
        }

        .product-details h3 {
            font-size: 1.1rem;
            margin: 10px 0;
            color: #333;
        }

        .product-details p {
            font-size: 0.9rem;
            color: #555;
            margin: 5px 0;
        }

        .product-details .price, .product-details .stock {
            font-weight: bold;
            color: #007bff;
        }

        /* Buttons */
        .delete-button, .update-button {
            display: inline-block;
            margin: 10px 5px;
            padding: 8px 12px;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.3s;
            cursor: pointer;
        }

        .delete-button {
            background-color: #dc3545;
        }

        .delete-button:hover {
            background-color: #c82333;
            transform: scale(1.1);
        }

        .update-button {
            background-color: #28a745;
        }

        .update-button:hover {
            background-color: #218838;
            transform: scale(1.1);
        }

        /* Back to Dashboard Link */
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #333;
            font-weight: bold;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 5px;
            background-color: #f8f9fa;
            transition: background-color 0.3s;
        }

        .back-link:hover {
            background-color: #e2e6ea;
            color: #007bff;
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>

<main>
    <div class="product-container">
        <%
            List<Product> products = (List<Product>) request.getAttribute("products");
            if (products == null || products.isEmpty()) {
        %>
            <p>No products found.</p>
        <%
            } else {
                for (Product product : products) {
        %>
            <div class="product-card">
    <img src="<%= product.getImage() %>" alt="Product Image">
    <div class="product-details">
        <h3><%= product.getName() %></h3>
        <p><%= product.getDescription() %></p>
        <p class="price"><del>$<%= product.getPrice() %></del></p> <!-- Strikethrough original price -->
        <p class="offer">$<%= product.getOffer() %></p> <!-- Offer price -->
        <p class="stock"><%= product.getStockQuantity() %> in stock</p>
        <a class="update-button" href="/seller/edit-product/<%= product.getProductId() %>">
            Update Product
        </a>
        <a class="delete-button" href="/seller/delete-product/<%= product.getProductId() %>">
            Delete Product
        </a>
    </div>
</div>

        <%
                }
            }
        %>
    </div>
    <div>
        <a href="/seller/dashboard" class="back-link">Back to dashboard</a>
    </div>
</main>

<script>
    function confirmDelete(productId) {
    	console.log("Product ID to delete:", productId);
        const confirmation = confirm("Are you sure you want to delete this product?");
        console.log(confirmation);
        if (confirmation) {
        	fetch(/seller/delete-product/${productId}, {
        	    method: 'POST',
        	    headers: {
        	        'Content-Type': 'application/json'
        	    }
        	})
   .then(response => {
                if (response.ok) {
                    alert("Product deleted successfully.");
                    location.reload();
                } else {
                    alert("Failed to delete the product. Please try again.");
                    
                }
            })
            .catch(error => {
                alert("An error occurred. Please try again.");
            });
        }
    }
</script>
</body>
</html>