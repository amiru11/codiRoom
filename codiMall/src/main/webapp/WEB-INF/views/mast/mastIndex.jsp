<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/admin/admin.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/font-awesome/css/font-awesome.min.css">

<style type="text/css">
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
</head>
<body>
	<header class="navbar undefined bg-alert navbar-fixed-top">
		<div class="navbar-branding dark bg-alert">
			<a href="index.html" class="navbar-brand text-uppercase">AdminPage</a><span
				id="toggle_sidemenu_l" class="fa fa-bars"></span>
		</div>
		<ul class="nav navbar-nav navbar-left"></ul>
		<form role="search" class="navbar-form navbar-left navbar-search alt">
			<span
				class="hide visible-md-inline-block visible-lg-inline-block fa fa-search fs18"></span>
			<div class="form-group">
				<input type="text" placeholder="Search..." class="form-control">
			</div>
		</form>
	</header>
	<aside id="sidebar_left" class="nano nano-light affix has-scrollbar">

		<div class="sidebar-left-content nano-content" tabindex="0"
			style="margin-right: -17px;">

			<header class="sidebar-header">

				<div class="sidebar-widget search-widget hidden">
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-search"></i></span>
						<input id="sidebar-search" type="text" placeholder="Search..."
							class="form-control">
					</div>
				</div>
			</header>
			<ul class="nav sidebar-menu">
				<li class="sidebar-label pt35" style="padding-top: 100px;"></li>
				<li><a id="goCalendar" style="cursor: pointer;"><span
						class="fa fa-calendar"></span><span class="sidebar-title">Calendar</span></a>
				</li>
				<li><a href="documentation/"><span
						class="fa fa-file-text-o"></span><span class="sidebar-title">Board</span></a>
				</li>
				<li><a href=""><span
						class="fa fa-home"></span><span class="sidebar-title">Member</span></a>
				</li>
				<li class=""><a href=""><span
						class="fa fa-home"></span><span class="sidebar-title">Product</span></a>
				</li>
				<li class=""><a href=""><span
						class="fa fa-home"></span><span class="sidebar-title">Codination</span></a>
				</li>
				</ul>
				</div>
	</aside>
	<div class="container" style="padding-top:100px;">
		<div id="view">
		
		</div>
	</div>
	<%-- 	<h1>BUYLIST</h1>
	<h1>
		<a href="${pageContext.request.contextPath}/">HOME</a>
	</h1>
	<h1>
		<a href="${pageContext.request.contextPath}/mast/mastBuyList"><button>BUYLIST</button></a>
	</h1>
	
 --%>
</body>
</html>
