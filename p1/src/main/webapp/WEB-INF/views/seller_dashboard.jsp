<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Seller Dashboard</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f7f8;
            display: flex;
            height: 100vh;
            overflow: hidden;
        }

        .sidebar {
            width: 250px;
            background-color: black;
            opacity: 0.8;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            display: flex;
            flex-direction: column;
            transition: width 0.3s;
        }

        .sidebar a {
            display: block;
            color: white;
            padding: 15px;
            text-decoration: none;
            margin-bottom: 10px;
            border-radius: 8px;
            transition: background-color 0.3s;
            font-size: 16px;
        }

        .sidebar a:hover {
            background-color: #0056b3;
        }

        .sidebar p {
            font-size: 20px;
            font-weight: bold;
            color: white;
            margin-bottom: 30px;
            text-align: center;
        }

        .content {
            margin-left: 250px;
            padding: 20px;
            flex-grow: 1;
            height: 100%;
            width: calc(100% - 250px);
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            transition: margin-left 0.3s, width 0.3s;
            align-items: center;
            justify-content: center;
            text-align: center;
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.5);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            padding: 20px;
            width: 80%;
            max-width: 800px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Dropdown Styles */
        .submenu {
            position: relative;
            cursor: pointer;
        }

        .submenu ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: none;
            position: absolute;
            left: 0;
            top: 100%;
            background: black;
            width: 100%;
        }

        .submenu ul.show {
            display: block;
        }

        .submenu ul li a {
            padding: 10px;
            color: white;
            text-decoration: none;
            display: block;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .submenu ul li a:hover {
            background-color: #0056b3;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 200px;
            }

            .content {
                margin-left: 200px;
                width: calc(100% - 200px);
            }
        }

        @media (max-width: 576px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }

            .content {
                margin-left: 0;
                width: 100%;
            }
        }
        
    </style>

  <script>
    // Function to load content dynamically into the content area
    function loadContent(page) {
        const xhr = new XMLHttpRequest();
        xhr.open('GET', page, true);
        xhr.onreadystatechange = function () {
            const contentArea = document.getElementById('content');
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    contentArea.classList.add('glass-effect');
                    contentArea.innerHTML = xhr.responseText;
                    setTimeout(() => contentArea.classList.remove('glass-effect'), 500);
                } else {
                    contentArea.innerHTML = "<p>Failed to load content. Please try again later.</p>";
                }
            }
        };
        xhr.send();
    }

    // Dropdown menu toggle function
    function toggleDropdown() {
        const submenu = document.querySelector('.submenu ul');
        submenu.classList.toggle('show');
    }

    // Close dropdown menu if clicked outside
    window.addEventListener('click', function(event) {
        const submenu = document.querySelector('.submenu ul');
        if (!event.target.closest('.submenu')) {
            submenu.classList.remove('show');
        }
    });

    // Load "My Products" content when button is clicked
    function loadMyProducts() {
        loadContent('/seller/my-products'); // Replace with your actual URL for "My Products"
    }

    // Initial content load and event setup
    window.onload = function() {
        loadContent('/seller/add-product'); // Load default page on load
        document.querySelector('.scroll-to-section').onclick = toggleDropdown;
        document.querySelector('.my-products-btn').onclick = loadMyProducts; // Set up "My Products" button click
    };
</script>

<body>
    <div class="sidebar">
        <p>Seller Dashboard</p>
        <a href="javascript:void(0);" onclick="loadContent('/seller/add-product');">Add Product</a>
        <a href="/seller/my-products">View Products</a>
        <a href="javascript:void(0);" onclick="loadContent('/seller/viewOrders');">Orders</a>

        <li class="submenu">
            <a href="javascript:;" class="scroll-to-section">${sellerName}</a>
            <ul>
                <li><a href="/seller/profile">My Profile</a></li>
                <li><a href="/login">Login as Buyer</a></li>
                <li><a href="/seller/logout">Logout</a></li>
            </ul>
        </li>
    </div>

    <div class="content" id="content">
        <h2>Welcome to the Seller Dashboard</h2>
        <p>Select an option from the menu to get started.</p>
    </div>
</body>
</html>

 <%-- 
 
 <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Layout</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            height: 100vh;
            background-color: #f4f7f8;
        }

        .sidebar {
            width: 20%; /* 2:8 ratio for sidebar */
            background-color: black;
            color: white;
            padding: 20px;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }

        .content {
            width: 80%; /* 2:8 ratio for content */
            padding: 20px;
            overflow-y: auto;
        }
    </style>
</head>
<body>
    <div class="sidebar">
		<jsp:include page="seller_header.jsp"/>
    </div>
    <div class="content">
        <!-- Main Content -->
    </div>
</body>
</html>
  --%>