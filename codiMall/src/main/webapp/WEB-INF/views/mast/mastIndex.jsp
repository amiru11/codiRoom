<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/mast/mast.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="http://fonts.googleapis.com/earlyaccess/hanna.css">
<script src="${pageContext.request.contextPath}/resources/js/mast.js"></script>

<style type="text/css">
body{
	font-family: 'hanna';
}
table, table tr, tr td, th {
	border: 1px solid black;
}
</style>
<script type="text/javascript">

	$(function() {
		$("#goCalendar").click(function(){
			$.ajax({
				
				url : "${pageContext.request.contextPath}/mast/calendar",
				success : function(data){
					$("#view").empty();
					$("#view").html(data);
					console.log(data);
				}
			});
			
		});		
	});
</script>
<style type="text/css">
.nav >li >a.side-btn{
	color: #91a7c6;
	padding: 0;
    line-height: 50px;
    height: 50px;
    overflow: hidden;
    cursor: pointer;
    font-size: 18px;
}
</style>
</head>
<body style="height:1200px;">
	<div class="container-fluid" style="padding : 0; height: 100%">
		<div class="row" style="height: 100%;">
				<div class="col-sm-2" style="height: 100%;">
					<%@ include file="/resources/temp/mast/sideBar.jspf"%>
				</div>
				<div class="com-sm-8" style="margin: 20px;height: 100%;">
					<div class="container" >
						<div id="view">
						
						</div>
					</div>
				</div>			
		</div>
	
	</div>

</body>
</html>
