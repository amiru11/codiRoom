<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이 페이지</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/basket/basket.css"
	rel="stylesheet">
<script type="text/javascript">
$(".btn_cancel").click(function() {
	$(thistr).find(".inh_buy_num").removeAttr("disabled", "disabled");
	$("#tab_form").attr("action", "${pageContext.request.contextPath}/buy/cancelBuy");
	$("#tab_form").submit();
});
</script>
<style type="text/css">
#order_tit {
    width: 180px;
    background: url(/codi/resources/images/basket/hgroup_img.gif) no-repeat 0 0;
    background-position: -615px 0px;
    text-indent: -9999px;
}
#first_now {
	background: url(/codi/resources/images/basket/hgroup_img.gif) no-repeat
		0 0;
	background-position: -331px -92px;
}
</style>
</head>
<body>
	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->
	<input type="hidden" value="${sessionScope.member.name}"
		id="hiddenName">
	<div class="container cart-body" style="padding-top: 30px; font-family: 'hanna';">
		<div class="row">
			<div class="col-sm-12">
				<h1 id="cart_title" class="page-heading">Order-result summary
				</h1>
				<div>
					<ul class="step list-inline" id="order_step">
						<li id="order_tit" class="title_img">TITLE</li>
						<li id="first_now"class="step-li first"><span>주문 완료</span></li>
						<li class="arrow-li"></li>
						<li class="step-li second"><span> 주문서 작성</span></li>
						<li class="arrow-li"></li>
						<li class="step-li third"><span> 장바구니</span></li>
					</ul>
				</div>
				
				<form id="tab_form" method="post">
					<div>
						<h3 class="product_tit">PAYMENT INFO</h3>
					</div>
						<table class="table cart-table">
							<tr>
								<th class="buy_th_01">주문번호</th>
								<th class="buy_th_02"></th>
								<th class="buy_th_03">상품명</th>
								<th class="buy_th_04">사이즈</th>
								<th class="buy_th_05">색상</th>
								<th class="buy_th_06">수량</th>
								<th class="buy_th_07">주문가격</th>
								<th class="buy_th_08">주문상태</th>
							</tr>
							<c:forEach var="list1" items="${list}">
								<tr class="buy_tr_ds">
									<td><input class="inh_buy_num" type="hidden"
										value="${list1.buy_num}" name="buy_num" disabled="disabled">${list1.buy_num}</td>
									<td></td>
									<td>
										<div class="bas_td_hid_proeach"
											style="display: inline-block; float: left; width: 150px;">
											<a
												href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">
												<img alt=""
												src="${pageContext.request.contextPath}/resources/testPic/${list1.productPic_pic}"
												width="55" height="55">
											</a>
										</div>
										<div
											style="display: inline-block; margin-top: 20px; float: left;">
											<p>
												<a
													href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">
													${list1.product_name} </a>
											</p>
										</div> <%-- <a href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a> --%>
									</td>
									<td>${list1.buyState_size}</td>
									<td>${list1.buyState_color}</td>
									<td>${list1.buyState_each}</td>
									<td><fmt:formatNumber value="${list1.buyState_price}"
											currencySymbol="" type="currency" />원</td>
									<td style="width: 50px;"><c:if
											test="${1 == list1.buyState_state }">
											<input class="btn_cancel" type="button" value="주문취소">
										</c:if> <c:if test="${2 == list1.buyState_state }">
											<a
												href="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=${list1.buyState_expressNum}"
												target="_blank"><input class="btn_adress_num"
												type="button" value="송장번호"> </a>

										</c:if> <c:if test="${3 == list1.buyState_state }">
									배송완료
										<a
												href="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=${list1.buyState_expressNum}"
												target="_blank"><input class="btn_adress_num"
												type="button" value="송장번호"> </a>
											<br>
											<input class="btn_buy_confirm" type="button" value="구매확정">

										</c:if> <c:if test="${4 == list1.buyState_state }">
									구매완료
										<a
												href="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=${list1.buyState_expressNum}"
												target="_blank"><input class="btn_adress_num"
												type="button" value="송장번호"> </a>
										</c:if></td>
								</tr>
							</c:forEach>
						</table>
					</form>
			</div>	
		</div>
	</div>				
	
	<!-- 서브 메뉴 부분 -->
 <%-- 	<div class="container" style="padding-top: 30px; font-family: 'hanna';"> -->
		 		<nav class="navbar" style="border-bottom: 2px solid #dce2eb;">
			<div class="navbar-collapse collapse">
				<ul id="infoSub-header" class="nav navbar-nav">
						<li style="margin-left: 300px;"><a id="buyList">주문/배송</a></li>
						<li><a>문의 내역</a></li>
						<li><a id="showMyinfo">내 정보</a></li>
						<li><input type="hidden" value="${subMenu}" id="subMenuV"></li>
				</ul>
			</div>
		</nav> 
		<div class="row">
			<div class="col-sm-12">
				<div id="subView" class="col-sm-8">
					<h2>주문/배송</h2>
					<form id="tab_form" method="post">
						<table class="table cart-table">
							<tr>
								<th class="buy_th_01">주문번호</th>
								<th class="buy_th_02"></th>
								<th class="buy_th_03">상품명</th>
								<th class="buy_th_04">사이즈</th>
								<th class="buy_th_05">색상</th>
								<th class="buy_th_06">수량</th>
								<th class="buy_th_07">주문가격</th>
								<th class="buy_th_08">주문상태</th>
							</tr>
							<c:forEach var="list1" items="${list}">
								<tr class="buy_tr_ds">
									<td><input class="inh_buy_num" type="hidden"
										value="${list1.buy_num}" name="buy_num" disabled="disabled">${list1.buy_num}</td>
									<td></td>
									<td>
										<div class="bas_td_hid_proeach"
											style="display: inline-block; float: left; width: 150px;">
											<a
												href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">
												<img alt=""
												src="${pageContext.request.contextPath}/resources/testPic/${list1.productPic_pic}"
												width="55" height="55">
											</a>
										</div>
										<div
											style="display: inline-block; margin-top: 20px; float: left;">
											<p>
												<a
													href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">
													${list1.product_name} </a>
											</p>
										</div> <a href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a>
									</td>
									<td>${list1.buyState_size}</td>
									<td>${list1.buyState_color}</td>
									<td>${list1.buyState_each}</td>
									<td><fmt:formatNumber value="${list1.buyState_price}"
											currencySymbol="" type="currency" />원</td>
									<td style="width: 50px;"><c:if
											test="${1 == list1.buyState_state }">
											<input class="btn_cancel" type="button" value="주문취소">
										</c:if> <c:if test="${2 == list1.buyState_state }">
											<a
												href="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=${list1.buyState_expressNum}"
												target="_blank"><input class="btn_adress_num"
												type="button" value="송장번호"> </a>

										</c:if> <c:if test="${3 == list1.buyState_state }">
									배송완료
										<a
												href="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=${list1.buyState_expressNum}"
												target="_blank"><input class="btn_adress_num"
												type="button" value="송장번호"> </a>
											<br>
											<input class="btn_buy_confirm" type="button" value="구매확정">

										</c:if> <c:if test="${4 == list1.buyState_state }">
									구매완료
										<a
												href="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=${list1.buyState_expressNum}"
												target="_blank"><input class="btn_adress_num"
												type="button" value="송장번호"> </a>
										</c:if></td>
								</tr>
							</c:forEach>
						</table>
					</form>
				</div>
				<div class="col-sm-4">
					<nav id="listMenu">
						<ul>
							<li class="infoSub-header"><a id="showMyinfo">내 정보</a></li>
							<li class=""><a id="buyList">주문/배송</a></li>
							<li class=""><a id="myQnAList" onclick="qnaToggle();">문의
									내역 <span class="sbox_arrow_down"></span>
							</a>
								<ul class="inList-group" style="display: none;">
									<li><a id="myproQnAList">상품 문의 내역</a></li>
									<li><a id="myhomeQnAList">일반 문의 내역</a></li>
								</ul></li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div> --%>


	<br>
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>
	<!-- Footer:E -->
</body>
</html>