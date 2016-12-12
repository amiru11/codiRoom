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
	$(function() {});
</script>
</head>
<body>
	<h1>BASKET</h1>
	<h1>
		<a href="${pageContext.request.contextPath}/">HOME</a>
	</h1>
	<form id="tab_form" action="${pageContext.request.contextPath}/buy/nonBasketBuy" method="post">

		<table>

			<tr>
				<th class="buy_th_01">01</th>
				<th class="buy_th_02">02</th>
				<th class="buy_th_03">03</th>
				<th class="buy_th_04">04</th>
				<th class="buy_th_05">05</th>
				<th class="buy_th_06">06</th>
				<th class="buy_th_07">07</th>
			</tr>
			<tr>
				<td>${list.product_num}</td>
				<td><a href="${pageContext.request.contextPath}/product/productView?product_num=${list.product_num}">${list.product_name}</a></td>
				<td>${list.productInfo_price}</td>
				<td>${list.productInfo_saleRate}</td>
				<td>${list.productSize_size}</td>
				<td>${list.productEach_color}</td>
				<td>${list.productEach_each}
				<input type="hidden" value="${list.product_num}" name="product_num">
				<input type="hidden" value="${list.productInfo_price}" name="productInfo_price">
				<input type="hidden" value="${list.productInfo_saleRate}" name="productInfo_saleRate">
				<input type="hidden" value="${list.productSize_size}" name="productSize_size">
				<input type="hidden" value="${list.productEach_color}" name="productEach_color">
				<input type="hidden" value="${list.productEach_each}" name="productEach_each">
				</td>
			</tr>

		</table>
		<button>구매하기</button>
	</form>
</body>
</html>
