<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<link rel="stylesheet" href="http://fonts.googleapis.com/earlyaccess/jejugothic.css">
<link
	href="${pageContext.request.contextPath}/resources/css/jquery.bxslider.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/homeslider.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath}/resources/js/jquery.bxslider.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/footer.js"></script>		
<script>
var myWindow = window.outerWidth;

$(function(){
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
});

</script>
<style>
.footer-ul > li > a{
	text-decoration: none;
	color : #fff;
}
</style>
<div class="container-fluid" style="padding : 0;">
	<div id="footer" style="height: 300px; font-family: 'nbg', '맑은 고딕', HelveticaNeue, DroidSans, Sans-serif, Helvetica;">
		<div style="margin-top: 50px; padding-top: 30px;">
			<ul class="list-inline footer-ul">
				<li style="margin-left: 400px;">
					<a href="" target="_blank" class="link">MAPSSI 소개</a>
				</li>
				<li>
					<a href="" target="_blank" class="link">개인 정보 수집 및 이용</a>
				</li>
				<li>
					<a href="" target="_blank" class="link">사업제휴</a>
				</li>
				<li>
					<a href="" target="_blank" class="link">채용 정보</a>
				</li>
	
				<li class="btn" style="margin-left: 200px;"> 
					<a href="#">
						<span class="glyphicon glyphicon-chevron-up"></span>TOP 
					</a>
				</li>	
			</ul>
			
		</div>
		<div style="font-size:11px; margin-left: 400px;" >
			<ul class="list-inline" style="color: #999;line-height:1.5em;">
				<li>
					<b>고객센터</b><br>
					(03909) 서울특별시 마포구 매봉산로 37 DMC 산학협력연구센터 7층<br>
					Tel : (010) 5959 - 0228 <span>E-mail : mapssi.com@gmail.com</span><br>
					사업자등록번호 : 204-86-53909 
					<a href="http://www.ftc.go.kr/info/bizinfo/communicationView.jsp?apv_perm_no=2015323023130200589&amp;area1=&amp;area2=&amp;currpage=1&amp;searchKey=04&amp;searchVal=2048653909&amp;stdate=&amp;enddate=" target="_blank" style="margin-left:15px;">
						<span style="color: #999;">사업자정보확인&gt;</span>
					</a>

				</li>
				<li>
					<b>주식회사 맵씨닷컴</b><br>
					대표 : 장윤필<br>
					(05840) 서울시 송파구 충민로 10 가든파이브 툴관 5층 222호
					<br>
					통신판매업신고 : 2015-서울송파-0591
				</li>
			</ul>
		</div>
		<div class="footer_awards_wrap" style="margin-top: 20px;">
			<div class="footer_awards_wrap_inner">
				
			</div>
		</div>	
		<ul class="list-inline text-center" style="font-size: 14px; color:#fff; margin-bottom: 10px; margin-top: 10px;">
				<li> 
					<strong style="color: #999;">
						© 2015 All right reserved. mapssi
					</strong>
				</li>
		</ul>	
	</div>
</div>	