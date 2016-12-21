<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="container">
  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        <div class="modal-body">
        <p>작성날짜:${review.review_reg_date}</p>
        <p>작성날짜:${review.review_writer}</p>
          <div>
          	<img id="review_file" src="${pageContext.request.contextPath}/resources/upload/${review.review_img}">
          </div>
          <div>
          	<p>구매한 옵션:</p>
          	<p>${review.review_contents}</p>
          </div>
        </div>
        <div class="modal-footer">
        	<button id="ud_btn">수정</button>
        	<button id="del_btn">삭제</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
</div>

