<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/basket/basket.css"
	rel="stylesheet">
<script type="text/javascript">
	$(function() {
		$.each($(".bas_td_sel_size"), function(key, value) {
			var z = $.trim($(value).text());
			if (z == "") {
				$(value).css('display', 'none');
			}
		});

		$.each($(".bas_td_sel_color"), function(key, value) {
			var z = $.trim($(value).text());
			if (z == "") {
				$(value).css('display', 'none');
			}
		});

		$("#btn_allBuy").click(function() {
			var count = 0;
			$(".bas_td_check").prop("checked", true);
			$(".bas_td_check").attr('checked', true);
			var bas_tr_jq = $(".bas_tr_jq");
			for (var i = 0; i < bas_tr_jq.length; i++) {
				if ($(bas_tr_jq[i]).find(".bas_td_check").is(":checked") != true) {
					$(bas_tr_jq[i]).find(".td_inh_bas_num").attr("disabled", "disabled");
				} else {
					$(bas_tr_jq[i]).find(".td_inh_bas_num").attr("disabled", "disabled");
					$(bas_tr_jq[i]).find(".td_inh_bas_num").removeAttr("disabled");
				}
			}
			var bas_td_inp_each = document.getElementsByClassName("bas_td_inp_each");
			for (var i = 0; i < bas_td_inp_each.length; i++) {
				if ($(bas_td_inp_each[i]).val() == 0) {
					count++;
				}
			}
			if (count > 0) {
				alert("수량을 1개이상 입력해주세요");
			} else {
				$("#tab_form").attr("action", "${pageContext.request.contextPath}/buy/basketBuyList");
				$("#tab_form").submit();
			}
		});

		$("#btn_checkBuy").click(function() {
			var count = 0;
			if ($(".bas_td_check:checked").length == 0) {
				alert("1개이상 체크하세요");
			} else {
				var bas_tr_jq = $(".bas_tr_jq");
				for (var i = 0; i < bas_tr_jq.length; i++) {
					if ($(bas_tr_jq[i]).find(".bas_td_check").is(":checked") != true) {
						$(bas_tr_jq[i]).find(".td_inh_bas_num").attr("disabled", "disabled");
					} else {
						$(bas_tr_jq[i]).find(".td_inh_bas_num").attr("disabled", "disabled");
						$(bas_tr_jq[i]).find(".td_inh_bas_num").removeAttr("disabled");
						if ($(bas_tr_jq[i]).find(".bas_td_inp_each").val() == 0) {
							count++;
						}
					}
				}
				if (count > 0) {
					alert("수량을 1개이상 입력해주세요");
				} else {
					$("#tab_form").attr("action", "${pageContext.request.contextPath}/buy/basketBuyList");
					$("#tab_form").submit();
				}
			}
		});


		$("#btn_allDel").click(function() {
			$(".bas_td_check").prop("checked", true);
			$(".bas_td_check").attr('checked', true);
			$("#tab_form").attr("action", "${pageContext.request.contextPath}/basket/basketDel");
			$("#tab_form").submit();
		});

		$("#btn_checkDel").click(function() {
			if ($(".bas_td_check:checked").length == 0) {
				alert("1개이상 체크하세요");
			} else {
				$("#tab_form").attr("action", "${pageContext.request.contextPath}/basket/basketDel");
				$("#tab_form").submit();
			}
		});




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
			var aaaa = $(this);
			basketTake(aaaa);
		});
		$(".bas_tr_jq").mouseleave(function() {
			$(".product_quantity_down").off('click');
			$(".product_quantity_up").off('click');
			$(".btn_fix").off('click');
		});

		if ($(".bas_tr_jq").length == 0) {
			$(":button").off("click");
			$(":button").css("display", "none");

		}

	});

	function basketTake(aaaa) {
		var thisTr = aaaa;
		thisTr.find(".bas_td_sel_size").on("change", function() {
			var optionSize = thisTr.find(".bas_td_sel_size option").length;
			var selSize = thisTr.find(".bas_td_sel_size").val();
			alert(optionSize);
			alert(selSize);
			thisTr.find(".bas_td_sel_color").css("display", "none");
			thisTr.find(".bas_td_sel_color[name=" + selSize + "]").css("display", "inline-block");
		});

		thisTr.find(".btn_fix").on("click", function() {
			if ($(thisTr).find(".bas_td_inp_each2").val() == 0) {
				alert("수량을 1개이상 입력해주세요")
			} else {
				var selSize = thisTr.find(".bas_td_sel_size").val();
				var selColor = thisTr.find(".bas_td_sel_color[name=" + selSize + "]").val();
				var each = thisTr.find(".bas_td_inp_each2").val();
				var basket_num = thisTr.find(".td_inh_bas_num").val();
				var product_num = thisTr.find(".bas_td_hid_pronum").val();


				$("#basket_num").val(basket_num);
				$("#product_num").val(product_num);
				$("#basketInfo_size").val(selSize);
				$("#basketInfo_color").val(selColor);
				$("#basketInfo_each").val(each);
				if ($("#basketInfo_each").val() > 0) {
					$("#basketFixFrm").submit();
				}
			}

		});

		thisTr.find(".bas_td_inp_each2").focus(function() {
			$(this).change(function() {
				numcheck();
				if ($(this).val() > 0) {
					numcheck();
					productEachGet(thisTr);
				} else {
					numcheck();
					$(this).val(1);
				}
			});
			$(this).keyup(function() {
				numcheck();
			});
			$(this).keydown(function() {
				numcheck();
			});
		});
		$(".product_quantity_down").click(function() { //수량감소
			if ($(thisTr).find(".bas_td_inp_each2").val() == 0) {
			} else {
				$(thisTr).find(".bas_td_inp_each2").val($(thisTr).find(".bas_td_inp_each2").val() * 1 - 1);
			}

		});

		$(thisTr).find(".product_quantity_up").click(function() { //수량증가
			var color = $(thisTr).find(".bas_td_sel_color");
			var size = $(thisTr).find(".bas_td_sel_size").text();
			var count = 0;
			$.each(color, function(key, value) {
				var z = $.trim($(value).text());
				if (z == "") {
					count++;
				}
			});

			if (size == "" || count > 0) {
			} else {
				$(thisTr).find(".bas_td_inp_each2").val($(thisTr).find(".bas_td_inp_each2").val() * 1 + 1);
				productEachGet(thisTr);
				if ($(thisTr).find(".bas_td_inp_each2").val() > 20) {
					alert("21개이상은 전화로 문의");
					$(thisTr).find(".bas_td_inp_each2").val(20);
				}
			}

		});
	}
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
	function numcheck() {
		if ( (event.keyCode == 69) ) {
			event.returnValue = false;
		}
	}
