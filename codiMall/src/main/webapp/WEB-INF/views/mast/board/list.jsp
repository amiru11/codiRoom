<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>        
<!DOCTYPE html>

								<!-- boardList:S -->
								<table class="table">
										<thead>
											<tr>
												<th>#</th>
												<th>TITLE</th>
												<th>WRITER</th>
												<th>DATE</th>
												<th>VIEW</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${list}" var="list">
												<tr>
													<td>${list.board_num}</td>
													<td><c:forEach begin="1" end="${list.board_depth}">
												&nbsp;&nbsp;&nbsp;&nbsp;
										</c:forEach> <a
														id="${list.board_num}" class="${list.board_kind}" onclick="goView(this);" href="${pageContext.request.contextPath}/mast/board/view?board_num=${list.board_num}&board_kind=${list.board_kind}">${list.board_title}</a>
														
													</td>
													<td>${list.board_writer}</td>
													<td>${list.board_date}</td>
													<td>${list.board_counts}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>	
									<!-- boardList:E -->
			
									<!-- PAGINATIOIN:S -->
									<div class="center-block">
										<nav aria-label="Page navigation">
											<ul class="pagination">
												<li><a href="#" aria-label="Previous"> <span
														aria-hidden="true">&laquo;</span>
												</a></li>
												<li><c:if test="${paging.curBlock > 1}">
														<a class="N_pageing"
															href="boardList?curPage=${paging.startNum-1}&perPage=10&board=${board}&type=${type}&find=${find}">&laquo;</a>
													</c:if></li>
												<li><c:forEach begin="${paging.startNum}" step="1"
														end="${paging.lastNum}" var="i">
														<a class="N_pageing"
															href="boardList?curPage=${i}&perPage=10&board=${board}&type=${type}&find=${find}">${i}</a>
							
													</c:forEach></li>
												<li><c:if test="${paging.curBlock < paging.totalBlock}">
														<a class="N_pageing"
															href="boardList?curPage=${paging.lastNum+1}&perPage=10&board=${board}&type=${type}&find=${find}">&raquo;</a>
													</c:if></li>
												<li><a href="#" aria-label="Next"> <span
														aria-hidden="true">&raquo;</span>
												</a></li>
											</ul>
										</nav>
									</div>
									<!-- PAGINATIOIN:E -->
