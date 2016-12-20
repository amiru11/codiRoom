<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript">
$(".sel_kindsel").on('change',function(){
	alert(123);
});
$(function(){
	
	getProductSelectList();
	$("#sel_prosel").on('change',function(){
		alert($(this).val());
		getKindList($(this).val());
		
	});
	
	
	
});

function getProductSelectList(){
	$.ajax({
		url : "../json/codiProductSelectList",
		type : "post",
		dataType : 'json',
		data : {
		},
		success : function(data) {
			$("#div_productSelect").html("");
			var x="<select id='sel_prosel' name='productSelect_num'>";
			$.each(data.ar, function( index, value ) {
	    		x=x+"<option value='"+value.productSelect_num;
	    		x=x+"'>"+value.productSelect_name+"</option>"
	    	});
			x=x+"</select>"
			$("#div_productSelect").html(x);
			$("#sel_prosel").on('change',function(){
				getKindList($("#sel_prosel").val());
				getCodiProductList(1);
			});
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "error:" + error);
		}
	});
	
	
}

function getKindList(productSelect_num){
	$.ajax({
		url : "../json/codiKindList",
		type : "post",
		dataType : 'json',
		data : {
			productSelect_num:productSelect_num
		},
		success : function(data) {
			$("#div_kind").html("");
			var x="<select class='sel_kindsel' name='kind_num'>";
			$.each(data.ar, function( index, value ) {
				alert(value.kind_num);
	    		x=x+"<option value='"+value.kind_num+"'>"+value.kind_name+"</option>"
	    	});
			x=x+"</select>"
			$("#div_kind").html(x);
			$(".sel_kindsel").on('change',function(){
				alert($(this).val());
				getCodiProductList($(this).val());
			});
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "error:" + error);
		}
	});
}

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
			var x="<table>";
			$.each(data.ar, function( index, value ) {
	    		x=x+"<tr><td>"+value.productDTO.product_num+"</td><td>"+value.productDTO.product_name+"</td></tr>"
	    	});
			x=x+"</table>"
			$("#div_product").html(x);
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "error:" + error);
		}
	});
}


</script>
</head>
<body>
	<div id="div_productSelect"></div>
	<div id="div_kind">
	<select class="sel_kindsel" style="display: none;"></select></div>
	<div id="div_product"></div>

</body>
</html>
