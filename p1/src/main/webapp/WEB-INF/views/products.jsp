<%@ page import="com.rev.entity.Product"%>
<%@ page import="java.util.List"%>

<style>
.thumb {
	width: 100%;
	height: 300px; /* Fixed height for consistency */
	display: flex;
	align-items: center;
	justify-content: center;
	overflow: hidden;
	border: 1px solid #ddd;
	border-radius: 10px;
	margin-bottom: 10px;
}

.thumb img {
	max-width: 100%;
	max-height: 100%;
	object-fit: cover; /* Ensures the image scales correctly */
}

.item {
	width: auto;
	margin: 0 auto;
	height: 450px; /* Fixed item height */
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.down-content {
	text-align: center;
	padding: 10px 0;
}

.stars {
	list-style: none;
	padding: 0;
	display: flex;
	justify-content: center;
}

.stars li {
	margin: 0 2px;
}

.hover-content ul {
	display: flex;
	justify-content: space-around;
	padding: 0;
	list-style: none;
}

.hover-content ul li a {
	color: #333;
	font-size: 18px;
}

.hover-content ul li a:hover {
	color: red;
}
</style>

<section class="section" id="products">
	<div class="container">
		<div class="row">
			<%
			List<Product> products = (List<Product>) request.getAttribute("products");
			if (products != null) {
				for (Product product : products) {
			%>

			<div class="col-lg-4">
				<div class="item">
					<div class="thumb">
						<div class="hover-content">
							<ul>
								<li style="display: inline-block; margin: 5px;"><a
									href="/product_details?productId=<%=product.getProductId()%>"
									style="text-decoration: none; background-color: grey; color: white; padding: 10px 15px; border-radius: 5px; display: inline-flex; align-items: center; justify-content: center; transition: background-color 0.3s;">
										<i class="fa fa-eye" style="font-size: 20px;"></i>
								</a></li>

								<li style="display: inline-block; margin: 5px;"><a
									href="javascript:void(0);"
									onclick="toggleWishlist('<%=product.getProductId()%>')"
									style="text-decoration: none; background-color: grey; color: white; padding: 10px 15px; border-radius: 5px; display: inline-flex; align-items: center; justify-content: center; transition: background-color 0.3s;">

										<i class="fa fa-heart"
										id="wishlist-icon-<%=product.getProductId()%>"
										style="font-size: 20px; color: <%=(request.getAttribute("inWishlist") != null && (Boolean) request.getAttribute("inWishlist")) ? "red" : "white"%>; ">
									</i>
								</a></li>

								<li style="display: inline-block; margin: 5px;"><a
									href="javascript:void(0);"
									onclick="addToCart('<%=product.getProductId()%>')"
									style="text-decoration: none; background-color: grey; color: white; padding: 10px 15px; border-radius: 5px; display: inline-flex; align-items: center; justify-content: center; transition: background-color 0.3s;">
										<i class="fa fa-shopping-cart" style="font-size: 20px;"></i>
								</a></li>

							</ul>
						</div>
						<img src="<%=product.getImage()%>" alt="<%=product.getName()%>">
					</div>
					<div class="down-content">
						<h4><%=product.getName()%></h4>
						<span>$<%=product.getPrice()%></span>
						<ul class="stars">
							<li><i class="fa fa-star"></i></li>
						</ul>
					</div>
				</div>
			</div>
			<%
			}
			}
			%>


		</div>
	</div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function removeFromWishlist(wishlistId) {
    fetch(`/wishlist/remove/${wishlistId}`, {
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
}
function addToCart(productId) {
	$
			.ajax({
				type : "POST",
				url : "/cart/addToCart",
				data : {
					productId : productId,
				},
				success : function(response) {
					if (response.status === "success") {
						alert("Product added to cart!");
						// Optionally update the UI to reflect the cart addition
					} else {
						alert("Error adding product to cart.");
					}
				},
				error : function() {
					alert("An error occurred while adding the product to the cart.");
				}
			});
}
			 function toggleWishlist(productId) {
			    const icon = document.getElementById("wishlist-icon-"+productId);
			    
			    // Check if the product is already in the wishlist
			    const isInWishlist = icon.style.color === "red";
			    
			    // Determine the method (POST or DELETE) based on the current state
			    const method = isInWishlist ? "DELETE" : "POST";
			    const url2 = isInWishlist ? "remove" : "add";
			    const url = `/wishlist/${isInWishlist ? "remove" : "add"}`;
			    
			    const requestData = {
			        user: {
			            id: "<%= session.getAttribute("userId") %>" // Ensure this is valid
			        },
			        product: {
			            productId: productId
			        }
			    };
			
			    // Use the Fetch API to make the request
			    fetch(url, {
			        method: method,
			        headers: {
			            'Content-Type': 'application/json'
			        },
			        body: JSON.stringify(requestData)
			    })
			    .then(response => {
			        if (!response.ok) {
			            throw new Error('Network response was not ok');
			        }
			        return response.json(); // Parse JSON response
			    })
			    .then(data => {
			        alert(data.message || "Product updated in wishlist!");
			        // Toggle icon color based on the current state
			        icon.style.color = isInWishlist ? "white" : "red";
			    })
			    .catch(error => {
			        alert("An error occurred while updating the wishlist: " + error.message);
			    });
			} 

		function toggleWishlist(productId) {
		    const icon = document.getElementById(`wishlist-icon-${productId}`);
		    
		    // Make sure to send a POST request to add the product to the wishlist
		    $.ajax({
		        type: "POST",
		        url: "/wishlist/add",
		        contentType: "application/json",
		        data: JSON.stringify({
		            user: {
		                id: <%=session.getAttribute("userId")%> // Ensure this is valid
		            },
		            product: {
		                productId: productId
		            }
		        }),
		        success: function(response) {
		            alert("Product added to wishlist!");
		            icon.style.color = "red"; // Change icon color to indicate it's in the wishlist
		        },
		        error: function() {
		            alert("An error occurred while adding the product to the wishlist.");
		        }
		    });
	}

</script>

