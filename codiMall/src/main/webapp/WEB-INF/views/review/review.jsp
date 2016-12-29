<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="container">
  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg">
       <c:if test="${review.review_img != null}">
      <div class="modal-content" style="width: 800px;height: 900;">
      </c:if>
       <c:if test="${review.review_img == null}">
         <div class="modal-content" style="width: 800px;height: 500;">
       </c:if>
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">상품 리뷰</h4>
        </div>
        <div class="modal-body">
        <c:if test="${review.review_img != null}">
        <table id="review_table">
        	<tr class="rd_rw">
        		<td class="td">작성날짜</td>
        		<td> ${review.review_reg_date}</td>
        	</tr>
        	<tr >
        		<td class="td">작성자</td>
        		<td> ${review.review_writer}</td>
        	</tr>
        	<tr id="rv_img">
        		<td class="td">이미지</td>
        		<td><img id="re_file" src="${pageContext.request.contextPath}/resources/upload/${review.review_img}"></td>
        	</tr>
        	<tr id="rv_con">
        		<td class="td">내용</td>
        		<td> ${review.review_contents}</td>
        	</tr>
        	</table>
        	</c:if>
        	 <c:if test="${review.review_img == null}">
        	 <table id="review_table1">
        	 <tr class="rd_rw1">
        		<td class="td">작성날짜</td>
        		<td> ${review.review_reg_date}</td>
        	</tr>
        	<tr >
        		<td class="td">작성자</td>
        		<td> ${review.review_writer}</td>
        	</tr>
        	<tr id="rv_con1">
        		<td class="td">내용</td>
        		<td> ${review.review_contents}</td>
        	</tr>
        	 </table>
        	 </c:if>
        </div>
        <div class="modal-footer">
        <c:if test="${sessionScope.member.id eq review.review_writer}">
        	<button id="ud_btn">수정</button>
        	<button id="del_btn">삭제</button>
        </c:if>
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>
</div>

