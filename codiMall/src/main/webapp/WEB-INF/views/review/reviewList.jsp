<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
	.star_img{
		width: 20px;
		height: 20px;
	}
	.review_star{
		width: 50px;
		height: 30px;
	}
	.file_img{
		width: 100px;
		height: 100px;
	}
	#review_file{
		width: 200px;
		height: 200px;
	}
	.reviewList{
		width: 100%;
		border-bottom: 1px solid gray;
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
					alert(${review_product})
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
					var aa = $(this).find('input[name=review_num]').val();
					alert(aa);
				$("#rvView").load("/codi/review/review?review_num="+aa,function(responseText){
					 $("#myModal").modal();
				   $("#ud_btn").click(function () {
						  alert(aa);
						  alert(${review_product});
						  $("#rvView").hide();
						 $("#rvUpdate").load("/codi/review/reviewUpdateForm?review_num="+aa,function(responseText){
							 $("#myModal1").modal();	
							 $("#rvw_btn").click(function () {
									$("#rvw_btn").attr("type","submit");
								});				
					}); 
				 });
				   	$("#del_btn").click(function () {
				   		alert(aa);
						location.href="/codi/review/reviewDelete?review_num="+aa+"&review_product="+${review_product};
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
	<div>
		<ul>
		<c:forEach items="${reviewList}" var="list">
			<li class="reviewList">
			<!--별점-->
			<p style="font-size: 20px;">
				작성자:${list.review_writer}
			</p>
			<p style="font-size: 20px;">
				작성날짜:${list.review_reg_date}
			</p>
				<div>
					<c:if test="${list.review_star == 1}">
					<img class="review_star" src="${pageContext.request.contextPath}/resources/images/review/star1.png"><h3>별로에요</h3>
					</c:if>
					<c:if  test="${list.review_star == 2}">
					<img class="review_star" src="${pageContext.request.contextPath}/resources/images/review/star2.png"><h3>그저 그래요</h3>
					</c:if>
					<c:if test="${list.review_star == 3}">
					<img class="review_star" src="${pageContext.request.contextPath}/resources/images/review/star3.png"><h3>입을만해요</h3>
					</c:if>
					<c:if test="${list.review_star == 4}">
					<img class="review_star" src="${pageContext.request.contextPath}/resources/images/review/star4.png"><h3>이뻐요</h3>
					</c:if>
					<c:if test="${list.review_star == 5}">
					<img class="review_star" src="${pageContext.request.contextPath}/resources/images/review/star5.png"><h3>완전이뻐요</h3>
					</c:if>
				</div>
			<a href="#" class="review">
				<input type="hidden" name="review_num" value="${list.review_num}">
				<div>
					<p class="review_contents" style="font-size: 20px;">
						${list.review_contents}
					</p>
				</div>
				<c:if test="${list.review_img != null}">
				<img class="file_img" src="${pageContext.request.contextPath}/resources/upload/${list.review_img}">
				</c:if>
				</a>
			</li>
		</c:forEach>
		</ul>
		<!-- PAGINATIOIN:S -->
				<div class="center-block">
					<nav aria-label="Page navigation">
						<ul class="pagination">
							<li><a href="#" aria-label="Previous"> <span
									aria-hidden="true">&laquo;</span>
							</a></li>
							<li><c:if test="${paging.curBlock > 1}">
									<a class="N_pageing"
										href="reviewList?curPage=${paging.startNum-1}&perPage=10">&laquo;</a>
								</c:if></li>
							<li><c:forEach begin="${paging.startNum}" step="1"
									end="${paging.lastNum}" var="i">
									<a class="N_pageing"
										href="reviewList?curPage=${i}&perPage=10">${i}</a>
		
								</c:forEach></li>
							<li><c:if test="${paging.curBlock < paging.totalBlock}">
									<a class="N_pageing"
										href="reviewList?curPage=${paging.lastNum+1}&perPage=10">&raquo;</a>
								</c:if></li>
							<li><a href="#" aria-label="Next"> <span
									aria-hidden="true">&raquo;</span>
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
