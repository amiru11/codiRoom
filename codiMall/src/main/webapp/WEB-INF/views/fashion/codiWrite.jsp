<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>나만의 코디</title>
<link rel="stylesheet"
	href="http://fonts.googleapis.com/earlyaccess/hanna.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/capture/html2canvas.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/capture/html2canvas.svg.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/css/pagination.css"
	rel="stylesheet">
<style type="text/css">
	body {
		margin: 0;
	}
	canvas {
		border: 1px solid black;
		background-color: black;
		display: none;
	}
.ppp{
	position : absolute;
	top : 0;
	left : 550px;
}	
#ul_productSelect > li > a {
	font-size : 16px;
}
#ul_kind > li > a{
	list-style: none;
	font-size : 14px;
}
#ul_kind > li > a:HOVER{
	background-color: #fff;
	color : #006633;
}
.list_pro > a{
	cursor: pointer;text-decoration: none;color : black;
}
</style>
</head>
<body style="font-family: 'hanna';">
<div style="width: 1000px; height: 1000px;" id="a">
	<div style="background : #fff; border : 2px solid #dce2eb;width: 500px; height: 500px;display: inline-block;" id="b"></div>
	<!-- 상품 리스트 :S -->
	<div class="ppp">
		<ul id="ul_productSelect" class="list-inline"></ul>
		<ul id="ul_kind" class="list-inline"></ul>
	</div>
	<!-- 상품 리스트 :E -->
	
	<!-- 상품 이미지 : S -->
	<div id="div_product"></div>
	<!-- 상품 이미지 : E -->
	
	<!-- PAGINATIOIN:S -->
	<div id="pageing"></div>
	<!-- PAGINATIOIN:E -->
</div>

	<!-- 코디저장 할 것들 -->
	<div class="input-group" style="width : 400px; position : absolute; top : 460px; left : 550px;">
		<input type="text" id="title" placeholder="ex)#남자코디 #남친룩" class="form-control" style="width : 200px; display: inline-block;">
		<input type="hidden" id="product_num">
		<button class="btn btn-info btn-md">코디등록<span class="glyphicon glyphicon-ok"></span>  </button>
	</div>
	
	<canvas width="500px" height="500px"></canvas>
<!-- <a></a> -->

<script type="text/javascript">
//코디 리스트 값 배열
var codi = [];
function codiArray(pNum) {
	var check = true;
 	for(var i=0; i<codi.length; i++){
		if(pNum == codi[i]){
			check = false;
		}
	}
 	if(check){
 		codi.push(pNum);
 		$("#product_"+pNum).clone().appendTo($("#b"));//기존에 있던 div를 캔버스안에서 복제
 	}
}
//상품 리스트
//페이지 열리면 실행
$(function(){
	getProductSelectList();
});
//첫번째 메뉴
function getProductSelectList(){
	$.ajax({
		url : "../json/codiProductSelectList",
		type : "post",
		dataType : 'json',
		data : {
		},
		success : function(data) {
			$("#div_productSelect").html("");
			var productSelect = "";
			var id = "";
			var productSelect_num = "";
			$.each(data.ar, function(index, value) {
				productSelect += "<li style='list-style: none;'><a id='productSelect_"+index+"' class='btn btn-default btn-sm' onclick='productView("+value.productSelect_num+");' name='1' style='background : transparent;border : none;'>" + value.productSelect_name + "</a></li>";
			});
			$("#ul_productSelect").append(productSelect);
		},
		error : function(request, status, error) {
			console.log("code:" + request.status + "\n" + "error:" + error);
		}
	});
}
//첫번째 메뉴 온클릭
function productView(productSelect_num) {
	getKindList(productSelect_num);
}
//두번째 메뉴
function getKindList(productSelect_num){
	$.ajax({
		url : "../json/codiKindList",
		type : "post",
		dataType : 'json',
		data : {
			productSelect_num:productSelect_num
		},
		success : function(data) {
			$("#ul_kind").html("");
			var kind = "";
			var id = "";
			var kind_num = "";
			$.each(data.ar, function( index, value ) {
				kind += "<li style='list-style: none;'><a id='kind_" + index + "'class='btn btn-default btn-sm'  onclick='kindView("+value.kind_num+")' style='background : transparent;border : none;' >"+value.kind_name+"</a></li>"
	    	});
			$("#ul_kind").html(kind);
		},
		error : function(request, status, error) {
			console.log("code:" + request.status + "\n" + "error:" + error);
		}
	});
}
//두번째 메뉴 온클릭
function kindView(kin_num) {
	getCodiProductList(kin_num);
}
var v = "";

