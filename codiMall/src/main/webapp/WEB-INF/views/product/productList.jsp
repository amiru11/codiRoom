<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<style type="text/css">
table, table tr, tr td, th {
	border: 1px solid black;
}
</style>
<script type="text/javascript">
<<<<<<< HEAD
	$(function() {
		$.ajax({
			url : "../json/allProductSize",
			type : "post",
			dataType : 'json',
			data : {
			},
			success : function(data) {
				$("#div_ck_size").html("");
				var x = "";
				$.each(data.sizeList, function(index, value) {
					x = x + value + '<input type="checkbox" value="' + value + '" name="size"><BR>'
				});
				$("#div_ck_size").html(x);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
=======
	$(function(){
		//$(".sel_type").click(function(){//검색타입 글자클릭시 라디오버튼 바뀌게
		//	$(".sel_radio").attr("checked",null);//checked속성을 전부 다 지워준다.
		//	$(this).prev("input").attr("checked","checked");//그다음 해당하는 radio에 checked를 해준다
		//});
		
		$(".kindBox").click(function(){//체크되면 검정색 배경으로 바꿔주기 name :1 배경X name:2 배경O
			alert($(this).val());
			/* alert($(this).parent().attr("name")); */
			checkSet(this);//체크박스 채우고 해제하는 과정
			$.ajax({
				url : "${pageContext.request.contextPath}/product/productserList",
				type : "GET",
				data : {
					kind_num : $(this).val()
				},
				success : function(data){//성공했을 때 
					alert(data.trim());
					$('#item-table').empty();
					$('#item-table').html(data);
				}
			});
>>>>>>> refs/heads/sub
		});
<<<<<<< HEAD

		$.ajax({
			url : "../json/allProductColor",
			type : "post",
			dataType : 'json',
			data : {
			},
			success : function(data) {
				$("#div_ck_color").html("");
				var x = "";
				$.each(data.colorList, function(index, value) {
					x = x + value + '<input type="checkbox" value="' + value + '" name="color"><BR>'
				});
				$("#div_ck_color").html(x);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
=======
		
		
		$('.sel_type').click(function(){//정렬방법 선택시
			//alert($(this).attr("name"));
			var selv = $(this).attr("name");
   			$.ajax({
				url : "${pageContext.request.contextPath}/product/productserList",	//경로
				type : "GET",//메서드형식
				data : {
					sel : selv
				},//들어가는 값
				success : function(data){//성공했을 때 
					alert(data.trim());
					$('#item-table').empty();
					$('#item-table').html(data);
				}
			}); 
>>>>>>> refs/heads/sub
		});

		$.ajax({
			url : "../json/allKindNum",
			type : "post",
			dataType : 'json',
			data : {
			},
			success : function(data) {
				$("#div_ck_kind").html("");
				var x = "";
				$.each(data.kindNumList, function(index, value) {
					x = x + value + '<input type="checkbox" value="' + value + '" name="kind_num"><BR>'
				});
				$("#div_ck_kind").html(x);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});

	});
	
	function checkSet(data){
		var v = "";	
		if($(data).parent().attr("name")=="1"){//배경이 적용될 부모 span의 name=1 일때는 배경이 없는 상태
			$(data).parent().attr("class","category_chkbox selected");//selected class는 css에서 체크박스 배경을 채워줌
			$(data).parent().attr("name","2");//배경을 넣기 위해 name을 2로 바꿔준다
			//alert($(this).val());
		}else if($(data).parent().attr("name")=="2"){
			$(data).parent().attr("class","category_chkbox");
			$(data).parent().attr("name","1");
			$(data).val('');
			if($(data).attr("name")=="kind_num"){
				alert($(data).val());
				$("#hdkind").val('');
			}else if($(data).attr("name")=="color"){
				$("#hdcolor").val('');
			}else if($(data).attr("name")=="size"){
				$("#hdsize").val('');
			}
			//alert("name:"+$(this).parent().attr("name"));
			//alert($(this).parent().attr("class"));
		} 		
	}
	
</script>

</head>
<body>
<<<<<<< HEAD
	<h1>
		<a href="${pageContext.request.contextPath}/">HOME</a>
	</h1>
	<table>
		<tr>
			<th>01</th>
			<th>02</th>
			<th>03</th>
		</tr>
		<c:forEach var="list1" items="${list}">
			<tr>
				<td>${list1.product_num}</td>
				<td><a
					href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a></td>
				<td>${list1.productInfo_price}</td>
			</tr>
		</c:forEach>
	</table>
	<form action="${pageContext.request.contextPath}/product/productList"
		method="get">
		curPage : <input type="number" name="curPage"><br>
		perPage : <input type="number" name="perPage"><br> <select
			name="sel"><option value="1">최신순</option>
			<option value="2">먼저나온순</option>
			<option value="3">최저가순</option>
			<option value="4">최고가순</option></select>
		<div id="div_out_search_select">
		KIND<br>
			<div id="div_ck_kind"
				style="width: 200px; height: 100px; overflow: scroll;"></div>
				SIZE<BR>
			<div id="div_ck_size"
				style="width: 200px; height: 100px; overflow: scroll;"></div>
				COLOR<br>
			<div id="div_ck_color"
				style="width: 200px; height: 100px; overflow: scroll;"></div>
=======

	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->
	
	<div class="container" style="padding-top:20px;">
		<nav class="navbar" style="border-bottom: 1px solid #eeeeee;">
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav sub-header">
					<li><a>아우터</a></li>
					<li><a>상의</a></li>
					<li><a>하의</a></li>
					<li><a>가방</a></li>
					<li><a>신발</a></li>
					<li><a>할인상품</a></li>
					<li><a>신상품</a></li>
				</ul>
			</div>
		</nav>
		<div class="item row">
			<div class="col-lg-12">
			<div class="left col-lg-4" style="margin-top: 0;">
				<form action="${pageContext.request.contextPath}/product/productList" method="get" name="itemSearch">
					<input type="hidden" name="sel" id="selValue"><!-- 최신순:3 인기순 높은가격순:4 낮은가격순:5 -->
					
					<div class="category_div">
						<p>CATEGORY</p>
						<ul class="category_ul">
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="1" name="kind_num" class="chkbox kindBox">
								</span>
								<span>kind_num1</span>
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="2" name="kind_num" class="chkbox kindBox">
								</span>
								<span>kind_num2</span>
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="3" name="kind_num" class="chkbox kindBox">
								</span>
								<span>kind_num3</span>
							</li>
						</ul>
					</div>
					<div class="category_div">
						<p>COLOR</p>
						<ul class="category_ul">
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="SRED" name="color" class="chkbox colorBox">
								</span>
								<span>RED</span>
							</li>
							<li>
							<span class="category_chkbox" name="1"> 
								<input type="checkbox" value="MORANGE" name="color" class="chkbox colorBox">
							</span> 
							<span>ORANGE</span>
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="MYELLOW" name="color" class="chkbox colorBox">
								</span>
								<span>YELLOW</span>							
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="GREEN" name="color" class="chkbox colorBox">
								</span>
								<span>GREEN</span>							
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="BLUE" name="color" class="chkbox colorBox">
								</span>
								<span>BLUE</span>							
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="NAVY" name="color" class="chkbox colorBox">
								</span>
								<span>NAVY</span>							
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="XXLBLACK" name="color" class="chkbox colorBox">
								</span>
								<span>GRAPE</span>									
							</li>
							
						</ul>

					</div>
					<!-- SIZE는 아직 안됨 -->
					<div class="category_div">
						<p>SIZE</p>
						<ul class="category_ul">
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="s" name="size" class="chkbox">
								</span>
								<span>S</span>
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="m" name="size" class="chkbox">
								</span>
								<span>M</span>
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="l" name="size" class="chkbox">
								</span>
								<span>L</span>
							</li>
						</ul>
					</div>					
				</form>	
			</div>

			<div class="right col-lg-8" style="margin-top: 0; width : 850px;">
				<!-- 상품 리스트:S -->
				<nav class="navbar">
					<div class="navbar-collapse collapse" style="padding-left:0; border-bottom: 1px solid #eee;">
						<ul class="nav navbar-nav category-type">
							<li><a class="sel_type" name="3">최신순</a></li>
							<li><a class="sel_type" name="3">인기순</a></li>
							<li><a class="sel_type" name="4">낮은 가격 순</a></li>
							<li><!-- <input name="sel" type="radio" class="sel_radio" value="5"> --><a class="sel_type" name="5">높은 가격 순</a></li>
						</ul>					
					</div>
				</nav>
				<div id="item-table">	
					<ul class="list-inline" style="width : 850px;">
						<c:forEach items="${list}" var="list1">
						<li style="padding-left:20px;" class="viewItem">
							<div class="mc" style="border : 1px solid #eee;">
								<span class="img">
									<a href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">
										<img src="http://placehold.it/500x150&text=FooBar1" width="250" height="250">
									</a>
								</span>
								<div class="item-info" style="padding-left: 10px;">
									<p style="padding-top:10px;">
					  					<a href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a>
					  				</p>
				  					<p>브랜드</p>
				  					<p>
					  					<span>
					  						<fmt:formatNumber value="${list1.productInfo_price}" currencySymbol="" type="currency"/>원
					  					</span>
				  						<strong style="color:#b5172e;">→639,200 원(20%)</strong>
				  					</p>								
								</div>
								<div class="cart">
									<span style="font-size: 20px; color: #ffffff;">ADD TO CART</span>
								</div>
							</div>
						</li>
						</c:forEach>
					</ul>
<%-- 					<table class="table table-bordered" style="margin-bottom: 0;">
				  		<c:forEach items="${list}" var="list1">
				  		<tr style="width: 270px;">
				  			<td style="padding:0;"><img src="http://placehold.it/500x150&text=FooBar1" width="270px"></td>
				  		</tr>
				  		<tr style="width: 270px;">
				  			<td style="padding:0; padding-left : 10px;">
				  				<p style="padding-top:10px;">
				  					<a href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a>
				  				</p>
			  					<p>브랜드</p>
			  					<span>${list1.productInfo_price}</span>
				  				<span class="glyphicon glyphicon-shopping-cart" style="font-size: 20px; background: #000; color: #ffffff; padding : 10px; border-radius: 20px; position : absolute; top : 350px; right : 15px;"></span>
							</td>
				  		</tr>
				  		</c:forEach>
				  	</table> --%>
<%-- 					<table class="table">
						<tr>
							<th>#</th>
							<th>상품명</th>
							<th>가격</th>
							
						</tr>
						<c:forEach items="${list}" var="list1">
							<tr>
								<td>${list1.product_num}</td>
								<td><a href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a></td>
								<td>${list1.productInfo_price}</td>
							</tr>
						</c:forEach>
					</table>			 --%>
				</div>	
				<!-- 상품 리스트:E -->
				
				<!-- PAGINATIOIN:S -->
				<div class="center-block">
					<nav aria-label="Page navigation">
						<ul class="pagination">
							<li><a href="#" aria-label="Previous"> <span
									aria-hidden="true">&laquo;</span>
							</a></li>
							<li><c:if test="${paging.curBlock > 1}">
									<a class="N_pageing"
										href="${pageContext.request.contextPath}/product/productList?curPage=${paging.startNum-1}&perPage=9">&laquo;</a>
								</c:if></li>
							<li><c:forEach begin="${paging.startNum}" step="1"
									end="${paging.lastNum}" var="i">
									<a class="N_pageing"
										href="${pageContext.request.contextPath}/product/productList?curPage=${i}&perPage=9">${i}</a>
		
								</c:forEach></li>
							<li><c:if test="${paging.curBlock < paging.totalBlock}">
									<a class="N_pageing"
										href="${pageContext.request.contextPath}/product/productList?curPage=${paging.lastNum+1}&perPage=9">&raquo;</a>
								</c:if></li>
							<li><a href="#" aria-label="Next"> <span
									aria-hidden="true">&raquo;</span>
							</a></li>
						</ul>
					</nav>
				</div>
				<!-- PAGINATIOIN:E -->				
				
			</div>
>>>>>>> refs/heads/sub
		</div>

		<button>SUBMIT</button>

	</form>

</body>
</html>
