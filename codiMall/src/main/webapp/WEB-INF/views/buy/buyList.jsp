<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<style type="text/css">
table, table tr, tr td, th {
	border: 1px solid black;
}
</style>
<script type="text/javascript">

	$(function() {

		$(".buy_tr_ds").mouseenter(function() {
			var thistr = $(this);

			$(".btn_cancel").click(function() {
				$(thistr).find(".inh_buy_num").removeAttr("disabled", "disabled");
				$("#tab_form").attr("action", "${pageContext.request.contextPath}/buy/cancelBuy");
				$("#tab_form").submit();
			});
			
			$(".btn_buy_confirm").click(function(){
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
</head>
<body>
	<h1>BUYLIST</h1>
	<h1>
		<a href="${pageContext.request.contextPath}/">HOME</a>
	</h1>
	<form id="tab_form" method="post">
		<table>
			<tr>
				<th class="buy_th_01">01</th>
				<th class="buy_th_02">02</th>
				<th class="buy_th_03">03</th>
				<th class="buy_th_04">04</th>
				<th class="buy_th_05">05</th>
				<th class="buy_th_06">06</th>
				<th class="buy_th_07">07</th>
				<th class="buy_th_08">08</th>
			</tr>
			<c:forEach var="list1" items="${list}">
				<tr class="buy_tr_ds">
					<td><input class="inh_buy_num" type="hidden"
						value="${list1.buy_num}" name="buy_num" disabled="disabled">${list1.buy_num}</td>
					<td>${list1.product_num}</td>
					<td><a
						href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a></td>
					<td>${list1.buyState_size}</td>
					<td>${list1.buyState_color}</td>
					<td>${list1.buyState_each}</td>
					<td>${list1.buyState_price}</td>
					<td><c:if test="${1 == list1.buyState_state }">
							<input class="btn_cancel" type="button" value="주문취소">
						</c:if> <c:if test="${2 == list1.buyState_state }">
							<a href="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=${list1.buyState_expressNum}" target="_blank"><input class="btn_adress_num" type="button" value="송장번호">
							</a>	

						</c:if> <c:if test="${3 == list1.buyState_state }">
						배송완료
							<a href="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=${list1.buyState_expressNum}" target="_blank"><input class="btn_adress_num" type="button" value="송장번호">
							</a>	
							<br>
							<input class="btn_buy_confirm" type="button" value="구매확정">

						</c:if> <c:if test="${4 == list1.buyState_state }">
						구매완료
							<a href="https://www.doortodoor.co.kr/parcel/doortodoor.do?fsp_action=PARC_ACT_002&fsp_cmd=retrieveInvNoACT&invc_no=${list1.buyState_expressNum}" target="_blank"><input class="btn_adress_num" type="button" value="송장번호">
							</a>				
						</c:if></td>
				</tr>
			</c:forEach>
		</table>
	</form>

</body>
</html>
