<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<style type="text/css">
table, table tr, tr td, th {
	border: 1px solid black;
}
</style>
</head>
<body>
	<h1>TEST TABLE</h1>
	<h1><a href="${pageContext.request.contextPath}/">HOME</a></h1>
	<table>
		<tr>
			<td>PRODUCT_NUM</td>
			<td>${list[0].productDTO.product_num}</td>
			<td>PRODUCT_NAME</td>
			<td>${list[0].productDTO.product_name}</td>
			<td>PRODUCT_PRICE</td>
			<td>${list[0].productInfoDTO.productInfo_price}</td>
			<td>PRODUCT_SALERATE</td>
			<td>${list[0].productInfoDTO.productInfo_saleRate}</td>
		</tr>
		<tr>
			<td>PRODUCT_SEARCHWORD</td>
			<td>${list[0].productInfoDTO.productInfo_searchWord}</td>
			<td>PRODUCT_KINDNUM</td>
			<td>${list[0].productKindDTO.kind_num}</td>
		</tr>
		<tr>
			<td>PRODUCT_COLOR</td>
			<td><select>
					<c:forEach var="x" items="${list}">
						<option>${x.productEachDTO.productEach_color}</option>
					</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td>PRODUCT_SIZE</td>
			<td><select>
					<c:forEach var="y" items="${list}">
						<option>${y.productEachDTO.productEach_size} -- ${y.productEachDTO.productEach_each}ea</option>
					</c:forEach>
			</select></td>
			<td>
				<form action="buy" method="post">
					<button id="test_btn_buy">BUY</button>
				</form>
			</td>
			<td><form action="basket" method="post">
					<button id="test_btn_basket">basket</button>
				</form></td>
		</tr>
	</table>

</body>
</html>