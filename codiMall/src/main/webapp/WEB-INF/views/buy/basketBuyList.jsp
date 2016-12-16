<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/basket/basket.css"
	rel="stylesheet">
<style type="text/css">
#second_now{
	background: url(/codi/resources/images/basket/hgroup_img.gif) no-repeat 0 0;
	background-position: -222px -93px;
}
#order_tit{
	width: 180px;
    background: url(/codi/resources/images/basket/hgroup_img.gif) no-repeat 0 0;
    background-position: -415px 0px;
    text-indent: -9999px;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#btn_buy").click(function(){
			$("#tab_form").attr("action","${pageContext.request.contextPath}/buy/basketBuy");
			$("#tab_form").submit();
		});
	});
</script>
</head>
<body>
	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->

	<div class="container cart-body">
		<div class="row">
			<div class="col-sm-12">
				<h1 id="cart_title" class="page-heading">Order/Payment summary </h1>
				<div>
					<ul class="step list-inline" id="order_step">
						<li id="order_tit" class="title_img">TITLE</li>
						<li class="step-li first">
							<span>주문 완료</span>
						</li>
						<li class="arrow-li"></li>
						<li id="second_now" class="step-li second">
							<span> 주문서 작성</span>
						</li>
						<li class="arrow-li"></li>
						<li class="step-li third">
							<span> 장바구니</span>
						</li>
					</ul>
				</div>
				<form id="tab_form" method="post">
					<div style="	border: 2px solid #dce2eb;">
						<h3 class="product_tit">PRODUCT INFO</h3>
						<table class="table cart-table">
						<tr>
							<th class="bas_th_01">상품명</th>
							<th class="bas_th_02">판매가</th>
							<th class="bas_th_03">할인율</th>
							<th class="bas_th_04">옵션</th>
							<th class="bas_th_05">색상</th>
							<th class="bas_th_06">수량</th>
							<th class="bas_th_07">주문금액</th>
						</tr>
						<c:forEach var="list1" items="${list}">
							<tr>
								<td style="width: 200px;"><input type="hidden" name="basket_num"  value="${list1.basket_num}"><input type="hidden" name="product_num"  value="${list1.product_num}">
										<div class="bas_td_hid_proeach" style="display: inline-block; float: left;" >
										<a href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">
											<img alt="" src="${pageContext.request.contextPath}/resources/images/noimage.jpg" width="60" height="60">
										</a>
										</div>
										<div style="display: inline-block; margin-top: 20px;float: left;">
										<p>
											<a
												href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">
													${list1.product_name}
											</a>
										</p>
										</div>
								</td>
								<td><input type="hidden" name=""  value="${list1.productInfo_price}"><fmt:formatNumber value="${list1.productInfo_price}" currencySymbol="" type="currency"/>원</td>
								<td><input type="hidden" name=""  value="${list1.productInfo_saleRate}">${list1.productInfo_saleRate}%</td>
								<td><input type="hidden" name=""  value="${list1.basketInfo_size}">${list1.basketInfo_size}</td>
								<td><input type="hidden" name=""  value="${list1.basketInfo_color}">${list1.basketInfo_color}</td>
								<td><input type="hidden" name=""  value="${list1.basketInfo_each}">${list1.basketInfo_each}</td>
								<td>
									<fmt:formatNumber
										value="${list1.productInfo_price*list1.basketInfo_each*(100-list1.productInfo_saleRate)/100}"
										currencySymbol="" type="currency" />원
								</td>
							</tr>
						</c:forEach>
					</table>
					</div>

				
					<div class="recipient-info" style="border-right: 2px solid #dce2eb; border-left: 2px solid #dce2eb;  border-bottom: 2px solid #dce2eb;">
						<h3 class="product_tit">RECIPIENT INFO</h3>
						<div class="clearfix">
							<ul class="box_receiver_info list-inline">
								<li class="cell_discount_tit">배송지 선택</li>
								<li class="cell_discount_detail">
									<label class="box_choice fist">
										<input type="radio" id="address_dongil" name="adress_chk" onclick=""> 기본 배송지(구매자 정보)
									</label>
									<label class="box_choice">
										<input type="radio" id="address_list" name="adress_chk" onclick=""> 새로운 배송지
									</label>
								</li>
							</ul>
							<ul class="list-inline">
								<li></li>
							</ul>
							<ul class="list-inline">
								<li></li>
							</ul>
							<ul class="list-inline">
								<li></li>
							</ul>
							<ul class="list-inline">
								<li></li>
							</ul>
						</div>
					</div>
					<div class="payment-info" style="border-right: 2px solid #dce2eb; border-left: 2px solid #dce2eb; border-bottom: 2px solid #dce2eb;">
						<h3 class="product_tit">PAYMENT INFO / AGREEMENT</h3>
					</div>
					<div class="button-set" style="float:right; font-family: hanna;">
						<input type="button" value="구매하기" id="btn_buy" class="btn btn-default">
					</div>
				</form>	
			</div>
		</div>
	</div>		
	
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>
	<!-- Footer:E -->
</body>
</html>
