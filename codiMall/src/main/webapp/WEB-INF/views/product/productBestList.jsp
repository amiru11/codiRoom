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
					
				</div>
				<div class="right col-lg-8" style="margin-top: 0; width: 850px;">
					<!-- 상품 리스트:S -->
				

					<div id="item-table">
						<ul class="list-inline" style="width: 850px;">
							<c:forEach items="${list}" var="list1">
								<li style="padding-left: 20px;" class="viewItem">
									<div class="mc" style="border: 1px solid #eee;">
										<span class="img"> <a
											href="${pageContext.request.contextPath}/product/productView?product_num=${list1.productDTO.product_num}">
												<img src="http://placehold.it/500x150&text=FooBar1"
												width="250" height="250">
										</a>
										</span>
										<div class="item-info" style="padding-left: 10px;">
											<p style="padding-top: 10px;">
												<a
													href="${pageContext.request.contextPath}/product/productView?product_num=${list1.productDTO.product_num}">${list1.productDTO.product_name}</a>
											</p>
											<p>브랜드</p>
											<p>
												<span> <fmt:formatNumber
														value="${list1.productInfoDTO.productInfo_price}"
														currencySymbol="" type="currency" />원
												</span> <strong style="color: #b5172e;">→<c:set
														var="number"
														value="${list1.productInfoDTO.productInfo_price*(100-list1.productInfoDTO.productInfo_saleRate)/100}" />
													<fmt:parseNumber var="total" value="${number}"
														type="number" integerOnly="true" /> ${total}
													원(${list1.productInfoDTO.productInfo_saleRate}%)
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
											<input type="hidden" value="${list1.productDTO.product_num}"
												class="inh_product_num" name="product_num"> <span
												style="font-size: 20px; color: #ffffff;">ADD TO CART</span>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
						<!-- 상품 리스트:E -->
					</div>

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
