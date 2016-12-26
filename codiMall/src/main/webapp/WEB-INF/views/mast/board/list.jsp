<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>        
<!DOCTYPE html>
<script>

</script>

								<!-- boardList:S -->
								<table class="table">
										<thead>
											<tr>
												<th>#</th>
												<th>TITLE</th>
												<th>WRITER</th>
												<th>DATE</th>
												<th>VIEW</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${list}" var="list" varStatus="i">
												<tr>
													<td>${i.count}<%-- ${list.board_num} --%></td>
													<td><c:forEach begin="1" end="${list.board_depth}">
												&nbsp;&nbsp;&nbsp;&nbsp;
										</c:forEach> <a
														id="${list.board_num}" class="${list.board_kind}" onclick="goView(this);" style="cursor : pointer;">${list.board_title}</a>
														
													</td>
													<td>${list.board_writer}</td>
													<td>${list.board_date}</td>
													<td>${list.board_counts}</td>
													<td>
														<input type="button" role="button" class="btn btn-danger btn-sm" value="DELETE">
														<input type="checkbox" class="checkSet">
													</td>
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
