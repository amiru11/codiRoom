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
			</tr>
			<c:forEach var="list1" items="${list}">
				<tr>
					<td>${list1.buy_num}</td>
					<td>${list1.product_num}</td>
					<td><a href ="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a></td>
					<td>${list1.buyState_size}</td>
					<td>${list1.buyState_color}</td>
					<td>${list1.buyState_each}</td>
					<td>${list1.buyState_price}</td>

				</tr>
			</c:forEach>
		</table>
	</form>

</body>
</html>
