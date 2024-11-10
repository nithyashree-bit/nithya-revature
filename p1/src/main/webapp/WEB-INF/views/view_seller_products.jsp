<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rev.entity.Product" %>
<%@ page import="com.rev.entity.Seller" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Products for <%= ((Seller) request.getAttribute("seller")).getUsername() %></title>
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../../assets/css/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="../../assets/css/templatemo-revshop.css">
    <link rel="stylesheet" type="text/css" href="../../assets/css/owl-carousel.css">
    <link rel="stylesheet" type="text/css" href="../../assets/css/lightbox.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: #f9f9f9; /* Background matching the admin dashboard */
            color: black;
            display: flex;
            animation: fadeIn 1s ease-in-out;
        }

        aside {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100%;
            background-color: #444;
            padding: 20px;
            color: white;
            display: flex;
            flex-direction: column;
        }

        aside h2 {
            color: white;
            font-size: 22px;
            margin-bottom: 20px;
        }

        .admin-links a {
            display: block;
            margin: 10px 0;
            padding: 10px;
            color: white;
            text-decoration: none;
            border: 1px solid #fff;
            border-radius: 5px;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        .admin-links a:hover {
            background-color: #333;
            transform: translateX(5px);
        }

        main {
            margin-left: 270px;
            padding: 40px;
            background-color: #f9f9f9;
            min-height: 100vh;
            width: 100%;
        }

        h1 {
            font-size: 28px;
            color: #444;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th,
        table td {
            padding: 10px;
            text-align: left;
            border: 1px solid #ccc;
        }

        table th {
            background-color: #444;
            color: white;
        }

        footer {
            background-color: #333;
            padding: 40px 0;
            color: white;
            margin-top: 40px;
            text-align: center;
        }

        footer a {
            color: white;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }

            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        aside {
            animation: fadeIn 1s ease-in-out;
        }

        .delete-button {
            background-color: #d9534f; /* Bootstrap danger color */
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        .delete-button:hover {
            background-color: #c9302c; /* Darker on hover */
        }
    </style>
</head>

<body>
    <aside>
        <h2>Manage Products</h2>
        <div class="admin-links">
            <a href="/admin/buyers">View Buyers</a>
            <a href="/admin/sellers">View Sellers</a>
            <a href="/admin/dashboard">Back to Dashboard</a>
        </div>

        <div class="logout-link" style="margin-top: auto;">
            <a href="/admin/logout" style="color: white;">Logout</a>
        </div>

        <div class="logo" style="margin-top: 20px;">
            <img src="../../assets/images/white-logo.png" alt="revshop ecommerce templatemo" style="height: 120px">
        </div>
    </aside>

    <main>
        <h1>Products for <%= ((Seller) request.getAttribute("seller")).getUsername() %></h1>
        <table>
            <thead>
                <tr>
                    <th>Product ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Product> products = (List<Product>) request.getAttribute("products");
                    if (products != null && !products.isEmpty()) {
                        for (Product product : products) {
                %>
                    <tr>
                        <td><%= product.getProductId() %></td>
                        <td><%= product.getName() %></td>
                        <td><%= product.getDescription() %></td>
                        <td><%= product.getPrice() %></td>
                        <td>
                            <form action="/product/delete" method="post" style="display:inline;">
                                <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                                <input type="submit" value="Delete" class="delete-button">
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="5">No products found for this seller.</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <br>
        
    </main>
</body>

</html>