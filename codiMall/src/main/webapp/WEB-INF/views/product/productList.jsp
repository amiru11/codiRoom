<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<style type="text/css">
table, table tr, tr td, th {
	border: 1px solid black;
}
</style>
</head>
<body>
<h1><a href="${pageContext.request.contextPath}/">HOME</a></h1>
	<table>
		<tr>
			<th>01</th>
			<th>02</th>
			<th>03</th>
			<th>04</th>
			<th>05</th>
			<th>06</th>
			<th>07</th>
		</tr>
		<c:forEach var="list1" items="${list}">
			<tr>
				<td>${list1.product_num}</td>
				<td>${list1.product_name}</td>
				<td>${list1.productinfo_price}</td>
				<td>${list1.productinfo_rec_date}</td>
				<td>${list1.productinfo_reg_date}</td>
				<td>${list1.productinfo_salerate}</td>
				<td>${list1.productinfo_searchword}</td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>
