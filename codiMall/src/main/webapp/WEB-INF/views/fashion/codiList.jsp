<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.bxslider.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/jquery.bxslider.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/homeslider.css" rel="stylesheet">
<script type="text/javascript">




</script>
</head>
<body>
<%@ include file="/resources/temp/header.jsp"%>

	<!-- 바디 부분 -->
	<h2>코디</h2>
	<h1><a href="" onclick="window.open('${pageContext.request.contextPath}/fashion/codiWrite','codi','width=1000,height=700');return false;">코디 생성</a></h1>
	
	<!-- 코디 리스트 -->
	<c:if test="">
		<div>
		
		
		
		</div>
	</c:if>

<%@ include file="/resources/temp/footer.jsp"%>	
</body>
</html>