<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>마이 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/member/myPage.css" rel="stylesheet">
<style type="text/css">
.sub-header > li > a{
    display: block;
    font-size: 14px;
    color: #444444;
    display: block;
    text-align: center;
    width: 100px;
    line-height: 20px;
    margin-left : 50px;
}
.sub-header > li > a:HOVER {
	cursor : pointer;
	color: #006633;
    font-weight: bold;
    background: none;
}
</style>
</head>
<script type="text/javascript">



//회원 정보 수정
$(function() {
	
	$("#showMyinfo").click(function() {
		$.ajax({
			url : "${pageContext.request.contextPath}/member/myPage/showMyinfo",
			type : "post",
			success : function(data){
				data = data.trim();
				$("#subView").empty();
				$("#subView").html(data);
				console.log(data);
			}
		});
	});
	if(${subMenu == 'showMyinfo'}){		
		$("#showMyinfo").css("color","#006633");
		$("#showMyinfo").css("font-weight","bold");
	}
});




</script>
<body>
	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->
	
	<!-- 서브 메뉴 부분 -->
	<div class="container" style="padding-top: 30px; font-family: 'hanna';">
		<nav class="navbar" style="border-bottom: 2px solid #dce2eb;">
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav sub-header">
						<li style="margin-left : 200px;"><a>주문/배송</a></li>
						<li><a>장바구니</a></li>
						<li><a>문의 내역</a></li>
						<li><a id="showMyinfo">내 정보</a></li>
				</ul>
			</div>
		</nav>
		
		<!-- 서브 내용 -->
		<div class="row">
			<div class="col-sm-12">
				<div class="center-block">
					<div id="subView" class="center-block" style="width: 600px;">
						<c:if test="${subMenu == 'showMyinfo'}">
							<c:import url="/member/myPage/showMyinfo"></c:import>
						</c:if>
						${message}
					</div>
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