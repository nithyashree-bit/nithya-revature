<style>
 footer {
            background-color: #333;
            color: white;
            padding: 10px 0;
            text-align: center;
            position: relative; /* Optional to ensure it doesn’t overlap */
        }
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
</style>

<body>	<div class="container">
		<div class="row">
			<div class="col-lg-3" style = "display: flex; align-items:center">
				<div class="logo">
					<img src="../../assets/images/white-logo.png"
						alt="revshop ecommerce templatemo" style="height: 120px">
				</div>
			</div>

			<div class="col-lg-3">
				<h4>Shopping &amp; Categories</h4>
				<ul>
					<li class="scroll-to-section"><a href="#electronics">Electronics</a></li>
					<li class="scroll-to-section"><a href="#Fashion">Fashions</a></li>
					<li class="scroll-to-section"><a href="#home_appliance">Home
							Appliance</a></li>
				</ul>
			</div>
			<div class="col-lg-3">
				<h4>Useful Links</h4>
				<ul>
					<li><a href="#">Homepage</a></li>
					<li><a href="#">About Us</a></li>
					<li><a href="#">Help</a></li>
					<li><a href="#">Contact Us</a></li>
				</ul>
			</div>
			<div class="col-lg-3">
													            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3886.9482775056085!2d80.24465247507756!3d13.038964287282608!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3a5267b55865f117%3A0xedb11f5553e1c048!2sRevature!5e0!3m2!1sen!2sin!4v1728397346889!5m2!1sen!2sin" width="250" height="250" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>

			</div>
			<div class="col-lg-12">
				<div class="under-footer">
					<p>
						Copyright © 2022 RevShop Co., Ltd. All Rights Reserved. <br>Design:
						<a href="https://templatemo.com" target="_parent"
							title="free css templates">TemplateMo</a> <br>Distributed
						By: <a href="https://themewagon.com" target="_blank"
							title="free & premium responsive templates">ThemeWagon</a>
					</p>
					<ul>
						<li><a href="#"><i class="fa fa-facebook"></i></a></li>
						<li><a href="#"><i class="fa fa-twitter"></i></a></li>
						<li><a href="#"><i class="fa fa-linkedin"></i></a></li>
						<li><a href="#"><i class="fa fa-behance"></i></a></li>
						
					</ul>
					
				</div>
				
			</div>
		</div>
	</div>


    <!-- jQuery -->
    <script src="../../assets/js/jquery-2.1.0.min.js"></script>

    <!-- Bootstrap -->
    <script src="../../assets/js/popper.js"></script>
    <script src="../../assets/js/bootstrap.min.js"></script>

    <!-- Plugins -->
    <script src="../../assets/js/owl-carousel.js"></script>
    <script src="../../assets/js/accordions.js"></script>
    <script src="../../assets/js/datepicker.js"></script>
    <script src="../../assets/js/scrollreveal.min.js"></script>
    <script src="../../assets/js/waypoints.min.js"></script>
    <script src="../../assets/js/jquery.counterup.min.js"></script>
    <script src="../../assets/js/imgfix.min.js"></script> 
    <script src="../../assets/js/slick.js"></script> 
    <script src="../../assets/js/lightbox.js"></script> 
    <script src="../../assets/js/isotope.js"></script> 
    
    <!-- Global Init -->
    <script src="assets/js/custom.js"></script>

    <script>

        $(function() {
            var selectedClass = "";
            $("p").click(function(){
            selectedClass = $(this).attr("data-rel");
            $("#portfolio").fadeTo(50, 0.1);
                $("#portfolio div").not("."+selectedClass).fadeOut();
            setTimeout(function() {
              $("."+selectedClass).fadeIn();
              $("#portfolio").fadeTo(50, 1);
            }, 500);
                
            });
        });

    </script>
</body>