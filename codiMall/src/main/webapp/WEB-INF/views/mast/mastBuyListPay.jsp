<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/css/mast/mast.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/font-awesome/css/font-awesome.min.css">
<script src="${pageContext.request.contextPath}/resources/js/mast.js"></script>

<style type="text/css">
table, table tr, tr td, th {
	border: 1px solid black;
}
</style>
<script type="text/javascript">

	$(function() {
		$("#goCalendar").click(function(){
			$.ajax({
				
				url : "${pageContext.request.contextPath}/mast/calendar",
				success : function(data){
					$("#view").empty();
					$("#view").html(data);
					console.log(data);
				}
			});
			
		});	
		mastBuyPay();
		

		
		
	});
	
	function mastBuyPay(){
		$("#btn_date_submit").click(function(){
			alert(123123);
			if($("#in_first_date").val()=="" || $("#in_last_date").val()==""){
				alert("날짜를 선택해 주세요");
			}
			if($("#in_first_date").val()>$("#in_last_date").val()){
				alert("앞의 날짜가 뒤의 날짜보다 빨라야합니다")
			}
			if($("#in_first_date").val() != "" && $("#in_last_date").val() != ""&& $("#in_first_date").val() < $("#in_last_date").val() ){
				
				$("#id_mast_buy_pay_frm").submit();
			}
		})
		
	}


</script>
<style type="text/css">
.nav>li>a.side-btn {
	color: #91a7c6;
	padding: 0;
	line-height: 50px;
	height: 50px;
	overflow: hidden;
	cursor: pointer;
	font-size: 18px;
}
</style>
</head>
<body style="height: 1200px;">
	<div class="container-fluid" style="padding: 0; height: 100%">
		<div class="row" style="height: 100%;">
			<div class="col-sm-2" style="height: 100%;">
				<%@ include file="/resources/temp/mast/sideBar.jspf"%>
			</div>
			<div class="com-sm-8" style="margin: 20px; height: 100%;">
				<div class="container">
					<div id="view">
						<input type="button" value="오늘"> <input type="button"
							value="3일"> <input type="button" value="일주일"> <input
							type="button" value="한달"> <input type="button" value="반년">
						<input type="button" value="1년"> <input type="button"
							value="3년"> <input type="button" value="ALL">
						<form id="id_mast_buy_pay_frm" method="post"
							action="${pageContext.request.contextPath}/mast/mastBuyListPay">
							<input id="in_first_date" type="date" name="first_date">
							<input id="in_last_date" type="date" name="last_date"> <input
								id="btn_date_submit" type="button" value="SEARCH">
						</form>
						<div id="div_listM">
				<table id="table_buy_pay_list">
					<tr>
						<th>ID</th>
						<th>P.NUM</th>
						<th>P.NAME</th>
						<th>B.NUM</th>
						<th>SIZE</th>
						<th>COLOR</th>
						<th>EACH</th>
						<th>PRICE</th>
						<th>EXPRESSNUM</th>
						<th>RESULTDATE</th>
					</tr>
					<c:forEach var="list1" items="${list}">
						<tr>
							<td>${list1.buyDTO.member_id}</td>
							<td>${list1.productDTO.product_num}</td>
							<td>${list1.productDTO.product_name}</td>
							<td>${list1.buyStateDTO.buy_num}</td>
							<td>${list1.buyStateDTO.buyState_size}</td>
							<td>${list1.buyStateDTO.buyState_color}</td>
							<td>${list1.buyStateDTO.buyState_each}</td>
							<td>${list1.buyStateDTO.buyState_price}</td>
							<td>${list1.buyStateDTO.buyState_expressNum}</td>
							<td>${list1.buyStateDTO.buyState_result_date}</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="5">합계</td>
						<td colspan="5"><c:set var="a" value="0" /> <c:forEach
								var="list1" items="${list}">
								<c:set var="a" value="${a+list1.buyStateDTO.buyState_price}" />
							</c:forEach>${a}원</td>
					</tr>

				</table>



			</div>


					</div>
				</div>
			</div>
			
		</div>

	</div>

</body>
</html>
