<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/pagination.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/product/productList.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		//$(".sel_type").click(function(){//검색타입 글자클릭시 라디오버튼 바뀌게
		//	$(".sel_radio").attr("checked",null);//checked속성을 전부 다 지워준다.
		//	$(this).prev("input").attr("checked","checked");//그다음 해당하는 radio에 checked를 해준다
		//});
		
		$(".chkbox").click(function(){//체크되면 검정색 배경으로 바꿔주기 name :1 배경X name:2 배경O
			/* alert($(this).parent().attr("name")); */
 			if($(this).parent().attr("name")=="1"){//배경이 적용될 부모 span의 name=1 일때는 배경이 없는 상태
				$(this).parent().attr("class","category_chkbox selected");//selected class는 css에서 체크박스 배경을 채워줌
				$(this).parent().attr("name","2");//배경을 넣기 위해 name을 2로 바꿔준다
				//alert("name:"+$(this).parent().attr("name"));
				//alert($(this).parent().attr("class"));
			}else if($(this).parent().attr("name")=="2"){
				$(this).parent().attr("class","category_chkbox");
				$(this).parent().attr("name","1");
				//alert("name:"+$(this).parent().attr("name"));
				//alert($(this).parent().attr("class"));
			} 
		});
		
		//ajax로 라디오버튼에 따라서 정렬 바꿔주기
		
		$('.sel_type').click(function(){
			alert($(this).attr("name"));
			var selv = $(this).attr("name");
 			$.ajax({
				url : "${pageContext.request.contextPath}/product/productList",	//경로
				type : "GET",//메서도형식
				data : {
					sel : selv
				},//들어가는 값
				success : function(data){//성공했을 때 
					location.href="${pageContext.request.contextPath}/product/productList?sel="+selv;
					$(this).css("color","#006633");
					$(this).css("font-weight","bold");
				}
			});
		});
	});
</script>
</head>
<body>

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
			<div class="left col-lg-4">
				<form action="${pageContext.request.contextPath}/product/productList" method="get">
					sel : <input type="number" name="sel"><br><!-- 최신순 인기순 높은가격순 낮은가격순 -->
					
					<div class="category_div">
						<p>CATEGORY</p>
						<ul class="category_ul">
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="1" name="kind_num" class="chkbox">
								</span>
								<span>kind_num1</span>
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="2" name="kind_num" class="chkbox">
								</span>
								<span>kind_num2</span>
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="3" name="kind_num" class="chkbox">
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
									<input type="checkbox" value="RED" name="color" class="chkbox">
								</span>
								<span>RED</span>
							</li>
							<li>
							<span class="category_chkbox" name="1"> 
								<input type="checkbox" value="ORANGE" name="color" class="chkbox">
							</span> 
							<span>ORANGE</span>
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="YELLOW" name="color" class="chkbox">
								</span>
								<span>YELLOW</span>							
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="GREEN" name="color" class="chkbox">
								</span>
								<span>GREEN</span>							
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="BLUE" name="color" class="chkbox">
								</span>
								<span>BLUE</span>							
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="NAVY" name="color" class="chkbox">
								</span>
								<span>NAVY</span>							
							</li>
							<li>
								<span class="category_chkbox" name="1">
									<input type="checkbox" value="GRAPE" name="color" class="chkbox">
								</span>
								<span>GRAPE</span>									
							</li>
						</ul>

					</div>
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
					<button>SUBMIT</button>
				</form>			
			</div>

			<div class="right col-lg-8">
				<!-- 상품 리스트:S -->
				<nav class="navbar">
					<div class="navbar-collapse collapse">
						<ul class="nav navbar-nav category-type">
							<li><!-- <input name="sel" type="radio" class="sel_radio" value="3" checked="checked"> --><a class="sel_type" name="3">최신순</a></li>
							<li><!-- <input name="sel" type="radio" class="sel_radio" value="3"> --><a class="sel_type" name="3">인기순</a></li>
							<li><!-- <input name="sel" type="radio" class="sel_radio" value="4"> --><a class="sel_type" name="4">낮은 가격 순</a></li>
							<li><!-- <input name="sel" type="radio" class="sel_radio" value="5"> --><a class="sel_type" name="5">높은 가격 순</a></li>
						</ul>					
					</div>
				</nav>
				<table class="table">
					<tr>
						<th>01</th>
						<th>02</th>
						<th>03</th>
					</tr>
					<c:forEach items="${list}" var="list1">
						<tr>
							<td>${list1.product_num}</td>
							<td><a href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a></td>
							<td>${list1.productInfo_price}</td>
						</tr>
					</c:forEach>
				</table>	
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
		</div>
	</div>
		
	</div>	
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>	
	<!-- Footer:E -->
</body>
</html>
