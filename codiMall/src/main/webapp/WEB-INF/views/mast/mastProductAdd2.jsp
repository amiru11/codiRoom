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

	//function eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee

	jQuery.ajaxSettings.traditional = true;
</script>
<style type="text/css">
</style>
</head>
<body style="height: 1200px;">
	<div class="container-fluid" style="padding: 0; height: 100%">
		<div class="row" style="height: 100%;">
			<div class="col-sm-2" style="height: 100%;">
				<%@ include file="/resources/temp/mast/sideBar.jspf"%>
			</div>

			<div class="col-sm-8" style="margin: 20px; height: 100%;">
				<div class="container">
					<div id="view">
						<div id="div_view_in_div">
							<form
								action="${pageContext.request.contextPath}/mast/mastProductAdd"
								method="post" enctype="multipart/form-data">


								<div id="selector">


									<div id="div_proSel_sel"
										style="float: left; width: 10%; height: 100px; overflow-y: scroll; text-align: right;">
										<label class="labelccc">대분류</label><input
											id="inp_id_ck_prosel" type="checkbox"><br>
										<table id="tab_prosel_ss">
											<c:forEach var="proselc" items="${productSelectList}">
												<tr>
													<td>${proselc.productSelect_num}</td>
													<td>${proselc.productSelect_name}</td>
													<td><input class="in_ck_proSelNum p_param"
														type="checkbox" name="productSelect_num"
														value="${proselc.productSelect_num}"
														<c:forEach var="listasd" items="${map.productSelect_num}"> 
							<c:if test="${proselc.productSelect_num == listasd}">
							checked="checked"</c:if>
					</c:forEach>></td>

												</tr>
											</c:forEach>
										</table>
									</div>
									<div id="div_kind_sel"
										style="float: left; width: 15%; height: 100px; overflow-y: scroll; text-align: right;">
										<label class="labelccc">소분류</label><input id="inp_id_ck_kind"
											type="checkbox"><br>
										<table id="tab_kindsel_ss">
											<c:forEach var="proselc" items="${kindList}">
												<tr>
													<td>${proselc.kind_num}</td>
													<td>${proselc.kind_name}</td>
													<td><input class="in_ck_kindNum p_param"
														type="checkbox" name="kind_num"
														value="${proselc.kind_num}"
														<c:forEach var="listasd" items="${map.kind_num}"> 
							<c:if test="${proselc.kind_num == listasd}">
							checked="checked"</c:if>
					</c:forEach>></td>
												</tr>
											</c:forEach>
										</table>
									</div>
									<div id="div_pro_sel"
										style="float: left; width: 15%; height: 100px; overflow-y: scroll; text-align: right;">
										<label class="labelccc">상품번호</label><input id="inp_id_ck_pro"
											type="checkbox"><br>
										<table id="tab_pro_ss">
											<c:forEach var="proselc" items="${productList}">
												<tr>
													<td>${proselc.product_num}</td>
													<td>${proselc.product_name}</td>
													<td><input class="in_ck_proNum p_param"
														type="checkbox" name="product_num"
														value="${proselc.product_num}"
														<c:forEach var="listasd" items="${map.product_num}"> 
							<c:if test="${proselc.product_num == listasd}">
							checked="checked"</c:if>
					</c:forEach>></td>
												</tr>
											</c:forEach>
										</table>
									</div>
									<div id="div_size_sel"
										style="float: left; width: 10%; height: 100px; overflow-y: scroll; text-align: right;">
										<label class="labelccc">사이즈</label><input id="inp_id_ck_size"
											type="checkbox"><br>
										<c:forEach var="proselc" items="${productSizeList}">
						${proselc.productSize_size}<input type="checkbox"
												class="in_ck_proSize p_param" name="productSize_size"
												value="${proselc.productSize_size}"
												<c:forEach var="listasd" items="${map.productSize_size}"> 
							<c:if test="${proselc.productSize_size == listasd}">
							checked="checked"</c:if>
					</c:forEach>>
											<br>
										</c:forEach>
									</div>
									<div id="div_color_sel"
										style="float: left; width: 15%; height: 100px; overflow-y: scroll; text-align: right;">
										<label class="labelccc">색상</label><input id="inp_id_ck_color"
											type="checkbox"><br>
										<c:forEach var="proselc" items="${productColorList}">
						${proselc.productEach_color}<input class="in_ck_proColor p_param"
												type="checkbox" name="productEach_color"
												value="${proselc.productEach_color}"
												<c:forEach var="listasd" items="${map.productEach_color}"> 
							<c:if test="${proselc.productEach_color == listasd}">
							checked="checked"</c:if>
					</c:forEach>>
											<br>
										</c:forEach>
									</div>
									<div id="div_product_list">
										<c:forEach var="list1" items="${list}">
											<div class="div_list_in_list">
												<div class="div_cl_img_asd"
													style="display: inline-block; cursor: pointer; float: left;">
													<input class="inh_product_num" type="hidden"
														name="product_num" value="${list1.productDTO.product_num}">
													<img class="cl_pro_pic"
														<c:if test="${!empty sessionScope.member}">
										data-toggle="modal" data-target="#basketModal"
							data-backdrop="true"
										</c:if>
														src="${pageContext.request.contextPath}/resources/testPic/${list1.productPicDTO.productPic_pic}">
												</div>
												<table class="tab_mast_productList">
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
														<td><fmt:formatNumber
																value="${list1.productInfoDTO.productInfo_price}"
																pattern="#,###" />원</td>
													</tr>
													<tr>
														<td>sale</td>
														<td>${list1.productInfoDTO.productInfo_saleRate}</td>
													</tr>
													<tr>
														<td>totalPrice</td>
														<td><c:set var="number"
																value="${list1.productInfoDTO.productInfo_price*(100-list1.productInfoDTO.productInfo_saleRate)/100}" />
															<fmt:parseNumber var="total" value="${number}"
																type="number" integerOnly="true" /> <fmt:formatNumber
																value="${total}" pattern="#,###" />원</td>
													</tr>
												</table>
											</div>
										</c:forEach>
									</div>
							</form>

						</div>

					</div>
					<!--  view E  -->
				</div>
			</div>
		</div>
	</div>
</body>
</html>