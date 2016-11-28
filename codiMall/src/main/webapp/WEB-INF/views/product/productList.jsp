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
		</tr>
		<c:forEach var="list1" items="${list}">
			<tr>
				<td>${list1.product_num}</td>
				<td>${list1.product_name}</td>
				<td>${list1.productInfo_price}</td>
			</tr>
		</c:forEach>
	</table>
	<form action="${pageContext.request.contextPath}/product/productList" method="get">
	curPage : <input type="number" name="curPage"><br>
	perPage : <input type="number" name="perPage"><br>
	sel : <input type="number" name="sel"><br>
	kind_num1 : <input type="checkbox" value="1" name="kind_num">
	kind_num2 : <input type="checkbox" value="2" name="kind_num">
	kind_num3 : <input type="checkbox" value="3" name="kind_num"><br>
	color_red : <input type="checkbox" value="RED" name="color">
	color_orange : <input type="checkbox" value="ORANGE" name="color">
	color_yellow : <input type="checkbox" value="YELLOW" name="color"><br>
	color_green : <input type="checkbox" value="GREEN" name="color">
	color_blue : <input type="checkbox" value="BLUE" name="color">
	color_navy : <input type="checkbox" value="NAVY" name="color"><br>
	color_grape : <input type="checkbox" value="GRAPE" name="color"><br>
	size_s : <input type="checkbox" value="s" name="size">
	size_m : <input type="checkbox" value="m" name="size">
	size_l : <input type="checkbox" value="l" name="size"><br>
	<button>SUBMIT</button>
	
	</form>

</body>
</html>
