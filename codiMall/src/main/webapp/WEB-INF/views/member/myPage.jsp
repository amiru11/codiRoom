<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>마이 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/member/myPage.css" rel="stylesheet">
</head>
<script type="text/javascript">



//회원 정보 수정
$(function() {
	//alert($("#sub_tit_h4").html());
	$("#showMyinfo").click(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/member/myPage/showMyinfo",
			type : "post",
			success : function(data){
				data = data.trim();
				$("#subView").empty();
				$("#subView").html(data);
				$(".sub_tit_h4").html('내 정보');
				//console.log(data);
			}
		});
	});
	
	$("#buyList").click(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/buy/buyList",
			type : "get",
			success : function(data){
				
				data = data.trim();
				$("#subView").empty();
				$("#subView").html(data);
				$(".sub_tit_h4").html('주문/배송');
			}
		});
	});
	
	$("#myproQnAList").click(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/board/memberBoardList",
			type : "post",
			data : {name : $("#hiddenName").val()},
			success : function(data){
				data = data.trim();
				$("#subView").empty();
				$("#subView").html(data);
				$(".sub_tit_h4").html('상품 문의 내역');
				console.log(data);
			}
		});
	});	
	
	$("#myhomeQnAList").click(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/board/memberBoardList2",
			type : "post",
			data : {name : $("#hiddenName").val()},
			success : function(data){
				data = data.trim();
				$("#subView").empty();
				$("#subView").html(data);
				$(".sub_tit_h4").html('일반 문의 내역');
				console.log(data);
			}
		});
	});	

/* 	if(subMenuV =='showMyinfo'){		
		$("#showMyinfo").css("color","#006633");
		$("#showMyinfo").css("font-weight","bold");
	}else if(subMenuV =='buyList'){
		$("#buyList").css("color","#006633");
		$("#buyList").css("font-weight","bold");
	} */
});

/* 주소지 찾기 */
function openDaumPostcode(){
	new daum.Postcode({
		oncomplete : function(data){
			/* document.getElementById('post1').value=data.postcode; */
			document.getElementById('addr').value=data.address;
			document.getElementById('addr2').focus();
		}
	}).open();
}

function qnaToggle(){
	$(".inList-group").slideToggle();
	if($(".sbox_arrow_down").attr("class")=='sbox_arrow_down'){
		$(".sbox_arrow_down").attr("class","sbox_arrow_up");
	}else{
		$(".sbox_arrow_up").attr("class","sbox_arrow_down");
	}
	//
}
</script>
<body>
	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->
	<input type="hidden" value="${sessionScope.member.name}" id="hiddenName">
	<!-- SUBHEADER:S -->
		<div class="jumbotron" id="subheader">		
			<div class="sub_tit_inner">
				<h4 class="sub_tit_h4">${subMenu}</h4>
				<ul class="smap">
					<li><a href="/codi"><img src="${pageContext.request.contextPath}/resources/images/icon_home_w.png" alt="홈으로"></a></li>
					<li><img class="arrow" src="${pageContext.request.contextPath}/resources/images/icon_arrow_w.png" alt="작은 맵 화살표"></li>
					<li><span class="sub_tit_h4" style="color:white;">${subMenu}</span></li>
				</ul>
			</div>
		</div>
	<!-- SUBHEADER:E -->	
	
	<!-- 서브 메뉴 부분 -->
	<div class="container" style="padding-top: 30px; font-family: 'hanna';">
<%-- 		<nav class="navbar" style="border-bottom: 2px solid #dce2eb;">
			<div class="navbar-collapse collapse">
				<ul id="infoSub-header" class="nav navbar-nav">
						<li style="margin-left: 300px;"><a id="buyList">주문/배송</a></li>
						<li><a>문의 내역</a></li>
						<li><a id="showMyinfo">내 정보</a></li>
						<li><input type="hidden" value="${subMenu}" id="subMenuV"></li>
				</ul>
			</div>
		</nav> --%>
		
		<!-- 서브 내용 -->
		<div class="row">
			<div class="col-sm-12">
					<div id="subView" class="col-sm-8">
						<c:if test="${subMenu == '내 정보'}">
							<c:import url="/member/myPage/showMyinfo"></c:import>
						</c:if>
						${message}
					</div>
					<div class="col-sm-4">
						<nav id="listMenu">
							<ul>
								<li class="infoSub-header"><a id="showMyinfo">내 정보</a></li>
								<li class=""><a id="buyList">주문/배송</a></li>
								<li class="">
									<a id="myQnAList" onclick="qnaToggle();">문의 내역
										<span class="sbox_arrow_down"></span>
									</a>
									<ul class="inList-group" style="display: none;">
										<li><a id="myproQnAList">상품 문의 내역</a></li>
										<li><a id="myhomeQnAList">일반 문의 내역</a></li>
									</ul>
								</li>
							</ul>
						</nav>	
					</div>
			</div>
		</div>
	</div>
		
	
	<br>
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>	
	<!-- Footer:E -->	
</body>
</html>