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

tr {
	
}

tr:FIRST-OF-TYPE {
	height: 10px;
}

.bas_td_second {
	width: 200px;
}

.bas_td_inp_each {
	width: 100px;
}

td:LAST-OF-TYPE {
	width: 200px;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#btn_allDel").click(function() {
			$(".bas_td_check").prop("checked", true);
			$(".bas_td_check").attr('checked', true);
			$("#tab_form").attr("action","${pageContext.request.contextPath}/basket/basketDel");
			$("#tab_form").submit();
		})
		
		$("#btn_checkDel").click(function() {
			if ($(".bas_td_check:checked").length == 0) {
				alert("1개이상 체크하세요");
			}else{
			$("#tab_form").attr("action","${pageContext.request.contextPath}/basket/basketDel");
			$("#tab_form").submit();
			}

		})


		$("#allCheck").change(function() {
			if ($("#allCheck").prop("checked")) {
				$(".bas_td_check").prop("checked", true);
				$(".bas_td_check").attr('checked', true);
			} else {
				$(".bas_td_check").prop("checked", false);
				$(".bas_td_check").attr('checked', true);

			}
		});
		$(".bas_td_check").change(function() {
			$("#allCheck").prop("checked", false);
			if ($(".bas_td_check:checked").length == $(".bas_td_check").length) {
				$("#allCheck").prop("checked", true);
			}

		});


		$(".bas_tr_jq").mouseenter(function() {
			var thisTr = $(this);
			thisTr.find(".bas_td_sel_size").on("change", function() {
				var optionSize = thisTr.find(".bas_td_sel_size option").size();
				var selSize = thisTr.find(".bas_td_sel_size").val();
				thisTr.find(".bas_td_sel_color").css("display", "none");
				thisTr.find(".bas_td_sel_color[name=" + selSize + "]").css("display", "inline-block");
			});

			thisTr.find(".btn_fix").on("click", function() {
				var selSize = thisTr.find(".bas_td_sel_size").val();
				var selColor = thisTr.find(".bas_td_sel_color[name=" + selSize + "]").val();
				var each = thisTr.find(".bas_td_inp_each").val();
				var basket_num = thisTr.find(".bas_td_bas_num").text();
				var product_num = thisTr.find(".bas_td_hid_pronum").val();

				$("#basket_num").val(basket_num);
				$("#product_num").val(product_num);
				$("#basketInfo_size").val(selSize);
				$("#basketInfo_color").val(selColor);
				$("#basketInfo_each").val(each);


				$("#basketFixFrm").submit();
			});

			thisTr.find(".bas_td_inp_each").focus(function() {
				$(this).keydown(function() {
					numcheck();
					productEachGet(thisTr);
				});
				$(this).keyup(function() {
					numcheck();
					productEachGet(thisTr);
				});
				$(this).keyblur(function() {
					numcheck();
					productEachGet(thisTr);
				});
			})

		});

	});
	function productEachGet(thisTr) {
		var product_num = thisTr.find(".bas_td_hid_pronum").val();
		var selSize = thisTr.find(".bas_td_sel_size").val();
		var selColor = thisTr.find(".bas_td_sel_color[name=" + selSize + "]").val();
		$.ajax({
			url : "../json/productEachGet",
			type : "post",
			data : {
				product_num : product_num,
				productSize_size : selSize,
				productEach_color : selColor
			},
			success : function(data) {
				if (thisTr.find(".bas_td_inp_each").val() > data) {
					alert("재고초과");
					thisTr.find(".bas_td_inp_each").val(data);
				}
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	function numcheck()  {  
		  if ((event.keyCode==69))  {
		      event.returnValue=false;
		  }       
		 }
</script>
</head>
<body>
	<h1>BASKET</h1>
	<h1>
		<a href="${pageContext.request.contextPath}/">HOME</a>
	</h1>
	<form id="tab_form" method="post">

		<table>

			<tr>
				<th class="bas_th_01">전체선택<input type="checkbox" id="allCheck"></th>
				<th class="bas_th_02">02</th>
				<th class="bas_th_03">03</th>
				<th class="bas_th_04">04</th>
				<th class="bas_th_05">05</th>
				<th class="bas_th_06">06</th>
				<th class="bas_th_07">07</th>
				<th class="bas_th_08">08</th>
				<th class="bas_th_09">09</th>

			</tr>
			<c:forEach var="list1" items="${list}">

				<tr class="bas_tr_jq">
					<td><input type="checkbox" value="${list1.basket_num}"
						name="del_basket_num" class="bas_td_check"></td>
					<td class="bas_td_bas_num"><input type="hidden"
						value="${list1.basket_num}" name="basket_num">${list1.basket_num}</td>
					<td class="bas_td_second"><input type="text"
						class="bas_td_hid_pronum" value="${list1.product_num}"
						name="product_num">
						<div class="bas_td_hid_proeach"></div> <a
						href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a></td>
					<td>${list1.productInfo_price}</td>
					<td>${list1.productInfo_saleRate}</td>
					<td class="bas_td_bas_size"><select class="bas_td_sel_size">
							<c:set var="tempname1" value="" />
							<c:forEach var="eachSize" items="${list1.productEachDTO}">
								<c:if test="${tempname1 != eachSize.productSize_size}">
									<option value="${eachSize.productSize_size}"
										<c:if test="${list1.basketInfo_size == eachSize.productSize_size }">selected="selected"</c:if>>${eachSize.productSize_size}</option>
									<c:set var="tempname1" value="${eachSize.productSize_size}" />
								</c:if>
							</c:forEach>
					</select>${list1.basketInfo_size}</td>
					<td class="bas_td_bas_color"><c:set var="tempname1" value="" />
						<c:forEach var="eachSize" items="${list1.productEachDTO}">
							<c:if test="${tempname1 != eachSize.productSize_size}">
								<c:set var="tempname1" value="${eachSize.productSize_size}" />
								<select class="bas_td_sel_color"
									name="${eachSize.productSize_size}"
									<c:if test="${list1.basketInfo_size != eachSize.productSize_size}"> 
										style="display: none;"
										</c:if>>
									<c:forEach var="eachSize2" items="${list1.productEachDTO}">
										<c:if test="${tempname1 == eachSize2.productSize_size}">
											<option value="${eachSize2.productEach_color}"
												<c:if test="${list1.basketInfo_size == eachSize.productSize_size  && list1.basketInfo_color==eachSize2.productEach_color}"> 
										selected="selected"
										</c:if>>${eachSize2.productEach_color}</option>
										</c:if>
									</c:forEach>
								</select>
							</c:if>
						</c:forEach>${list1.basketInfo_color}</td>
					<td><c:set var="number"
							value="${list1.productInfo_price*list1.basketInfo_each*(100-list1.productInfo_saleRate)/100}" />
						<fmt:parseNumber var="total" value="${number}" type="number"
							integerOnly="true" /> ${total}
					<td><input type="number" class="bas_td_inp_each"
						value="${list1.basketInfo_each}" name="basketInfo_each">${list1.basketInfo_each}
						<input type="button" class="btn_fix" value="FIX"></td>
				</tr>
			</c:forEach>
		</table>
	</form>
	<button id="btn_allDel">전체삭제</button>
	<button id="btn_checkDel">선택삭제</button>
	<form id="basketFixFrm"
		action="${pageContext.request.contextPath}/basket/basketFix"
		method="post">
		<input id="product_num" type="hidden" value="" name="product_num">
		<input id="basket_num" type="hidden" value="" name="basket_num">
		<input id="basketInfo_size" type="hidden" value=""
			name="basketInfo_size"> <input id="basketInfo_color"
			type="hidden" value="" name="basketInfo_color"> <input
			id="basketInfo_each" type="hidden" class="bas_td_inp_each" value=""
			name="basketInfo_each">
	</form>


</body>
</html>
