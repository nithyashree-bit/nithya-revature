<%@ page import="java.util.List" %>
<%@ page import="com.rev.entity.Seller" %>

<!DOCTYPE html>
<html lang="en">


<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
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
            background: white;
            color: black;
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
        }

        .main-content h2 {
            font-size: 28px;
            margin-bottom: 20px;
            color: #444;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .logout-link {
            margin-top: 50px;
        }

        .logout-link a {
            color: white;
            text-decoration: none;
            font-size: 16px;
        }

        .logout-link a:hover {
            text-decoration: underline;
        }

        footer {
            background-color: #333;
            padding: 40px 0;
            color: white;
            margin-top: 40px;
        }

        footer h4 {
            color: white;
        }

        footer a {
            color: white;
            text-decoration: none;
        }

        footer a:hover {
            text-decoration: underline;
        }

        footer .under-footer {
            text-align: center;
            margin-top: 20px;
        }

        footer .under-footer p {
            margin: 0;
        }
    </style>
</head>

<body>
    <aside style="display: flex; flex-direction: column; height: 100%;">
        <h2>Manage Users</h2>
        <div class="admin-links">
            <a href="/admin/buyers">View Buyers</a>
            <a href="/admin/sellers">View Sellers</a>
        </div>
        
        <div class="logout-link" style="margin-top: auto;">
            <a href="/admin/logout">Logout</a>
        </div>
        
        <div class="logo" style="margin-top: 20px;">
            <img src="../../assets/images/white-logo.png" alt="revshop ecommerce templatemo" style="height: 120px">
        </div>
    </aside>

    <main>
        <div class="main-content">
            <h2>Admin Dashboard</h2>
            <div class="graph-container">
                <canvas id="sellersBuyersChart" width="400" height="200"></canvas>
            </div>
            
            <!-- Pending Sellers Section -->
            <h1>Pending Sellers</h1>
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
				            List<Seller> pendingSellers = (List<Seller>) request.getAttribute("pendingSellers");
				            if (pendingSellers != null && !pendingSellers.isEmpty()) {
				                for (Seller seller : pendingSellers) {
				        %>
				                    <tr>
				                        <td><%= seller.getId() %></td>
				                        <td><%= seller.getUsername() %></td>
				                        <td><%= seller.getEmail() %></td>
				                        <td>
				                            <form action="/admin/approve-seller/<%= seller.getId() %>" method="post">
				                                <input type="submit" value="Approve">
				                            </form>
				                        </td>
				                    </tr>
				        <%
				                }
				            } else {
				        %>
				                <tr>
				                    <td colspan="4">No pending sellers found.</td>
				                </tr>
				        <%
				            }
				        %>
				    </tbody>
				</table>


        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        async function fetchUserCounts() {
            try {
                const response = await fetch('/admin/user-counts');
                if (!response.ok) throw new Error('Network response was not ok');
                return await response.json();
            } catch (error) {
                console.error('Failed to fetch user counts:', error);
                return { sellers: 0, buyers: 0 };
            }
        }

        async function initializeChart() {
            const ctx = document.getElementById('sellersBuyersChart').getContext('2d');
            const userCounts = await fetchUserCounts();

            const sellersBuyersChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Sellers', 'Buyers'],
                    datasets: [{
                        label: '# of Users',
                        data: [userCounts.sellers, userCounts.buyers],
                        backgroundColor: [
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(255, 99, 132, 0.2)'
                        ],
                        borderColor: [
                            'rgba(75, 192, 192, 1)',
                            'rgba(255, 99, 132, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        initializeChart();
    </script>
</body>

</html>