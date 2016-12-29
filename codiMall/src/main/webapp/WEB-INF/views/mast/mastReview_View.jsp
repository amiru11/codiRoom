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
					<table id="table">
						<tbody>
								<tr>
									<td>작성자</td>
									<td>${review.review_writer}</td>
									
								</tr>
								<tr>
									<td>등록날짜</td>
									<td>${review.review_reg_date}</td>
								</tr>
								<tr>
									<td>이미지</td>
									<td><img id="review_file" src="${pageContext.request.contextPath}/resources/upload/${review.review_img}"></td>
								</tr>
								<tr>
									<td>내용</td>
									<td>${review.review_contents}</td>
								</tr>
						</tbody>
						
					</table>
					
				</div>
				<div class="modal-footer">
					<button id="review_del_btn">삭제</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</div>

