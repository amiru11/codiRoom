<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<link rel="stylesheet" href="http://fonts.googleapis.com/earlyaccess/hanna.css">
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/font-awesome/css/font-awesome.min.css">
<script src="${pageContext.request.contextPath}/resources/js/mast.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/css/mast/mast.css"
	rel="stylesheet">
<style type="text/css">
table, table tr, tr td, th {
	border: 2px solid #dce2eb;
}

th {
	text-align: center;
}
.nav>li>a.side-btn {
	color: #91a7c6;
	padding: 0;
	line-height: 50px;
	height: 50px;
	overflow: hidden;
	cursor: pointer;
	font-size: 18px;
}

#div_tab_eachin {
	width: 100%;
	height: 100px;
	overflow-y: scroll;
}

#tab_mast_productList_eachList {
	margin : 10px;
	width: 100%;
	border : none;
}
#tab_mast_productList_eachList > tbody > tr{
	border : none;
}
#tab_mast_productList_eachList > tbody > tr > th{
	border : none;
	border-bottom : 2px solid #dce2eb;
}
#tab_mast_productList_eachList > tbody > tr > td{
	border : none;
}
#tab_mast_productList {
	border-top : none;
	border-left : 2px solid #dce2eb;
}
#tab_mast_productList > tbody > tr{
	border-bottom : 2px solid #dce2eb;
}
#tab_mast_productList > tbody > tr > td{
	border : none;
}
</style>
<script type="text/javascript">

	$(function() {
		var message="${message}";
		if(message !=""){
			alert(message);
		}
		$("#2").parent("li").addClass("active");
	});

	jQuery.ajaxSettings.traditional = true;
</script>
</head>
<body style="height: 1800px; font-family: 'hanna';">
	<div class="container-fluid" style="padding: 0; height: 100%">
		<div class="row" style="height: 100%;">
			<div class="col-sm-2" style="height: 100%;">
				<%@ include file="/resources/temp/mast/sideBar.jspf"%>
			</div>
			<div class="col-sm-8" style="margin: 20px; height: 100%;">
				<div class="container-fulid">
					<div id="view">
						<header id="topbar" class="text-center bg-white alt ph10 br-b-ddd">
							<nav class="navbar">
								<div class="navbar-collapse collapse"
									style="padding-left: 0; border-bottom: 1px solid #eee;">
									<ul id="category-type" class="nav navbar-nav" style="vertical-align: top;">
										<li class="category-li"><a id="1" class="sel_type" href="${pageContext.request.contextPath}/mast/mastProductList">ProductList</a></li>
										<li class="category-li"><a id="2" class="sel_type" href="${pageContext.request.contextPath}/mast/mastProductListEach0">ProductEach(Update)</a></li>
										<%-- <li class="category-li"><a id="3" class="sel_type" href="${pageContext.request.contextPath}/mast/mastProductListEach022">ProductListEach0</a></li> --%>
										<li class="category-li"><a id="4" class="sel_type" href="${pageContext.request.contextPath}/product/productAdd">ProductAdd</a></li>
									</ul>		
								</div>
							</nav>
						</header>	
						<section id="section" class="jumbotron">
							<div class="panel" style="background: #fff; margin-bottom: 30px;">
								<div class="panel-heading">
									<a id="subList" class="subBtn btn btn-default btn-lg">
										<span class="fa fa-list"></span> List
									</a>
								</div>
								<div class="panel-body" style="background-color: white;">
									<div id="div_product_list">
										<c:forEach var="list1" items="${list}">
											<div style="width: 330px; border: 2px solid #dce2eb; float: left;">
												<div class="div_cl_img_asd" 
													style="display: inline-block; width : 50%; cursor: pointer; float: left;">
													<input class="inh_product_num" type="hidden"
														name="product_num" value="${list1.productDTO.product_num}">
													<img 
														<c:if test="${!empty sessionScope.member}">
													data-toggle="modal" data-target="#basketModal"
										data-backdrop="true"
													</c:if>
														style="float: left; border-bottom : 2px solid #dce2eb;" width="100%" height="200"
														src="${pageContext.request.contextPath}/resources/testPic/${list1.productPicDTO.productPic_pic}">
												</div>
												<table id="tab_mast_productList"
													style="display: inline-block; width : 50%; padding-left : 10px;">
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
												<div id="div_tab_eachin">
													<table id="tab_mast_productList_eachList" class="table"
														style="display: inline-block; float: left;">
														<tr>
															<th>SIZE</th>
															<th>COLOR</th>
															<th>EACH</th>
															<th>FIX</th>
														</tr>
			
														<c:forEach var="list22" items="${list1.productEachDTOs}">
															<tr class="tr_cl_fix">
																<td class="td_first_size">${list22.productSize_size}</td>
																<td class="td_second_size">${list22.productEach_color}</td>
																<td>${list22.productEach_each}</td>
																<td class="td_third_size">
																	<form class="cl_each_fix_form" action="${pageContext.request.contextPath}/mast/mastProductListEach0EachFix" method="post">
																		<input class="inp_pro_each" type="number" min="0"
																			name="productEach_each" style="width: 40px;"> <input
																			class="inph_pro_num" type="hidden" name="product_num"
																			value="${list1.productDTO.product_num }"> <input
																			class="inph_pro_size" type="hidden"
																			name="productSize_size"
																			value="${list22.productSize_size}"> <input
																			class="inph_pro_color" type="hidden"
																			name="productEach_color"
																			value="${list22.productEach_color}">
																		<button class="btn_each_fix">FIX</button>
																	</form>
																</td>
															</tr>
														</c:forEach>
													</table>
												</div>
											</div>
										</c:forEach>
									</div>
								</div>								
								<div class="panel-footer"  style="background-color: white;">
									<div class="center-block"  style="width : 200px;">
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
			
															<a
																href="${pageContext.request.contextPath}/mast/mastProductListEach0?curPage=${i}"
																style="cursor: pointer" class="N_pageing">${i}</a>
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
							</div>
						</section>					
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>