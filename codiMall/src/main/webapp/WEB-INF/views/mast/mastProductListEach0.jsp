<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/css/mast/mast.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/font-awesome/css/font-awesome.min.css">
<script src="${pageContext.request.contextPath}/resources/js/mast.js"></script>

<style type="text/css">
table, table tr, tr td, th {
	border: 1px solid black;
}

th {
	text-align: center;
}
</style>
<script type="text/javascript">

	$(function() {
		$("#goCalendar").click(function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/mast/calendar",
				success : function(data) {
					$("#view").empty();
					$("#view").html(data);
					console.log(data);
				}
			});

		});
	});
	jQuery.ajaxSettings.traditional = true;
</script>
<style type="text/css">
.nav>li>a.side-btn {
	color: #91a7c6;
	padding: 0;
	line-height: 50px;
	height: 50px;
	overflow: hidden;
	cursor: pointer;
	font-size: 18px;
}
</style>
</head>
<body style="height: 1200px;">
	<div class="container-fluid" style="padding: 0; height: 100%">
		<div class="row" style="height: 100%;">
			<div class="col-sm-2" style="height: 100%;">
				<%@ include file="/resources/temp/mast/sideBar.jspf"%>
			</div>
			<div class="com-sm-8" style="margin: 20px; height: 100%;">
				<div class="container">
					<div id="view">
						<!--      -->
						<H1>each0</H1>
						<div id="div_product_list">
							<c:forEach var="list1" items="${list}">
								<div style="width: 330px; border: 1px solid black; float: left;">
									<div class="div_cl_img_asd"
										style="display: inline-block; cursor: pointer; float: left;">
										<input class="inh_product_num" type="hidden"
											name="product_num" value="${list1.productDTO.product_num}">
										<img
											<c:if test="${!empty sessionScope.member}">
										data-toggle="modal" data-target="#basketModal"
							data-backdrop="true"
										</c:if>
											style="float: left;" width="200px" height="200px"
											src="${pageContext.request.contextPath}/resources/testPic/${list1.productPicDTO.productPic_pic}">
									</div>
									<table id="tab_mast_productList"
										style="display: inline-block; float: left;">
										<tr>
											<td>판매수</td>
											<td>${list1.selCount}</td>
										</tr>
										<tr>
											<td>pS.num</td>
											<td>${list1.productSelectDTO.productSelect_num}</td>
										</tr>
										<tr>
											<td>pS.name</td>
											<td>${list1.productSelectDTO.productSelect_name}</td>
										</tr>
										<tr>
											<td>k.num</td>
											<td>${list1.kindDTO.kind_num}</td>
										</tr>
										<tr>
											<td>k.name</td>
											<td>${list1.kindDTO.kind_name}</td>
										</tr>
										<tr>
											<td>p.num</td>
											<td>${list1.productDTO.product_num}</td>
										</tr>
										<tr>
											<td>p.name</td>
											<td>${list1.productDTO.product_name}</td>
										</tr>
										<tr>
											<td>price</td>
											<td>${list1.productInfoDTO.productInfo_price}</td>
										</tr>
										<tr>
											<td>sale</td>
											<td>${list1.productInfoDTO.productInfo_saleRate}</td>
										</tr>
									</table>
									<table id="tab_mast_productList_eachList"
										style="display: inline-block; float: left;">
										<tr>
											<th>SIZE</th>
											<th>COLOR</th>
											<th>EACH</th>
											<th>FIX</th>
										</tr>
										<c:forEach var="list22" items="${list1.productEachDTOs}">
										<tr class="tr_cl_fix">
											<td>${list22.productSize_size}</td>
											<td>${list22.productEach_color}</td>
											<td>${list22.productEach_each}</td>
											<td><input class="inp_pro_each" type="number" min="0" name="productEach_each" style="width: 40px;">
											<input class="inph_pro_num" type="hidden" name="product_num" value="${list1.productDTO.product_num }">
											<input class="inph_pro_size" type="hidden" name="productSize_size" value="${list22.productSize_size}">
											<input class="inph_pro_color" type="hidden" name="productEach_color" value="${list22.productEach_color}">
											<button class="btn_each_fix">FIX</button>
											</td>
										</tr>
										</c:forEach>
									</table>
								</div>
							</c:forEach>
						</div>
						<div class="center-block">
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






					</div>
					<!--  view E  -->
				</div>
			</div>
		</div>

	</div>


</body>
</html>