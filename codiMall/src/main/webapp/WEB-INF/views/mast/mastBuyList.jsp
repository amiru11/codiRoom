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

tr, td, th {
	text-align: center;
}
</style>
<script type="text/javascript">

	/*          function SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS  */

	$(function() {
		$(window).keydown(function() {
			if(47 < event.keyCode &&  event.keyCode <55){
				getBuyList(event.keyCode-48);
				$("#sel_buy_state").val(event.keyCode-48);
			}
		});


		var buyState_state = 1;
		getBuyList(buyState_state);
		$("#sel_buy_state").change(function() {
			buyState_state = $(this).val();
			getBuyList(buyState_state);
		});
		

	});

	/*      function EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE     */


	function numcheck() {
		if ( (event.keyCode == 69) ) {
			event.returnValue = false;
		}
		;
	}
	;

	function getBuyList(buyState_state) {
		$.ajax({
			url : "../json/mastBuyList",
			type : "post",
			dataType : 'json',
			data : {
				buyState_state : buyState_state
			},
			success : function(data) {
				var x = "";
				x = x + "<tr><th>buy_num</th><th>id</th><th>product_num</th><th>product_name</th><th>size</th>";
				x = x + "<th>color</th><th>each</th><th>price</th><th>expressNum</th><th>pay_date</th><th>result_date</th>";
				x = x + "<th>state</th>";
				if (buyState_state == 1) {
					x = x + "<th>state1to2</th>"
				} else if (buyState_state == 2) {
					x = x + "<th>expressNumFix</th></tr>";
				}
				$.each(data.ar, function(index, value) {
					x = x + '<tr class="tr_buy_list">';
					x = x + '<td>' + value.buyDTO.buy_num + '</td>';
					x = x + '<td>' + value.buyDTO.member_id + '</td>';
					x = x + '<td>' + value.productDTO.product_num + '</td>';
					x = x + '<td>' + value.productDTO.product_name + '</td>';
					x = x + '<td>' + value.buyStateDTO.buyState_size + '</td>';
					x = x + '<td>' + value.buyStateDTO.buyState_color + '</td>';
					x = x + '<td>' + value.buyStateDTO.buyState_each + '</td>';
					x = x + '<td>' + value.buyStateDTO.buyState_price + '</td>';
					x = x + '<td>' + value.buyStateDTO.buyState_expressNum + '</td>';
					x = x + '<td>' + value.buyStateDTO.buyState_pay_date + '</td>';
					x = x + '<td>' + value.buyStateDTO.buyState_result_date + '</td>';
					x = x + '<td>' + value.buyStateDTO.buyState_state + '</td>';
					if (buyState_state == 1) {
						x = x + '<td>';
						x = x + '<input class="hid_buy_num" name="buy_num" type="hidden" value="' + value.buyDTO.buy_num + '">';
						x = x + 'expressNum:<input onkeydown="numcheck()" class="inp_expressNum" type="number" name="buyState_expressNum"><Br>';
						x = x + '<input class="btn_add" type="button" value="ADD"></td>';
					} else if (buyState_state == 2) {
						x = x + '<td>';
						x = x + '<input class="hid_buy_num" name="buy_num" type="hidden" value="' + value.buyDTO.buy_num + '">';
						x = x + 'expressNum:<input onkeydown="numcheck()" class="inp_expressNum" type="number" name="buyState_expressNum"><Br>';
						x = x + '<input class="btn_add" type="button" value="ADD">';
						x = x + '<input class="btn_expressConfirm" type="button" value="ExConf"></td>';
					} else if (buyState_state == 3) {
						x = x + '<td>';
						x = x + '<input class="hid_buy_num" name="buy_num" type="hidden" value="' + value.buyDTO.buy_num + '">';
						x = x + '<input class="btn_BuyConfirm" type="button" value="BuyConf"><br>';
						x = x + 'expressNum:<input onkeydown="numcheck()" class="inp_expressNum" type="number" name="buyState_expressNum"><Br>';
						x = x + '<input class="ReFund" type="button" value="ReFund"></td>';
					} else if (buyState_state == 5) {
						x = x + '<td>';
						x = x + '<input class="hid_buy_num" name="buy_num" type="hidden" value="' + value.buyDTO.buy_num + '">';
						x = x + 'expressNum:<input onkeydown="numcheck()" class="inp_expressNum" type="number" name="buyState_expressNum"><Br>';
						x = x + '<input class="ReFundConfirm" type="button" value="ReFundConf"></td>';
					}
					x = x + '</tr>';
				});
				$("#table_buy_list").html(x);

				$(".tr_buy_list").mouseenter(function() {
					var thisTr = $(this);
					$(thisTr).find(".btn_add").click(function() {
						if ($(thisTr).find(".inp_expressNum").val() != "") {
							var buy_num = $(thisTr).find(".hid_buy_num").val();
							var buyState_expressNum = $(thisTr).find(".inp_expressNum").val();
							alert(buy_num);
							alert(buyState_state);
							alert(buyState_expressNum);
							mastUpState(buy_num, buyState_state, buyState_expressNum);
						} else {
							alert("송장번호를 입력해주세요");
						}
					});
					$(thisTr).find(".btn_expressConfirm").click(function(){
						var buy_num = $(thisTr).find(".hid_buy_num").val();
						mastUpState(buy_num, buyState_state, 0);
					});
	
				});
				$(".tr_buy_list").mouseleave(function() {
					var thisTr = $(this);
					$(thisTr).find(".btn_add").off("click");
					$(thisTr).find(".btn_expressConfirm").off("click");
				});
				$(".inp_expressNum").focus(function(){
					$(window).off('keydown');
				});
				$(".inp_expressNum").blur(function(){
					$(window).keydown(function() {
						if(47 < event.keyCode &&  event.keyCode <55){
							getBuyList(event.keyCode-48);
							$("#sel_buy_state").val(event.keyCode-48);
						}
					});
				});

			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});

	}

	function mastUpState(buy_num, buyState_state, buyState_expressNum) {
		$.ajax({
			url : "../json/mastUpState",
			type : "post",
			data : {
				buyState_state : buyState_state,
				buy_num : buy_num,
				buyState_expressNum : buyState_expressNum
			},
			success : function(data) {
				alert(data);
				var a = 1;
				if (data > 0) {
					alert("success");
					getBuyList(buyState_state * 1 + 1);
					if (buyState_state == 2) {
						a--;
					}
					$("#sel_buy_state").val(buyState_state * 1 + a);
				} else {
					alert("fail");
					getBuyList(buyState_state * 1 + 1);
					$("#sel_buy_state").val(buyState_state * 1);
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
</script>
</head>
<body>
	<h1>BUYLIST</h1>
	<h1>
		<a href="${pageContext.request.contextPath}/">HOME</a>
	</h1>
	<select id="sel_buy_state" name="buy_state">
		<option value="1">1배송준비</option>
		<option value="2">2배송중</option>
		<option value="3">3배송완료</option>
		<option value="4">4판매완료</option>
		<option value="0">all</option>
		<option value="5">5환불중</option>
		<option value="6">6환불완료</option>
	</select>
	<table id="table_buy_list">
		<%-- <tr>
			<th>buy_num</th>
			<th>id</th>
			<th>product_num</th>
			<th>product_name</th>
			<th>size</th>
			<th>color</th>
			<th>each</th>
			<th>price</th>
			<th>expressNum</th>
			<th>pay_date</th>
			<th>result_date</th>
			<th>state</th>
			<th>state1to2</th>
			<th>expressNumFix</th>	
		</tr>
		<c:forEach items="${list}" var="list1">
			<tr class="tr_buy_list">
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
				<td><form
						action="${pageContext.request.contextPath}/mast/buyState1to2"
						method="post">
						<input class="hid_buy_num" type="hidden"
							value="${list1.buyDTO.buy_num}" name="buy_num">
						expressNum:<input type="number" name="buyState_expressNum"><Br>
						<input class="btn_add" type="button" value="ADD">
					</form></td>
				<td><form
						action="${pageContext.request.contextPath}/mast/expressNumFix"
						method="post">
						<input class="hid_buy_num" type="hidden"
							value="${list1.buyDTO.buy_num}" name="buy_num">
						expressNum:<input type="number" name="buyState_expressNum"><Br>
						<input class="btn_add" type="button" value="ADD">
					</form></td>
			</tr>
		</c:forEach> --%>
	</table>

</body>
</html>
