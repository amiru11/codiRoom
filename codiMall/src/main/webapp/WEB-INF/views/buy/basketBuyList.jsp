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

tr {
	
}

tr:FIRST-OF-TYPE {
	height: 10px;
}

.bas_td_second {
	width: 200px;
}

.bas_td_inp_each {
	width: 100px;
}

td:LAST-OF-TYPE {
	width: 200px;
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
	<h1>BASKET</h1>
	<h1>
		<a href="${pageContext.request.contextPath}/">HOME</a>
	</h1>
	<form id="tab_form" method="post">
		<table>
			<tr>
				<th class="bas_th_01">01</th>
				<th class="bas_th_02">02</th>
				<th class="bas_th_03">03</th>
				<th class="bas_th_04">04</th>
				<th class="bas_th_05">05</th>
				<th class="bas_th_06">06</th>
				<th class="bas_th_07">07</th>
			</tr>
			<c:forEach var="list1" items="${list}">
				<tr>
					<td><input type="hidden" name="basket_num"  value="${list1.basket_num}"><input type="hidden" name="product_num"  value="${list1.product_num}"><a
						href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a></td>
					<td><input type="hidden" name=""  value="${list1.productInfo_price}">${list1.productInfo_price}</td>
					<td><input type="hidden" name=""  value="${list1.productInfo_saleRate}">${list1.productInfo_saleRate}</td>
					<td><input type="hidden" name=""  value="${list1.basketInfo_size}">${list1.basketInfo_size}</td>
					<td><input type="hidden" name=""  value="${list1.basketInfo_color}">${list1.basketInfo_color}</td>
					<td><input type="hidden" name=""  value="${list1.basketInfo_each}">${list1.basketInfo_each}</td>
					<td><c:set var="number"
							value="${list1.productInfo_price*list1.basketInfo_each*(100-list1.productInfo_saleRate)/100}" />
						<fmt:parseNumber var="total" value="${number}" type="number"
							integerOnly="true" />${total}</td>
				</tr>
			</c:forEach>
		</table>
		<input type="button" value="구매하기" id="btn_buy">
	</form>

</body>
</html>