</script>
<style>
#third_now {
	background: url(/codi/resources/images/basket/hgroup_img.gif) no-repeat
		0 0;
	background-position: 1px -93px;
}
</style>
</head>
<body>
	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->

	<div class="container cart-body">
		<div class="row">
			<div class="col-sm-12">
				<h1 id="cart_title" class="page-heading">Shopping-cart summary
				</h1>
				<div>
					<ul class="step list-inline" id="order_step">
						<li class="title_img">TITLE</li>
						<li class="step-li first"><span>주문서 작성</span></li>
						<li class="arrow-li"></li>
						<li class="step-li second"><span> 주문서 작성</span></li>
						<li class="arrow-li"></li>
						<li class="step-li third third_now"
							style="background-position: 1px -91px;"><span> 장바구니</span></li>
					</ul>
				</div>
				<form id="tab_form" class="form" method="post">
					<div style="border: 2px solid #dce2eb;">
						<h3 class="product_tit">CART INFO</h3>
						<table class="table cart-table">

							<tr>
								<th class="bas_th_01"><input type="checkbox" id="allCheck"></th>
								<!-- 체크박스 -->
								<th class="bas_th_02">번호</th>
								<!-- 상품이미지 -->
								<th class="bas_th_03" style="text-align: center;">상품</th>
								<!-- 상품명 -->
								<th class="bas_th_04">판매가</th>
								<!-- 가격 -->
								<th class="bas_th_05">할인율</th>
								<!-- 할인율 -->
								<th class="bas_th_06">사이즈</th>
								<!-- 사이즈 -->
								<th class="bas_th_07">색상</th>
								<!-- 색상 -->
								<th class="bas_th_08">주문금액</th>
								<!-- 할인된 가격 -->
								<th class="bas_th_09">수량</th>
								<!-- 수량 -->
								<th></th>
							</tr>
							<c:forEach var="list1" items="${list}" varStatus="i">

								<tr class="bas_tr_jq">
									<!-- 체크박스 -->
									<td><input type="checkbox" value="${list1.basket_num}"
										name="del_basket_num" class="bas_td_check"></td>
									<!-- 상품이미지 -->
									<td class="bas_td_bas_num"><input class="td_inh_bas_num"
										type="hidden" value="${list1.basket_num}" name="basket_num">
										${i.count}</td>
									<td class="bas_td_second"><input type="hidden"
										class="bas_td_hid_pronum" value="${list1.product_num}"
										name="product_num">
										<div class="bas_td_hid_proeach"
											style="display: inline-block; margin-right: 10px; float: left;">
											<a
												href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">
												<img alt=""
												src="${pageContext.request.contextPath}/resources/images/noimage.jpg"
												width="60" height="60">
											</a>
										</div>
										<div style="display: inline-block; margin-top: 20px;">
											<p>
												<a
													href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">
													${list1.product_name} </a>
											</p>

										</div></td>
									<td><fmt:formatNumber value="${list1.productInfo_price}"
											currencySymbol="" type="currency" />원</td>
									<td>${list1.productInfo_saleRate}%</td>
									<td class="bas_td_bas_size"><select
										class="bas_td_sel_size">
											<c:set var="tempname1" value="" />
											<c:forEach var="eachSize" items="${list1.productEachDTO}">
												<c:if
													test="${tempname1 != eachSize.productSize_size && eachSize.productEach_each != 0}">
													<option value="${eachSize.productSize_size}"
														<c:if test="${list1.basketInfo_size == eachSize.productSize_size }">selected="selected"</c:if>>${eachSize.productSize_size}</option>
													<c:set var="tempname1" value="${eachSize.productSize_size}" />
												</c:if>
											</c:forEach>
									</select>${list1.basketInfo_size}</td>
									<td class="bas_td_bas_color"><c:set var="tempname1"
											value="" /> <c:forEach var="eachSize"
											items="${list1.productEachDTO}">
											<c:if test="${tempname1 != eachSize.productSize_size }">
												<c:set var="tempname1" value="${eachSize.productSize_size}" />
												<select class="bas_td_sel_color"
													name="${eachSize.productSize_size}"
													<c:if test="${list1.basketInfo_size != eachSize.productSize_size}"> 
												style="display: none;"
												</c:if>>
													<c:forEach var="eachSize2" items="${list1.productEachDTO}">
														<c:if
															test="${tempname1 == eachSize2.productSize_size && eachSize2.productEach_each != 0}">
															<option value="${eachSize2.productEach_color}"
																<c:if test="${list1.basketInfo_size == eachSize.productSize_size  && list1.basketInfo_color==eachSize2.productEach_color}"> 
												selected="selected"
												</c:if>>${eachSize2.productEach_color}</option>
														</c:if>
													</c:forEach>
												</select>
											</c:if>
										</c:forEach>${list1.basketInfo_color}</td>
									<td><fmt:formatNumber
											value="${list1.productInfo_price*list1.basketInfo_each*(100-list1.productInfo_saleRate)/100}"
											currencySymbol="" type="currency" />원 <%-- 							
								<c:set var="number"
										value="${list1.productInfo_price*list1.basketInfo_each*(100-list1.productInfo_saleRate)/100}" />
									<fmt:parseNumber var="total" value="${number}" type="number"
										integerOnly="true" /> ${total} --%>
									<td>
										<div class="attribute_list" id="quantity">

											<a class="btn btn-default button-minus product_quantity_down"
												style="margin-left: 10px;"> <span><i
													class="glyphicon glyphicon-minus"></i></span>
											</a> <input style="width: 60px;" type="number" min="1"
												class="bas_td_inp_each2" value="${list1.basketInfo_each}"
												readonly="readonly"> <a
												class="btn btn-default button-plus product_quantity_up">
												<span><i class="glyphicon glyphicon-plus"
													style="left: 1px;"></i></span>
											</a><input  type="hidden" class="bas_td_inp_each"
												value="${list1.basketInfo_each}"
												name="basketInfo_each" >
											${list1.basketInfo_each}

										</div>
									</td>
									<td><input type="button" class="btn_fix btn btn-default"
										value="변경"></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</form>
				<div class="button-set" style="float: right; font-family: hanna;">
					<button id="btn_allDel" class="btn btn-default" type="button">전체삭제</button>
					<button id="btn_checkDel" class="btn btn-default" type="button">선택삭제</button>
					<button id="btn_allBuy" class="btn btn-default" type="button">전체구매</button>
					<button id="btn_checkBuy" class="btn btn-default" type="button">선택구매</button>
					<form id="basketFixFrm"
						action="${pageContext.request.contextPath}/basket/basketFix"
						method="post">
						<input id="product_num" type="hidden" value="" name="product_num">
						<input id="basket_num" type="hidden" value="" name="basket_num">
						<input id="basketInfo_size" type="hidden" value=""
							name="basketInfo_size"> <input id="basketInfo_color"
							type="hidden" value="" name="basketInfo_color"> <input
							id="basketInfo_each" type="hidden" value=""
							name="basketInfo_each">
					</form>
				</div>

			</div>

		</div>


	</div>


	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>
	<!-- Footer:E -->
</body>
</html>
