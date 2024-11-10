<%@page import="com.rev.entity.Wishlist"%>
<%@page import="java.util.List"%>
<%@page import="com.rev.entity.Product"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Your Wishlist</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f4f4f4;
	font-family: Arial, sans-serif;
}

.wishlist-container {
	margin: 20px auto;
	padding: 20px;
	background-color: #fff;
	border-radius: 8px;
}

.wishlist-header {
	margin-bottom: 20px;
	margin-top: 100px;
}

.wishlist-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 1px solid #e0e0e0;
	padding: 15px 0;
}

.wishlist-item img {
	width: 80px;
	height: 80px;
	object-fit: cover;
	border-radius: 5px;
}

.wishlist-item-details {
	flex-grow: 1;
	padding-left: 20px;
}

.wishlist-item-details h5 {
	margin: 0;
	font-size: 16px;
	font-weight: 600;
}

.wishlist-item-details p {
	margin: 5px 0;
	color: #777;
}

.remove-item {
	color: #ff3f6c;
	font-size: 14px;
	cursor: pointer;
	text-align: center;
	background-color: transparent;
	border: none;
	box-shadow: none;
	transition: transform 0.2s ease-in-out, font-size 0.2s ease-in-out;
}

.remove-item:hover {
	font-size: 16px;
}

@media ( max-width : 768px) {
	.wishlist-container {
		padding: 15px;
	}
	.wishlist-item {
		flex-direction: column;
		align-items: flex-start;
	}
	.wishlist-item img {
		margin-bottom: 10px;
	}
}
</style>
</head>
<body>

	<div class="container wishlist-container">
		<jsp:include page="buyer_header.jsp" />
		<div class="wishlist-header">
			<h1>Your Wishlist</h1>
		</div>

		<%
		List<Wishlist> wishlist = (List<Wishlist>) request.getAttribute("wishlist");

		if (wishlist != null && !wishlist.isEmpty()) {
		%>
		<div class="wishlist-items">
			<%
			for (Wishlist item : wishlist) {
				Product product = item.getProduct();
			%>
			<div class="wishlist-item">
				<img src="<%=product.getImage()%>" alt="<%=product.getName()%>">
				<div class="wishlist-item-details">
					<h5><%=product.getName()%></h5>
					<p>
						Price: ₹<%=product.getPrice()%></p>
				</div>
				<div>

					<button class="remove-item"
						onclick="removeItem11(<%=product.getProductId()%>)">Remove</button>
					<button class="move-to-cart"
						onclick="moveToCart(<%=product.getProductId()%>)"
						style="background-color: #28a745; color: white; border: none; padding: 10px 15px; border-radius: 5px; cursor: pointer; transition: background-color 0.3s;">
						Add to Cart</button>

				</div>
			</div>

			<%
			}
			%>
		</div>
		<%
		} else {
		%>
		<p>Your wishlist is empty.</p>
		<%
		}
		%>

		<a href="/productList" class="btn btn-primary mt-3">Back to
			Product List</a>
	</div>

<script>
    function removeItem11(productId) {
        fetch("/wishlist/remove/"+productId, {
            method: 'DELETE',
            headers: { 'Content-Type': 'application/json' },
        })
        .then(response => {
            if (response.ok) {
                debugger;
                location.reload();
            } else {
                response.text().then(text => alert(text));
            }
        })
        .catch(error => console.error('Error:', error));
    }

    function moveToCart(productId) {
        fetch("/cart/addItem?productId="+productId, {  
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
        })
        .then(response => {
            if (response.ok) {
                alert('Item moved to cart successfully.');
                location.reload(); // Reload the page to reflect changes
            } else {
                response.text().then(text => alert(text));
            }
        })
        .catch(error => console.error('Error:', error));
    }
</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<footer class="my-footer"><jsp:include page="footer.jsp" /></footer>
</body>
</html>
