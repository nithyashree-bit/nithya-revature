<!DOCTYPE html>
<%@page import="java.util.List"%>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href="https://fonts.googleapis.com/css?family=Poppins:100,200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
    <title>Product Filter</title>

    <!-- Additional CSS Files -->
    <link rel="stylesheet" type="text/css" href="../../assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="../../assets/css/font-awesome.css">
    <link rel="stylesheet" href="../../assets/css/templatemo-revshop.css">
    <link rel="stylesheet" href="../../assets/css/owl-carousel.css">
    <link rel="stylesheet" href="../../assets/css/lightbox.css">
</head>

<body>
    <div>
        <jsp:include page="buyer_header.jsp" />
    </div>

    <div class="container mt-5">
        <%
            String category = (String) request.getAttribute("category");
            List<com.rev.entity.Product> products = (List<com.rev.entity.Product>) request.getAttribute("products");
        %>

        <h2 class="text-center">Filtered Products - <%= category != null ? category : "All" %></h2>

        <div class="row mt-4">
           <jsp:include page="products.jsp"/>
        </div>
    </div>

    <div class="jumper">
        <div></div>
        <div></div>
        <div></div>
    </div>
</body>
</html>
