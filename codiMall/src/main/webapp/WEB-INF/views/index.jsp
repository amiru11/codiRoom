<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<title>Home</title>
<link rel="stylesheet"
	href="http://fonts.googleapis.com/earlyaccess/hanna.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.bxslider.js"></script>
<%-- <script
	src="${pageContext.request.contextPath}/resources/js/footer.js"></script> --%>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/jquery.bxslider.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/homeslider.css"
	rel="stylesheet">
<script type="text/javascript">
	
	$(function() { 
		bestCodiList();
		/* 첫번째 슬라이드 */
		$('.bxslider').bxSlider({
			mode : 'fade',
			auto : true,
			pager : true, /* 동그라미 페이지넘기기 */
			/* captions: true  */
			controls : false /* 슬라이드 좌,우 화살표  */
		});

		/* 두번째 슬라이드 */
		$('.slider3').bxSlider({
			//slideWidth : 1000,
			minSlides : 3,
			maxSlides : 3,
			slideMargin : 40,
			auto : false,
			pager : false
		});
		
		/* 세번째 슬라이드 */
 		$('.slider4').bxSlider({
			//slideWidth : 1000,
			minSlides : 4,
			maxSlides : 4,
			slideMargin : 20,
			auto : false,
			pager : false
		});
	var myWindow = window.outerWidth;
	
		/* 네번째 슬라이드 */
	if (myWindow > 960) {
		
					$('.footer_awards_slider').bxSlider({
						minSlides:4,
						maxSlides:6,
						slideWidth:189,
						slideMargin:0,
						controls:false,
						auto:true,
						autoControls:true,
						autoControlsCombine:true,
						pause:2000
					});
		
				} else if ((myWindow > 640) && (myWindow <= 960)) {
					$('.footer_awards_slider').bxSlider({
						minSlides:3,
						maxSlides:3,
						slideWidth:210,
						slideMargin:0,
						controls:false,
						auto:true,
						autoControls:true,
						autoControlsCombine:true,
						pause:2000,
						pagerSelector:'.footer_slider_pagers',
						autoControlsSelector:'.footer_slider_controls'
					});
				} else if (myWindow <= 640) {
					$('.footer_awards_slider').bxSlider({
						minSlides:1,
						maxSlides:1,
						slideWidth:300,
						slideMargin:0,
						controls:false,
						auto:true,
						autoControls:true,
						autoControlsCombine:true,
						pause:2000,
						pagerSelector:'.footer_slider_pagers',
						autoControlsSelector:'.footer_slider_controls'
					});	
				}
		//sale의 화살표 클릭시
		$(".arrows").click(function() {
			var paging = $(this).attr("name"); //화살표클릭시 paging으로 사용할 값을 name태그에 넣어 놨습니다. 저는 각각 뒤로가기는 a, 앞으로가기는 b 
			alert("before paging : " + paging); //paging을 찍어봅니다.
			if (paging == 'a') { //paging 함수가 a라면
				paging = -1; //-1을 넣어줍니다
			} else if (paging == 'b') { //paging 함수가 b라면
				paging = 1; //1을 넣어줍니다
			}
			alert("after paging : " + paging); //바뀐 paging을 찍어봅니다.
			sale_curPage += paging ; //전역변수로 선언한 sale_curPage에 paging을 더해줍니다. 저는 default값으로 1을 주었습니다.
			alert("before sale_curPage : " + sale_curPage); //sale_curPage를 찍어봅니다.
			if (sale_curPage <= 0) { //sale_curPage가 0보다작거나 같으면 (1page에서 맨뒤의 page로 이동)
				sale_curPage = 2 ; //지금 맥스 페이지가 2이기에 2로 설정했습니다.
			} else if (sale_curPage > 2) { //반대의 경우에는
				sale_curPage = 1 ; //첫페이지를 보여줍니다.
			}
			alert("after sale_curPage : " + sale_curPage); //바뀐 sale_curPage를 찍어봅니다.
			showSaleItem(sale_curPage); //click시 showSaleItem함수 실행
		});

	});

/* 	function showSaleItem(sale_curPage) {
		$.ajax({
			url : '/codi/board/bestList', //지금은 일단 겟방식으로 ajax를 실행합니다
			type : 'GET',
			datatype : 'json',
			data : {
				curPage : sale_curPage,
				perPage : 3
			},
			success : function(data) {
				//var result = JSON.parse(data);
				//alert("json object의 갯수 : " + data.length);//JACSON일 때는 length가 먹힌다
				 alert(data[0].board_num);
				            console.log(data[1].board_num) ; 
				var r = '';
				$("#saleItem").empty() ;
				$(data).each(function() {
					r = r + "<p># : " + this.board_num + "</p>";
					r = r + "<p>TITLE : " + this.board_title + "</p>";
					r = r + "<p>WRITER : " + this.board_writer + "</p>";
					r = r + "<p>CATEGORY : " + this.board_category + "</p>";
					$("#saleItem").html(r);

				});
			},
		 		        error:function(request,status,error){
				        	console.error("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				       	}
		}); 
	}*/
	function bestCodiList() {
		$.ajax({
			url : '/codi/fashion/bestCodiList', //지금은 일단 겟방식으로 ajax를 실행합니다
			type : 'GET',
			data : {},
			success : function(data) {
				$(".slider3").empty() ;
				$(".slider3").html(data);
				
			},
		    error:function(request,status,error){
				        	console.error("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				       	} 
		});
	}
</script>
<style type="text/css">
.slider {
	width: 100%;
}
/* 1번째 슬라이드 이미지 */
#bxslider1 img {
	height: 390px;
}

/* 2번째 슬라이드 이미지 */
.slide img {
	width: 100%;
	height: 300px;
}

#portImg ul li {
	padding: 0;
	width: 33%;
	position: relative;
	cursor: pointer;
}

