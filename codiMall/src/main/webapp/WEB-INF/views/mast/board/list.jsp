<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>        
<!DOCTYPE html>
<script>

//전역변수선언
var editor_object = [];
 
nhn.husky.EZCreator.createInIFrame({
    oAppRef: editor_object,
    elPlaceHolder: "smarteditor",
    sSkinURI: "/codi/resources/SE2/SmartEditor2Skin.html", 
    htParams : {
        // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
        bUseToolbar : true,             
        // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
        bUseVerticalResizer : true,     
        // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
        bUseModeChanger : true, 
    }
});

</script>		
								<div class="panel" style="background: #fff;    margin-bottom: 30px;">
									<div class="panel-heading">
										<a id="subList" class="subBtn btn btn-default btn-lg">
											<span class="fa fa-list"></span> List
										</a>

									</div>
									<!-- boardList:S -->
									<div class="panel-body">
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
												<c:forEach items="${list}" var="list1" varStatus="i">
													<tr>
														<td>${i.count}<%-- ${list.board_num} --%></td>
														<td><c:forEach begin="1" end="${list1.board_depth}">
													&nbsp;&nbsp;&nbsp;&nbsp;
											</c:forEach> <a
															id="${list1.board_num}" class="${list1.board_kind}" onclick="goView(this);" style="cursor : pointer;">${list1.board_title}</a>
															
														</td>
														<td>${list1.board_writer}</td>
														<td>${list1.board_date}</td>
														<td>${list1.board_counts}</td>
														<td>
															<div class="btn-group">
																<button type="button"  class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">설정<span class="caret"></span></button>
																<ul class="dropdown-menu" role="menu" style="min-width: 55px;">
																      <li style="text-align: center;"><a class="mod-btn" style="cursor: pointer;">수정</a></li>
																      <li style="text-align: center;"><a class="del-btn"  style="cursor: pointer;" onclick="delBtn(this);">삭제</a><input type="checkbox" class="checkSet" style="display: none;" value="${list1.board_num}"></li>
																</ul>														
															</div>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>									
									</div>
									<!-- boardList:E -->	
										
									
									<div class="panel-footer"  style="background-color: white;">
										<!-- PAGINATIOIN:S -->
										<div class="row">
											<nav aria-label="Page navigation" class="center-block" style="width : 180px;">
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
									</div>
						
								</div>


									<!-- BoardWrite: S -->
									<form action="${pageContext.request.contextPath}/mast/boardWrite" name="writeFrm" method="post">
										<div class="panel"> 
											<div class="panel-heading" style="background-color: white;">
												<a id="goWrite" class="subBtn btn btn-default btn-lg">
													<span class="fa fa-pencil"></span> Write
												</a>
											</div>
											<div class="panel-body">
												<div id="tab1_1" class="tab-pane active" style="width:100%;">
													<div class="section row mbn">
														<input type="hidden" name="board_writer">
														<input type="hidden" name="board_kind" value="1">
														<span>
															<select class="form-control" name="board_category" style="margin-left : 15px; width : 20%;height : 50px; display: inline-block;">
																<option value="">카테고리를 선택하세요</option>
																<option value="코디/상품">코디/상품</option>
																<option value="주문/배송">주문/배송</option>
																<option value="입금/결제">입금/결제</option>
																<option value="기타">기타</option>
															</select>
															<input type="text" class="form-control" placeholder="제목을 입력하세요.." name="board_title" style="margin : 15px;padding : 15px; width : 75%;height : 50px; margin-bottom : 20px;  background: #fff; display: inline-block;">
														</span>
														<div style="width: 1155px; margin-left:15px;">
															<textarea class="form-control" name="board_contents" id="smarteditor" rows="10" cols="100" style="width:100%; height:100%;"  placeholder="내용을 입력하세요"></textarea>
														</div>
													</div>
												</div>
											</div>
										</div>
									</form>
									<!-- BoardWrite: E -->
									