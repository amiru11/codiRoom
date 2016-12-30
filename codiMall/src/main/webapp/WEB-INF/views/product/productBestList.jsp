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
		$(".a_best_product").css('color', '#006633');
		$(".a_best_product").css('font-size', '25px');
		
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
				$("#hidd_form_prosel").submit();
			})	
		}
		$(".a_sale_product").click(function(){
			$(".inh_sale_st").attr('name','sale')
			$("#form_all").submit();
		});
		
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
			var productPic_pic = $(this).find(".inh_productPic_pic_val").val();
			var price = $(this).find(".p_cl_price").html();
			var xxx = '<table id="modal_tab_right"><tr><td><select id="sel_size"></select></td></tr><tr><td><select id="sel_color" style="display:none"></select>';
			xxx=xxx+'</td></tr><tr><td><input type="number" value="0" min="1" max="20" step="1" id="inp_each" style="display:none"></select></td></tr></table>';
			$("#modal_div_img_left").html("");
			$("#modal_div_img_left").append('<img src="'+productPic_pic+'" >');
			$("#modal_div_tab_right").html("");
			$("#modal_div_tab_right").append(xxx);
			$("#modal_div_price").append(price);
			
			selSize(product_num);
			$("#inh_pro_val").val(product_num);
			$("#sel_color").css('display','none');
			$("#sel_size").val("");
			$("#inp_each").val(0);
			$("#inp_each").css('display','none');
			$("#btn_basketAdd").css('display','none');
			
			$("#sel_size").on('change',function() {
				if($(this).val()!=""){
					selColor($("#inh_pro_val").val());
					$("#sel_color").css('display','inline-block');
					$("#inp_each").css('display','none');
				}
				if($(this).val()==""){
					$("#sel_color").css('display','none');
					$("#inp_each").css('display','none');
				}
				if($("#sel_color").val()==""){
					$("#inp_each").css('display','none');
				}
				
				$("#inp_each").val(0);
				$("#inp_each").css('display','none');
			});
			$("#sel_color").on('change',function() {
				if($(this).val()==""){
					$("#inp_each").css('display','none');
				}else{
					$("#inp_each").css('display','inline-block');
				}
				$("#inp_each").val(0);
				$("#btn_basketAdd").css('display','none');
			});
			$("#inp_each").on('change',function() {
				numcheck();
				eachCheck();
				if($(this).val()>0 && $(this).val()<21){
					$("#btn_basketAdd").css('display','inline-block');
				}else{
					$("#btn_basketAdd").css('display','none');
				}
			});
			$("#inp_each").on('keydown',function() {
				numcheck();
				eachCheck();
				if($(this).val()>0 && $(this).val()<21){
					$("#btn_basketAdd").css('display','inline-block');
				}else{
					$("#btn_basketAdd").css('display','none');
				}
			});
			$("#inp_each").on('keyup',function() {
				numcheck();
				eachCheck();
				if($(this).val()>0 && $(this).val()<21){
					$("#btn_basketAdd").css('display','inline-block');
				}else{
					$("#btn_basketAdd").css('display','none');
				}
			});
			$("#inp_each").on('blur',function() {
				eachCheck();
				if($(this).val()>0 && $(this).val()<21){
					$("#btn_basketAdd").css('display','inline-block');
				}else{
					$("#btn_basketAdd").css('display','none');
				}
			});
		});

		

		$("#btn_basketAdd").on('click',function() {
			if($("#inp_each").val()!=0 && $("#inp_each").val()<20){
			basketAdd($("#inh_pro_val").val());
			}else{
			alert("1개이상 20개 이하로 입력해주세요")
			}

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
					y = y + '<input class="' + value.productEach_color + '" type="hidden" value="' + value.productEach_each + '">';
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
		} else if(c*1 >20){
			alert("21개 이상은 문의")
			$("#inp_each").val(20);
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

<style type="text/css">
.cl_div_subject_name {
	width: 220px;
	text-align: center;
	background-color: black;
}

.cl_div_subject_name label {
	font-size: 30px;
	font-weight: bold;
	color: white;
}

.cl_div_checkboxpp {
	overflow-y: scroll;
	width: 220px;
	height: 300px;
	border: 1px red solid;
}

.cl_tab_checkboxp {
	border: 3px blue double;
	width: 200px;
}

.cl_tab_checkboxp tr th {
	text-align: center;
	font-size: 30px;
}

.cl_tab_checkboxp tr td {
	font-size: 20px;
	text-align: right;
}

.cl_tab_checkboxp tr td {
	border: 2px black solid;
}

.cl_tab_checkboxp td:LAST-OF-TYPE {
	width: 10%;
}

.cl_tab_checkboxp td:LAST-OF-TYPE input {
	width: 40px;
	height: 40px;
}

#modal_div_img_left {
	width: 200px;
	height: 200px;
	border: 2px blue solid;
	float: left;
}

#modal_div_img_left img {
	width: 190px;
	height: 190px;
}

