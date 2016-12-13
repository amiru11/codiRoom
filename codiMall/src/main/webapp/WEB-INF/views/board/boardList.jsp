<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${boardName}</title>
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/board/board_list.css" rel="stylesheet">	
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		
		$("#wrBtn").click(function(){
			location.href="${pageContext.request.contextPath}/board/boardWrite?board_kind=${board_kind}";
		});
		
		if(${board_kind eq 1}){
			$(".noticeTab").css("color","#f8f8f8");
			$(".noticeTab").css("font-weight","800");
		}else if(${board_kind eq 2}){
			$(".faqTab").css("color","#f8f8f8");
			$(".faqTab").css("font-weight","800");
		}else if(${board_kind eq 3}){
			$(".qnaTab").css("color","#f8f8f8");
			$(".qnaTab").css("font-weight","800");
		}
		
		$(".faqTop").click(function(){
			$(this).next("tr").toggle();
		});
		
	}); 
</script>
</head>
<body>

	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->
	
	<!-- SUBHEADER:S -->
		<div class="jumbotron" id="subheader">		
			<div class="sub_tit_inner">
				<h4>${boardName}</h4>
				<ul class="smap">
					<li><a href="/"><img src="${pageContext.request.contextPath}/resources/images/icon_home_w.png" alt="홈으로"></a></li>
					<li><img class="arrow" src="${pageContext.request.contextPath}/resources/images/icon_arrow_w.png" alt="작은 맵 화살표"></li>
					<li><a href="${pageContext.request.contextPath}/board/findList?board_kind=${board_kind}"><span>${boardName}</span></a></li>
				</ul>
			</div>
		</div>
	<!-- SUBHEADER:E -->
	
	<c:if test="${board_kind eq 1}">
	
	<!-- NOTICE SECTION:S -->
	<%@ include file="/resources/temp/boardList/noticeList.jspf"%>
	<!-- NOTICE SECTION:E -->
	</c:if>
	
	<c:if test="${board_kind eq 2}">
	<!-- FAQ SECTION:S -->
	<%@ include file="/resources/temp/boardList/faqList.jspf"%>
	<!-- FAQ SECTION:E -->
	</c:if>
	
	<c:if test="${board_kind eq 3}">
	<!-- QNA SECTION:S -->
	<%@ include file="/resources/temp/boardList/qnaList.jspf"%>
	<!-- QNA SECTION:E -->
	</c:if>
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>	
	<!-- Footer:E -->
	
</body>
</html>