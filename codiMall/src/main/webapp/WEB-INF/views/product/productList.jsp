<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/product/productList.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/pagination.css"
	rel="stylesheet">
<style type="text/css">
table, table tr, tr td, th {
	border: 1px solid black;
}
</style>
<script type="text/javascript">
	$(function() {
		//$(".sel_type").click(function(){//검색타입 글자클릭시 라디오버튼 바뀌게
		//	$(".sel_radio").attr("checked",null);//checked속성을 전부 다 지워준다.
		//	$(this).prev("input").attr("checked","checked");//그다음 해당하는 radio에 checked를 해준다
		//});

		$.ajax({
			url : "../json/allKindNum",
			type : "post",
			dataType : 'json',
			data : {
			},
			success : function(data) {
				$("#div_ck_kind").html("");
				var x = "";
				$.each(data.kindNumList, function(index, value) {
					x = x + value + '<input type="checkbox" value="' + value + '" name="kind_num"><BR>'
				});
				$("#div_ck_kind").html(x);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});

		$.ajax({
			url : "../json/allProductSize",
			type : "post",
			dataType : 'json',
			data : {
			},
			success : function(data) {
				$("#div_ck_size").html("");
				var x = "";
				$.each(data.sizeList, function(index, value) {
					x = x + value + '<input type="checkbox" value="' + value + '" name="size"><BR>'
				});
				$("#div_ck_size").html(x);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});


		$.ajax({
			url : "../json/allProductColor",
			type : "post",
			dataType : 'json',
			data : {
			},
			success : function(data) {
				$("#div_ck_color").html("");
				var x = "";
				$.each(data.colorList, function(index, value) {
					x = x + value + '<input type="checkbox" value="' + value + '" name="color"><BR>'
				});
				$("#div_ck_color").html(x);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	});
</script>

</head>
<body>
	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->

	<div class="container" style="padding-top: 20px;">
		<nav class="navbar" style="border-bottom: 1px solid #eeeeee;">
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav sub-header">
					<li><a>아우터</a></li>
					<li><a>상의</a></li>
					<li><a>하의</a></li>
					<li><a>가방</a></li>
					<li><a>신발</a></li>
					<li><a>할인상품</a></li>
					<li><a>신상품</a></li>
				</ul>
			</div>
		</nav>
		<div class="item row">
			<div class="col-lg-12">
				<div class="left col-lg-4" style="margin-top: 0;">
					<form
						action="${pageContext.request.contextPath}/product/productList"
						method="get">
						curPage : <input type="number" name="curPage"><br>
						perPage : <input type="number" name="perPage"><br> <select
							name="sel"><option value="1">최신순</option>
							<option value="2">먼저나온순</option>
							<option value="3">최저가순</option>
							<option value="4">최고가순</option></select>
						<div id="div_out_search_select">
							KIND<br>
							<div id="div_ck_kind"
								style="width: 200px; height: 100px; overflow: scroll;"></div>
							SIZE<BR>
							<div id="div_ck_size"
								style="width: 200px; height: 100px; overflow: scroll;"></div>
							COLOR<br>
							<div id="div_ck_color"
								style="width: 200px; height: 100px; overflow: scroll;"></div>
						</div>
						<button>SUBMIT</button>

					</form>
				</div>
				<div class="right col-lg-8" style="margin-top: 0; width: 850px;">
					<!-- 상품 리스트:S -->
					<nav class="navbar">
						<div class="navbar-collapse collapse"
							style="padding-left: 0; border-bottom: 1px solid #eee;">
							<ul class="nav navbar-nav category-type">
								<li><a class="sel_type" name="3">최신순</a></li>
								<li><a class="sel_type" name="3">인기순</a></li>
								<li><a class="sel_type" name="4">낮은 가격 순</a></li>
								<li>
									<!-- <input name="sel" type="radio" class="sel_radio" value="5"> -->
									<a class="sel_type" name="5">높은 가격 순</a>
								</li>
							</ul>
						</div>
					</nav>

					<div id="item-table">
						<ul class="list-inline" style="width: 850px;">
							<c:forEach items="${list}" var="list1">
								<li style="padding-left: 20px;" class="viewItem">
									<div class="mc" style="border: 1px solid #eee;">
										<span class="img"> <a
											href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">
												<img src="http://placehold.it/500x150&text=FooBar1"
												width="250" height="250">
										</a>
										</span>
										<div class="item-info" style="padding-left: 10px;">
											<p style="padding-top: 10px;">
												<a
													href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a>
											</p>
											<p>브랜드</p>
											<p>
												<span> <fmt:formatNumber
														value="${list1.productInfo_price}" currencySymbol=""
														type="currency" />원
												</span> <strong style="color: #b5172e;">→<c:set
														var="number"
														value="${list1.productInfo_price*(100-list1.productInfo_saleRate)/100}" />
													<fmt:parseNumber var="total" value="${number}"
														type="number" integerOnly="true" /> ${total}
													원(${list1.productInfo_saleRate}%)
												</strong>
											</p>
										</div>
										<div class="cart">
											<span style="font-size: 20px; color: #ffffff;">ADD TO
												CART</span>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
						<!-- 상품 리스트:E -->
					</div>
					<!-- PAGINATIOIN:S -->
					<div class="center-block">
						<nav aria-label="Page navigation">
							<ul class="pagination">

								<li><c:if test="${pageing.curBlock>1}">
										<a
											href="${pageContext.request.contextPath}/product/productList?perPage=${pageing.perPage}&curPage=${pageing.startNum-1}
											<c:forEach items="${kind_num}" var="kind">
											&kind_num=${kind}
											</c:forEach>
											<c:forEach items="${size}" var="siz">
											&size=${siz}
											</c:forEach>
											<c:forEach items="${color}" var="colo">
											&color=${colo}
											</c:forEach>
											"
											aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
										</a>
									</c:if></li>
								<li><c:forEach begin="${pageing.startNum}" step="1"
										end="${pageing.lastNum}" var="i">

										<a class="N_pageing"
											href="${pageContext.request.contextPath}/product/productList?perPage=${pageing.perPage}&curPage=${i}
											<c:forEach items="${kind_num}" var="kind">
											&kind_num=${kind}
											</c:forEach>
											<c:forEach items="${size}" var="siz">
											&size=${siz}
											</c:forEach>
											<c:forEach items="${color}" var="colo">
											&color=${colo}
											</c:forEach>">${i}</a>
									</c:forEach></li>
								<li><c:if test="${pageing.curBlock<pageing.totalBlock}">
										<a
											href="${pageContext.request.contextPath}/product/productList?perPage=${pageing.perPage}&curPage=${pageing.lastNum+1}
											<c:forEach items="${kind_num}" var="kind">
											&kind_num=${kind}
											</c:forEach>
											<c:forEach items="${size}" var="siz">
											&size=${siz}
											</c:forEach>
											<c:forEach items="${color}" var="colo">
											&color=${colo}
											</c:forEach>"
											aria-label="Next"> <span aria-hidden="true">&raquo;</span>
										</a>
									</c:if></li>
							</ul>
						</nav>
					</div>
					<!-- PAGINATIOIN:E -->
				</div>
			</div>
		</div>


	</div>
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>
	<!-- Footer:E -->

</body>
</html>
