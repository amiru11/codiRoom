<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/product/productList.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/pagination.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/product/productSideBar.css"
	rel="stylesheet">
<script type="text/javascript">
var requestSubmitted = false;

	$(function() {
		sideBar();
		$(document).keydown(function(e) {
		    key = (e) ? e.keyCode : event.keyCode;
		     
		    var t = document.activeElement;
		     
		    if (key == 8 || key == 116 || key == 17 || key == 82) {
		        if (key == 8) {
		            if (t.tagName != "INPUT") {
		                if (e) {
		                    e.preventDefault();
		                } else {
		                    event.keyCode = 0;
		                    event.returnValue = false;
		                }
		            }
		        } else {
		        	window.location.reload();
		            if (e) {
		                e.preventDefault();
		            } else {
		                event.keyCode = 0;
		                event.returnValue = false;
		            }
		        }
		    }
		});
		

		for(var i = 0 ; i < ${fn:length(productSelectList) } ; i++){
			$(".subh_prosel_num"+(i*1+1)).click(function(){
				$("#inphid_productSelect_num").val($(this).find(".inhA_proselNum").val());
				alert($("#inphid_productSelect_num").val());
				$("#hidd_form_prosel").submit();
			})	
		}
		
		$(".N_pageing").click(function(){
			$(".inh_curPage").val($(this).text());
			$("#form_all").submit();
		});
		$(".sel_type").click(function(){
			$(".inh_sel").val($(this).find(".inhc_sel").val());
			$("#form_all").submit();
		});
		
		$(".a_prev").click(function(){
			$(".inh_curPage").val($(this).find(".inh_prev").val());
			$("#form_all").submit();
		});
		$(".a_next").click(function(){
			$(".inh_curPage").val($(this).find(".inh_next").val());
			$("#form_all").submit();
		});
		
		
		
		$("#checkForm").find(":checkbox").change(function(){
			$("#hid_div_kind_num").html("");
			$("#hid_div_size").html("");
			$("#hid_div_color").html("");
			$(".inCk_kind_num:checked").each(function(){
				$("#hid_div_kind_num").append('<input class="inh_kind_num" type="hidden" value="'+$(this).val()+'" name="kind_num">');	
			});
			$(".inCk_size:checked").each(function(){
				$("#hid_div_size").append('<input class="inh_size" type="hidden" value="'+$(this).val()+'" name="size">');	
			});
			$(".inCk_color:checked").each(function(){
				$("#hid_div_color").append('<input class="inh_color" type="hidden" value="'+$(this).val()+'" name="color">');	
			});
			$("#form_all").submit();
		});
		
	
		$(".div_cart").click(function() {

			var product_num = $(this).find(".inh_product_num").val();
			selSize(product_num);
			$("#inh_pro_val").val(product_num);
		});

		$("#sel_size").change(function() {
			if($(this).val()!=""){
				selColor($("#inh_pro_val").val());	
			}
			
		});

		$("#btn_basketAdd").click(function() {
			basketAdd($("#inh_pro_val").val());
		});

		$("#inp_each").change(function() {
			numcheck();
			eachCheck();
		});
		$("#inp_each").keydown(function() {
			numcheck();
			eachCheck();
		});
		$("#inp_each").keyup(function() {
			numcheck();
			eachCheck();
		});
		$("#inp_each").blur(function() {
			eachCheck();
		});
	});
	//function end ------------------------------------------------------------------------------------------ 
	
	function selCheck(){
		
	}


	function selSize(product_num) {
		$.ajax({
			url : "../json/productSize",
			type : "post",
			data : {
				product_num : product_num
			},
			success : function(data) {
				var x = '<option value="">SIZE</option>';
				$.each(data, function(index, value) {
					x = x + "<option value=" + value + ">" + value + "</option>";
				});
				$("#sel_size").html(x);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}
	function selColor(product_num) {
		$.ajax({
			url : "../json/productEach",
			type : "post",
			dataType : 'json',
			data : {
				product_num : product_num,
				productSize_size : $("#sel_size").val()
			},
			success : function(data) {
				var x = '<option value="">COLOR</option>';
				var y = "";
				$.each(data.eachList, function(index, value) {
					x = x + "<option value=" + value.productEach_color + ">" + value.productEach_color + '_' + value.productEach_each + "</option>";
					y = y + value.productEach_color + '_' + value.productEach_each + '<input class="' + value.productEach_color + '" type="text" value="' + value.productEach_each + '">';
				});
				$("#div_hidden_each").html(y);
				$("#sel_color").html(x);

			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function basketAdd(product_num) {
		$.ajax({
			url : "../basket/basketAdd",
			type : "post",
			data : {
				product_num : product_num,
				productSize_size : $("#sel_size").val(),
				productEach_color : $("#sel_color").val(),
				productEach_each : $("#inp_each").val(),
			},
			success : function(data) {
				if (data == 1) {
					alert("장바구니 등록성공");
				} else {
					alert(data);
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
	function eachCheck() {
		var as = $("#sel_color").val();
		var b = $("." + as + "").val() * 1;
		var c = $("#inp_each").val() * 1;
		if (c * 1 > b * 1) {
			alert("재고초과");
			$("#inp_each").val(b);
		} else {
		}
	}
	function sideBar(){
		var currentPosition = parseInt($("#div_sidebar").css("top"));
		
		var position2 = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.
		$("#div_sidebar").stop().animate({
			"top" : position2 + currentPosition + "px"
		}, 500);
		
		$(window).scroll(function() {
			var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환합니다.
			$("#div_sidebar").stop().animate({
				"top" : position + currentPosition + "px"
			}, 500);
		});
	}
</script>

</head>
<body>
	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->

	<div class="container" style="padding-top: 20px;">
		<nav class="navbar" style="border-bottom: 1px solid #eeeeee;">
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav sub-header">
					<c:forEach var="list1" items="${productSelectList}">
						<li><a class="subh_prosel_num${list1.productSelect_num}"><input
								class="inhA_proselNum" type="hidden"
								value="${list1.productSelect_num}">${list1.productSelect_name}</a></li>
					</c:forEach>
					<li><a
						href="${pageContext.request.contextPath}/product/productSaleList">할인상품</a></li>
					<li><a
						href="${pageContext.request.contextPath}/product/productBestList">BSET</a></li>
				</ul>
			</div>
		</nav>
		<div class="item row">
			<div class="col-lg-12">
				<div class="left col-lg-4" style="margin-top: 0;">
					<form id="checkForm"
						action="${pageContext.request.contextPath}/product/productList"
						method="get">
						<div id="div_out_search_select">
							KIND<br>
							<div id="div_ck_kind"
								style="width: 200px; height: 100px; overflow: scroll;">
								<c:forEach var="kindList" items="${selKind_num}">
								${kindList}<input class="inCk_kind_num" type="checkbox"
										value="${kindList}"
										<c:forEach var = "kind2" items="${kind_num}">
								<c:if test="${kindList ==kind2}">
								checked="checked"
								</c:if>
								</c:forEach>
										name="kind_num">
								</c:forEach>
							</div>
							SIZE<BR>
							<div id="div_ck_size"
								style="width: 200px; height: 100px; overflow: scroll;">
								<c:forEach var="sizeList" items="${selSize}">
								${sizeList}<input class="inCk_size" type="checkbox"
										value="${sizeList}"
										<c:forEach var = "size2" items="${size}">
								<c:if test="${sizeList ==size2}">
								checked="checked"
								</c:if>
								</c:forEach>
										name="size">
									<br>
								</c:forEach>
							</div>
							COLOR<br>
							<div id="div_ck_color"
								style="width: 200px; height: 100px; overflow: scroll;">
								<c:forEach var="colorList" items="${selColor}">
								${colorList}<input class="inCk_color" type="checkbox"
										value="${colorList}"
										<c:forEach var = "color2" items="${color}">
								<c:if test="${colorList ==color2}">
								checked="checked"
								</c:if>
								</c:forEach>
										name="color">
									<br>
								</c:forEach>
							</div>
						</div>

					</form>
				</div>
				<div class="right col-lg-8" style="margin-top: 0; width: 850px;">
					<!-- 상품 리스트:S -->
					<nav class="navbar">
						<div class="navbar-collapse collapse"
							style="padding-left: 0; border-bottom: 1px solid #eee;">
							<ul class="nav navbar-nav category-type">
								<li><a style="cursor: pointer" class="sel_type"><input
										class="inhc_sel" type="hidden" value="1">최신순</a></li>
								<li><a style="cursor: pointer" class="sel_type"><input
										class="inhc_sel" type="hidden" value="2">인기순</a></li>
								<li><a style="cursor: pointer" class="sel_type"><input
										class="inhc_sel" type="hidden" value="3">낮은 가격 순</a></li>
								<li>
									<!-- <input name="sel" type="radio" class="sel_radio" value="5"> -->
									<a style="cursor: pointer" class="sel_type"><input
										class="inhc_sel" type="hidden" value="4">높은 가격 순</a>
								</li>
							</ul>
						</div>
					</nav>

					<div id="item-table">
						<ul class="list-inline" style="width: 850px;">
							<c:forEach items="${list}" var="list1">
								<li style="padding-left: 20px;" class="viewItem">
									<div class="mc" style="border: 1px solid #eee;">
										<span class="img"> <a
											href="${pageContext.request.contextPath}/product/productView?product_num=${list1.productDTO.product_num}">
												<img
												src="${pageContext.request.contextPath}/resources/testPic/${list1.productPicDTO.productPic_pic}"
												width="250" height="250">
										</a>
										</span>
										<div class="item-info" style="padding-left: 10px;">
											<p style="padding-top: 10px;">
												<a
													href="${pageContext.request.contextPath}/product/productView?product_num=${list1.productDTO.product_num}">${list1.productDTO.product_name}</a>
											</p>
											<p>브랜드</p>
											<p>
												<span> <fmt:formatNumber
														value="${list1.productInfoDTO.productInfo_price}"
														currencySymbol="" type="currency" />원
												</span>
												<c:if
													test="${list1.productInfoDTO.productInfo_saleRate > 0  }">
													<strong style="color: #b5172e;">→<c:set
															var="number"
															value="${list1.productInfoDTO.productInfo_price*(100-list1.productInfoDTO.productInfo_saleRate)/100}" />
														<fmt:parseNumber var="total" value="${number}"
															type="number" integerOnly="true" /> ${total}
														원(${list1.productInfoDTO.productInfo_saleRate}%)
													</strong>
												</c:if>
											</p>
										</div>
										<div class="div_cart cart"
											<c:if test="${empty sessionScope.member}">
										data-toggle="modal" data-target="#loginModal"
							data-backdrop="true"
										</c:if>
											<c:if test="${!empty sessionScope.member}">
										data-toggle="modal" data-target="#basketModal"
							data-backdrop="true"
										</c:if>>
											<input type="hidden" value="${list1.productDTO.product_num}"
												class="inh_product_num" name="product_num"> <span
												style="font-size: 20px; color: #ffffff;">ADD TO CART</span>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
						<!-- 상품 리스트:E -->
					</div>
					<!-- PAGINATIOIN:S -->
					<div class="center-block">
						<nav aria-label="Page navigation">
							<ul class="pagination">
								<c:if test="${!empty list}">

									<li><c:if test="${pageing.curBlock>1}">
											<a class="a_prev" aria-label="Previous"
												style="cursor: pointer"><input class="inh_prev"
												type="hidden" value="${pageing.startNum-1}"> <span
												aria-hidden="true">&laquo;</span> </a>
										</c:if></li>
									<li><c:forEach begin="${pageing.startNum}" step="1"
											end="${pageing.lastNum}" var="i">

											<a style="cursor: pointer" class="N_pageing">${i}</a>
										</c:forEach></li>
									<li><c:if test="${pageing.curBlock<pageing.totalBlock}">
											<a class="a_next" aria-label="Next" style="cursor: pointer">
												<input class="inh_next" type="hidden"
												value="${pageing.lastNum+1}"><span
												aria-hidden="true">&raquo;</span>
											</a>
										</c:if></li>
								</c:if>
							</ul>
						</nav>
					</div>
					<!-- PAGINATIOIN:E -->
				</div>
			</div>
		</div>



	</div>
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>
	<!-- Footer:E -->

	<!-- Modal -->
	<div class="modal fade" id="basketModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">CART</h4>
				</div>
				<input type="hidden" value="" id="inh_pro_val">
				<div class="modal-body"
					style="padding: 3px; height: 300px; background-color: red;">사진</div>
				<div class="modal-body2">
					<select id="sel_size"></select>
				</div>
				<div class="modal-body3">
					<select id="sel_color"></select>
				</div>
				<div class="modal-body3">
					<input type="number" id="inp_each" value="1" min="1" step="1"><br>
					<input id="btn_basketAdd" type="button" value="장바구니 추가">
				</div>

				<div id="div_hidden_each"></div>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>

	<!--  hidden form (POST로 넘기기위한 숨겨진 FORM 지저분한 주소창방지용)  -->
	<form id="form_all" name="formAll"
		action="${pageContext.request.contextPath}/product/productList"
		method="post" style="display: none;">
		<input class="inh_curPage" type="hidden" value="" name="curPage">
		<input class="inh_sel" type="hidden" name="sel"> <input
			class="inh_productSelect_num" type="hidden"
			value="${productSelect_num}" name="productSelect_num">
		<div id="hid_div_kind_num">
			<c:forEach var="kindList1" items="${kind_num}">
				<input class="inh_kind_num" type="hidden" value="${kindList1}"
					name="kind_num">
			</c:forEach>
		</div>
		<div id="hid_div_size">
			<c:forEach var="sizeList1" items="${size}">
				<input class="inh_size" type="hidden" value="${sizeList1}"
					name="size">
			</c:forEach>
		</div>
		<div id="hid_div_color">
			<c:forEach var="colorList1" items="${color}">
				<input class="inh_color" type="hidden" value="${colorList1}"
					name="color">
			</c:forEach>
		</div>



	</form>

	<!--   hiddenForm2   productSelect 전용 -->
	<form id="hidd_form_prosel" name="formProsel"
		action="${pageContext.request.contextPath}/product/productList"
		method="post" style="display: none;">
		<input id="inphid_productSelect_num" type="hidden"
			name="productSelect_num">
	</form>

	<!--   side bar  -->
	<%@ include file="/resources/temp/product/productSideBar.jspf"%>



</body>
</html>
