<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rev.entity.Buyer" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>View Buyers</title>
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../../assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../../assets/css/font-awesome.css">
    <link rel="stylesheet" href="../../assets/css/templatemo-revshop.css">
    <link rel="stylesheet" href="../../assets/css/owl-carousel.css">
    <link rel="stylesheet" href="../../assets/css/lightbox.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: #f9f9f9; /* Updated background to match the admin dashboard */
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
            width: 100%; /* Ensure main content uses full width */
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

        .view-products-link {
            color: black; /* Set link color to black */
            text-decoration: none; /* Remove underline */
        }

        .view-products-link:hover {
            text-decoration: underline; /* Add underline on hover */
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
    </style>
</head>

<body>
    <aside>
        <h2>Manage Users</h2>
        <div class="admin-links">
            <a href="/admin/buyers">View Buyers</a>
            <a href="/admin/sellers">View Sellers</a>
            <a href="/admin/dashboard">Back to Dashboard</a>
        </div>

        <div class="logout-link" style="margin-top: auto;">
            <a href="/admin/logout" style="color: white;">Logout</a> <!-- Updated color to white -->
        </div>

        <div class="logo" style="margin-top: 20px;">
            <img src="../../assets/images/white-logo.png" alt="revshop ecommerce templatemo" style="height: 120px">
        </div>
    </aside>

    <main>
        <h1>View Buyers</h1>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Get the buyers list from the request attribute
                    List<Buyer> buyers = (List<Buyer>) request.getAttribute("buyers");
                    if (buyers != null && !buyers.isEmpty()) {
                        for (Buyer buyer : buyers) {
                %>
                    <tr>
                        <td><%= buyer.getId() %></td>
                        <td><%= buyer.getUsername() %></td>
                        <td><%= buyer.getEmail() %></td>
                        <td>
                            <form action="/buyer/delete" method="post" style="display:inline;">
                                <input type="hidden" name="buyerId" value="<%= buyer.getId() %>">
                                <input type="submit" value="Delete">
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="4">No buyers found.</td>
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