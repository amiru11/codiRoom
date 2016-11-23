<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<title>Home</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.bxslider.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/jquery.bxslider.css" rel="stylesheet">
<script type="text/javascript">
	$(function(){
	 	var message = "${message}";
		
		if(message != ''){
			alert(message);
		} 
		
		/* 첫번째 슬라이드 */
		$('.bxslider').bxSlider({
			  mode : 'fade',
			  auto : true,
			  captions: true 
		});
		
		/* 두번째 슬라이드 */
		$('.slider3').bxSlider({
		    slideWidth: 1000,
		    minSlides: 3,
		    maxSlides: 3,
		    slideMargin: 50,
		    auto : true,
		    pager : false
		});
	});
</script>
<style type="text/css">

/* 1번째 슬라이드 이미지 */
#bxslider1 img {
   height: 390px;
}

/* 2번째 슬라이드 이미지 */
.slide img{
	height : 300px;
}
</style>
</head>
<body class="home">

	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->
	<div class="container">

		<div class="slider">
			<ul class="bxslider" id="bxslider1">
			  <li><img src="${pageContext.request.contextPath}/resources/images/picto.png" title="Funky roots"></li>
			  <li><img src="${pageContext.request.contextPath}/resources/images/hillside.jpg" title="The long and winding road"></li>
			  <li><img src="${pageContext.request.contextPath}/resources/images/houses.jpg" title="Happy trees"></li>
			</ul>
		</div>
		<!-- Container (Portfolio Section) -->
		<div id="portfolio" class="text-center bg-grey">
		  <div class="row text-center">
		    <div class="col-lg-4">
		        <img src="${pageContext.request.contextPath}/resources/images/mdpick.jpg" alt="Paris" style="width: 100%; height: 240px;">
		    </div>
		    <div class="col-lg-4">
		        <img src="${pageContext.request.contextPath}/resources/images/saleItem.jpg" alt="New York" style="width: 100%; height: 240px;">
		    </div>
		    <div class="col-lg-4">
		        <img src="${pageContext.request.contextPath}/resources/images/covernat.jpg" alt="San Francisco" style="width: 100%; height: 240px;">
		    </div>
		  </div><br>
		 </div>
		  <p>BEST CODI</p>	
		<div class="slider3">
		  <div class="slide"><img src="http://placehold.it/500x150&text=FooBar1"></div>
		  <div class="slide"><img src="http://placehold.it/500x150&text=FooBar2"></div>
		  <div class="slide"><img src="http://placehold.it/500x150&text=FooBar3"></div>
		  <div class="slide"><img src="http://placehold.it/500x150&text=FooBar4"></div>
		  <div class="slide"><img src="http://placehold.it/500x150&text=FooBar5"></div>
		  <div class="slide"><img src="http://placehold.it/500x150&text=FooBar6"></div>
		  <div class="slide"><img src="http://placehold.it/500x150&text=FooBar7"></div>
		  <div class="slide"><img src="http://placehold.it/500x150&text=FooBar8"></div>
		  <div class="slide"><img src="http://placehold.it/500x150&text=FooBar9"></div>
		  <div class="slide"><img src="http://placehold.it/500x150&text=FooBar10"></div>
		</div>
		
	</div>
	<br>
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>	
	<!-- Footer:E -->
</body>
</html>
