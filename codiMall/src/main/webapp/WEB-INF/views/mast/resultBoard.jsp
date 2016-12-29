<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>        
<!DOCTYPE html>
<c:if test="${board_kind != 4}">

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
														href="${pageContext.request.contextPath}/board/boardView?board_num=${list.board_num}&board_kind=${list.board_kind}">${list.board_title}</a>
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
															href="boardList?curPage=${paging.startNum-1}&perPage=10&board=${board}&type=${type}&find=${find}&board_kind=${board_kind}">&laquo;</a>
													</c:if></li>
												<li><c:forEach begin="${paging.startNum}" step="1"
														end="${paging.lastNum}" var="i">
														<a class="N_pageing"
															href="boardList?curPage=${i}&perPage=10&board=${board}&type=${type}&find=${find}&board_kind=${board_kind}">${i}</a>
							
													</c:forEach></li>
												<li><c:if test="${paging.curBlock < paging.totalBlock}">
														<a class="N_pageing"
															href="boardList?curPage=${paging.lastNum+1}&perPage=10&board=${board}&type=${type}&find=${find}&board_kind=${board_kind}">&raquo;</a>
													</c:if></li>
												<li><a href="#" aria-label="Next"> <span
														aria-hidden="true">&raquo;</span>
												</a></li>
											</ul>
										</nav>
									</div>
									<!-- PAGINATIOIN:E -->
	 </c:if>	
	<!--상품별 1:1문의 리뷰 리스트  -->
	 <c:if test="${board_kind ==4}">
		<div>
			<div>
				<select id="productGroup"  onchange="listAjax()">
					<option value="0">전체</option>
					<option value="1">아우터</option>
					<option value="2">상의</option>
					<option value="3">하의</option>
					<option value="4">가방</option>
					<option value="5">신발</option>
				</select>
			</div>
			<table class="table">
			<thead>
				<tr>
					<th>#</th>
					<th>TITLE</th>
					<th>board</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${list}" var="list">
				<tr>
					<td class="product_num">
						${list.product_num}
					</td>
					<td>
						${list.product_name}
					</td>
					<td>
						<input type="hidden" value="${list.product_num}" name="pnum">
						<button class="pr_btn">1:1문의</button><button class="rv_btn">REVIEW</button>
					</td>
				</tr>
				</c:forEach>
			</tbody>
			</table>
		</div>
									<!-- PAGINATIOIN:S -->
									<div class="center-block">
										<nav aria-label="Page navigation">
											<ul class="pagination">
												<li><a href="#" aria-label="Previous"> <span
														aria-hidden="true">&laquo;</span>
												</a></li>
												<li><c:if test="${paging.curBlock > 1}">
														<a class="N_pageing"
															href="boardList?curPage=${paging.startNum-1}&perPage=10&board_kind=${board_kind}&productGroup=${productGroup}">&laquo;</a>
													</c:if></li>
												<li><c:forEach begin="${paging.startNum}" step="1"
														end="${paging.lastNum}" var="i">
														<a class="N_pageing"
															href="boardList?curPage=${i}&perPage=10&board_kind=${board_kind}&productGroup=${productGroup}">${i}</a>
							
													</c:forEach></li>
												<li><c:if test="${paging.curBlock < paging.totalBlock}">
														<a class="N_pageing"
															href="boardList?curPage=${paging.lastNum+1}&perPage=10&board_kind=${board_kind}&productGroup=${productGroup}">&raquo;</a>
													</c:if></li>
												<li><a href="#" aria-label="Next"> <span
														aria-hidden="true">&raquo;</span>
												</a></li>
											</ul>
										</nav>
									</div>
									<!-- PAGINATIOIN:E -->
									</c:if>
