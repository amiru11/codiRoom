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
<style>
.center-block {
	margin-left: 50%;
}

#subheader{
	background : url(${pageContext.request.contextPath}/resources/images/subMenu_bg.png);
	height: 178px;
}
.sub-title{
	color : white;
	font-size: 40px;
	text-decoration: none;
}
.sub-title:HOVER {
	color: #f8f8f8;
	text-decoration: none;
	font-weight: 800;
}

#searchHeader{
	background : url(${pageContext.request.contextPath}/resources/images/main_search_bg.png);
	border-radius: 3px;
    height: 290px;
    width: 100%;
}
.search_input {
    height: 45px;
    left: 161px;
    position: absolute;
    top: 161px;
    width: 520px;
}
.search_input input {
    border: none;
    color: #666;
    float: left;
    font-size: 14px;
    height: 40px;
    line-height: 40px;
    margin: 3px 0 0 30px;
    width: 416px;
}
.search_input a {
    background: url(${pageContext.request.contextPath}/resources/images/btn_search.png);
    margin-left : 20px;
    float: right;
    display: block;
    height: 45px;
    overflow: hidden;
    text-indent: -20000px;
    width: 45px;
}
.search_txt{
	left: 0;
    position: absolute;
    top: 54px;
    width: 830px;
}

.search_txt > strong{
	font-size: 22px;
    line-height: 30px;
}

.search_txt > p{
	font-size: 14px;
    line-height: 20px;
}
#listMenu{
	float: right;
    font-weight: bold;
    width: 220px;
    margin-bottom: 90px;
}
#listMenu > ul{
	border-top : 2px solid #222;
}
#listMenu > ul > li{
	border-bottom: 1px solid #ddd;
    width: 220px;
}
#listMenu > ul > li > a {
    color: #444;
    display: block;
    font-size: 14px;
    padding: 20px 30px 20px 15px;
    position: relative;
    width: 175px;
    text-decoration: none;
}
#listMenu > ul > li > a:HOVER{
	color: #006633;
}

