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
<link href="${pageContext.request.contextPath}/resources/css/homeslider.css" rel="stylesheet">
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
			  pager : true
			  /* captions: true  */
		});
		
		/* 두번째 슬라이드 */
		$('.slider3').bxSlider({
		    slideWidth: 1000,
		    minSlides: 3,
		    maxSlides: 3,
		    slideMargin: 40,
		    auto : false,
		    pager : false
		});
	});
</script>
<style type="text/css">
.slider{
	width:100%;
}
/* 1번째 슬라이드 이미지 */
#bxslider1 img {
   height: 390px;
}

/* 2번째 슬라이드 이미지 */
.slide img{
	width : 100%;
	height : 300px;
}

#portImg ul li {
	padding: 0;
    width: 33%;
    position: relative;
    cursor : pointer;
}
.port-li1, .port-li4{
	width : 33%;
}
.port-li2, .port-li3{
	width : 67%;
}
#portImg ul li img:HOVER {
	cursor : pointer;
    background: #353940;
    color: white;
    -moz-box-shadow: 0 15px 30px rgba(53, 57, 64, 0.5);
    -webkit-box-shadow: 0 15px 30px rgba(53, 57, 64, 0.5);
    box-shadow: 0 15px 30px rgba(53, 57, 64, 0.5);
}
.codi-item{
	cursor : pointer;
	
}
.codi-item:HOVER {
	background: #a6a6a6;
}
</style>
</head>
<body class="home">

	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->
	<section id="firstWrap">
		<div id="homepage-slider" class="slider">
			<ul class="bxslider" id="bxslider1">
			  <li><img src="${pageContext.request.contextPath}/resources/images/main/20161101daylife.jpg" title="Funky roots"></li>
			  <li><img src="${pageContext.request.contextPath}/resources/images/main/20161102wissy.jpg" title="The long and winding road"></li>
			  <li><img src="${pageContext.request.contextPath}/resources/images/main/20161125getitman.jpeg" title="Happy trees"></li>
			</ul>
		</div>
	</section>	
		<!-- Container (Portfolio Section) -->
		<section id="secondWrap" class="container">
		<div id="portfolio" class="row">
		  <div class="col-lg-12" id="portImg">
		    <ul class="row">
		    	<li class="col-xs-4 port-li1">
		    		<img src="${pageContext.request.contextPath}/resources/images/main/mdpick.jpg" width=384 height=394>
		    	</li>
		    	<li class="col-xs-4 port-li2">
		    		<img src="${pageContext.request.contextPath}/resources/images/main/saleItem.jpg" width=784 height=394>
		    	</li>
		    	<li class="col-xs-4 port-li3" style="clear: left;">
		    		<img src="${pageContext.request.contextPath}/resources/images/main/covernat.jpg" width=784 height=394>	
		    	</li>
		    	<li class="col-xs-4 port-li4" style="padding-left:400px;">
		    		<img src="${pageContext.request.contextPath}/resources/images/main/20161125lostgarden.jpg"  width=384 height=394>	
		    	</li>
		    </ul>
		  </div><br>
		 </div>
		</section>
		
		<!-- BEST CODI :S --> 
		<section class="container" style="padding-top : 50px;">
			<div class="row">
				<div class="text-center">
				    <p style="font-size: 18px; font-weight: 800;">BEST CODI</p>
				    <p style="font-size: 12px; color : #a6a6a6; font-weight: 700;">현재 가장인기 있는 코디를 만나보세요</p>	
				</div>
				<div class="slider3">
				  <div class="slide codi-item">
				  	<table class="table table-bordered" style="margin-bottom: 0;">
				  		<tr>
				  			<td style="padding:0;"><img src="http://placehold.it/500x150&text=FooBar1"></td>
				  		</tr>
				  		<tr>
				  			<td style="padding:0;">회원정보</td>
				  		</tr>
				  	</table>
				  </div>
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
		</section>
		<!-- BEST CODI :E -->
		
		<div class="row">
			<div class="col-lg-4" STYLE=""></div>
			<div class="col-lg-4"></div>
			<div class="col-lg-4"></div>
		</div>
	<br>
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>	
	<!-- Footer:E -->
</body>
</html>
