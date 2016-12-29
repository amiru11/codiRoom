<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/capture/html2canvas.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/capture/html2canvas.svg.js"></script>
<style type="text/css">
	body {
		margin: 0;
	}
	canvas {
		border: 1px solid black;
		background-color: black;
		display: none;
	}
</style>
<style type="text/css">
.ppp{
	float: right;
}

</style>
</head>
<body>
<div style="background-color: red; width: 1000px; height: 1000px;" id="a">
	<div style="background-color: blue; width: 500px; height: 500px;" id="b"></div>
	<!-- 상품 리스트 -->
	<div class="ppp">
		<ul  id="ul_productSelect">
		
		</ul>
	</div>
	<div class="ppp">
		<ul id="ul_kind"></ul>
	</div>
	<div id="div_product">
	</div>
	
	
		<!-- PAGINATIOIN:S -->
	<div id="pageing">
	
	</div>
	

		<!-- PAGINATIOIN:E -->
</div>

	<!-- 코디저장 할 것들 -->
		태그 걸꺼 : <input type="text" id="title" value="#" placeholder="# 태그 입력">
		<input type="hidden" id="product_num">
	<button>코디 생성</button><br>
	
	<canvas width="501px" height="501px"></canvas>
<a></a>


   
   
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
 		$("#product_"+pNum).clone().appendTo($("#b"));
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
				productSelect += "<li><a id='productSelect_"+index+"' onclick='productView("+value.productSelect_num+");' name='1'>" + value.productSelect_name + "</a></li>";
			});
			$("#ul_productSelect").append(productSelect);
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "error:" + error);
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
				kind += "<li><a id='kind_" + index + "' onclick='kindView("+value.kind_num+")'>"+value.kind_name+"</a></li>"
	    	});
			$("#ul_kind").html(kind);
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "error:" + error);
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
			
			$.each(data.ar, function( index, value ) {
				productList += "<div class='product' id='product_"+value.productDTO.product_num+"' style='display : inline-block; background : url(${pageContext.request.contextPath}/resources/testPic/"+value.productPicDTO.productPic_pic+"); width: 200px; height: 200px' onmousedown='move(this,"+value.productDTO.product_num+");'>";
				productList += "<input id='x-"+value.productDTO.product_num+"' type='text' value='' readonly='readonly'><input id='y-"+value.productDTO.product_num+"' type='text' value='' readonly='readonly'>";
				productList += "</div>";
				console.log(index+" : "+ value.productDTO.product_num+" : "+value.productPicDTO.productPic_pic+" : "+value.productDTO.product_name);
	    	});
			var x = data.pageing.lastNum*1;
			alert(x);
 			var pageing = "";
 			
 			pageing += '<nav aria-label="Page navigation"><ul class="pagination"><li>';
			pageing += '<c:if test="'+(data.pageing.curBlock > 1)+'"><a class="a_prev" aria-label="Previous"	style="cursor: pointer"><input class="inh_prev"	type="hidden" value="'+(data.pageing.startNum*1-1)+'"><span aria-hidden="true">&laquo;</span>';
			pageing += '</a></c:if></li><li><c:forEach begin="1" step="1"	end="6" var="i"><a style="cursor: pointer" class="N_pageing">${i}</a></c:forEach></li>';
			pageing += '<li><c:if test="'+(data.pageing.curBlock < data.pageing.totalBlock)+'"><a class="a_next" aria-label="Next" style="cursor: pointer"><input class="inh_next" type="hidden" value="'+(data.pageing.lastNum*1+1)+'}"><span aria-hidden="true">&raquo;</span></a></c:if></li></ul></nav>';

			 console.log("되라" + data.pageing.startNum*1);
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
	var x = event.pageX;
	var y = event.pageY;
	var product = $(a).attr("id");
	var xVal = $(a).css('left').replace(/[^0-9]/g, "");
	var yVal = $(a).css('top').replace(/[^0-9]/g, "");
        
	$(a).mousemove(function(event) {
        $("#x-"+product_num).val($("#"+product).css('left').replace(/[^0-9]/g, ""));
        $("#y-"+product_num).val($("#"+product).css('top').replace(/[^0-9]/g, ""));
        $(a).css({
           "left" : xVal * 1 + ((event.pageX) * 1 - x * 1) * 1,
           "top" : yVal * 1 + ((event.pageY) * 1 - y * 1) * 1
        });
        	$(a).on("mouseup mouseout", function(event) {
        		$(a).off("mousemove");
		        xVal = $(a).css('left').replace(/[^0-9]/g, "");
		        yVal = $(a).css('top').replace(/[^0-9]/g, "");

			       	if(xVal < 500 && yVal < 500){
			    		 //상품 번호를 배열에 넣음
			        	 codiArray(product_num);
			    		 //이미지 복사
			    	 }else {
			    		 //이미지 삭제
			    		 
			    		 //상품 번호 삭제
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
		//코디 등록
       	$.ajax({
       		type: "POST",
               data : {
               	data : data,
               	product : product_num,
               	title : title
               },
               url: "${pageContext.request.contextPath}/fashion/codiCreate",
               success: function(data) {
               	alert(data.message);
					if(data.result = 1){
						opener.location.reload();//부모창리프래쉬
						window.close();//윈도우 클로즈
					}
               }
       	});
	});
});

////   T       E         S        T          T        E        S       T
function ccclliikk(a){
	var x =""
	$("#divasdasd_test").append("<div style='background : url(${pageContext.request.contextPath}/resources/testPic/"+a"); position: absolute; width: 200px; height: 200px' onmousedown='move(this,"+index+");'>";")
}
    
</script>

</body>
</html>