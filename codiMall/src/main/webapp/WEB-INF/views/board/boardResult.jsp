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
								
								<tr class="qnaTop" style="cursor:pointer;" onclick="trtoggle(this)">
								
									<td>${list1.board_num}</td>
									<td>${list1.board_category}</td>
									<td>
										${list1.board_title}
									</td>
									<td>${list1.board_writer}</td>
									<td>${list1.board_date}</td>
									<td>${list1.board_counts}</td>
								
								</tr>
								<tr class="qnaBottom" style="background-color: #ddd; display: none;">
									<td colspan="6">
										${list1.board_contents}
									</td>
								</tr>
								<tr style="background-color: #ddd; display: none;">
									<td colspan="6">
										<textarea rows="" cols="" class="form-control"  style="background-color: #ddd; border : solid 1px white"></textarea>											
										<input type="button" value="SUBMIT" class="commentSubmit btn btn-default">
									</td>
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