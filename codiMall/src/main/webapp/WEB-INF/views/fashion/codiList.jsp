<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>코디 리스트</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/pagination.css" rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/product/productList.css"
	rel="stylesheet">
<script type="text/javascript">
$(function(){
	$(".N_pageing").click(function(){
		$(".inh_curPage").val($(this).text());
		$("#form_all").submit();
	});
});
</script>
<style type="text/css">
.tit{
    background : none;
    border: none;
    
}
.code_group > .tit {
    padding-top: 45px;
    padding-bottom: 45px;
    text-align: center;
}
</style>
</head>
<body>
	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->
	
	<div class="container" style="padding-top: 20px;">
		<div class="row">
			<div class="col-sm-12">
			<div class="code_group">
		    		<pre class="tit"><span style="font-size:18px; color: #333; font-weight: bold;font-family: 'Sandol', sans-serif;">MAPSSI 코디</span><br>
					<span style="font-size:12px; color: #d2d2d2; font-weight: bold;font-family: 'Sandol', sans-serif;margin-left: -270px;">인기코디와 최신코디를 만나보세요!</span>
		    		</pre>
		    	</div>
					<nav class="navbar">
						<div class="navbar-collapse collapse"
							style="padding-left: 100px; border-bottom: 1px solid #eee;">
							<ul class="nav navbar-nav category-type">
								<li><a style="cursor: pointer" class="sel_type"><input
										class="inhc_sel" type="hidden" value="1">최신순</a></li>
								<li><a style="cursor: pointer" class="sel_type"><input
										class="inhc_sel" type="hidden" value="2">인기순</a></li>
								<c:if  test="${sessionScope.member ne null }">								
								<li><a style="cursor: pointer" class="sel_type" onclick="window.open('${pageContext.request.contextPath}/fashion/codiWrite','codi','width=900,height=700');return false;">코디 생성</a></li>
								</c:if>		
							</ul>
						</div>
					</nav>
					<div id="item-table" style="margin-left:100px;">
						<ul class="list-inline" style="width: 850px;">
							<c:forEach items="${list}" var="list1">
							<li style="padding-left: 20px;" class="viewItem">
								<div class="mc" style="border: 1px solid #eee;">
									<span class="img"> <a
										href="${pageContext.request.contextPath}/fashion/codiView?num=${list1.num}">
											<img
											src="${pageContext.request.contextPath}/resources/codiUpload/${list1.fileName}"
											width="250" height="250">
									</a>
									</span>
									<div class="item-info" style="padding-left: 10px;">
										<p style="padding-top: 10px;">
											<a
												href="${pageContext.request.contextPath}/fashion/codiView?num=${list1.num}">${list1.title}</a>
										</p>
									</div>	
								</div>							
							</li>							
							</c:forEach>
						</ul>
					</div>	

					</div>	
						<!-- 상품 리스트:E -->
					<!-- PAGINATIOIN:S -->
					<div class="center-block" style="width : 400px;">
						<nav aria-label="Page navigation">
							<ul class="pagination">
								<c:if test="${!empty list}">

									<li><c:if test="${pageing.curBlock>1}">
											<a class="a_prev" aria-label="Previous"
												style="cursor: pointer"><input class="inh_prev"
												type="hidden" value="${pageing.startNum-1}"> <span
												aria-hidden="true">&laquo;</span> </a>
										</c:if></li>
									<li><c:forEach begin="${pageing.startNum}" step="1"
											end="${pageing.lastNum}" var="i">

											<a style="cursor: pointer" class="N_pageing">${i}</a>
										</c:forEach></li>
									<li><c:if test="${pageing.curBlock<pageing.totalBlock}">
											<a class="a_next" aria-label="Next" style="cursor: pointer">
												<input class="inh_next" type="hidden"
												value="${pageing.lastNum+1}"><span
												aria-hidden="true">&raquo;</span>
											</a>
										</c:if></li>
								</c:if>
							</ul>
						</nav>
					</div>
					<!-- PAGINATIOIN:E -->						
					</div>
			</div>
			<%@ include file="/resources/temp/footer.jsp"%>

				<!--  hidden form (POST로 넘기기위한 숨겨진 FORM 지저분한 주소창방지용)  -->
				<form id="form_all" name="formAll"
					action="${pageContext.request.contextPath}/fashion/codiList"
					method="post" style="display: none;">
					<input class="inh_curPage" type="hidden" value="" name="curPage">
				</form>
</body>
</html>