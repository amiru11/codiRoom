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

th {
	text-align: center;
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
		mastProductListSt();
		selBox();
		allCheckBoxes();
		pageing();
	});


	function mastProductListSt() {
		$(".div_cl_img_asd").on('click', function() {
			var product_num = $(this).find(".inh_product_num").val();
			alert(product_num);
			ajaxfirst(product_num);
		});
	}

	function ajaxfirst(product_num) {
		$.ajax({
			url : "../json/mastProductAllInfo",
			type : "post",
			dataType : 'json',
			data : {
				product_num : product_num,
			},
			success : function(data) {
				alert(data);
				alert(data.ar.product_num);
				$("#div_modin_main").html("");
				var x = "";
				x = x + '<table id="tab_modin"><tr>';
				x = x + '<td class="modin_td"><div class="modin_div"><img src="${pageContext.request.contextPath}/resources/testPic/' + data.ar.productPic_pic + '"></div></td>';
				x = x + '<td class="modin_td"><div class="modin_div"><table id="tabin_tab_12"><tr>';
				x = x + '<td>productSelect_num</td><td>' + data.ar.productSelect_num + '</td>';
				x = x + '</tr><tr><td>productSelect_name</td><td>' + data.ar.productSelect_name + '</td>';
				x = x + '</tr><tr><td>kind_num</td><td>' + data.ar.kind_num + '</td></tr>';
				x = x + '<tr><td>kind_name</td><td>' + data.ar.kind_name + '</td></tr>';
				x = x + '</tr><tr><td>product_name</td><td>' + data.ar.product_name + '</td>';
				x = x + '</tr><tr><td>product_num</td><td>' + data.ar.product_num + '</td></tr>';
				x = x + '</table><div></td></tr>';
				x = x + '<tr><td class="modin_td"><div class="modin_div"><table id="tabin_tab_11">';
				x = x + '<tr><td>PRICE</td><td>' + data.ar.productInfo_price + '</td></tr>';
				x = x + '<tr><td>REG_DATE</td><td>' + data.ar.productInfo_reg_date + '</td></tr>';
				x = x + '<tr><td>REC_DATE</td><td>' + data.ar.productInfo_rec_date + '</td></tr>';
				x = x + '<tr><td>SALERATE</td><td>' + data.ar.productInfo_saleRate + '</td></tr>';
				x = x + '<tr><td>TOTALPRICE</td><td>' + data.ar.productInfo_price*1*((100*1)-(data.ar.productInfo_saleRate)*1)/100 + '</td></tr>';
				
				x = x + '<tr><td>SEARCHWORD</td><td>' + data.ar.productInfo_searchWord + '</td></tr>';
				x = x + '<tr><td>BRAND</td><td>' + data.ar.productInfo_brand + '</td></tr>';
				x = x + '</table><div class="div_fix_pro_info">수정할가격<input class="inp_cl_price" type="number" name="productInfo_price" min="0"><br>';
				x = x + '수정할할인율<input class="inp_cl_saleRate" type="number" name="productInfo_saleRate" step="0.1" min="0"><br>';
				x = x + '수정할검색단어<input class="inp_cl_searchWord" type="text" name="productInfo_searchWord"><br>';
				x = x + '<button class="btn_submit_bt">수 정 하 기</button>';
				x = x + '<input type="hidden" class="inph_cl_pro_num" name="product_num" value="' + data.ar.product_num + '">' + '</div></td>';
				x = x + '<td class="modin_td"><div class="modin_div"><table id="tabin_tab_22">';
				x = x + '<tr><th>SIZE</th><th>COLOR</th><th>EACH</th><th>EACHFIX</th></tr>'
				$.each(data.ar.productEachDTOs, function(index, value) {

					x = x + '<tr class="tr_each_fix"><td>' + value.productSize_size + '</td><td>' + value.productEach_color + '</td>';
					x = x + '<td><label>&nbsp </label>' + value.productEach_each + '&nbsp </td>'
					x = x + '<td>';
					x = x + '<input type="hidden" class="inph_cl_pro_num" name="product_num" value="' + data.ar.product_num + '">';
					x = x + '<input type="hidden" class="inph_cl_pro_size" name="productSize_size" value="' + value.productSize_size + '">';
					x = x + '<input type="hidden" class="inph_cl_pro_color" name="productEach_color" value="' + value.productEach_color + '">';
					x = x + '<input style="width:40px;" type="number" class="inp_cl_each" name="productEach_each>">';
					x = x + '<input type="button" class="each_fix_button_submit" value="수정"></td></tr>'
				});

				x = x + '</table><div></td></tr></table>'
				$("#div_modin_main").html(x);
				mastProductEachFix();
				mastProductInfoFix();
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}

	function mastProductInfoFix() {
		$(".div_fix_pro_info").on('mouseenter', function() {
			alert(456456);
			var tis_div = $(this);
			$(this).find(".btn_submit_bt").on('click', function() {
				alert(123123);
				var product_num = $(tis_div).find(".inph_cl_pro_num").val();
				var productInfo_price = $(tis_div).find(".inp_cl_price").val();
				var productInfo_saleRate = $(tis_div).find(".inp_cl_saleRate").val();
				var productInfo_searchWord = $(tis_div).find(".inp_cl_searchWord").val();
				if (productInfo_price != "" && productInfo_saleRate != "" && productInfo_searchWord != "") {
					$.ajax({
						url : "../json/mastProductInfoFix",
						type : "post",
						data : {
							product_num : product_num,
							productInfo_price : productInfo_price,
							productInfo_saleRate : productInfo_saleRate,
							productInfo_searchWord : productInfo_searchWord
						},
						success : function(data) {
							if (data == 1) {
								alert("수정성공");
							} else {
								alert("수정실패");
							}
							ajaxfirst(product_num);
						},
						error : function(request, status, error) {
							alert("code:" + request.status + "\n" + "error:" + error);
						}
					});
				} else {
					alert("값을 모두 입력해 주세요");
				}
			});
		});
		$(".div_fix_pro_info").on('mouseleave', function() {
			$(this).find(".btn_submit_bt").off('click');
		});
	}


	function mastProductEachFix() {
		$(".tr_each_fix").on('mouseenter', function() {
			var tis_tr = $(this);

			$(this).find(".each_fix_button_submit").on('click', function() {
				var product_num = $(tis_tr).find(".inph_cl_pro_num").val();
				var productSize_size = $(tis_tr).find(".inph_cl_pro_size").val();
				var productEach_color = $(tis_tr).find(".inph_cl_pro_color").val();
				var productEach_each = $(tis_tr).find(".inp_cl_each").val();
				alert(123123);
				alert(product_num);
				alert(productSize_size);
				alert(productEach_color);
				alert(productEach_each);



				if (productEach_each != "") {
					$.ajax({
						url : "../json/mastProductEachFix",
						type : "post",
						data : {
							product_num : product_num,
							productSize_size : productSize_size,
							productEach_color : productEach_color,
							productEach_each : productEach_each
						},
						success : function(data) {
							if (data == 1) {
								alert("수정성공");
							} else {
								alert("수정실패");
							}
							ajaxfirst(product_num);

						},
						error : function(request, status, error) {
							alert("code:" + request.status + "\n" + "error:" + error);
						}
					});

				} else {
					alert("수량을 입력해주세요");
				}
			});
		});
		$(".tr_each_fix").on('mouseleave', function() {
			$(this).find(".each_fix_button_submit").off('click');
		});
	}
	$(".cl1").on('change', function() {
		$(".div1").html("");
		for (var i = 0; i < $(".cl1").length; i++) {
			if($(".cl1").eq(i).is(":checked")){
				$(".div1").append('<input type="text" name="cl1" value="'+$(".cl1").eq(i).val()+'">')
			}
		}
	});
	function divhiddenForm(){
		$("#div_hid_sel").html('');
		$("#div_hid_mtpsel").html('');
		$("#div_hid_prosel").html('');
		$("#div_hid_kind").html('');
		$("#div_hid_pro").html('');
		$("#div_hid_size").html('');
		$("#div_hid_color").html('');
		$("#div_hid_sel").append('<input type="hidden" name="sel" value="'+$("input:radio[name='sel']:checked").val()+'">');
		$("#div_hid_mtpsel").append('<input type="hidden" name="mtpSel" value="'+$("input:radio[name='mtpSel']:checked").val()+'">');
		for(var i = 0 ; i < $("input:checkbox[name='productSelect_num']:checked").length ; i++){
			$("#div_hid_prosel").append('<input type="hidden" name="productSelect_num" value="'+$("input:checkbox[name='productSelect_num']:checked").eq(i).val()+'">');
		}
		for(var i = 0 ; i < $("input:checkbox[name='kind_num']:checked").length ; i++){
			$("#div_hid_kind").append('<input type="hidden" name="kind_num" value="'+$("input:checkbox[name='kind_num']:checked").eq(i).val()+'">');
		}
		for(var i = 0 ; i < $("input:checkbox[name='product_num']:checked").length ; i++){
			$("#div_hid_pro").append('<input type="hidden" name="product_num" value="'+$("input:checkbox[name='product_num']:checked").eq(i).val()+'">');
		}
		for(var i = 0 ; i < $("input:checkbox[name='productSize_size']:checked").length ; i++){
			$("#div_hid_size").append('<input type="hidden" name="productSize_size" value="'+$("input:checkbox[name='productSize_size']:checked").eq(i).val()+'">');
		}
		for(var i = 0 ; i < $("input:checkbox[name='productEach_color']:checked").length ; i++){
			$("#div_hid_color").append('<input type="hidden" name="productEach_color" value="'+$("input:checkbox[name='productEach_color']:checked").eq(i).val()+'">');
		}
		$("#form_hidden_asd").submit();
	}
	function pageing(){
		$(".n_pageing").on('click',function(){
			$("input:hidden[name='curPage']").val($(this).text());
			divhiddenForm();
		})
		$(".a_prev").on('click',function(){
			$("input:hidden[name='curPage']").val($(this).find(".inh_prev").val());
			divhiddenForm();
		})
		$(".a_next").on('click',function(){
			$("input:hidden[name='curPage']").val($(this).find(".inh_next").val());
			divhiddenForm();
		})
	}
	function selBox(){
		$(".p_param").on('change',function(){
			divhiddenForm();
		});
	}
	function allCheckBoxes(){
		$("#inp_id_ck_prosel").on('change',function(){
			if($(this).is(':checked')){
				$("input:checkbox[name='productSelect_num']").prop("checked", true);
			}else{
				$("input:checkbox[name='productSelect_num']").prop("checked", false);
			}
			divhiddenForm();
		});
		$("#inp_id_ck_kind").on('change',function(){
			if($(this).is(':checked')){
				$("input:checkbox[name='kind_num']").prop("checked", true);
			}else{
				$("input:checkbox[name='kind_num']").prop("checked", false);
			}
			divhiddenForm();
		});
		$("#inp_id_ck_pro").on('change',function(){
			if($(this).is(':checked')){
				$("input:checkbox[name='product_num']").prop("checked", true);
			}else{
				$("input:checkbox[name='product_num']").prop("checked", false);
			}
			divhiddenForm();
		});
		$("#inp_id_ck_size").on('change',function(){
			if($(this).is(':checked')){
				$("input:checkbox[name='productSize_size']").prop("checked", true);
			}else{
				$("input:checkbox[name='productSize_size']").prop("checked", false);
			}
			divhiddenForm();
		});
		$("#inp_id_ck_color").on('change',function(){
			if($(this).is(':checked')){
				$("input:checkbox[name='productEach_color']").prop("checked", true);
			}else{
				$("input:checkbox[name='productEach_color']").prop("checked", false);
			}
			divhiddenForm();
		});
	}


	jQuery.ajaxSettings.traditional = true;
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

#tab_modin {
	
}

.modin_div {
	width: 250px;
	height: 350px;
	overflow: scroll;
}
input[type="checkbox"],input[type="radio"]{
width:15px;
height: 15px;
}
.labelccc{
text-align: center;
font-weight: bold;

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
						<div style="display: inline-block;">
							<form id="form_hidden_asd"
								action="${pageContext.request.contextPath}/mast/mastProductList"
								method="post">
								<div id="div_hid_sel">
								</div>
								<div id="div_hid_mtpsel">
								</div>
								<div id="div_hid_prosel">
								</div>
								<div id="div_hid_kind">
								</div>
								<div id="div_hid_pro">
								</div>
								<div id="div_hid_size">
								</div>
								<div id="div_hid_color">
								</div>
								<div id="div_hid_curPage">
								<input type="hidden" name="curPage" value="${pageing.curPage}">
								</div>
								<div id="div_hid_perPage">
								</div>
							</form>
						</div>
						<div class="center-block"  style="display: inline-block;">
							<nav aria-label="Page navigation">
								<ul class="pagination">
									<c:if test="${!empty list}">

										<li><c:if test="${pageing.curBlock>1}">
												<a class="a_prev pageMove" aria-label="Previous"
													style="cursor: pointer"><input class="inh_prev"
													type="hidden" value="${pageing.startNum-1}"> <span
													aria-hidden="true">&laquo;</span> </a>
											</c:if></li>
										<li><c:forEach begin="${pageing.startNum}" step="1"
												end="${pageing.lastNum}" var="i">

												<a style="cursor: pointer" class="n_pageing">${i}</a>
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
						<!--      -->
						<!--     임시 페이지 이동   -->
						<a href="${pageContext.request.contextPath}/mast/mastProductList">MAST product List</a><br>
						<a href="${pageContext.request.contextPath}/mast/mastProductListEach0">MAST productEach0</a><br>
						<a href="${pageContext.request.contextPath}/mast/mastBuyList">MAST BuyList</a><br>
						<a href="${pageContext.request.contextPath}/mast/mastBuyListPay">MAST BuyListPay</a><br>
						
						
						
						
						<div id="selector">
							<div id="div_sel_sel"
								style="float: left; width: 10%; height: 100px; overflow: scroll; text-align: right;">
								<label class="labelccc">순서1</label><br>
								최신순<input class="p_param" type="radio" name="sel" value="1" <c:if test="${map.sel == 1}">
								checked="checked"
								</c:if>
								><br>
								오래된순<input class="p_param" type="radio" name="sel" value="2" <c:if test="${map.sel == 2}">
								checked="checked"
								</c:if>
								><br>
								세일높은순<input class="p_param" type="radio" name="sel" value="3" <c:if test="${map.sel == 3}">
								checked="checked"
								</c:if>
								><br>
								세일낮은순<input class="p_param" type="radio" name="sel" value="4" <c:if test="${map.sel == 4}">
								checked="checked"
								</c:if>
								><br>
								가격높은순<input class="p_param" type="radio" name="sel" value="5" <c:if test="${map.sel == 5}">
								checked="checked"
								</c:if>
								><br>
								가격낮은순<input class="p_param" type="radio" name="sel" value="6" <c:if test="${map.sel == 6}">
								checked="checked"
								</c:if>
								>
							</div>
							<div id="div_mtpSel_sel"
								style="float: left; width: 10%; height: 100px; overflow: scroll; text-align: right;">
								<label class="labelccc">순서2</label><br>
								기본<input class="p_param" type="radio" name="mtpSel" value="1" <c:if test="${map.mtpSel == 1}">
								checked="checked"
								</c:if>
								><br>
								세일있음<input class="p_param" type="radio" name="mtpSel" value="2" <c:if test="${map.mtpSel == 2}">
								checked="checked"
								</c:if>
								><br>
								세일없음<input class="p_param" type="radio" name="mtpSel" value="3" <c:if test="${map.mtpSel == 3}">
								checked="checked"
								</c:if>
								><br>
								재고있음<input class="p_param" type="radio" name="mtpSel" value="4" <c:if test="${map.mtpSel == 4}">
								checked="checked"
								</c:if>
								><br>
								재고없음<input class="p_param" type="radio" name="mtpSel" value="5" <c:if test="${map.mtpSel == 5}">
								checked="checked"
								</c:if>
								><br>
							</div>
							<div id="div_proSel_sel"
								style="float: left; width: 10%; height: 100px; overflow: scroll; text-align: right;">
								<label class="labelccc">대분류</label><input id="inp_id_ck_prosel" type="checkbox"><br>
								<c:forEach var="proselc" items="${productSelectList}">
						${proselc.productSelect_name}<input class="in_ck_proSelNum p_param" type="checkbox"
										name="productSelect_num" value="${proselc.productSelect_num}"
										<c:forEach var="listasd" items="${map.productSelect_num}"> 
							<c:if test="${proselc.productSelect_num == listasd}">
							checked="checked"</c:if>
					</c:forEach>>
									<br>
								</c:forEach>
							</div>
							<div id="div_kind_sel"
								style="float: left; width: 15%; height: 100px; overflow: scroll; text-align: right;">
								<label class="labelccc">소분류</label><input id="inp_id_ck_kind" type="checkbox"><br>
								<c:forEach var="proselc" items="${kindList}">
						${proselc.kind_name}<input class="in_ck_kindNum p_param" type="checkbox" name="kind_num"
										value="${proselc.kind_num}"
										<c:forEach var="listasd" items="${map.kind_num}"> 
							<c:if test="${proselc.kind_num == listasd}">
							checked="checked"</c:if>
					</c:forEach>>
									<br>
								</c:forEach>
							</div>
							<div id="div_pro_sel"
								style="float: left; width: 15%; height: 100px; overflow: scroll; text-align: right;">
								<label class="labelccc">상품번호</label><input id="inp_id_ck_pro" type="checkbox"><br>
								<c:forEach var="proselc" items="${productList}">
						${proselc.product_name}<input class="in_ck_proNum p_param"  type="checkbox" name="product_num"
										value="${proselc.product_num}"
										<c:forEach var="listasd" items="${map.product_num}"> 
							<c:if test="${proselc.product_num == listasd}">
							checked="checked"</c:if>
					</c:forEach>>
									<br>
								</c:forEach>
							</div>
							<div id="div_size_sel"
								style="float: left; width: 10%; height: 100px; overflow: scroll; text-align: right;">
								<label class="labelccc">사이즈</label><input id="inp_id_ck_size" type="checkbox"><br>
								<c:forEach var="proselc" items="${productSizeList}">
						${proselc.productSize_size}<input type="checkbox"  class="in_ck_proSize p_param"
										name="productSize_size" value="${proselc.productSize_size}"
										<c:forEach var="listasd" items="${map.productSize_size}"> 
							<c:if test="${proselc.productSize_size == listasd}">
							checked="checked"</c:if>
					</c:forEach>>
									<br>
								</c:forEach>
							</div>
							<div id="div_color_sel"
								style="float: left; width: 15%; height: 100px; overflow: scroll; text-align: right;">
								<label class="labelccc">색상</label><input id="inp_id_ck_color" type="checkbox"><br>
								<c:forEach var="proselc" items="${productColorList}">
						${proselc.productEach_color}<input class="in_ck_proColor p_param" type="checkbox"
										name="productEach_color" value="${proselc.productEach_color}"
										<c:forEach var="listasd" items="${map.productEach_color}"> 
							<c:if test="${proselc.productEach_color == listasd}">
							checked="checked"</c:if>
					</c:forEach>>
									<br>
								</c:forEach>
							</div>
						</div>
						<div id="div_product_list">
							<c:forEach var="list1" items="${list}">
								<div style="width: 330px; border: 1px solid black; float: left;">
									<div class="div_cl_img_asd"
										style="display: inline-block; cursor: pointer; float: left;">
										<input class="inh_product_num" type="hidden"
											name="product_num" value="${list1.productDTO.product_num}">
										<img
											<c:if test="${!empty sessionScope.member}">
										data-toggle="modal" data-target="#basketModal"
							data-backdrop="true"
										</c:if>
											style="float: left;" width="200px" height="200px"
											src="${pageContext.request.contextPath}/resources/testPic/${list1.productPicDTO.productPic_pic}">
									</div>
									<table id="tab_mast_productList"
										style="display: inline-block; float: left;">
										<tr>
											<td>판매수</td>
											<td>${list1.selCount}</td>
										</tr>
										<tr>
											<td>pS.num</td>
											<td>${list1.productSelectDTO.productSelect_num}</td>
										</tr>
										<tr>
											<td>pS.name</td>
											<td>${list1.productSelectDTO.productSelect_name}</td>
										</tr>
										<tr>
											<td>k.num</td>
											<td>${list1.kindDTO.kind_num}</td>
										</tr>
										<tr>
											<td>k.name</td>
											<td>${list1.kindDTO.kind_name}</td>
										</tr>
										<tr>
											<td>p.num</td>
											<td>${list1.productDTO.product_num}</td>
										</tr>
										<tr>
											<td>p.name</td>
											<td>${list1.productDTO.product_name}</td>
										</tr>
										<tr>
											<td>price</td>
											<td>${list1.productInfoDTO.productInfo_price}</td>
										</tr>
										<tr>
											<td>sale</td>
											<td>${list1.productInfoDTO.productInfo_saleRate}</td>
										</tr>
										<tr>
										<td>totalPrice</td>
										<td><c:set
															var="number"
															value="${list1.productInfoDTO.productInfo_price*(100-list1.productInfoDTO.productInfo_saleRate)/100}" />
														<fmt:parseNumber var="total" value="${number}"
															type="number" integerOnly="true" /> ${total}</td>
										</tr>
									</table>
								</div>
							</c:forEach>
						</div>
	

					</div>
					<!--  view E  -->
				</div>
			</div>
		</div>

	</div>


	<div class="modal fade" id="basketModal" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div id=div_modin_main>
					<table id="tab_modin">
						<tr>
							<td></td>
							<td><table id="tabin_tab_12">
									<tr>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
									</tr>

								</table></td>
						</tr>
						<tr>
							<td><table id="tabin_tab_11">
									<tr>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
									</tr>

								</table></td>
							<td><table id="tabin_tab_22">
									<tr>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td></td>
									</tr>

								</table></td>
						</tr>
					</table>
				</div>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>

</body>
</html>