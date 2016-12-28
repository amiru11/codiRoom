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

		$("#goCalendar").click(function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/mast/calendar",
				success : function(data) {
					$("#view").empty();
					$("#view").html(data);
					console.log(data);
				}
			});

		});
		mastBuyPay();
		<c:if test="${first_date ==null && last_date == null}">
		today();
		yesterday();
		</c:if>
		btns();
		<c:set var="a" value="0" /> <c:forEach
			var="list1" items="${list}">
			<c:set var="a" value="${a+list1.buyStateDTO.buyState_price}" />
		</c:forEach>
		var x = '${a}';
		x=numberWithCommas(x);
		$(".total_money").text(x+" 원");
	});
	//function ---------------------------------------------------------------------------------
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	function count(yearc, monthc, datec) {
		var ToDay = new Date();
		var nail = new Date(ToDay.getFullYear() - yearc, ToDay.getMonth() - monthc, ToDay.getDate() - datec);
		var nailyear = nail.getFullYear();
		var nailmon = (nail.getMonth() + 1) > 9 ? '' + (nail.getMonth() + 1) : '0' + (nail.getMonth() + 1);
		var nailday = nail.getDate() > 9 ? '' + nail.getDate() : '0' + nail.getDate();
		var nailchan_val = nailyear + '-' + nailmon + '-' + nailday;
		$("#in_first_date").val(nailchan_val);
	}
	function yesterday() {
		var ToDay = new Date();
		var nail = new Date(ToDay.getFullYear(), ToDay.getMonth(), ToDay.getDate() - 1);
		var nailyear = nail.getFullYear();
		var nailmon = (nail.getMonth() + 1) > 9 ? '' + (nail.getMonth() + 1) : '0' + (nail.getMonth() + 1);
		var nailday = nail.getDate() > 9 ? '' + nail.getDate() : '0' + nail.getDate();
		var nailchan_val = nailyear + '-' + nailmon + '-' + nailday;
		$("#in_first_date").val(nailchan_val);
	}
	function today() {
		var now = new Date();
		var year = now.getFullYear();
		var mon = (now.getMonth() + 1) > 9 ? '' + (now.getMonth() + 1) : '0' + (now.getMonth() + 1);
		var day = now.getDate() > 9 ? '' + now.getDate() : '0' + now.getDate();
		var chan_val = year + '-' + mon + '-' + day;
		$("#in_last_date").val(chan_val);
	}

	function mastBuyPay() {
		$("#btn_date_submit").click(function() {
			alert(123123);
			if ($("#in_first_date").val() == "" || $("#in_last_date").val() == "") {
				alert("날짜를 선택해 주세요");
			}
			if ($("#in_first_date").val() > $("#in_last_date").val()) {
				alert("앞의 날짜가 뒤의 날짜보다 빨라야합니다")
			}
			if ($("#in_first_date").val() != "" && $("#in_last_date").val() != "" && $("#in_first_date").val() < $("#in_last_date").val()) {

				$("#id_mast_buy_pay_frm").submit();
			}
		})

	}
	function btns() {
		$("#btn_today").click(function() {
			count(0, 0, 1);
			$("#id_mast_buy_pay_frm").submit();
		})
		$("#btn_3day").click(function() {
			count(0, 0, 3);
			$("#id_mast_buy_pay_frm").submit();
		})
		$("#btn_week").click(function() {
			count(0, 0, 7);
			$("#id_mast_buy_pay_frm").submit();
		})
		$("#btn_month").click(function() {
			count(0, 1, 0);
			$("#id_mast_buy_pay_frm").submit();
		})
		$("#btn_halfyear").click(function() {
			count(0, 6, 0);
			$("#id_mast_buy_pay_frm").submit();
		})
		$("#btn_year").click(function() {
			count(1, 0, 0);
			$("#id_mast_buy_pay_frm").submit();
		})
		$("#btn_3year").click(function() {
			count(3, 0, 0);
			$("#id_mast_buy_pay_frm").submit();
		})
		$("#btn_all").click(function() {
			$("#in_first_date").removeAttr("name");
			$("#in_last_date").removeAttr("name");
			$("#id_mast_buy_pay_frm").submit();
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
						<input id="btn_today" type="button" value="오늘"> <input
							id="btn_3day" type="button" value="3일"> <input
							id="btn_week" type="button" value="일주일"> <input
							id="btn_month" type="button" value="한달"> <input
							id="btn_halfyear" type="button" value="반년"> <input
							id="btn_year" type="button" value="1년"> <input
							id="btn_3year" type="button" value="3년"> <input id="btn_all"
							type="button" value="ALL">
						<form id="id_mast_buy_pay_frm" method="post"
							action="${pageContext.request.contextPath}/mast/mastBuyListPay">

							<input id="in_first_date" type="date" name="first_date"
								value=<c:if test="${first_date != null}">
							"${first_date}"
							</c:if>>
							<input id="in_last_date" type="date" name="last_date"
								value=<c:if test="${last_date != null}">
							"${last_date}"
							</c:if>>
							<input id="btn_date_submit" type="button" value="SEARCH">
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
										<td style="text-align: right;">
										 <fmt:formatNumber value="${list1.buyStateDTO.buyState_price}" pattern="#,###" /> 원
										</td>
										<td>${list1.buyStateDTO.buyState_expressNum}</td>
										<td>${list1.buyStateDTO.buyState_result_date}</td>
									</tr>
								</c:forEach>
								<tr>
									<td colspan="5">합계</td>
									<td colspan="5" class="total_money"></td>
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
