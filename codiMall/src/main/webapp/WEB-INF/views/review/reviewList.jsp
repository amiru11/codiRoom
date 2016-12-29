<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
.star_img {
	width: 20px;
	height: 20px;
}

.review_star {
	width: 50px;
	height: 30px;
}

.file_img {
	width: 70px;
	height: 70px;
}


.reviewList {
	width: 100%;
	height:270px;
	border-bottom: 1px solid gray;
}
#review_table{
	width: 80%;
	height: 700px;
	margin: 0 auto;
}
#review_table td {
	border: 1px solid gray;
}
 #re_file{
	width: 350px;
	height: 400px;
	 margin-left: 38px;
}
.rd_rw{
	width: 100%;
	height: 10%;
}
#rv_img{
	width: 100%;
	height: 60%;
}
#rv_con{
	width: 100%;
	height: 20%;
}
.td{
	width: 30%;
	text-align: center;
	background-color: #f2f2f2;
	
}
.reg{
float: right;
}

.star_magin{
	margin-top: 20px;
}
#review_table1{
	width: 80%;
	height: 400px;
	margin: 0 auto;
}
#review_table1 td {
	border: 1px solid gray;
}
.rd_rw1{
	width: 100%;
	height: 20%;
}
#rv_con1{
	width: 100%;
	height: 60%;
}
</style>
<!--modal-->

<!--modal end  -->

<script type="text/javascript">
	
			$(function() {
				/*글쓰기 버튼 클릭  */
				$("#rw_btn").click(function () {			
					alert("리뷰클쓰기")
					/*reviewWriteForm ajax로 페이지를 불러옴  */

					$("#reviewWrite").load("/codi/review/reviewWriteForm?review_product=${review_product}",function(responseText){
						 $("#myModal").modal();
						 	
							/*글쓰기 버튼 type을 submit*/
						 $("#rvw_btn").click(function () {
						 if($('input[name=review_star]').val() == ''){
							 alert("별점을 입력해주세요")
						 }else{
								$("#rvw_btn").attr("type","submit"); 
						 }					 
							});				
				});			
			});
				/*view Page*/
				$(".review").click(function () {
					alert("aa");
				
					var aa = $(this).find('input[name=review_num]').val();
					var rp = $(this).find('input[name=review_product]').val();
					alert(aa);
				$("#rvView").load("/codi/review/review?review_num="+aa+"&review_product="+rp,function(responseText){
					 $("#myModal").modal();
				   $("#ud_btn").click(function () {
						  alert(aa);
						  $("#rvView").hide();
						 $("#rvUpdate").load("/codi/review/reviewUpdateForm?review_num="+aa+"&review_product="+rp,function(responseText){
							 $("#myModal1").modal();	
							 $("#rvw_btn").click(function () {
								 if($('input[name=review_star]').val() == ''){
									 alert("별점을 입력해주세요")
								 }else{
									$("#rvw_btn").attr("type","submit");
								 }
								});				
					}); 
				 });
				   	$("#del_btn").click(function () {
				   		alert(aa);
						location.href="/codi/review/reviewDelete?review_num="+aa+"&review_product="+rp;
					});
				});
		 	});
				
			});
			var locked = 0;
		  	function show(star) {/*별이미지 마우스 쇼이벤트  */
				if(locked)
					return
					var i;
				var image;
				var el;
				var e =document.getElementById('startext');
				var stateMsg;
				
				for(i=1;i<=star;i++){
					image='image'+i;
					el= document.getElementById(image);
					el.src = "${pageContext.request.contextPath}/resources/images/review/star1.png";
				}
				switch(star){/*별이미지 클릭수로 텍스트 반환  */
				case 1:
					stateMsg = "별로에요";
					break;
				case 2:
					stateMsg = "그저 그래요";
					break;
				case 3:
					stateMsg = "입을만해요";
					break;
				case 4:
					stateMsg = "이뻐요";
					break;
				case 5:
					stateMsg = "완전이뻐요";
					break;
				}
				e.innerHTML = stateMsg;
				}
		  	function noshow(star) {/*별이미지 마우스 이벤트*/
				if(locked)
					return;
				var i;
				var image;
				var el;		
				for(i=1;i<=star;i++){
					image='image'+i;
					el= document.getElementById(image);
					el.src = "${pageContext.request.contextPath}/resources/images/review/star0.png";
				}
		  	}
				function lock(star) {/*마우스 클리깃 선택되어지게됨  */
				show(star);
				locked = 1;				
				}
				function mark(star) {/*선택된 값을 star에 넣어줌  */
				lock(star)
				alert(star);
				document.cmtform.review_star.value=star;
				}
				
			
  </script>
  <br>
