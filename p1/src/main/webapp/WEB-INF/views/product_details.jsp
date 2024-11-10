<%@page import="java.math.BigDecimal"%>
<%@page import="com.rev.entity.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<head>
<title>Explore</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

<!-- Font Awesome -->
<script defer
	src="https://use.fontawesome.com/releases/v5.0.13/js/all.js"
	integrity="sha384-xymdQtn1n3lH2wcu0qhcdaOpQwyoarkgLVxC/wZ5q7h9gHtxICrpcaSUfygqZGOe"
	crossorigin="anonymous"></script>

<!-- Style.CSS -->
<style>
/* Alert info */
.alert {
	margin-bottom: 0px;
}

.alert-info {
	color: #ffffff;
	background-color: #977CB7;
	border-color: #bee5eb;
}

.alert p {
	text-align: center;
}

/* Nav bar */
.navbar img {
	height: 50px;
}

.removed button {
	background: #977CB7;
	color: #ffffff;
}

.removed button:hover {
	background-color: #a668f1;
	color: #ffffff;
}

/* Carousel Images */
.carousel-control-prev-icon {
	background-color: #977CB7;
	border-radius: 12px;
}

.carousel-control-next-icon {
	background-color: #977CB7;
	border-radius: 12px;
}

/* SELECT QUANTITY DROPDOWN & ADD TO CART BUTTON HERE  */
.custom-select {
	width: auto;
}

.add-to-cart button {
	background-color: #977CB7;
	border: #977CB7;
}

.add-to-cart button:hover {
	background-color: #a668f1;
	color: #ffffff;
}

.image-container !important {
	width: 300px; /* Set the max width of the image */
	height: 300px; /* Set the max height of the image */
	overflow: hidden; /* Hide overflow if the image is larger */
	border-radius: 10px; /* Optional: Add rounded corners */
	border: 1px solid #ddd; /* Optional: Add a subtle border */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Optional: Add shadow */
	display: flex;
	align-items: center;
	justify-content: center;
}

.image-container img {
	max-width: 100%; /* Ensure image does not exceed container width */
	max-height: 100%; /* Ensure image does not exceed container height */
	object-fit: cover;
	/* Scale image to fill the container while maintaining aspect ratio */
}

.my-footer {
	background: #977CB7;
}
</style>
</head>

