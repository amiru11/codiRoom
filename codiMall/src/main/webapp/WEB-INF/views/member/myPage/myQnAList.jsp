<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>  
				<h2>문의 내역</h2>  
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
							<c:forEach items="${list}" var="list1"  varStatus="i">
								
								<tr class="qnaTop" id="qna${i.index}" style="cursor:pointer;" onclick="trtoggle(this)" title="${list1.board_num}">
								
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
										<form action="">
											<textarea rows="" cols="" class="form-control"  style="border : none;" id="comment${i.index}"></textarea>	
											<input type="hidden" value="${list1.board_num}" id="refNum${i.index}">
											<input type="hidden" value="관리자" id="commentWriter${i.index}">										
											<input type="button" value="SUBMIT" class="commentSubmit btn btn-default" onclick="commWrite(this)" name="${i.index}">
										</form>
									</td>
								</tr>
								<tr class="qna${i.index}"  style="background-color: #ddd; display: none;"></tr>
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