.port-li1, .port-li4 {
	width: 33%;
}

.port-li2, .port-li3 {
	width: 67%;
}

#portImg ul li img:HOVER {
	cursor: pointer;
	background: #353940;
	color: white;
	-moz-box-shadow: 0 15px 30px rgba(53, 57, 64, 0.5);
	-webkit-box-shadow: 0 15px 30px rgba(53, 57, 64, 0.5);
	box-shadow: 0 15px 30px rgba(53, 57, 64, 0.5);
}

.codi-item:HOVER {
	-moz-box-shadow: 0 15px 30px rgba(53, 57, 64, 0.5);
	-webkit-box-shadow: 0 15px 30px rgba(53, 57, 64, 0.5);
	box-shadow: 0 15px 30px rgba(53, 57, 64, 0.5);
}
</style>
</head>
<body class="home" style="font-family: 'hanna';">

	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->
	<section id="firstWrap" class="container" style="padding-top:50px;">
		<div id="homepage-slider" class="slider">
			<ul class="bxslider" id="bxslider1">
				<li><img
					src="${pageContext.request.contextPath}/resources/images/main/20161101daylife.jpg"
					title=""></li>
				<li><img
					src="${pageContext.request.contextPath}/resources/images/main/20161102wissy.jpg"
					title=""></li>
				<li><img
					src="${pageContext.request.contextPath}/resources/images/main/20161125getitman.jpeg"
					title=""></li>
				<li><img
					src="${pageContext.request.contextPath}/resources/images/main/20161201secondmove.jpg"
					title=""></li>
			</ul>
		</div>
	</section>
	<!-- Container (Portfolio Section) -->
	<section id="secondWrap" class="container">
			<div id="portImg">
				<ul>
					<li class="col-xs-4 port-li1"><img
						src="${pageContext.request.contextPath}/resources/images/main/mdpick.jpg"
						width=380 height=394></li>
					<li class="col-xs-4 port-li2"><img
						src="${pageContext.request.contextPath}/resources/images/main/saleItem.jpg"
						width=760 height=394></li>
					<li class="col-xs-4 port-li3" style="clear: left; margin-top:-3px;"><img
						src="${pageContext.request.contextPath}/resources/images/main/covernat.jpg"
						width=760 height=394></li>
					<li class="col-xs-4 port-li4" style="padding-left: 380px; margin-top:-3px;"><img
						src="${pageContext.request.contextPath}/resources/images/main/20161125lostgarden.jpg"
						width=380 height=394></li>
				</ul>
			</div>
			<br>
	</section>

	<!-- BEST CODI :S -->
	<section class="container" style="padding-top: 50px;">
		<div class="row">
			<div class="text-center">
				<p style="font-size: 18px; font-weight: 800;">BEST CODI</p>
				<p style="font-size: 12px; color: #a6a6a6; font-weight: 700;">현재
					가장인기 있는 코디를 만나보세요</p>
			</div>
				<div class="slider3">
					
				</div>
		</div>
	</section>
	<!-- BEST CODI :E -->

	<!-- BEST ITEM :S -->
	<section class="container" style="padding-top: 50px;">
		<div class="row">
			<div class="text-center">
				<p style="font-size: 18px; font-weight: 800;">BEST ITEM</p>
				<p style="font-size: 12px; color: #a6a6a6; font-weight: 700;">현재
					가장 인기있는 상품을 만나보세요</p>
			</div>
			<div class="slider4">
				<c:forEach items="${list}" var="list1" begin="0" end="3">
					<div class="slide codi-item"style="display:inline-block; width:290px;">
						<table class="table table-bordered" style="margin-bottom: 0;">
							<tr>
								<td style="padding: 0;"><a
									href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">
										<img alt=""
										src="${pageContext.request.contextPath}/resources/testPic/${list1.productPic_pic}"
										width="200" height="200">
								</a></td>
							</tr>
							<tr>
								<td style="padding: 0; padding-left: 10px;">
									<p style="padding-top: 10px;">
										<a
											href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">상품명
											: ${list1.product_name}</a>
									</p>
									<p>브랜드 : ${list1.productInfo_brand }</p> <span>가격 : <c:set
											var="number"
											value="${list1.productInfo_price*(100-list1.productInfo_saleRate)/100}" />
										<fmt:parseNumber var="total" value="${number}" type="number"
											integerOnly="true" /> <fmt:formatNumber value="${total}"
											pattern="#,###" />원
								</span>
								</td>
							</tr>
						</table>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>
	<!-- BEST ITEM :E -->

	<br>
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>
	<!-- Footer:E -->

</body>
</html>
