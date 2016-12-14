<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
				<table class="table">
						<thead>
							<tr>
								<th>#</th>
								<th>CATEGORY</th>
								<th>TITLE</th>
								<th>WRITER</th>
								<th>DATE</th>
								<th>VIEW</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="list1">
								<tr>
									<td>${list1.board_num}</td>
									<td>${list1.board_category}</td>
									<td>
										<a href="${pageContext.request.contextPath}/board/boardView?board_num=${list1.board_num}&board_kind=${list1.board_kind}">${list1.board_title}</a>
									</td>
									<td>${list1.board_writer}</td>
									<td>${list1.board_date}</td>
									<td>${list1.board_counts}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
						<div class="pagination">
							<ul class="pagination pagination-sm">
							  <li><a href="#">1</a></li>
							  <li><a href="#">2</a></li>
							  <li><a href="#">3</a></li>
							  <li><a href="#">4</a></li>
							  <li><a href="#">5</a></li>
							</ul>
						</div>
						<div class="writeComm">
							<input type="button" onclick="goPopUp()" id="goPopup" class="btn btn-default" value="WRITE">
							
						</div>