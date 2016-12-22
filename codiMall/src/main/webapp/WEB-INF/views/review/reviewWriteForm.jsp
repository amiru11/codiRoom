<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<div class="container">
	<form action="/codi/review/reviewWrite" method="post" name="cmtform" id="reform" enctype="multipart/form-data">
  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">REVIEW WRITE</h4>
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
	<input type="hidden" name="review_writer" value="${sessionScope.member.id}"><br>
	<input type="hidden" name="review_product" value="${review_product}">
	<textarea rows="" cols="" name="review_contents" style="width: 400px;height: 200px;">
키: km <br>
몸무계: kg <br>
색상&싸이즈: <br>
사용후기:
	</textarea><br>
        </div>
	이미지 등록 :<input type="file" name="reviewfile">	
        <div class="modal-footer">
			<input type="button" id="rvw_btn" value="리뷰등록">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
	</form>
</div>
