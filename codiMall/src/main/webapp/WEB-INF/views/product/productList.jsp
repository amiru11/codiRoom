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
		$("#checkForm").find(":checkbox").change(function() {
			$("#checkForm").submit();
		});

		$(".div_cart").click(function() {

			var product_num = $(this).find(".inh_product_num").val();
			selSize(product_num);
			$("#inh_pro_val").val(product_num);
		});

		$("#sel_size").change(function() {
			if($(this).val()!=""){
				selColor($("#inh_pro_val").val());	
			}
			
		});

		$("#btn_basketAdd").click(function() {
			basketAdd($("#inh_pro_val").val());
		});

		$("#inp_each").change(function() {
			numcheck();
			eachCheck();
		});
		$("#inp_each").keydown(function() {
			numcheck();
			eachCheck();
		});
		$("#inp_each").keyup(function() {
			numcheck();
			eachCheck();
		});
		$("#inp_each").blur(function() {
			eachCheck();
		});




		//$(".sel_type").click(function(){//검색타입 글자클릭시 라디오버튼 바뀌게
		//	$(".sel_radio").attr("checked",null);//checked속성을 전부 다 지워준다.
		//	$(this).prev("input").attr("checked","checked");//그다음 해당하는 radio에 checked를 해준다
		//});

	/* $.ajax({
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
	}); */
	});


	function selSize(product_num) {
		$.ajax({
			url : "../json/productSize",
			type : "post",
			data : {
				product_num : product_num
			},
			success : function(data) {
				var x = '<option value="">SIZE</option>';
				$.each(data, function(index, value) {
					x = x + "<option value=" + value + ">" + value + "</option>";
				});
				$("#sel_size").html(x);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	function selColor(product_num) {
		$.ajax({
			url : "../json/productEach",
			type : "post",
			dataType : 'json',
			data : {
				product_num : product_num,
				productSize_size : $("#sel_size").val()
			},
			success : function(data) {
				var x = '<option value="">COLOR</option>';
				var y = "";
				$.each(data.eachList, function(index, value) {
					x = x + "<option value=" + value.productEach_color + ">" + value.productEach_color + '_' + value.productEach_each + "</option>";
					y = y + value.productEach_color + '_' + value.productEach_each + '<input class="' + value.productEach_color + '" type="text" value="' + value.productEach_each + '">';
				});
				$("#div_hidden_each").html(y);
				$("#sel_color").html(x);

			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function basketAdd(product_num) {
		$.ajax({
			url : "../basket/basketAdd",
			type : "post",
			data : {
				product_num : product_num,
				productSize_size : $("#sel_size").val(),
				productEach_color : $("#sel_color").val(),
				productEach_each : $("#inp_each").val(),
			},
			success : function(data) {
				if (data == 1) {
					alert("장바구니 등록성공");
				} else {
					alert(data);
				}

			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	function numcheck() {
		if ( (event.keyCode == 69) ) {
			event.returnValue = false;
		}
	}
	function eachCheck() {
		var as = $("#sel_color").val();
		var b = $("." + as + "").val() * 1;
		var c = $("#inp_each").val() * 1;
		if (c * 1 > b * 1) {
			alert("재고초과");
			$("#inp_each").val(b);
		} else {
		}
	}
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
					<form id="checkForm"
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
								style="width: 200px; height: 100px; overflow: scroll;">
								<c:forEach var="kindList" items="${selKind_num}">
								${kindList}<input type="checkbox" value="${kindList}"
										<c:forEach var = "kind2" items="${kind_num}">
								<c:if test="${kindList ==kind2}">
								checked="checked"
								</c:if>
								</c:forEach>
										name="kind_num">
								</c:forEach>
							</div>
							SIZE<BR>
							<div id="div_ck_size"
								style="width: 200px; height: 100px; overflow: scroll;">
								<c:forEach var="sizeList" items="${selSize}">
								${sizeList}<input type="checkbox" value="${sizeList}"
										<c:forEach var = "size2" items="${size}">
								<c:if test="${sizeList ==size2}">
								checked="checked"
								</c:if>
								</c:forEach>
										name="size">
									<br>
								</c:forEach>
							</div>
							COLOR<br>
							<div id="div_ck_color"
								style="width: 200px; height: 100px; overflow: scroll;">
								<c:forEach var="colorList" items="${selColor}">
								${colorList}<input type="checkbox" value="${colorList}"
										<c:forEach var = "color2" items="${color}">
								<c:if test="${colorList ==color2}">
								checked="checked"
								</c:if>
								</c:forEach>
										name="color">
									<br>
								</c:forEach>
							</div>
						</div>

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
										<div class="div_cart cart"
											<c:if test="${empty sessionScope.member}">
										data-toggle="modal" data-target="#loginModal"
							data-backdrop="true"
										</c:if>
											<c:if test="${!empty sessionScope.member}">
										data-toggle="modal" data-target="#basketModal"
							data-backdrop="true"
										</c:if>>
											<input type="hidden" value="${list1.product_num}"
												class="inh_product_num" name="product_num"> <span
												style="font-size: 20px; color: #ffffff;">ADD TO CART</span>
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

	<!-- Modal -->
	<div class="modal fade" id="basketModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">CART</h4>
				</div>
				<input type="hidden" value="" id="inh_pro_val">
				<div class="modal-body"
					style="padding: 3px; height: 300px; background-color: red;">사진</div>
				<div class="modal-body2">
					<select id="sel_size"></select>
				</div>
				<div class="modal-body3">
					<select id="sel_color"></select>
				</div>
				<div class="modal-body3">
					<input type="number" id="inp_each" value="1" min="1" step="1"><br>
					<input id="btn_basketAdd" type="button" value="장바구니 추가">
				</div>

				<div id="div_hidden_each"></div>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>

		</div>
	</div>

</body>
</html>
