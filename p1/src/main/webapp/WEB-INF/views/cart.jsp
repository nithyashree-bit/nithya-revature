<%@page import="com.rev.entity.Cart"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f4f4;
            font-family: Arial, sans-serif;
        }

        .cart-container {
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
        }

        .cart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e0e0e0;
            padding: 15px 0;
        }

        .cart-item img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }

        .cart-item-details {
            flex-grow: 1;
            padding-left: 20px;
        }

        .cart-item-details h5 {
            margin: 0;
            font-size: 16px;
            font-weight: 600;
        }

        .cart-item-details p {
            margin: 5px 0;
            color: #777;
        }

        .cart-item-actions {
            text-align: center;
        }

        .cart-item-actions .quantity {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .cart-item-actions .quantity button {
            border: none;
            background-color: transparent;
            font-size: 20px;
            cursor: pointer;
        }

        .cart-summary {
            padding: 20px;
            background-color: #f8f8f8;
            border-radius: 8px;
            margin-top: 20px;
        }

        .cart-summary h5 {
            margin-bottom: 15px;
            font-weight: 600;
        }

        .cart-summary .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

        .cart-summary .summary-item:last-child {
            font-size: 18px;
            font-weight: bold;
        }

        .checkout-btn {
            margin-top: 20px;
            width: 100%;
            background-color: #ff3f6c;
            color: white;
            border: none;
            padding: 15px 0;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }

        .checkout-btn:hover {
            background-color: #e63858;
        }

        .remove-item {
            color: #ff3f6c;
            font-size: 14px;
            cursor: pointer;
            text-align: center;
            background-color: transparent;
            border: none;
            box-shadow: none;
            padding: 0;
            transition: transform 0.2s ease-in-out, font-size 0.2s ease-in-out;
        }

        .remove-item:focus {
            outline: none;
        }

        .remove-item:hover {
            font-size: 16px;
        }

        @media (max-width: 768px) {
            .cart-container {
                padding: 15px;
            }

            .cart-item {
                flex-direction: column;
                align-items: flex-start;
            }

            .cart-item img {
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>

<div class="container cart-container">
    <jsp:include page="buyer_header.jsp"/>
    <%
    List<Cart> cartItems = (List<Cart>) request.getAttribute("cart");
    int totalPrice = 0;
    if (cartItems == null || cartItems.isEmpty()) {
        out.println("Your cart is empty.");
    } else {
    %>
    <div class="cart-header" style="margin-top: 100px">
        <h4>My Cart</h4>
    </div>
    <%
    for (Cart cartItem : cartItems) {
    %>
    <!-- Cart Item -->
    <div class="cart-item">
        <img src="<%= cartItem.getProduct().getImage() %>" alt="<%= cartItem.getProduct().getName() %>">
        <div class="cart-item-details">
            <h5><%= cartItem.getProduct().getName() %></h5>
            <p>Filter not added</p>
            <p>₹<%= cartItem.getProduct().getPrice() %></p>
        </div>
        <div class="cart-item-actions">
            <div class="quantity">
                <button type="button" onclick="updateQuantity(<%= cartItem.getProduct().getProductId() %>, -1)" class="minus">-</button>
                <input type="text" id="quantity-<%= cartItem.getProduct().getProductId() %>" value="<%= cartItem.getQuantity() %>" readonly class="form-control text-center" style="width: 40px; margin: 0 5px;">
                <button type="button" onclick="updateQuantity(<%= cartItem.getProduct().getProductId() %>, 1)" class="plus">+</button>
            </div>
            <button class="remove-item" onclick="removeItem(<%= cartItem.getProduct().getProductId() %>)">Remove</button>
        </div>
    </div>
    
    <%
    totalPrice += cartItem.getProduct().getPrice().intValue()*cartItem.getQuantity();

    }
    }
    %>

    <!-- Cart Summary -->
    <div class="cart-summary">
        <h5>Order Summary</h5>
        <div class="summary-item">
            <p>Total</p>
            <p>₹<%= totalPrice %></p>
        </div>
        <div class="summary-item">
            <p>Tax (5%)</p>
            <p>₹<%= totalPrice * 0.05 %></p>
        </div>
        <div class="summary-item">
            <p>Total</p>
            <p>₹<%= totalPrice * 1.05 %></p>
        </div>
        <button class="checkout-btn">Proceed to Checkout</button>
    </div>
</div>

<script>
function updateQuantity(productId, change) {
    console.log(`Product ID: ${productId}, Change:`+change); // Debug line
	
    const quantityInput = document.getElementById("quantity-"+productId);
    const currentQuantity = parseInt(quantityInput.value);

    // Calculate the new quantity
    console.log(currentQuantity);
    const newQuantity = currentQuantity + change;
    
    // Prevent negative quantities
    if (newQuantity < 0) {
        alert('Quantity cannot be less than 0.');
        return;
    }

    // Send PUT request to update the quantity in the cart
    fetch('/cart/update', {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            productId: productId,
            quantity: newQuantity
        })
    })
    .then(response => {
        if (response.ok) {
            // Update the displayed quantity
            location.reload(); // Reload the page to reflect changes
            quantityInput.value = newQuantity;
        } else {
            // If the response is not ok, handle the error
            response.text().then(text => alert(text));
        }
    })
    .catch(error => console.error('Error:', error));
}
    function removeItem(productId) {
        fetch(`/cart/removeItem`, { // Change the URL to not include the query parameter
            method: 'DELETE', // Ensure your server supports this method
            headers: { 'Content-Type': 'application/json' }, // Set the content type to JSON
            body: JSON.stringify({ productId: productId }) // Send productId in the body
        })
        .then(response => {
            if (response.ok) {
                location.reload(); // Reload the page to reflect changes
            } else {
                return response.text().then(text => alert(text));
            }
        })
        .catch(error => console.error('Error:', error));
    }
        

    /* function removeItem(productId) {
        fetch(`/api/cart/remove?productId=${productId}`, {
            method: 'DELETE',
        })
        .then(response => {
            if (response.ok) {
                location.reload(); // Reload the page to reflect changes
            } else {
                return response.text().then(text => alert(text));
            }
        })
        .catch(error => console.error('Error:', error));
    } */
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<footer class="my-footer"><jsp:include page="footer.jsp" /></footer>
</body>
</html>
