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
<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "../json/allProductSize",
			type : "post",
			dataType : 'json',
			data : {
			},
			success : function(data) {
				$("#div_ck_size").html("");
				var x = "";
				$.each(data.sizeList, function(index, value) {
					x = x + value + '<input type="checkbox" value="' + value + '" name="size"><BR>'
				});
				$("#div_ck_size").html(x);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});

		$.ajax({
			url : "../json/allProductColor",
			type : "post",
			dataType : 'json',
			data : {
			},
			success : function(data) {
				$("#div_ck_color").html("");
				var x = "";
				$.each(data.colorList, function(index, value) {
					x = x + value + '<input type="checkbox" value="' + value + '" name="color"><BR>'
				});
				$("#div_ck_color").html(x);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});

		$.ajax({
			url : "../json/allKindNum",
			type : "post",
			dataType : 'json',
			data : {
			},
			success : function(data) {
				$("#div_ck_kind").html("");
				var x = "";
				$.each(data.kindNumList, function(index, value) {
					x = x + value + '<input type="checkbox" value="' + value + '" name="kind_num"><BR>'
				});
				$("#div_ck_kind").html(x);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});

	});
</script>

</head>
<body>
	<h1>
		<a href="${pageContext.request.contextPath}/">HOME</a>
	</h1>
	<table>
		<tr>
			<th>01</th>
			<th>02</th>
			<th>03</th>
		</tr>
		<c:forEach var="list1" items="${list}">
			<tr>
				<td>${list1.product_num}</td>
				<td><a
					href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a></td>
				<td>${list1.productInfo_price}</td>
			</tr>
		</c:forEach>
	</table>
	<form action="${pageContext.request.contextPath}/product/productList"
		method="get">
		curPage : <input type="number" name="curPage"><br>
		perPage : <input type="number" name="perPage"><br> <select
			name="sel"><option value="1">최신순</option>
			<option value="2">먼저나온순</option>
			<option value="3">최저가순</option>
			<option value="4">최고가순</option></select>
		<div id="div_out_search_select">
		KIND<br>
			<div id="div_ck_kind"
				style="width: 200px; height: 100px; overflow: scroll;"></div>
				SIZE<BR>
			<div id="div_ck_size"
				style="width: 200px; height: 100px; overflow: scroll;"></div>
				COLOR<br>
			<div id="div_ck_color"
				style="width: 200px; height: 100px; overflow: scroll;"></div>
		</div>

		<button>SUBMIT</button>

	</form>

</body>
</html>
