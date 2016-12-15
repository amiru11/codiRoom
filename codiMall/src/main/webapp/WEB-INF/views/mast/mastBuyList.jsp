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
tr,td,th{
text-align: center;
}
</style>
<script type="text/javascript">

	$(function() {});
</script>
</head>
<body>
	<h1>BUYLIST</h1>
	<h1>
		<a href="${pageContext.request.contextPath}/">HOME</a>
	</h1>
	<table>
		<tr>
			<th>buy_num</th>
			<th>member_id</th>
			<th>product_num</th>
			<th>product_name</th>
			<th>buyState_size</th>
			<th>buyState_color</th>
			<th>buyState_each</th>
			<th>buyState_price</th>
			<th>buyState_expressNum</th>
			<th>buyState_pay_date</th>
			<th>buyState_result_date</th>
			<th>buyState_state</th>
		</tr>
		<c:forEach items="${list}" var="list1">
			<tr>
				<td>${list1.buyDTO.buy_num}</td>
				<td>${list1.buyDTO.member_id}</td>
				<td>${list1.productDTO.product_num}</td>
				<td>${list1.productDTO.product_name}</td>
				<td>${list1.buyStateDTO.buyState_size}</td>
				<td>${list1.buyStateDTO.buyState_color}</td>
				<td>${list1.buyStateDTO.buyState_each}</td>
				<td>${list1.buyStateDTO.buyState_price}</td>
				<td>${list1.buyStateDTO.buyState_expressNum}</td>
				<td>${list1.buyStateDTO.buyState_pay_date}</td>
				<td>${list1.buyStateDTO.buyState_result_date}</td>
				<td>${list1.buyStateDTO.buyState_state}</td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>
