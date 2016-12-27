<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<div class="container">
	<form action="/codi/review/reviewUpdate" method="post" name="cmtform" id="reform" enctype="multipart/form-data">
  <!-- Modal -->
  <div class="modal fade" id="myModal1" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">REVIEW UPDATE</h4>
        </div>
        <div class="modal-body">
	 <span>
		<img class="star_img" id="image1" onmouseover=show(1) onclick=mark(1) onmouseout=noshow(1) src="${pageContext.request.contextPath}/resources/images/review/star0.png">
		<img class="star_img" id="image2" onmouseover=show(2) onclick=mark(2)  onmouseout=noshow(2) src="${pageContext.request.contextPath}/resources/images/review/star0.png">
		<img class="star_img" id="image3" onmouseover=show(3) onclick=mark(3)  onmouseout=noshow(3) src="${pageContext.request.contextPath}/resources/images/review/star0.png">
		<img class="star_img" id="image4" onmouseover=show(4) onclick=mark(4)  onmouseout=noshow(4) src="${pageContext.request.contextPath}/resources/images/review/star0.png">
		<img class="star_img" id="image5" onmouseover=show(5) onclick=mark(5)  onmouseout=noshow(5) src="${pageContext.request.contextPath}/resources/images/review/star0.png">
	</span><br>
	<h3 id="startext">평가하기</h3>
	<input type="hidden" name="review_star">
	<input type="text" name="review_num" value="${review.review_num}">
	<input type="text" name="review_product" value="${review.review_product}">
	<textarea rows="" cols="" name="review_contents" style="width: 400px;height: 200px;">
	${review.review_contents}
	</textarea><br>
        </div>
	이미지 등록 :<input type="file" name="reviewfile">	<!--수정할이미지파일  -->
			<input type="hidden" name="fileimg" value="${review.review_img}"><!--기존이미지파일  -->
        <div class="modal-footer">
			<input type="button" id="rvw_btn" value="리뷰수정">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
	</form>
</div>
