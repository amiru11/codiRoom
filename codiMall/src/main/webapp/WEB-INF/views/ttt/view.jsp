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
<script type="text/javascript">
	$(function() {

		$("#test_sel_c").click(function() {
			$("#test_inh_proc").val($(this).val());
		});
		$("#test_sel_c").blur(function() {
			$("#test_inh_proc").val($(this).val());
		});
		$("#test_sel_s").click(function() {
			$("#test_inh_pros").val($(this).val());
		});
		$("#test_sel_s").blur(function() {
			$("#test_inh_pros").val($(this).val());
		});
		$("#test_btn_basket").click(function() {
			$("#test_inh_proe").val($("#test_inp_proe").val());

			if ($("#test_inp_proe").val() > 0) {
				$("#test_inh_proe").val($("#test_inp_proe").val());
				$("#bas_frm").submit();
			}else{
				alert("수량입력");
			}
		})
	});
</script>
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
			<td><select id="test_sel_c" name="productEach_color">
					<c:forEach var="x" items="${list}">
						<option value="${x.productEachDTO.productEach_color}">${x.productEachDTO.productEach_color}</option>
					</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td>PRODUCT_SIZE</td>
			<td><select id="test_sel_s" name="productEach_size">
					<c:forEach var="y" items="${list}">
						<option value="${y.productEachDTO.productEach_size}">${y.productEachDTO.productEach_size}
							-- ${y.productEachDTO.productEach_each}ea</option>
					</c:forEach>
			</select></td>
			<td><input id="test_inp_proe" type="number" value="0"
				name="productEach_each"></td>
			<td>
				<form action="buy" method="post">

					<input type="button" value="BUY" id="test_btn_buy">
				</form>
			</td>
			<td><form id="bas_frm" action="basket" method="post">
					<input type="text" value="${list[0].productDTO.product_num}"
						name="product_num"> <input id="test_inh_pros"
						type="text" value="" name="basketInfo_size"> <input
						id="test_inh_proc" type="text" value="" name="basketInfo_color">
					<input id="test_inh_proe" type="text" value=""
						name="basketInfo_each">
					<input type="button" value="BASKET" id="test_btn_basket">
				</form></td>
		</tr>
	</table>

</body>
</html>