<div>
	<ul>
		<c:forEach items="${reviewList}" var="list">
		 <br>
			<li class="reviewList">
				<!--별점-->
				<span style="font-size: 15px;">작성자:${list.review_writer}</span><span style="font-size: 15px;" class="reg">작성날짜:${list.review_reg_date}</span>
				<div class="star_magin">
					<c:if test="${list.review_star == 1}">
						<img class="review_star"
							src="${pageContext.request.contextPath}/resources/images/review/star1.png">
						<h4>별로에요</h4>
					</c:if>
					<c:if test="${list.review_star == 2}">
					<c:forEach begin="1" end="2">
						<img class="review_star"
							src="${pageContext.request.contextPath}/resources/images/review/star1.png">
					</c:forEach>
						<h4>그저 그래요</h4>
					</c:if>
					<c:if test="${list.review_star == 3}">
						<c:forEach begin="1" end="3">
						<img class="review_star"
							src="${pageContext.request.contextPath}/resources/images/review/star1.png">
					</c:forEach>
						<h4>입을만해요</h4>
					</c:if>
					<c:if test="${list.review_star == 4}">
						<c:forEach begin="1" end="4">
						<img class="review_star"
							src="${pageContext.request.contextPath}/resources/images/review/star1.png">
					</c:forEach>
						<h4>이뻐요</h4>
					</c:if>
					<c:if test="${list.review_star == 5}">
						<c:forEach begin="1" end="5">
						<img class="review_star"
							src="${pageContext.request.contextPath}/resources/images/review/star1.png">
					</c:forEach>
						<h4>완전이뻐요</h4>
					</c:if>
				</div> 
				<a href="#" class="review"> <input type="hidden"
					name="review_num" value="${list.review_num}">
					<input type="hidden" value="${list.review_product}" name="review_product">
					<div>
						<p class="review_contents" style="font-size: 15px;">
							${list.review_contents}</p>
					</div>
					 <c:if test="${list.review_img != null}">
						<img class="file_img"
							src="${pageContext.request.contextPath}/resources/upload/${list.review_img}">
					</c:if>
							<br>
			</a>
			</li>
		</c:forEach>
	</ul>
	<!-- PAGINATIOIN:S -->
	<div class="center-block">
		<nav aria-label="Page navigation">
			<ul class="pagination">
				<li><a href="javascript:void(0)" aria-label="Previous"> <span
						aria-hidden="true">&laquo;</span>
				</a></li>
				<li><c:if test="${paging.curBlock > 1}">
						<a class="N_pageing"
							href="reviewList?curPage=${paging.startNum-1}&perPage=10">&laquo;</a>
					</c:if></li>
				<li><c:forEach begin="${paging.startNum}" step="1"
						end="${paging.lastNum}" var="i">
						<a class="N_pageing" href="reviewList?curPage=${i}&perPage=10">${i}</a>

					</c:forEach></li>
				<li><c:if test="${paging.curBlock < paging.totalBlock}">
						<a class="N_pageing"
							href="reviewList?curPage=${paging.lastNum+1}&perPage=10">&raquo;</a>
					</c:if></li>
				<li><a href="#" aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a></li>
			</ul>
		</nav>
	</div>
	
	<!-- PAGINATIOIN:E -->
	<div id="reviewWrite"></div>
	<div id="rvView"></div>
	<div id="rvUpdate"></div>
	<button id="rw_btn">리뷰쓰기</button>
</div>
