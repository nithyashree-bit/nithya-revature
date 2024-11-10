<%@ page import="java.util.List"%>
<%@ page import="com.rev.entity.Review"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product Reviews</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<style>
}
.review-item {
	border-bottom: 1px solid;
	padding: 15px 0;
}

.review-item:last-child {
	border-bottom: none;
}

.star-rating {
	color: black;
}

.form-label {
	font-size: 14px;
	font-weight: bold;
}

.btn {
	font-size: 14px;
}

.alert {
	font-size: 12px;
}
</style>
</head>
<body>
	<div class="container">

		<%
		String productIdParam = request.getParameter("productId");
		int productId = productIdParam != null ? Integer.parseInt(productIdParam) : 0;

		Review userReview = (Review) request.getAttribute("userReview");
		Long userId = (Long) session.getAttribute("userId");
		List<Review> reviews = (List<Review>) request.getAttribute("reviews");
		%>

		<script>
            function toggleReviewForm() {
                const formContainer = document.getElementById("reviewFormContainer");
                formContainer.style.display = formContainer.style.display === "none" ? "block" : "none";
            }

            function deleteReview(reviewId) {
                alert('Delete review with ID: ' + reviewId);
            }
        </script>

		<%
		if (userId == null) {
		%>
		<div class="alert alert-warning" role="alert">Please log in to
			submit a review.</div>
		<%
		} else if (userReview != null && userId != null) {
		%>
		<div class="review-item">
			<h5>My Review</h5>
			<div class="star-rating">
				<%
				for (int i = 1; i <= 5; i++) {
					if (i <= userReview.getRating()) {
				%>
				<i class="fas fa-star"></i>
				<%
				} else {
				%>
				<i class="far fa-star"></i>
				<%
				}
				}
				%>
			</div>
			<p><%=userReview.getReviewText()%></p>
			<button type="button" class="btn btn-danger"
				onclick="deleteReview(<%=userReview.getReviewId()%>, <%=productId%>)">
				Delete Review</button>

		</div>
		<%
		} else if (userReview == null) {
		%>
		<div class="text-center mb-4">
			<button class="btn btn-primary" onclick="toggleReviewForm()">Add
				Review</button>
		</div>

		<div id="reviewFormContainer" style="display: none;">
			<h5>Add a Review</h5>
			<form action="/reviews" method="post">
				<input type="hidden" name="productId" value="<%=productId%>">
				<input type="hidden" name="userId" value="<%=userId%>">

				<div class="mb-3">
					<label for="rating" class="form-label">Rating (1-5)</label> <input
						type="number" class="form-control" id="rating" name="rating"
						min="1" max="5" required>
				</div>
				<div class="mb-3">
					<label for="imageUrl" class="form-label"> Upload any
						pictures (Optional)</label> <input type="url" class="form-control"
						id="imageUrl" name="imageUrl" placeholder="Enter image URL">
				</div>


				<div class="mb-3">
					<label for="reviewText" class="form-label">Review</label>
					<textarea class="form-control" id="reviewText" name="reviewText"
						rows="3" required></textarea>
				</div>

				<button type="submit" class="btn btn-success">Submit Review</button>
			</form>
		</div>
		<%
		} else {
		%>
		<div class="alert alert-warning" role="alert">You have already
			submitted a review.</div>
		<%
		}
		%>
		<hr>
		<div>
			<h5>All Reviews</h5>
			<%
			if (reviews != null && !reviews.isEmpty()) {
				for (Review review : reviews) {
			%>
			<div class="review-item">
				<p>
					User: <strong><%=review.getUserName()%></strong>
				</p>
				<div class="star-rating">
					<%
					for (int i = 1; i <= 5; i++) {
						if (i <= review.getRating()) {
					%>
					<i class="fas fa-star"></i>
					<%
					} else {
					%>
					<i class="far fa-star"></i>
					<%
					}
					}
					%>
				</div>
				<%
				if (review.getImageUrl() != null && !review.getImageUrl().isEmpty()) {
				%>
				<img src="<%=review.getImageUrl()%>" alt="Review Image"
					class="img-fluid mb-3" style="max-width: 200px;">
				<%
				}
				%>
				<p><%=review.getReviewText() != null ? review.getReviewText() : "No review text"%></p>
				<small class="text-muted">Added at: <%=review.getCreatedAt()%></small>
				<hr>
			</div>
			<%
			}
			} else {
			%>
			<p>No reviews available for this product.</p>
			<%
			}
			%>
		</div>
	</div>
	<script>
	function deleteReview(reviewId, productId) {
	    if (confirm('Are you sure you want to delete this review?')) {
	        fetch('/reviews/delete', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json',
	            },
	            body: JSON.stringify({ 
	                reviewId: reviewId, 
	                productId: productId 
	            })
	        })
	        .then(response => {
	            if (response.ok) {
	                alert('Review deleted successfully!');
	                location.reload(); // Refresh the page to see the updated review list
	            } else {
	                alert('Error deleting review.');
	            }
	        })
	        .catch(error => {
	            console.error('Error:', error);
	        });
	    }
	}


</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
