<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/product/productView.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/zoomItem.js"></script>
<script type="text/javascript">
	$(function() {
		qnaList();
		$("#sel_size_a").change(function(){
			if($("#sel_size_a").val()!=""){
				$("#buttonSet").css("display","none");
				$("#quantityField").css("display","none")
				selSize();
				$("#colorField").fadeIn("slow");
			}else{
				$("#buttonSet").css("display","none");
				$("#quantityField").css("display","none")
				$("#colorField").css("display","none");
				$("#sel_size_b").html("");
			}
		});

		
		$("#sel_size_b").blur(function(){
			$("#inh_productSize_size").val($("#sel_size_a").val());
			$("#inh_productEach_color").val($("#sel_size_b").val());
		});
		$("#sel_size_b").change(function(){
			if($("#sel_size_b").val()!=""){
				$("#quantityField").fadeIn("slow");
				$("#buttonSet").fadeIn("slow");
				$("#inh_productSize_size").val($("#sel_size_a").val());
				$("#inh_productEach_color").val($("#sel_size_b").val());
				$("#inp_each").val(1);
				$("#inh_productEach_each").val($("#inp_each").val());	
			}else{
				$("#quantityField").css("display","none");
				$("#buttonSet").css("display","none");
			}
		});

		$("#inp_each").change(function(){
			numcheck();
			eachCheck();
		});
		$("#inp_each").keydown(function(){
			numcheck();
			eachCheck();
		});
		$("#inp_each").keyup(function(){
			numcheck();
			eachCheck();
		});
		
		
		$("#btn_basket").click(function(){
			if($("#sel_size_b").val()!=null && $("#sel_size_a").val()!=null ){
				if($("#inp_each").val()>0){
					$.ajax({
					    url : "../basket/basketAdd",
					    type : "post",
					    data : {
					    	product_num:${view.product_num},
					    	productSize_size:$("#sel_size_a").val(),
					    	productEach_color:$("#sel_size_b").val(),
					    	productEach_each:$("#inp_each").val(),
					    },
					    success: function(data) {
					    	if(data==1){
					    		alert("장바구니 등록성공");
					    	}else{
					    		alert(data);
					    	}
					    	
					    },
					    error:function(request,status,error){
					        alert("code:"+request.status+"\n"+"error:"+error);
					    }
					});
				}else{
					alert("1개이상 입력하세요");
				}
			}else{
				alert("color 선택하세요");
			}
		});
		
		$("#btn_buy").click(function(){
			if($("#sel_size_b").val()!=null){
				if($("#inp_each").val()!=null){
					$("#view_frm").attr("action","${pageContext.request.contextPath}/basket/basketNonBuy");
				}else{
					alert("1개이상 입력하세요");
				}
			}else{
				alert("color 선택하세요");
			}
		});
		
			
		$(".product_quantity_down").click(function(){//수량감소
			var c = parseInt($("#inp_each").val());
			var d = c+1;
			if(d>1){	
				$("#inp_each").val(d);
			}
		});

		$(".product_quantity_up").click(function(){//수량증가
			var c =  parseInt($("#inp_each").val());
			var d = c+1;
			if(d<6){	
				$("#inp_each").val(d);
			}
			alert(c);
		});
		
	});
	
	function selList(){
		$.ajax({
		    url : "../json/productSize",
		    type : "post",
		    data : {
		    	product_num:${view.product_num}
		    },
		    success: function(data) {
		    	var x='<option value="">SIZE</option>';
		    	$.each(data, function( index, value ) {
		    		   x=x+"<option value="+value+">"+value+"</option>";
		    		});
		    	$("#sel_size_a").html(x);
		    },
		    error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"error:"+error);
		    }
		});
	}
	function selSize(){
		$.ajax({
		    url : "../json/productEach",
		    type : "post",
		    dataType : 'json',
		    data : {
		    	product_num:${view.product_num},
		    	productSize_size:$("#sel_size_a").val()
		    },
		    success:function(data) {
		    	var x='<option value="">COLOR</option>';
		    	var y="";
		    	$.each(data.eachList, function( index, value ) {
		    		x=x+"<option value="+value.productEach_color+">"+value.productEach_color+'_'+value.productEach_each+"</option>";
		    		y=y+value.productEach_color+'_'+value.productEach_each+'<input class="'+value.productEach_color+'" type="text" value="'+value.productEach_each+'">';
		    	});
		    	$("#div_hidden_each").html(y);
		    	$("#sel_size_b").html(x);
		    	
		    },
		    error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"error:"+error);
		    }
		});
	}
	
	function eachCheck(){
		var as =  $("#inh_productEach_color").val(); 
		var b = $("."+as+"").val()*1;
		var c = $("#inp_each").val()*1;
		if(c*1>b*1){
			alert("재고초과");
			$("#inp_each").val(b);
		}else{
		$("#inh_productEach_each").val($("#inp_each").val());
		}
	}
	function numcheck()  {  
		  if ((event.keyCode==69))  {
		      event.returnValue=false;
		  }       
		 }
	
	function qnaList(){
		$.ajax({
		    url : "../board/productQnAList",
		    type : "get",
		    data : {
		    	curPage : 1,
		    	perPage : 10,
		    	product_num :  ${view.product_num}	
		    },
		    success: function(data) {
		    	console.log(data);
		    	$("#qna").html(data.trim());
		    },
		    error:function(request,status,error){
		        console.log("code:"+request.status+"\n"+"error:"+error);
		    }			
		});
	}
	function goPopUp(){
		window.open("${pageContext.request.contextPath}/product/qna_form?product_num=${view.product_num}","ITEM QnA","width=650,height=720");
	}	
	
	//작은 이미지를 큰 이미지로//
	var currentImageIdx = 0;
	if (currentImageIdx == "") {
		currentImageIdx = 0;
	}	
	
	var smallImages = new Object();

	function changeImg(img_id, bigimg_id, idx, big_yn){
			
		var imgview = document.getElementById(bigimg_id);
		var img_obj = document.getElementById(img_id);

		console.log(imgview);
		console.log(img_obj);
		
		currentImageIdx = parseInt(idx);
		
		console.log(currentImageIdx);
		
		if(smallImages[currentImageIdx] == undefined) {

			// 이미지 객체 만들기
			smallImages[currentImageIdx] = new Image();

			if(bigimg_id == "org_bigimg"){
				var src = img_obj.src.replace("_60.", "_960.");
			} else {
				var src = img_obj.src;
			}
			console.log("src : " + src);
			smallImages[currentImageIdx].src = src;
		}

		imgview.src = smallImages[currentImageIdx].src;
	}
	
