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
<body class="home">
	<table>
		<tr>
			<th>01</th>
			<th>02</th>
		</tr>
		<c:forEach var="list1" items="${list}">
			<tr>
				<td>${list1.product_num}</td>
				<td>${list1.product_name}</td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>
