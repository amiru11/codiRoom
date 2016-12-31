<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/font-awesome/css/font-awesome.min.css">
<script src="${pageContext.request.contextPath}/resources/js/mast.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/css/mast/mast.css"
	rel="stylesheet">
<script type="text/javascript">

	$(function() {

		mastBuyStart();
		$("#1").parent("li").addClass("active");
		
	});


</script>
<style type="text/css">
#table_buy_list > tr > th{
	border : 1px solid #dce2eb;
}
#table_buy_list > tr > td{
	border : 1px solid #dce2eb;
	width : 6%;
}
.nav>li>a.side-btn {
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
<body style="height: 1800px; font-family: 'hanna';">
	<div class="container-fluid" style="padding: 0; height: 100%">
		<div class="row" style="height: 100%;">
			<div class="col-sm-2" style="height: 100%;">
				<%@ include file="/resources/temp/mast/sideBar.jspf"%>
			</div>
			<div class="col-sm-8" style="margin: 20px; height: 100%;">
				<div class="container-fluid">
					<div id="view">
						<header id="topbar" class="text-center bg-white alt ph10 br-b-ddd">
							<nav class="navbar">
								<div class="navbar-collapse collapse"
									style="padding-left: 0; border-bottom: 1px solid #eee;">
									<ul id="category-type" class="nav navbar-nav" style="vertical-align: top;">
										<li class="category-li"><a id="1" class="sel_type" href="${pageContext.request.contextPath}/mast/mastBuyList">BuyList</a></li>
										<li class="category-li"><a id="2" class="sel_type" href="${pageContext.request.contextPath}/mast/mastBuyListPay">BuyListPay</a></li>
									</ul>		
								</div>
							</nav>
						</header>
						<section id="section" class="jumbotron">
							<div class="panel" style="background: #fff; margin-bottom: 30px;">
								<div class="panel-heading">
									<a id="subList" class="subBtn btn btn-default btn-lg">
										<span class="fa fa-list"></span>  구매리스트
									</a>
								</div>
								<div class="panel-body" style="background-color: white;">
									<select id="sel_buy_state" name="buy_state">
										<option value="1">1배송준비</option>
										<option value="2">2배송중</option>
										<option value="3">3배송완료</option>
										<option value="4">4판매완료</option>
										<option value="0">all</option>
										<option value="5">5환불중</option>
										<option value="6">6환불완료</option>
									</select>
									<table id="table_buy_list" class="table table-bordered">
									
									</table>								
								</div>
							</div>
						</section>					


					</div>
				</div>
			</div>
		</div>

	</div>

</body>
</html>