//마지막 메뉴 상품 리스트
function getCodiProductList(kind_num){
	$.ajax({
		url : "../json/codiProductList",
		type : "post",
		dataType : 'json',
		data : {
			kind_num:kind_num
		},
		success : function(data) {
			$("#div_product").html("");
			var productList = "";
			
			$.each(data.ar, function( index, value ) {//상품이미지 출력하기 위해 가지고 있는 상품리스트를 가져온다(기본적으로 6개씩 출력)
				//mousemove 이벤트로 div를 캔버스로 움직이도록 해주기//
				productList += "<div class='product' id='product_"+value.productDTO.product_num+"' style='display : inline-block; width: 200px; height: 200px' onmousedown='move(this,"+value.productDTO.product_num+");'>";
				//div안에 있는 상품이미지
				productList += "<img alt='' src='/codi/resources/testPic/"+value.productPicDTO.productPic_pic+"' width='200' height='200'>";
				//가져가야할 상품의 x축 ,y축 value
				productList += "<input id='x-"+value.productDTO.product_num+"' type='hidden' value='' readonly='readonly'><input id='y-"+value.productDTO.product_num+"' type='hidden' value='' readonly='readonly'>";
				productList += "</div>";
				console.log(index+" : "+ value.productDTO.product_num+" : "+value.productPicDTO.productPic_pic+" : "+value.productDTO.product_name);
	    	});

			//pagination해주기
 			var pageing = "";
 			//alert(${a}); background : url(${pageContext.request.contextPath}/resources/testPic/"+value.productPicDTO.productPic_pic+");//
 			pageing += '<nav aria-label="Page navigation"><ul class="pagination"><li>';
 			pageing += '<a class="a_prev" aria-label="Previous" style="cursor: pointer"><input class="inh_prev" type="hidden" value="'+(data.pageing.startNum*1-1)+'"><span aria-hidden="true">&laquo;</span>';
			pageing += '</a></li><li><c:forEach begin="1" step="1" end="5" var="i"><a style="cursor: pointer" class="N_pageing" onclick="gogo();">${i}</a></c:forEach></li>';
			pageing += '<li><c:if test="'+(data.pageing.curBlock < data.pageing.totalBlock)+'"><a class="a_next" aria-label="Next" style="cursor: pointer"><input class="inh_next" type="hidden" value="'+(data.pageing.lastNum*1+1)+'}"><span aria-hidden="true">&raquo;</span></a></c:if></li></ul></nav>';
			 //console.log("되라" + data.pageing.startNum*1);
 			//console.log("11111" + data.pageing.startRowNum);
			//console.log("22222" + data.pageing.lastLowNum); 
			$("#div_product").html(productList);
			$("#pageing").html(pageing); 
			
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "error:" + error);
		}
	});
}
//이미지 무빙
function move(a, product_num) {
    $(a).css({
    	"position" : 'absolute'
    });
	var x = event.pageX;//이벤트발생시 X좌표
	var y = event.pageY;//이벤트발생시 Y좌표
	var product = $(a).attr("id");
	var xVal = $(a).css('left').replace(/[^0-9]/g, "");//숫자이외의 것이 들어가면 left를 공백으로
	var yVal = $(a).css('top').replace(/[^0-9]/g, "");//숫자이외의 것이 들어가면 top을 공백으로

	$(a).mousemove(function(event) {//지금 클릭한 div 상품을 움직일 때,
        $("#x-"+product_num).val($("#"+product).css('left').replace(/[^0-9]/g, ""));
        $("#y-"+product_num).val($("#"+product).css('top').replace(/[^0-9]/g, ""));
        $(a).css({//left와 top를 바꿔준다
           "left" : xVal * 1 + ((event.pageX) * 1 - x * 1) * 1,
           "top" : yVal * 1 + ((event.pageY) * 1 - y * 1) * 1
        });
        	$(a).on("mouseup mouseout", function(event) {//mouseup 또는 mouseout 이벤트 발생시
        		$(a).off("mousemove");//mousemove를 중지시킴
		        xVal = $(a).css('left').replace(/[^0-9]/g, "");
		        yVal = $(a).css('top').replace(/[^0-9]/g, "");
			       	if(xVal < 500 && yVal < 500){
			    		 //상품 번호를 배열에 넣음
			        	 codiArray(product_num);
			    		 //이미지 복사
			    	 }else {
			    		 //이미지 삭제&상품 번호 삭제
			    		 for(var i=0; i<codi.length; i++){
			    			 if(product_num == codi[i]){
			    					codi.splice(i,1);
			    					$(a).remove();
			    				}
			    		 }
			    	 }
		    		 console.log("codi : "+codi);
			});
     });
}
function Check() {
	var title = $("#title").val();
	var product_num = $("#product_num").val();
	var check = false;
}
var canvas = document.querySelector("canvas");
	
//codi submit해주기	
document.querySelector("button").addEventListener("click", function() {
	html2canvas(document.querySelector("#a"), {canvas: canvas}).then(function(canvas) {
		$("#product_num").val(codi);
		var data = canvas.toDataURL();
		var product_num = $("#product_num").val();
		var title = $("#title").val();
		//코디 태그 검사 및 코디 올라가 있는지 검사
		if(title == ""){
			alert("# 태그를 입력해주세요.");
			return false;
		}
		if(product_num == ""){
			alert("상품을 올려 주세요.");
			return false;
		}
		/* alert(data);
		alert(product_num);
		alert(title); */
		//코디 등록
       	$.ajax({
            url: "${pageContext.request.contextPath}/fashion/codiCreate",
       		type: "POST",
               data : {
               	data : data,
               	product : product_num,
               	title : title
               },
               success: function(data) {
            	//alert(data);   
               	alert(data.message);
					if(data.result = 1){
						opener.location.reload();//부모창리프래쉬
						window.close();//윈도우 클로즈
					}
               }
       	});
	});
});    
</script>
</body>
</html>