#searchTable{
	margin-top : 50px;
}
.inner-searchL{
	float : left; 
	width : 60%;
	padding: 10px;
	border-right: 1px solid #ccc;
}
.inner-searchL strong{
	font-size: 22px;
    line-height: 30px;
}
.inner-searchL p{
	font-size: 16px;
    line-height: 20px;
}
.inner-searchL > ul > li > span {
	border-right: 1px solid #ccc;
    color: #666;
    padding-right: 7px;
    font-size: 18px;
    font-weight : bold;
    line-height: 30px;
}
.inner-searchL > ul > li > a {
	color: #666;
    margin-left: 7px;
    text-indent: 0;
    font-size: 18px;
    line-height: 30px;
}
.inner-searchR{
	float : right; 
	width:40%;
	padding: 10px;
}
.inner-searchR strong{
	font-size: 22px;
    line-height: 30px;
}
.inner-searchR > select{
	margin-top : 70px;	
}
#faq_wrap{
	border-top: 1px solid #222;
    border-bottom: 1px solid #222;
}
#faqList{
	margin : 0;
}
#faqList > tbody > tr > td{
	padding : 20px;
	font-size: 18px;
}
.faqTop{
	cursor: pointer;
}
.faq_Q{
	float: left;
    width: 23px;
    font-size: 18px;
    color: #006633;
    position: relative;
}
.faqTitle{
	float: left;
	font-size: 18px;
	padding-left : 20px;
    width: 600px;
    color: #006633;
}
.faq_A{
	float: left;
    width: 23px;
    font-size: 18px;
    color: #333;
    position: relative;
}
.faqCont{
	float: left;
	font-size: 18px;
	padding-left : 20px;
    width: 600px;
    color: #333;
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
			<a href="${pageContext.request.contextPath}/board/findList?board_kind=1" class="sub-title noticeTab">NOTICE</a>
			<a href="${pageContext.request.contextPath}/board/findList?board_kind=2" class="sub-title faqTab" style="margin-left: 100px;">FAQ</a>
			<a href="#" class="sub-title qnaTab" style="margin-left: 100px;">Q&A</a>
		</div>
	<!-- SUBHEADER:E -->
	
	<c:if test="${board_kind eq 1}">
	
	<!-- NOTICE SECTION:S -->
	<div class="container">
		<div class="row">
			<div class="col-md-8">			
				<nav class="nav nav-default">
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
				</nav>
				<!-- NOTICE LIST -->
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
				<!-- PAGINATIOIN:S -->
				<div class="center-block">
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
				</div>
				<!-- PAGINATIOIN:E -->
				<div class="col-md-4">
					<input type="button" value="글쓰기" id="wrBtn" class="btn btn-info">
				</div>
			</div>
			<div class="col-md-4">
				<nav id="listMenu">
					<ul>
						<li class=""><a href="#">NOTICE</a></li>
						<li class=""><a href="/util/faq.do">FAQ</a></li>
						<li class=""><a href="/customer/suggestionWrite.do">QNA</a></li>
					</ul>
				</nav>	
			</div>
		</div>
	</div>
	<!-- NOTICE SECTION:E -->
	</c:if>
	
	<c:if test="${board_kind eq 2}">
	<!-- FAQ SECTION:S -->
		<div class="container">
			<div class="row">
				<div class="col-md-9">
					<div id="searchHeader" class="text-center">
						<div class="search_txt">
							<strong>궁금하신 점을 검색 해 주세요.</strong>
							<p>	알고 싶으신 내용이 있으시면 키워드를 입력하셔서 검색해 주세요.</p>
						</div>
						
						<form action="findList" method="post" role="search">
							    <div class="search_input">
							      <input type="text" placeholder="Search for...">
							      <a href="#" class="sch_btn" id="sch_btn">검색</a>
							    </div>
						</form>
					</div>
					<div id="searchTable" class="panel panel-default">
						<div class="panel-body">
							<div class="inner-searchL">
								<strong>FAQ</strong>
								<p>자주하는 질문 BEST 5</p>
								<ul>
									<c:forEach items="${bestList}" var="bestList">								
									<li>
										<a style="text-decoration: none; cursor: pointer; color: #006633; font-size: 16px; font-weight: bold;">
											<span style="padding-right: 50px; border-right: 1px solid #ddd;">${bestList.board_category}</span>
											<span style="padding-left : 30px;">${bestList.board_title}</span>
										</a>
									</li>
									</c:forEach>
								</ul>
							</div>
							<div class="inner-searchR">
								<strong>분류별 키워드</strong><br>
								<select class="form-control">
									<option value="">전체</option>
									<option value="코디/상품">코디/상품</option>
									<option value="주문">주문</option>
									<option value="입금/결제">입금/결제</option>
									<option value="기타">기타</option>
								</select>
							</div>
						</div>
					</div>
					<div id="faq_wrap">
						<table class="table" id="faqList">
							<tbody>
								<c:forEach items="${list}" var="list">
									<tr class="faqTop">
										<td style="width : 150px; padding-left : 20px;">${list.board_category}</td>
										<td>
											<span class="faq_Q">Q</span>
											<span class="faqTitle">
										 		${list.board_title}
										 	</span>
										</td>
									</tr>
									<tr style="background-color: #ddd; display:none;" class="faqBottom">
										<td>&nbsp</td>
										<td>
											<span class="faq_A">A</span>
											<span class="faqCont">
										 		${list.board_contents}
										 	</span>											
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- PAGINATIOIN:S -->
					<div class="center-block">
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
					</div>
					<!-- PAGINATIOIN:E -->
					<div class="col-md-4">
						<input type="button" value="글쓰기" id="wrBtn" class="btn" style="background-color: #333; color : #ddd;">
					</div>
				</div>
				<div class="col-md-3">
					<nav id="listMenu">
						<ul>
							<li class=""><a href="#">NOTICE</a></li>
							<li class=""><a href="/util/faq.do">FAQ</a></li>
							<li class=""><a href="/customer/suggestionWrite.do">QNA</a></li>
						</ul>
					</nav>		
				</div>
			</div>
		</div>
	<!-- FAQ SECTION:E -->
	</c:if>
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>	
	<!-- Footer:E -->
	
</body>
</html>