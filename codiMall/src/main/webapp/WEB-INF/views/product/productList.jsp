<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="http://fonts.googleapis.com/earlyaccess/hanna.css">
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
		$(".a_sale_product").css('width', '120px');
		var sessel = "${sel}"
		var sale = "${sale}";
		if(sale != ""){
			$(".a_sale_product").css('color', '#006633');
			$(".a_sale_product").css('font-size', '15px');
			$(".a_sale_product").css('font-weight', 'bold');
		}else{
			$.each( $(".a_prosel_num"), function( key, value ) {
				  if($(value).find(".inhA_proselNum").val()==${productSelect_num}){
/* 					  $(value).css({
							 color : #006633,
							 'font-size' : '15px',
							 'font-weight' : 'bold;'
						  }); */
					  $(value).css('color', '#006633');
					  $(value).css('font-size', '15px');
					  $(value).css('font-weight','bold');						  
				  }
			});
			
		}
		$.each( $(".sel_type"), function( key, value ) {
			  if($(value).find(".inhc_sel").val()==sessel){
/* 				  $(value).css({
					 'color' : '#006633',
					 'font-size' : '15px',
					 'font-weight' : 'bold;'
				  }); */
				  $(value).css('color', '#006633');
				  $(value).css('font-size', '15px');
				  $(value).css('font-weight','bold');
				  
			  }
			});
		
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
			var xxx = '<table id="modal_tab_right"><tr><td><select id="sel_size" class="form-control"></select></td></tr><tr><td><select id="sel_color" class="form-control" style="display:none"></select>';
			xxx=xxx+'</td></tr><tr><td><div id="each_div" style="display:none"><input type="number" value="0" min="1" max="20" step="1" id="inp_each">';
			xxx=xxx+'<a	class="btn btn-default button-minus product_quantity_down" style="margin-left: 20px; padding : 0;" onclick="minusOn();"> <span><i class="glyphicon glyphicon-minus"></i></span></a> <span><i id="btn_add_eachaa" class="btn btn-default button-plus product_quantity_up glyphicon glyphicon-plus" style="left: 1px; padding : 0;" onclick="addOn();"></i></span></div></td></tr></table>';
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
			$("#each_div").css('display','none');
			$("#btn_basketAdd").css('display','none');
			
			$("#sel_size").on('change',function() {
				if($(this).val()!=""){
					selColor($("#inh_pro_val").val());
					$("#sel_color").css('display','inline-block');
					$("#each_div").css('display','none');
				}
				if($(this).val()==""){
					$("#sel_color").css('display','none');
					$("#each_div").css('display','none');
				}
				if($("#sel_color").val()==""){
					$("#each_div").css('display','none');
				}
				
				$("#inp_each").val(0);
				$("#each_div").css('display','none');
			});
			$("#sel_color").on('change',function() {
				if($(this).val()==""){
					$("#each_div").css('display','none');
				}else{
					$("#each_div").css('display','inline-block');
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
	
	function addOn(){
		$("#inp_each").val($("#inp_each").val()*1+1);
		var as = $("#inh_id_hidden_each").val()*1;
    	if($("#inp_each").val()*1>as*1){
    		alert("재고초과");
    		$("#inp_each").val(as*1);
    	}else{
    		if($("#inp_each").val()*1>20){	
				$("#inp_each").val(20*1);
				alert("21개이상은 전화로 문의");
			}
    	}
	}
	
	function minusOn(){
		var c = parseInt($("#inp_each").val());
		var d = c-1;
		if(d>1 || d==1){	
			$("#inp_each").val(d);
		}else{
			alert("더 이상 수량을 줄일 수 없습니다.");
		}
	}
	
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
	/* border: 2px blue solid; */
	float: left;
}

#modal_div_img_left img {
	width: 190px;
	height: 190px;
}

#modal_div_tab_right {
	width: 200px;
	height: 200px;
	/* border: 2px green solid; */
	float: right;
}

#modal_tab_right {
	/* border: black 3px double; */
}

#modal_tab_right td>select{
	width: 195px;
	height: 50px;
	font-size: 15px;
	font-weight: bold;
	border: 2px solid #dce2eb;
	margin-bottom:15px;
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


	<div class="container" style="padding-top: 30px;">
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
							<div class="cl_div_subject_name">
								<label>KIND</label>
							</div>
							<div id="div_ck_kind" class="cl_div_checkboxpp">
								<table id="tab_kind_checkbox" class="cl_tab_checkboxp">
									<c:forEach var="kindList" items="${selKind_num}">
										<tr>
											<td>${kindList}</td>
											<td><input class="inCk_kind_num" type="checkbox"
												value="${kindList}"
												<c:forEach var = "kind2" items="${kind_num}">
								<c:if test="${kindList ==kind2}">
								checked="checked"
								</c:if>
								</c:forEach>
												name="kind_num"></td>
										</tr>
									</c:forEach>
								</table>
							</div>
							<div class="cl_div_subject_name">
								<label>SIZE</label>
							</div>
							<div id="div_ck_size" class="cl_div_checkboxpp">
								<table id="tab_kind_checkbox" class="cl_tab_checkboxp">
									<c:forEach var="sizeList" items="${selSize}">
										<tr>
											<td>${sizeList}</td>
											<td><input class="inCk_size" type="checkbox"
												value="${sizeList}"
												<c:forEach var = "size2" items="${size}">
								<c:if test="${sizeList ==size2}">
								checked="checked"
								</c:if>
								</c:forEach>
												name="size"></td>
										</tr>
									</c:forEach>
								</table>
							</div>
							<div class="cl_div_subject_name">
								<label>COLOR</label>
							</div>
							<div id="div_ck_color" class="cl_div_checkboxpp">
								<table id="tab_kind_checkbox" class="cl_tab_checkboxp">
									<c:forEach var="colorList" items="${selColor}">
										<tr>
											<td>${colorList}</td>
											<td><input class="inCk_color" type="checkbox"
												value="${colorList}"
												<c:forEach var = "color2" items="${color}">
								<c:if test="${colorList ==color2}">
								checked="checked"
								</c:if>
								</c:forEach>
												name="color"></td>
										</tr>
									</c:forEach>
								</table>
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
															type="number" integerOnly="true" /> <fmt:formatNumber
															value="${total}" pattern="#,###" />
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
											<p class="p_cl_price" style="display: none;">
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
															type="number" integerOnly="true" /> <fmt:formatNumber
															value="${total}" pattern="#,###" />
														원(${list1.productInfoDTO.productInfo_saleRate}%)
													</strong>
												</c:if>
											</p>
											<input type="hidden" value="${list1.productDTO.product_num}"
												class="inh_product_num" name="product_num"> <input
												type="hidden" class="inh_productPic_pic_val"
												value="${pageContext.request.contextPath}/resources/testPic/${list1.productPicDTO.productPic_pic}">
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
	<div class="modal fade" id="basketModal" role="dialog" style="font-family: 'hanna';">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">장바구니 담기</h4>
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

				<div id="div_hidden_each">
					<input type="hidden" id="inh_id_hidden_each">
				</div>
					
				<!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
			</div>
		</div>
	</div>

	<!--  hidden form (POST로 넘기기위한 숨겨진 FORM 지저분한 주소창방지용)  -->
	<form id="form_all" name="formAll"
		action="${pageContext.request.contextPath}/product/productList"
		method="post" style="display: none;">
		<input class="inh_product_search_word" type="hidden" value="${productInfo_searchWord}" name="productInfo_searchWord">
		<input class="inh_sale_st" type="hidden" value="sale" name="${sale}">
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
