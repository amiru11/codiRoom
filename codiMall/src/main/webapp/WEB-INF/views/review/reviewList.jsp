
<style type="text/css">
	.star_img{
		width: 44px;
		height: 44px;
	}
	.file_img{
		width: 100px;
		height: 100px;
	}
	#review_file{
		width: 200px;
		height: 200px;
	}
</style>
<!--modal-->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <!--modal end  -->
  <script type="text/javascript">
	
			$(function() {
				/*글쓰기 버튼 클릭  */
				$("#rw_btn").click(function () {			
					alert("리뷰클쓰기")
					/*reviewWriteForm ajax로 페이지를 불러옴  */
					$("#reviewWrite").load("reviewWriteForm",function(responseText){
						 $("#myModal").modal();	
						 	
							/*글쓰기 버튼 type을 submit*/
						 $("#rvw_btn").click(function () {
								$("#rvw_btn").attr("type","submit");
							});				
				});			
			});
				/*view Page*/
				$(".review").click(function () {
					var aa = $(this).find('input').val();
					alert(aa);
				$("#rvView").load("review?review_num="+aa,function(responseText){
					 $("#myModal").modal();
				   $("#ud_btn").click(function () {
						  alert(aa);
						  $("#rvView").hide();
						 $("#rvUpdate").load("reviewUpdateForm?review_num="+aa,function(responseText){
							 $("#myModal1").modal();	
							 $("#rvw_btn").click(function () {
									$("#rvw_btn").attr("type","submit");
								});				
					}); 
				 });
				   	$("#del_btn").click(function () {
				   		alert(aa);
						location.href="reviewDelete?review_num="+aa;
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
			<li>
			<!--별점-->
				<div>
					<c:if test="${list.review_star == 1}">
					<img src="${pageContext.request.contextPath}/resources/images/review/star1.png"><h3>별로에요</h3>
					</c:if>
					<c:if test="${list.review_star == 2}">
					<img src="${pageContext.request.contextPath}/resources/images/review/star2.png"><h3>그저 그래요</h3>
					</c:if>
					<c:if test="${list.review_star == 3}">
					<img src="${pageContext.request.contextPath}/resources/images/review/star3.png"><h3>입을만해요</h3>
					</c:if>
					<c:if test="${list.review_star == 4}">
					<img src="${pageContext.request.contextPath}/resources/images/review/star4.png"><h3>이뻐요</h3>
					</c:if>
					<c:if test="${list.review_star == 5}">
					<img src="${pageContext.request.contextPath}/resources/images/review/star5.png"><h3>완전이뻐요</h3>
					</c:if>
				</div>
				<div>
					<p>
						${list.review_contents}
					</p>
					<p>
						작성자:${list.review_writer}
					</p>
					<p>
						작성날짜:${list.review_reg_date}
					</p>
				</div>
				<a href="#" class="review">
				<input type="hidden" value="${list.review_num}">
				<img class="file_img" src="${pageContext.request.contextPath}/resources/upload/${list.review_img}">
				</a>
				<div>	
				</div>
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