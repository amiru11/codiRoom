<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
					<table id="table">
						<thead>
							<tr>
								<th>#</th>
								<th>WRITER</th>
								<th>STAR</th>
								<th>DATE</th>
							</tr>
						<tbody>
							<c:forEach items="${reviewList}" var="list">
								<tr>
									<td>${list.review_num}
									</td>
									
									<td>${list.review_writer}</td>
									<td>
										<input type="hidden" value="${list.review_num}" name="review_num">
									<c:if test="${list.review_star == 1}">
											<a href="#"  class="star">별로에요</a>
										</c:if> <c:if test="${list.review_star == 2}">

											<a href="#" class="star">그저 그래요</a>
										</c:if> <c:if test="${list.review_star == 3}">

											<a href="#"  class="star">입을만해요</a>
										</c:if> <c:if test="${list.review_star == 4}">

											<a href="#"  class="star">이뻐요</a>
										</c:if> <c:if test="${list.review_star == 5}">

											<a href="#"  class="star">완전이뻐요</a>
										</c:if></td>
									<td>${list.review_reg_date}</td>
								</tr>
							</c:forEach>
						</tbody>
						</thead>
					</table>
					<a href="${pageContext.request.contextPath}/mast/boardList?board_kind=${board_kind}" type="button">목록</a>
					<!-- PAGINATIOIN:S -->
									<div class="center-block">
										<nav aria-label="Page navigation">
											<ul class="pagination">
												<li><a href="#" aria-label="Previous"> <span
														aria-hidden="true">&laquo;</span>
												</a></li>
												<li><c:if test="${paging.curBlock > 1}">
														<a class="N_pageing"
															href="boardList?curPage=${paging.startNum-1}&perPage=10&board_kind=${board_kind}">&laquo;</a>
													</c:if></li>
												<li><c:forEach begin="${paging.startNum}" step="1"
														end="${paging.lastNum}" var="i">
														<a class="N_pageing"
															href="boardList?curPage=${i}&perPage=10&board_kind=${board_kind}">${i}</a>
							
													</c:forEach></li>
												<li><c:if test="${paging.curBlock < paging.totalBlock}">
														<a class="N_pageing"
															href="boardList?curPage=${paging.lastNum+1}&perPage=10&board_kind=${board_kind}">&raquo;</a>
													</c:if></li>
												<li><a href="#" aria-label="Next"> <span
														aria-hidden="true">&raquo;</span>
												</a></li>
											</ul>
										</nav>
									</div>
									<!-- PAGINATIOIN:E -->

