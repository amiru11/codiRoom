<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<style type="text/css">
table, table tr, tr td, th {
	border: 1px solid black;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#btn_aa").click(function(){
			$.ajax({
			    url : "../json/productSize",
			    type : "post",
			    data : {
			    	product_num:${view.product_num}
			    },
			    success: function(data) {
			    	var x="";
			    	$.each(data, function( index, value ) {
			    		   x=x+"<option value="+value+">"+value+"</option>";
			    		});
			    	$("#sel_size_a").html(x);
			    },
			    error:function(request,status,error){
			        alert("code:"+request.status+"\n"+"error:"+error);
			    }
			 
			});
		})
		
		$("#btn_bb").click(function(){
			$.ajax({
			    url : "../json/productEach",
			    type : "post",
			    dataType : 'json',
			    data : {
			    	product_num:${view.product_num},
			    	productSize_size:$("#sel_size_a").val()
			    },
			    success:function(data) {
			    	var x="";
			    	$.each(data.eachList, function( index, value ) {
			    		x=x+"<option value="+value.productEach_color+">"+value.productEach_color+'__'+value.productEach_each+"</option>";
			    		});
			    	
			    	$("#sel_size_b").html(x);
			    },
			    error:function(request,status,error){
			        alert("code:"+request.status+"\n"+"error:"+error);
			    }
			 
			});
		}) 
		

	});
</script>
</head>
<body>
	<h1>TEST TABLE</h1>
	<h1>
		<a href="${pageContext.request.contextPath}/">HOME</a>
	</h1>
	<table>
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
			<td><select id="sel_size_b"></select></td>
		</tr>


	</table>

	<button id="btn_aa">aaaaa</button>
	<button id="btn_bb">bbbb</button>

</body>
</html>