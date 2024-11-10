<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.List" %>
<%@ page import="com.rev.entity.Cart" %>

<jsp:include page="header.jsp" />
<html>
<head>
    <title>Checkout</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Checkout</h2>
    <%
        List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");
        BigDecimal totalPrice = (BigDecimal) request.getAttribute("totalPrice");
    %>
    
    <!-- Shipping Address -->
    <h4>Shipping Address</h4>
    <form action="processCheckout" method="POST">
        <div class="form-group mb-3">
            <label for="fullName">Full Name</label>
            <input type="text" name="fullName" class="form-control" required>
        </div>
        <div class="form-group mb-3">
            <label for="address">Address</label>
            <textarea name="address" class="form-control" rows="2" required></textarea>
        </div>
        <div class="form-group mb-3">
            <label for="city">City</label>
            <input type="text" name="city" class="form-control" required>
        </div>
        <div class="form-group mb-3">
            <label for="state">State</label>
            <input type="text" name="state" class="form-control" required>
        </div>
        <div class="form-group mb-3">
            <label for="zip">ZIP Code</label>
            <input type="text" name="zip" class="form-control" required>
        </div>
        <div class="form-group mb-3">
            <label for="phone">Phone Number</label>
            <input type="tel" name="phone" class="form-control" required>
        </div>

        <!-- Payment Method -->
        <h4>Payment Method</h4>
        <div class="form-check">
            <input type="radio" class="form-check-input" name="paymentMethod" value="Credit Card" required>
            <label class="form-check-label">Credit Card</label>
        </div>
        <div class="form-check">
            <input type="radio" class="form-check-input" name="paymentMethod" value="UPI">
            <label class="form-check-label">UPI</label>
        </div>
        <div class="form-check">
            <input type="radio" class="form-check-input" name="paymentMethod" value="Cash on Delivery">
            <label class="form-check-label">Cash on Delivery</label>
        </div>

        <!-- Order Summary -->
        <h4 class="mt-4">Order Summary</h4>
        <div>
            <ul class="list-group">
                <%
                    for (Cart cartItem : cartItems) {
                        String productName = cartItem.getProduct().getName();
                        BigDecimal productPrice = cartItem.getProduct().getPrice();
                        int quantity = cartItem.getQuantity();
                %>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    <%= productName %> (x<%= quantity %>)
                    <span>₹<%= productPrice.multiply(BigDecimal.valueOf(quantity)) %></span>
                </li>
                <% } %>
            </ul>
            <div class="d-flex justify-content-between mt-3">
                <strong>Total:</strong>
                <strong>₹<%= totalPrice %></strong>
            </div>
        </div>

        <!-- Checkout Button -->
        <button type="submit" class="btn btn-primary mt-4 w-100">Place Order</button>
    </form>
</div>
</body>
</html>
<jsp:include page="footer.jsp" />