<body class="d-flex align-items-start flex-column">
	<!-- ADD TOP ALERT HERE -->
	<div class="alert alert-info  w-100 alert-dismissible fade show"
		role="alert">
		<p>Not looking for this? browse our other products</p>
		<button type="button" class="close" data-dismiss="alert"
			aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<jsp:include page="buyer_header.jsp" />
	



	<!-- Main Content -->
	<main class="container"  style = "margin-top:100px;">
		<div class="row">
			<!-- Carousel Images -->
			<div class="col-md-7">
				<!-- ADD YOUR CAROUSEL HERE -->

				<div id="carouselExampleControls" class="carousel slide"
					data-ride="carousel">
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img src="${product.image}" alt="${product.name}"
								class="product-img">
						</div>
						<div class="carousel-item">
							<img src="${product.image}" alt="${product.name}"
								class="product-img">
						</div>

					</div>
					<a class="carousel-control-prev" href="#carouselExampleControls"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="carousel-control-next" href="#carouselExampleControls"
						role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>



				<!-- </div> -->
			</div>

			<!-- Main Product Information -->
			<div class="col-md-5" style ="margin-top:50px";>

				<h2>${product.name}
					<span class="badge badge-secondary">New</span>
					
				</h2>
				<p>Attributes</p>
				<hr>
				<%
				Product product = (Product) request.getAttribute("product"); // Retrieve product object

				// Retrieve price and offer
				BigDecimal priceBD = product.getPrice(); // Assuming getPrice returns BigDecimal
				double price = priceBD.doubleValue(); // Convert BigDecimal to double
				BigDecimal offerBD = product.getOffer(); // Assuming offer is a double or can be directly retrieved
				double offer = offerBD.doubleValue(); // Convert BigDecimal to double
				double discountedPrice = price - (price * offer / 100);
				%>
				<h6 style="color: green">Special Price</h6>
				<span style="font-size: 20px">$<%=discountedPrice%></span> <span><s>$${product.price}</s></span>
				<span>${product.offer }% off</span>
				<!-- Form for adding to cart -->
				<!-- SELECT QUANTITY DROPDOWN & ADD TO CART BUTTON HERE -->
				<!-- <form> -->
				<div class="form-row add-to-cart align-items-center">
					<!-- <div class="col-12 my-1 form-group">
						<label class="mr-sm-12" for="inlineFormCustomSelect">Select a Quantity</label>
						<select class="custom-select mr-sm-2 form-control"
							id="quantityOfUnicorns">
							<option selected>Choose...</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="3">4</option>
							<option value="3">5</option>
						</select>
					</div> -->
					<div style="display: flex; justfy-content: space-around; width: 300px; margin-top:20px;">

					<form
						action="/cart/addItem?productId=<%=product.getProductId()%>"
						method="post">
						<div class="col-12 my-1">
								<%
								boolean alreadyInCart = (boolean) request.getAttribute("alreadyAdded");

								if (!alreadyInCart) {
								%>

									<button type="submit" class="btn btn-primary"
										style="height: 50px; width: auto; padding: 10px">Add
										to Cart</button>
									<%
									} else {
									%>

									<button type="submit" class="btn btn-primary" disabled
										style="background-color: grey; height: 50px; width: auto; padding: 10px">Added
										to Cart</button>
									<!-- </form> -->
									<%
									}
									%>
									</div>	
								
					</form>
				
					<form action="/checkout" method="post">
											<div class="col-12 my-1">
					
						<button type="submit" class="btn btn-primary"
							style="height: 50px; width: auto; padding: 10px;background-color:green">Buy Now</button>
							</div>
					</form>
				</div>
				</div>
			</div>
		</div>

		<!-- Scrollspy connected to Dropdown Menu -->
		<div data-spy="scroll" data-target="#sections" data-offset="0">

			<!-- Product Information -->
			<div class="row">
				<div class="col-12">
					<h4 id="product-info" class="section-header">Product
						Information</h4>

					<!-- ADD PRODUCT INFORMATIOB TABS HERE -->
					<nav>
						<div class="nav nav-tabs" id="nav-tab" role="tablist">
							<a class="nav-item nav-link active" id="nav-home-tab"
								data-toggle="tab" href="#nav-home" role="tab"
								aria-controls="nav-home" aria-selected="true">Description</a> <a
								class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab"
								href="#nav-profile" role="tab" aria-controls="nav-profile"
								aria-selected="false">Details</a>
								<a
								class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab"
								href="#reviews" role="tab" aria-controls="nav-profile"
								aria-selected="false">Reviews</a>

						</div>
					</nav>
					<div class="tab-content" id="nav-tabContent">
						<div class="tab-pane fade show active" id="nav-home"
							role="tabpanel" aria-labelledby="nav-home-tab">
							<p>${product.description }</p>
						</div>
						<div class="tab-pane fade" id="nav-profile" role="tabpanel"
							aria-labelledby="nav-profile-tab">
							<ul>
								<li>Suitable for ages 3 years and up</li>
								<li>Silky plush fur</li>
								<li>Measure 36" H</li>
								<li>Imported</li>
							</ul>
						</div>
						<div class="tab-pane fade" id="reviews" role="tabpanel"
							aria-labelledby="nav-profile-tab">
							<jsp:include page="reviews.jsp"/>
						</div>

					</div>


					<!-- Text for tab 1:
            This graceful unicorn will prance right into any child’s collection -- and heart! With its pretty pink mane and tail, both scattered through with shimmering silver strands that catch the light, this enchanting friend is sure to become a new favorite. Additional irresistible details include super-silky plush fur, satin star decorations, beautiful blue eyes, and a soft, shiny horn.-->
					<!-- Text for tab 2:
            • Suitable for ages 3 years and up
            • Silky plush fur
            • Measure 36" H
            • Imported -->
				</div>
			</div>

			<!-- Similar Items -->
			<div class="row">
				<div class="col-12">
					<h4 id="similar-items" class="section-header">Similar Items</h4>
					<div class="row">
						<!-- ADD SIMILAR ITEMS HERE -->
						<div class="col-3">
							<img class="w-100" src="img/recommendedProduct1.jpg"
								alt="First similar">
						</div>
						<div class="col-3">
							<img class="w-100" src="img/recommendedProduct2.jpg"
								alt="Second similar">
						</div>
						<div class="col-3">
							<img class="w-100" src="img/recommendedProduct3.jpg"
								alt="Third similar">
						</div>
						<div class="col-3">
							<img class="w-100" src="img/recommendedProduct4.jpg"
								alt="Fourth similar">
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
	</main>

	<!-- Chat Button with Popover-->
	<!-- BONUS: ADD CHAT POPOVER HERE -->
	<button id="chatPopover" type="button" class="chat btn">Need
		help?</button>

	<!-- Footer -->
	<footer
		class="mt-auto d-flex justify-content-center align-items-center">
		<p class="m-0">Everything Unicorns</p>
	</footer>

	<!-- Modal -->
	<div class="modal fade" id="signUpModal" tabindex="-1" role="dialog"
		aria-labelledby="mySignUpModal" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h5 class="modal-title" id="modalHeader">Sign up for savings
						sent right to your inbox!</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

				<!-- Modal Body - Form -->
				<div class="modal-body">
					<!-- ADD YOUR FORM HERE -->
					<form>
						<div class="form-group">
							<label for="formGroupFirstNameInput">First Name</label> <input
								type="text" class="form-control" id="formGroupFirstNameInput"
								placeholder="">
						</div>
						<div class="form-group">
							<label for="formGroupLastNameInput2">Last Name</label> <input
								type="text" class="form-control" id="formGroupLastNameInput2"
								placeholder="">
						</div>
						<div class="form-group">
							<label for="formGroupInputEmail">E-mail</label> <input
								type="email" class="form-control" id="formGroupInputEmail"
								aria-describedby="emailHelp" placeholder="Enter email">
							<small id="emailHelp" class="form-text text-muted">We'll
								never share your email with anyone else.</small>
						</div>
						<div class="form-check">
							<input type="checkbox" class="form-check-input"
								id="exampleCheck1"> <label class="form-check-label"
								for="exampleCheck1">Check me out</label>
						</div>
						<!-- <button type="submit" class="btn btn-primary">Submit</button> -->
					</form>



				</div>

				<!-- Modal Footer - Button -->
				<div class="modal-footer">
					<button type="button" id="signUpBtn" class="btn btn btn-primary">Sign
						me up!</button>
					<!-- <button type="submit" class="close" data-dismiss="modal" aria-label="Submit"></button> -->
				</div>
			</div>
		</div>
	</div>


	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script src="./app2.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>


</body>

</html>