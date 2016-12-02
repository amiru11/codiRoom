<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>마이 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.bxslider.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/jquery.bxslider.css" rel="stylesheet">
</head>
<script type="text/javascript">

//페이지 시작시 받아온 값에 따라 서브 메뉴 ajax로 보여짐
$(function() {
	var subSelect = $("#subSelect").val();
	//회원 정보
	if(subSelect == 1){
		$.ajax({
			url : "${pageContext.request.contextPath}/member/myPage/showMyinfo",
			type : "post",
			success : function(data){
				data = data.trim();
				$("#subView").html(data);
			}
		});
	}
	//주문내역
	if(subSelect == 2){
		
	}
	//장바구니
	if(subSelect == 3){
			
	}
	//문의 내역
	if(subSelect == 4){
		
	}
});



//회원 정보 수정
$(function() {
	$("#showMyinfo").click(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/member/myPage/showMyinfo",
			type : "post",
			success : function(data){
				data = data.trim();
				$("#subView").html(data);
			}
		});
	});
});




</script>
<body>
	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	
	
	<!-- 서브 메뉴 부분 -->
	<input type="hidden" id="subSelect" value="${subSelect }">
	<div style="margin-top: 100px">
		<a href="">주문 배송</a>
		<a href="">장바구니</a>
		<a href="">문의 내역</a>
		<a href="#" id="showMyinfo">내 정보</a>
	</div>
	
	<!-- 서브 내용 -->
	<div id="subView">
${message }
	</div>	
	
	<br>
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>	
</body>
</html>