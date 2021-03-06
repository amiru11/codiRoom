<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
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
<style type="text/css">
#buy_tit {
	width: 180px;
	background: url(/codi/resources/images/basket/hgroup_img.gif) no-repeat
		0 0;
	background-position: -600px 0px;
	text-indent: -9999px;
}
</style>
<script type="text/javascript">

	$(function() {
		var message = "${message}";
		if (message != "") {
			alert(message);
		}
		$(".buy_tr_ds").mouseenter(function() {
			var thistr = $(this);

			$(".btn_cancel").click(function() {
				$(thistr).find(".inh_buy_num").removeAttr("disabled", "disabled");
				$("#tab_form").attr("action", "${pageContext.request.contextPath}/buy/cancelBuy");
				$("#tab_form").submit();
			});

			$(".btn_buy_confirm").click(function() {
				$(thistr).find(".inh_buy_num").removeAttr("disabled", "disabled");
				$("#tab_form").attr("action", "${pageContext.request.contextPath}/buy/buyConfirm");
				$("#tab_form").submit();
			});

		});
		$(".buy_tr_ds").mouseleave(function() {
			$(".btn_cancel").off('click');
			$(".btn_buy_confirm").off('click');
			$(".btn_adress_num").off('click');
		});
	});
</script>


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
					<div style="display: inline-block; margin-top: 20px; float: left;">
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
							target="_blank"><input class="btn_adress_num" type="button"
							value="송장번호"> </a>

					</c:if> <c:if test="${3 == list1.buyState_state }">
									배송완료
										<a
							href="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=${list1.buyState_expressNum}"
							target="_blank"><input class="btn_adress_num" type="button"
							value="송장번호"> </a>
						<br>
						<input class="btn_buy_confirm" type="button" value="구매확정">

					</c:if> <c:if test="${4 == list1.buyState_state }">
									구매완료
										<a
							href="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=${list1.buyState_expressNum}"
							target="_blank"><input class="btn_adress_num" type="button"
							value="송장번호"> </a>
					</c:if> <c:if test="${5 == list1.buyState_state }">
									환불중
											
									</c:if> <c:if test="${6 == list1.buyState_state }">
									환불완료			
									</c:if></td>
			</tr>
			<c:set var="addd0" value="${list1.buyState_address}" />
			<c:set var="addd1"
				value="${fn:substring(addd0,0,fn:indexOf(addd0,'_-_'))}" />
			<c:set var="addd2"
				value="${fn:substring(addd0,fn:indexOf(addd0,'_-_')+3,fn:length(addd0)) }" />
			<c:set var="addd3"
				value="${fn:substring(addd2,0,fn:indexOf(addd2,'_-_'))}" />
			<c:set var="addd4"
				value="${fn:substring(addd2,fn:indexOf(addd2,'_-_')+3,fn:length(addd2)) }" />
			<c:set var="addd5"
				value="${fn:substring(addd4,0,fn:indexOf(addd4,'_-_'))}" />
			<c:set var="addd6"
				value="${fn:substring(addd4,fn:indexOf(addd4,'_-_')+3,fn:length(addd4)) }" />
			<c:set var="addd7"
				value="${fn:substring(addd6,0,fn:indexOf(addd6,'_-_'))}" />
			<c:set var="addd8"
				value="${fn:substring(addd6,fn:indexOf(addd6,'_-_')+3,fn:length(addd6)) }" />
			<c:set var="addd9"
				value="${fn:substring(addd8,0,fn:indexOf(addd8,'_-_'))}" />




			<tr>
				<td colspan="8"><input id="i1" type="text" readonly="readonly"
					value="${addd1}"style="width: 50px;"> <input id="i3" type="text"
					readonly="readonly" value="${addd3}" style="width: 30px;"> <input id="i5"
					type="text" readonly="readonly" value="${addd5}" style="width: 100px;"> <input
					id="i5" type="text" readonly="readonly" value="${addd7}"> <input
					id="i5" type="text" readonly="readonly" value="${addd9}"></td>
			</tr>
		</c:forEach>
	</table>
</form>

