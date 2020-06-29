<!--<%
if((String)session.getAttribute("userid")!=null)
	response.sendRedirect(request.getContextPath()+"/latest/article");
%>-->
<!DOCTYPE html>
<html>
	<head>
		<title>Agrivio | The Smart Farming App </title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.svg">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lib/spinner.css">
		<script src="${pageContext.request.contextPath}/assets/js/lib/spinner.js" ></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/index/index.css">
		<script src="${pageContext.request.contextPath}/assets/js/index/index.js" charset="utf-8"></script>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lib/text-underline-transition.css">
	</head>

<body>
	<div class="spinner">
    <div class="spinner-container">
      <svg height="300" >
        <ellipse id="circle1" cx="150" cy="150" r="0" stroke="snow" fill="none" />
        <ellipse id="circle2" cx="150" cy="150" r="0" stroke="snow" fill="none" />
        <ellipse id="circle3" cx="150" cy="150" r="0" stroke="snow" fill="none" />
        <ellipse id="circle4" cx="150" cy="150" r="0" stroke="snow" fill="none" />
      </svg>
    </div>
  </div>
	<div class="bgimagediv-1">
		<div class="top-nav">
			<div class="signup-option">
				<a href="${pageContext.request.contextPath}/signup"><span class="underline-transition">Signup</span> </a>
			</div>
			<div class="signin-option">
				<a href="${pageContext.request.contextPath}/login"><span class="underline-transition">Login</span> </a>
			</div>
		</div>
 		<div class="caption">
 			<div class="logo">
 				<img src="${pageContext.request.contextPath}/assets/img/agrivio-2.png" alt="agrivio">
 			</div>
			<div class="quote">It's The Smart Farming You Can See</div>
			<div class="get-started">
				<a href="${pageContext.request.contextPath}/latest/article">
					Get Started
				</a>
			</div>
 		</div>

	</div>
	<div class="intro">
 		<h2>Always inspring the innovation</h2>
		<span>Our team is always looking for the upliftment of our service enabling scientific approach of cultivation in India through mobile, tablet and desktop using state-of-the-art technologies.</span>
	</div>
	<div class="">
		<div class="slide-show">
	    <div class="slide">
	      <img src="https://agrivio-assets.s3.amazonaws.com/index/tractor.jpg" alt="">
	    </div>
	    <div class="slide">
	      <img src="https://agrivio-assets.s3.amazonaws.com/index/vegetables.jpg" alt="">
	    </div>
	    <div class="slide">
	      <img src="https://agrivio-assets.s3.amazonaws.com/index/harvestor.jpg" alt="">
	    </div>
	    <button type="button" name="prev">&#10094;</button>
	    <button type="button" name="next" >&#10095;</button>
	    <div class="dots">
	      <button class="dot" ></button>
	      <button class="dot"></button>
	      <button class="dot" ></button>
	    </div>
	  </div>
	</div>
	<div class="services" >
		<h2>Services</h2>
		<div class="row">
			<div class="col-6 col-sm-6 col-xs-12">
				<div class="service">
					<img src="https://agrivio-assets.s3.amazonaws.com/index/article-icon.png" alt="" height="130px">
					<h3>Guides</h3>
					<span>Detailed guide articles on cultivation of different crops and related issues.</span>
				</div>
			</div>
			<div class="col-6 col-sm-6 col-xs-12">
				<div class="service">
					<img src="https://agrivio-assets.s3.amazonaws.com/index/expert-icon.png" alt="" height="130px">
					<h3>Ask Expert</h3>
					<span>Consultaion from highly qualified experts about any query related to cultivation.</span>
				</div>
			</div>
		</div>
		<div class="row">
			<div class=" col-6 col-sm-6 col-xs-12" >
				<div class="service">
					<img src="https://agrivio-assets.s3.amazonaws.com/index/notification-icon.png" alt="" height="130px">
					<h3>Real Time Alert </h3>
					<span>Notification alert for each cultivation event and remainder.  </span>
				</div>
			</div>
			<div class="col-6 col-sm-6 col-xs-12">
				<div class="service">
					<img src="https://agrivio-assets.s3.amazonaws.com/index/price-icon.png" alt="" height="130px">
					<h3>Crop Price</h3>
					<span>Latest price of crops at different kishan mandi across India from official government data source.</span>
				</div>
			</div>
		</div>
		<div class="row">
			<div class=" col-6 col-sm-6 col-xs-12">
				<div class="service">
					<img src="https://agrivio-assets.s3.amazonaws.com/index/crop-icon.png" alt="" height="140px">
					<h3>Crop Recommendation</h3>
					<span>Exclusive Crop Recommendation based on Soil data of your location collected using SoilGrid API</span>
				</div>
			</div>
			<div class="col-6 col-sm-6 col-xs-12">
				<div class="service">
					<img src="https://agrivio-assets.s3.amazonaws.com/index/bug-icon.png" alt=""  height="140px">
					<h3>Pest Control</h3>
					<span>Tutorial article on identification of pests and how to prevent them</span>
				</div>
			</div>
		</div>
	</div>

	<div class="footer">
		<div class="logo">
			<img src="${pageContext.request.contextPath}/assets/img/agrivio-2.png" alt="agrivio">
		</div>
		<div class="contact-details">
			<div class="location">
				Kolkata, India
			</div>
			<div class="">
				&#9990; 033 4582 4751
			</div>
			<div class="">
				&#9993; xyz@example.com
			</div>
		</div>
		<div class="copyright">
			<hr>
			&copy; 2020 <span class="website-name">agrivio</span>. All rights reserved.
		</div>
	</div>
</body>

</html>
