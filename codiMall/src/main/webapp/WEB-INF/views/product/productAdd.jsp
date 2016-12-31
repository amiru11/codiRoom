<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>상품등록</title>
<link rel="stylesheet" href="http://fonts.googleapis.com/earlyaccess/hanna.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/mast/mast.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/font-awesome/css/font-awesome.min.css">
<script src="${pageContext.request.contextPath}/resources/js/mast.js"></script>
<style type="text/css">
.submitBtn {
    font-weight: 600 !important;
    border: 2px solid transparent;
    white-space: nowrap;
    text-transform: uppercase;
    letter-spacing: 0.02em;
    transition: 0.3s ease-out;
    color: #30b5e1;
    background-color: #fff;
    border-color: initial;
}
.submitBtn:HOVER {
    color: #fff;
    background-color: #30b5e1;
    border-color: initial;
}
.subBtn{
    font-weight: 600 !important;
    border: 2px solid transparent;
    white-space: nowrap;
    text-transform: uppercase;
    letter-spacing: 0.02em;
    transition: 0.3s ease-out;
    color: #30b5e1;
    background-color: #fff;
    border-color: initial;
}
.subBtn:HOVER {
    color: #30b5e1;
    background-color: #fff;
    border-color: initial;
}
</style>
<script type="text/javascript">
	$(function() {
		var message = "${message}";
		if(message != ""){
			alert(message);
		}
		$("#4").parent("li").addClass("active");
		$("#btn_add_proeach").click(function() {
			$(".div_proeach").clone().appendTo("#div_first_proe");
		});
	});
</script>
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
										<li class="category-li"><a id="1" class="sel_type" href="${pageContext.request.contextPath}/mast/mastProductList">ProductList</a></li>
										<li class="category-li"><a id="2" class="sel_type" href="${pageContext.request.contextPath}/mast/mastProductListEach0">ProductEach(Update)</a></li>
										<li class="category-li"><a id="3" class="sel_type" href="${pageContext.request.contextPath}/mast/mastProductListEach022">MASTproductEach0</a></li>
										<li class="category-li"><a id="4" class="sel_type" href="${pageContext.request.contextPath}/product/productAdd">ProductAdd</a></li>
									</ul>		
								</div>
							</nav>
						</header>
						<section id="section" class="jumbotron">
							<div class="panel" style="background: #fff; margin-bottom: 30px;">
								<div class="panel-heading">
									<a id="subList" class="subBtn btn btn-default btn-lg">
										<span class="fa fa-pencil"></span>  상품기본설정
									</a>
								</div>
								<div class="panel-body" style="background-color: white;">
									<form action="${pageContext.request.contextPath}/product/productAdd" method="post">
										<table class="table">
											<tr>
												<td>PRODUCT_NAME</td>
												<td><input type="text" class="form-control" name="product_name"></td>
											</tr>
											<tr>
												<td>PRODUCT_PRICE</td>
												<td><input type="number" class="form-control" name="productInfo_price"></td>
											</tr>
											<tr>
												<td>PRODUCT_saleRate</td>
												<td><input type="number" class="form-control" step="0.1" name="productInfo_saleRate"></td>
											</tr>
											<tr>
												<td>PRODUCT_searchWord</td>
												<td><input type="text" class="form-control" name="productInfo_searchWord"></td>
											</tr>		
											<tr>
												<td>PRODUCTKIND</td>
												<td><input type="number" class="form-control" name="kind_num"></td>
											</tr>																				
										</table>
										<button class="btn btn-lg btn-default submitBtn">등록</button>										
									</form>
								</div><!-- panel body : E -->
							</div>	<!-- panel : E -->
							<div class="panel" style="background: #fff; margin-bottom: 30px;">
								<div class="panel-heading">
									<a id="subList" class="subBtn btn btn-default btn-lg">
										<span class="fa fa-pencil"></span>  상품수량설정
									</a>
								</div>
								<div class="panel-body" style="background-color: white;">
									<form action="${pageContext.request.contextPath}/product/productEachAdd" method="post">
										<table class="table">
											<tr>
												<td>PRODUCT_NUM</td>
												<td><input class="form-control" type="number" name="product_num"></td>
											</tr>
											<tr>
												<td>PRODUCTEACH_COLOR</td>
												<td><input type="text" class="form-control" name="productEach_color"></td>
											</tr>
											<tr>
												<td>PRODUCTEACH_EACH</td>
												<td><input type="number" class="form-control" name="productEach_each"></td>
											</tr>
																												
										</table>
										<button class="btn btn-lg  btn-default submitBtn">등록</button>										
									</form>
								</div><!-- panel body : E -->
							</div>	<!-- panel : E -->							
						</section>
					</div><!--view:E  -->
				</div><!-- in container-fluid:E -->
			</div>	<!-- col-sm-8 : E -->
		</div><!-- out container-fluid:E -->
	</div>			
<%-- 	<h1>PRODUCT ADDDDDDDDDDDDD</h1>
	<h1>
		<a href="${pageContext.request.contextPath}/">HOME</a>
	</h1>
	<form action="${pageContext.request.contextPath}/product/productAdd"
		method="post">
		PRODUCT_NAME<input type="text" name="product_name"><br>
		<HR>
		PRODUCTINFO<BR> PRODUCT_PRICE<input type="number"
			name="productInfo_price"><br> PRODUCT_saleRate<input
			type="number" step="0.1" name="productInfo_saleRate"><br>
		PRODUCT_searchWord<input type="text" name="productInfo_searchWord"><br>
		<hr>
		PRODUCTKIND<BR> KIND_NUM<input type="number" name="kind_num"><br>
		<button>SUBMIT</button>
	</form>
	<hr>
	<hr>
	<hr>
	<hr> 
										<form
		action="${pageContext.request.contextPath}/product/productEachAdd"
		method="post">
		PRODUCT<BR> PRODUCT_NUM<input type="number" name="product_num"><br>
		<hr>
		<input type="button" id="btn_add_proeach" value="ADD">
		<div id="div_first_proe" style="width: 1000px">
			<div class="div_proeach" style="display: inline-block;">
				<br> PRODUCTEACH_SIZE<input type="text" name="productSize_size"><br>
				PRODUCTEACH_COLOR<input type="text" name="productEach_color"><br>
				PRODUCTEACH_EACH<input type="number" name="productEach_each"><br>
				<button>SUBMIT</button>
			</div>
		</div>
	</form>
	
	
	
	--%>


</body>
</html>