</script>
</head>
<body>
	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->
	
	<div class="container" style="padding-top:100px;">
		<div class="row">
			<div class="col-sm-12">
				<!-- 왼쪽 이미지부분 -->
				<div class="col-sm-6 left-info">
					<div id="image-block" class="clearfix">
						<span class="image_loader" style="opacity: 0; display: none;"></span>
						<div id="big_box" class="product_zoom spotlightActive" style="display:none">
							<div class="product_img_zoom minus_cursor spotlight" id="big_img_area">
								<img src="" id="big_img" alt="" style="position: relative; width: 1200px; background-color: white;" onclick="image_zoom.hideLayer('big_box');">
							</div>
							<span class="btn_close_pop" onclick="image_zoom.hideLayer('big_box');">close</span>
						</div>
						<div id="detail_bigimg" class="product_img_basic plus_cursor">
							<span class="product-img">
								<img src="${pageContext.request.contextPath}/resources/images/product/outer/sideBB_60.png" width="500" title="" alt="" id="bigimg" onclick="image_zoom.showLayer('big_box', 'big_img', 'detail_thumb', currentImageIdx);" style="margin-top: -250px; position: absolute; top: 50%; left: 0px;">
							</span>
						</div>
						<!-- 상품 썸네일 -->
						<div id="detail_thumb">
							<ul class="product_thumb">
								<li onclick="changeImg('thum_0', 'bigimg', '0', 'N');" style="cursor: pointer;">
									<img src="${pageContext.request.contextPath}/resources/images/product/outer/sideBB_60.png" alt="thum" width="100" id="thum_0" big_yn="N" style="display: inline-block; vertical-align: middle"><span class="vertical_standard"></span>
								</li>
								<li onclick="changeImg('thum_1', 'bigimg', '1', 'N');" style="cursor: pointer;">
									<img src="${pageContext.request.contextPath}/resources/images/product/outer/sideBB_detail1_60.jpg" alt="thum" width="100" id="thum_1" big_yn="N" style="display: inline-block; vertical-align: middle"><span class="vertical_standard"></span>
								</li>
								<li onclick="changeImg('thum_2', 'bigimg', '2', 'N');" style="cursor: pointer;">
									<img src="${pageContext.request.contextPath}/resources/images/product/outer/sideBB_detail2_60.jpg" alt="thum" width="100" id="thum_2" big_yn="N" style="display: inline-block; vertical-align: middle"><span class="vertical_standard"></span>
								</li>
								<li onclick="changeImg('thum_3', 'bigimg', '3', 'N');" style="cursor: pointer;">
									<img src="${pageContext.request.contextPath}/resources/images/product/outer/sideBB_detail3_60.jpg" alt="thum" width="100" id="thum_3" big_yn="N" style="display: inline-block; vertical-align: middle"><span class="vertical_standard"></span>
								</li>
							</ul>
						<!--//상품 썸네일-->
						</div>						
					</div>
				</div>
				<div class="col-sm-6 right-info" style="padding-left : 50px;">
					<div class="item-title clearfix">
						<div class="item-brand pull-left">
							<img src="${pageContext.request.contextPath}/resources/images/product/brand/esnocturne.gif" alt="">
						</div>
						<h1>${view.product_name}</h1>
						<div class="item-manufacture">BRAND NAME</div>
					</div>
					<form id="view_frm" method="post">
						<div class="infoBox">
							<div class="item-price clearfix">
								<div class="all-price-info">
									<p class="now-price">
										<fmt:formatNumber value="${view.productInfo_price*(100-view.productInfo_saleRate)/100}" currencySymbol="" type="currency"/>원
									</p>
									<p class="old-price"><fmt:formatNumber value="${view.productInfo_price}" currencySymbol="" type="currency"/>원</p>
									<p class="reduction-percent">(-<fmt:formatNumber value="${(view.productInfo_saleRate)}" pattern="#.##" />%)</p>
								</div>
								<div id="product_comments_block_extra" class="no-print">
									<div class="comments_note clearfix">
										<span style="display: none;">Rating&nbsp;</span>
										<div class="star_content clearfix">
											<div class="star star_on"></div>
											<div class="star star_on"></div>
											<div class="star star_on"></div>
											<div class="star star_on"></div>
											<div class="star"></div>
										</div>
									</div>
									<ul class="comments_advices">
										<li>
											<a href="#idTab5" class="reviews" title="Read reviews">
												Read reviews (<span>1</span>)
											</a>
										</li>
									</ul>
								</div>
							</div>
							<div class="product_select clearfix">
								<div id="attributes">
									<div class="clearfix"></div>
									<fieldset class="fieldset_list clearfix">
										<label>SIZE&nbsp;</label>
										<div class="attribute_list">
											<div class="selector" style="margin-left:25px;">
												<select id="sel_size_a" class="form-control"></select>
											</div>
										</div>
									</fieldset>
									<fieldset class="fieldset_list clearfix" id="colorField"  style="display: none;">
										<label>COLOR&nbsp;</label>
										<div class="attribute_list">
											<div class="selector">
												<!-- <span>COLOR</span> -->
												<select id="sel_size_b" class="form-control"></select>
											</div>
										</div>
									</fieldset>
									<fieldset class="fieldset_list clearfix" id="quantityField"  style="display: none;">
										<label>QUANTITY&nbsp;</label>
										<div class="attribute_list" id="quantity">
											<input id="inp_each" accept="e" type="number" min="1" step="1">											
											<a class="btn btn-default button-minus product_quantity_down" style="margin-left: 20px;">
												<span><i class="glyphicon glyphicon-minus"></i></span>
											</a>
											<a class="btn btn-default button-plus product_quantity_up">
												<span><i class="glyphicon glyphicon-plus" style="left:1px;"></i></span>
											</a>
										</div>
									</fieldset>
									<fieldset class="fieldset_list clearfix" id="buttonSet"  style="display: none;">
										<div class="attribute_list">
											<a id="btn_buy" class="btn btn-default" type="button">BUY</a>
											<a id="btn_basket" class="btn btn-default" type="button">BASKET</a>
										</div>
									</fieldset>
								</div>
							</div>
						</div>
					</form>
					<div id="div_hidden_each" style="display: none;"></div>
					<script type="text/javascript">
						selList();
					</script>				
				</div>
				
			</div>
			<div class="col-sm-12" style="margin-top: 100px;">
				<ul class="nav nav-tabs item-nav">
					<li class="active"><a href="#a">상세설명</a></li>
					<li><a href="#b">배송관련</a></li>
					<li><a href="#c">상품문의</a></li>
				</ul>
				<div class="jumbotron">
					<div id="a">
						<div class="item-contents">
							<div class="rte-contents">
								<h3>Product Detail</h3>
								<p>심플한 디자인과 깔끔한 핏의 3버튼 모직코트.</p>
								<p>어디에나 무난하고 고급스럽게 잘 어울립니다.</p>
								<h3>Size</h3>
								<p>M:총장94.5 / 어깨 45 / 가슴 60 / 소매 60</p>
								<p>L:총장96 / 어깨 47 / 가슴 62.5 / 소매 62</p>
								<h3>Material&Washing</h3>
								<p>울 70% / 폴리 20% / 레이온 10%</p>
								<p>드라이클리닝 권장</p>
							</div>

						</div>
					</div>
					<%@ include file="/resources/temp/product/productView.jspf"%>
					
					<div id="c">
						<h3 style="display: inline-block;">Q&A</h3><span>상품문의</span>
						<div id="qna"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>	
	<!-- Footer:E -->


</body>
</html>