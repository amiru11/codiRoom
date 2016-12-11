<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		
		$("#sel_size_a").change(function(){
			if($("#sel_size_a").val()!=""){
				$("#inp_each").css("display","none")
				selSize();
				$("#sel_size_b").css("display","inline-block");
			}else{
				$("#inp_each").css("display","none")
				$("#sel_size_b").css("display","none");
				$("#sel_size_b").html("");
			}
		});

		
		$("#sel_size_b").blur(function(){
			$("#inh_productSize_size").val($("#sel_size_a").val());
			$("#inh_productEach_color").val($("#sel_size_b").val());
		});
		$("#sel_size_b").change(function(){
			if($("#sel_size_b").val()!=""){
				$("#inp_each").css("display","inline-block")
				$("#inh_productSize_size").val($("#sel_size_a").val());
				$("#inh_productEach_color").val($("#sel_size_b").val());
				$("#inp_each").val(1);
				$("#inh_productEach_each").val($("#inp_each").val());	
			}else{
				$("#inp_each").css("display","none")
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
		
		

	});
	
	function selList(){
		$.ajax({
		    url : "../json/productSize",
		    type : "post",
		    data : {
		    	product_num:${view.product_num}
		    },
		    success: function(data) {
		    	var x='<option value="">SIZE를 고르세요</option>';
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
		    	var x='<option value="">Color를 고르세요</option>';
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
								<img src="${pageContext.request.contextPath}/resources/images/product/sideBB_60.png" width="500" title="" alt="" id="bigimg" onclick="image_zoom.showLayer('big_box', 'big_img', 'detail_thumb', currentImageIdx);" style="margin-top: -250px; position: absolute; top: 50%; left: 0px;">
							</span>
						</div>
						<!-- 상품 썸네일 -->
						<div id="detail_thumb">
							<ul class="product_thumb">
								<li onclick="changeImg('thum_0', 'bigimg', '0', 'N');" style="cursor: pointer;">
									<img src="${pageContext.request.contextPath}/resources/images/product/sideBB_60.png" alt="thum" width="60" id="thum_0" big_yn="N" style="display: inline-block; vertical-align: middle"><span class="vertical_standard"></span>
								</li>
								<li onclick="changeImg('thum_1', 'bigimg', '1', 'N');" style="cursor: pointer;">
									<img src="${pageContext.request.contextPath}/resources/images/product/sideBB_detail1_60.jpg" alt="thum" width="60" id="thum_1" big_yn="N" style="display: inline-block; vertical-align: middle"><span class="vertical_standard"></span>
								</li>
								<li onclick="changeImg('thum_2', 'bigimg', '2', 'N');" style="cursor: pointer;">
									<img src="${pageContext.request.contextPath}/resources/images/product/sideBB_detail2_60.jpg" alt="thum" width="60" id="thum_2" big_yn="N" style="display: inline-block; vertical-align: middle"><span class="vertical_standard"></span>
								</li>
								<li onclick="changeImg('thum_3', 'bigimg', '3', 'N');" style="cursor: pointer;">
									<img src="${pageContext.request.contextPath}/resources/images/product/sideBB_detail3_60.jpg" alt="thum" width="60" id="thum_3" big_yn="N" style="display: inline-block; vertical-align: middle"><span class="vertical_standard"></span>
								</li>
							</ul>
						<!--//상품 썸네일-->
						</div>						
					</div>
				</div>
				<div class="col-sm-6 right-info">
					<div class="item-title clearfix">
						<div class="item-brand pull-left">
							<img src="${pageContext.request.contextPath}/resources/images/product/brand/esnocturne.gif" alt="">
						</div>
						<h1>${view.product_name}</h1>
						<div class="item-manufacture">BRAND NAME</div>
					</div>
<%-- 					<table class="table">
						<tr>
							<td>PRODUCT_NUM</td>
							<td>${view.product_num}</td>
							<td>PRODUCT_NAME</td>
							<td>${view.product_name}</td>
							<td>PRODUCT_PRICE</td>
							<td>${view.productInfo_price}</td>
							<td>PRODUCT_SALERATE</td>
							<td>${view.productInfo_saleRate}</td>
						</tr>
						<tr>
							<td>PRODUCT_SEARCHWORD</td>
							<td>${view.productInfo_searchWord}</td>
							<td>PRODUCT_KINDNUM</td>
							<td>${view.kind_num}</td>
						</tr>
						<tr>
							<td><select id="sel_size_a"></select></td>
							<td><select id="sel_size_b" style="display: none;"></select></td>
							<td><input id="inp_each" accept="e" type="number" min="1"
								step="1" style="display: none;"></td>
						</tr>
						<tr>
							<td><form id="view_frm" method="post">
									<input id="inh_product_num" type="text" value="${view.product_num}"
										name="product_num"> <input id="inh_productSize_size"
										type="text" name="productSize_size"> <input
										id="inh_productEach_color" type="text" name="productEach_color">
									<input id="inh_productEach_each" type="text"
										name="productEach_each"> <input id="inh_each_each"
										type="text">
								</form></td>
							<td><input id="btn_buy" type="button" value="BUY"></td>
							<td><input id="btn_basket" type="button" value="BASKET">
							</td>
						</tr>
				
				
				
					</table> --%>
				
					<div id="div_hidden_each"></div>
				
					<button id="btn_aa">aaaaa</button>
					<button id="btn_bb">bbbb</button>
					<script type="text/javascript">
						selList();
					</script>				
				</div>
			</div>
		</div>
	</div>



	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>	
	<!-- Footer:E -->


</body>
</html>