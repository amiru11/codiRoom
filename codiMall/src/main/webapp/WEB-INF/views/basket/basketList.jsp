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
		$(".bas_tr_jq").on("click",".bas_sel_color",function(){
		})

		/* $(".bas_tr_jq").mouseenter(function(){
			
			$(".bas_sel_color").on("click");
		})
		$(".bas_tr_jq").mouseleave(function(){
			
			$(".bas_sel_color").off("click");
		}) */
		
		
		
	})
</script>
</head>
<body>
	<h1>BASKET</h1>
	<h1>
		<a href="${pageContext.request.contextPath}/">HOME</a>
	</h1>
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
			<tr class="bas_tr_jq">
				<td class="bas_td_bas_num">${list1.basket_num}</td>
				<td><a
					href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a></td>
				<td>${list1.productInfo_price}</td>
				<td>${list1.productInfo_saleRate}</td>

				<td><select class="bas_sel_color"><c:forEach var="list3"
							items="${list1.productEachDTOs}">
							<option value="${list3.productEach_color}">${list3.productEach_color}</option>
						</c:forEach></select> ${list1.basketInfo_color}</td>
				<td><select class="bas_sel_size">
						<c:forEach var="list2" items="${list1.productEachDTOs}">
							<option value="${list2.productEach_size}">${list2.productEach_size}</option>
						</c:forEach>
				</select> ${list1.basketInfo_size}</td>
				<td><select class="bask_sel_each"><c:forEach var="list4"
							items="${list1.productEachDTOs}">
							<option class="bas_op_each">
								${list4.productEach_color}_${list4.productEach_size}_${list4.productEach_each}</option>
						</c:forEach></select></td>
			</tr>
		</c:forEach>
	</table>

</body>
</html>