#modal_div_tab_right {
	width: 200px;
	height: 200px;
	border: 2px green solid;
	float: right;
}

#modal_tab_right {
	border: black 3px double;
}

#modal_tab_right td>select, input {
	width: 195px;
	height: 50px;
	font-size: 25px;
	font-weight: bold;
}

#modal_div_tab_right img {
	width: 190px;
	height: 190px;
}

#btn_basketAdd {
	width: 100%;
	height: 60px;
	font-size: 30px;
	text-align: center;
}
</style>

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
						<li><a
							class="a_prosel_num subh_prosel_num${list1.productSelect_num}"><input
								class="inhA_proselNum" type="hidden"
								value="${list1.productSelect_num}">${list1.productSelect_name}</a></li>
					</c:forEach>
					<li><a class="a_sale_product" style="cursor: pointer;">할인상품</a></li>
					<li><a class="a_best_product" style="cursor: pointer;"
						href="${pageContext.request.contextPath}/product/productBestList">BSET</a></li>
				</ul>
			</div>
		</nav>
		<div class="item row">
			<div class="col-lg-12">
			<div class="left col-lg-4" style="width:100px;">

				</div>
				<div class="right col-lg-8" style="margin-top: 0; width: 850px;">
					<div id="item-table">
						<ul class="list-inline" style="width: 850px;">
							<c:forEach items="${list}" var="list1">
								<li style="padding-left: 20px;" class="viewItem">
									<div class="mc" style="border: 1px solid #eee;">
										<span class="img"> <a
											href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">
												<img
												src="${pageContext.request.contextPath}/resources/testPic/${list1.productPic_pic}"
												width="250" height="250">
										</a>
										</span>
										<div class="item-info" style="padding-left: 10px;">
											<p style="padding-top: 10px;">
												<a
													href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a>
											</p>
											<p>브랜드</p>
											<p>
												<span> <fmt:formatNumber
														value="${list1.productInfo_price}"
														currencySymbol="" type="currency" />원
												</span>
												<c:if
													test="${list1.productInfo_saleRate > 0  }">
													<strong style="color: #b5172e;">→<c:set
															var="number"
															value="${list1.productInfo_price*(100-list1.productInfo_saleRate)/100}" />
														<fmt:parseNumber var="total" value="${number}"
															type="number" integerOnly="true" /> <fmt:formatNumber
															value="${total}" pattern="#,###" />
														원(${list1.productInfo_saleRate}%)
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
											<p class="p_cl_price" style="display: none;">
												<span> <fmt:formatNumber
														value="${list1.productInfo_price}"
														currencySymbol="" type="currency" />원
												</span>
												<c:if
													test="${list1.productInfo_saleRate > 0  }">
													<strong style="color: #b5172e;">→<c:set
															var="number"
															value="${list1.productInfo_price*(100-list1productInfo_saleRate)/100}" />
														<fmt:parseNumber var="total" value="${number}"
															type="number" integerOnly="true" /> <fmt:formatNumber
															value="${total}" pattern="#,###" />
														원(${list1.productInfo_saleRate}%)
													</strong>
												</c:if>
											</p>
											<input type="hidden" value="${list1.product_num}"
												class="inh_product_num" name="product_num"> <input
												type="hidden" class="inh_productPic_pic_val"
												value="${pageContext.request.contextPath}/resources/testPic/${list1.productPic_pic}">
											<span style="font-size: 20px; color: #ffffff;">ADD TO
												CART</span>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
						<!-- 상품 리스트:E -->
					</div>
					<!-- PAGINATIOIN:S -->
					
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
				<div class="modal-body div_img_in"
					style="padding: 10px; height: 300px;">
					<div id="modal_div_img_left"></div>
					<div id="modal_div_tab_right"></div>
					<div id="modal_div_price"></div>
					<button id="btn_basketAdd" style="display: none;">장바구니 추가</button>
				</div>
				<div class="modal-body3"></div>

				<div id="div_hidden_each"></div>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
	<form id="form_all" name="formAll"
		action="${pageContext.request.contextPath}/product/productList"
		method="post" style="display: none;">
		<input class="inh_sale_st" type="hidden" value="sale" name="${sale}">
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
