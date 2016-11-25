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
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
 	var message = "${message}";
	if(message != ''){
		alert(message);
	}
	$(function(){
		$("#wrBtn").click(function(){
			location.href="${pageContext.request.contextPath}/board/boardWrite?board_kind=${board_kind}";
		});
		
		if(${boardName eq 'NOTICE'}){
			$(".noticeTab").css("color","black");
			$(".noticeTab").css("font-weight","800");
		}else if(${boardName eq 'FAQ'}){
			$(".faqTab").css("color","black");
			$(".faqTab").css("font-weight","800");
		}
		
		
	}); 
</script>
<style>
.center-block {
	margin-left: 40%;
}

#subheader{
	background : url("${pageContext.request.contextPath}/resources/images/subMenu_back.jpg");
}
.sub-title{
	color : white;
	font-size: 40px;
	text-decoration: none;
}
.sub-title:HOVER {
	color: black;
	text-decoration: none;
	font-weight: 800;
}
</style>
</head>
<body>

	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->
	
	<!-- SUBHEADER:S -->
		<div class="jumbotron text-center" id="subheader">		
			<h2></h2>
			<a href="#" class="sub-title noticeTab">NOTICE</a>
			<a href="#" class="sub-title faqTab" style="margin-left: 100px;">FAQ</a>
			<a href="#" class="sub-title qnaTab" style="margin-left: 100px;">Q&A</a>
		</div>
	<!-- SUBHEADER:E -->
	
	<div class="container">
	
		
		<nav class="nav nav-default">
			<!-- <div class="jumbotron"> -->
			
			<form action="findList" method="post" role="search" class="navbar-form navbar-right">
				
				
						<select name="type" class="form-control">
							<option value="title">TITLE</option>
							<option value="writer">WRITER</option>
							<option value="contents">CONTENTS</option>
						</select>
				
				    <div class="input-group">
				      <input type="text" class="form-control" placeholder="Search for...">
				      <span class="input-group-btn">
				        <a class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></a>
				      </span>
				    </div>
				
			</form>
			<!-- </div> -->
		</nav>
		
<%-- 		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading">${boardName}</div>
		</div> --%>
		<table class="table">
				<thead>
					<tr>
						<th>#</th>
						<th>TITLE</th>
						<th>WRITER</th>
						<th>DATE</th>
						<th>VIEW</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="list">
						<tr>
							<td>${list.board_num}</td>
							<td><c:forEach begin="1" end="${list.board_depth}">
						&nbsp;&nbsp;&nbsp;&nbsp;
				</c:forEach> <a
								href="${pageContext.request.contextPath}/board/boardView?board_num=${list.board_num}&board_kind=${list.board_kind}">${list.board_title}</a>
							</td>
							<td>${list.board_writer}</td>
							<td>${list.board_date}</td>
							<td>${list.board_counts}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		<div class="center-block">
			<!-- PAGINATIOIN:S -->
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><a href="#" aria-label="Previous"> <span
							aria-hidden="true">&laquo;</span>
					</a></li>
					<li><c:if test="${paging.curBlock > 1}">
							<a class="N_pageing"
								href="boardList?curPage=${paging.startNum-1}&perPage=10&board=${board}&type=${type}&find=${find}">&laquo;</a>
						</c:if></li>
					<li><c:forEach begin="${paging.startNum}" step="1"
							end="${paging.lastNum}" var="i">
							<a class="N_pageing"
								href="boardList?curPage=${i}&perPage=10&board=${board}&type=${type}&find=${find}">${i}</a>

						</c:forEach></li>
					<li><c:if test="${paging.curBlock < paging.totalBlock}">
							<a class="N_pageing"
								href="boardList?curPage=${paging.lastNum+1}&perPage=10&board=${board}&type=${type}&find=${find}">&raquo;</a>
						</c:if></li>
					<li><a href="#" aria-label="Next"> <span
							aria-hidden="true">&raquo;</span>
					</a></li>
				</ul>
			</nav>
			<!-- PAGINATIOIN:E -->
		</div>
		<div class="col-md-4">
			<input type="button" value="글쓰기" id="wrBtn" class="btn btn-info">
		</div>
	</div>
	
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>	
	<!-- Footer:E -->
	
</body>
</html>