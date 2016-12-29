<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>        
<!DOCTYPE html>
<script>
$(function(){
	if(${message ne null}){
		alert('${message}');
	}
});
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
								<div class="panel" style="background: #fff; margin-bottom: 30px;">
									<div class="panel-heading">
										<a id="subList" class="subBtn btn btn-default btn-lg">
											<span class="fa fa-list"></span> List
										</a>
										<form name="fname" role="search"
											class="navbar-form navbar-right" style="margin-top: 0;">
											<select id="boardType" name="type" class="form-control"
												style="height: 54px; border: 2px solid #30b5e1; border-radius: 6px; color: #30b5e1; font-weight: 600 !important;">
												<option value="title">TITLE</option>
												<option value="writer">WRITER</option>
												<option value="category">CATEGORY</option>
												<option value="contents">CONTENTS</option>
											</select>
								
											<div class="input-group"
												style="height: 52px; border: 2px solid #30b5e1; border-radius: 6px; color: #30b5e1; font-weight: 600 !important;">
												<input type="text" id="boardFind" class="form-control" placeholder="Search for..." name="find" style="height: 52px;"> 
													<input type="hidden" id="kind_num" name="board_kind" value="${board_kind}"> 
													<span class="input-group-btn"
													style="height: 52px; border-left: 2px solid #30b5e1;"> 
													<a class="btn btn-default" type="button" id="search_btn" onclick="searchBoard();"
													style="height: 52px; vertical-align: top; padding-top: 18px; color: #30b5e1;">
														<span class="glyphicon glyphicon-search"></span>
													</a>
												</span>
											</div>
										</form>
									</div>
									<!-- boardList:S -->
									<div class="panel-body">
										<table class="table">
											<thead>
												<tr>
													<th>#</th>
													<th>TITLE</th>
													<th>CATEGORY</th>
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
														<td>
															<a id="${list1.board_num}" class="${list1.board_kind}" onclick="goView(this);" style="cursor : pointer;">${list1.board_title}</a>
														</td>
														<td>${list1.board_category}</td>
														<td>${list1.board_writer}</td>
														<td>${list1.board_date}</td>
														<td>${list1.board_counts}</td>
														<td>
															<div class="btn-group">
																<button type="button"  class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">설정<span class="caret"></span></button>
																<ul class="dropdown-menu" role="menu" style="min-width: 55px;">
																      <li style="text-align: center;"><a class="mod-btn" style="cursor: pointer;">수정</a></li>
																      <li style="text-align: center;"><a class="del-btn"  style="cursor: pointer;"  onclick="delBtn(this);">삭제</a><input type="checkbox" class="checkSet" style="display: none;" value="${list1.board_num}"></li>
																      <c:if test="${board_kind eq 3}">
																      <li style="text-align: center;">
																      	<a class="com-btn" style="cursor: pointer;" data-toggle="modal" data-target="#commModal" data-backdrop="true" onclick="comBtn(this);">답글</a>
																      	<input type="text" value="${list1.board_num}"><!-- -->
																      </li>
																      </c:if>
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
										<%@include file="/resources/temp/mast/pagination.jspf" %>
										<!-- PAGINATIOIN:E -->		
									</div>
						
								</div>


									<!-- BoardWrite: S -->
									
										
											<form action="${pageContext.request.contextPath}/mast/boardWrite" name="writeFrm" method="post">
												<div class="panel"> 
													<div class="panel-heading" style="background-color: white;">
														<a class="subBtn btn btn-default btn-lg" onclick="goWrite();">
															<span class="fa fa-pencil"></span> Write
														</a>
													</div>
													<div class="panel-body">
														<div id="tab1_1" class="tab-pane active" style="width:100%;">
															<div class="section row mbn">
																<input type="hidden" name="board_writer" value="관리자">
																<input type="hidden" name="board_kind" value="${board_kind}">
																<span>
																	<select class="form-control" name="board_category" style="margin-left : 15px; width : 20%;height : 50px; display: inline-block;">
																		<option value="">카테고리를 선택하세요</option>
																		<option value="공지">공지</option>
																		<option value="코디/상품">코디/상품</option>
																		<option value="주문/배송">주문/배송</option>
																		<option value="입금/결제">입금/결제</option>
																		<option value="기타">기타</option>
																	</select>
																	<input type="text" class="form-control" placeholder="제목을 입력하세요.." name="board_title" style="margin : 15px;padding : 15px; width : 75%;height : 50px; margin-bottom : 20px;  background: #fff; display: inline-block;">
																</span>
																<div style="width: 75%; margin-left:15px;">
																	<textarea class="form-control" name="board_contents" id="smarteditor" rows="10" cols="100" style="width:100%; height:100%;"  placeholder="내용을 입력하세요"></textarea>
																</div>
															</div>
														</div>
													</div>
												</div>
											</form>
											<!-- BoardWrite: E -->										
									<!-- Comment Modal : S -->
									<div class="modal fade" id="commModal" role="dialog">
										<div class="modal-dialog">
											<!-- Modal content-->
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">&times;</button>
													<h4 class="modal-title">CoMMent</h4>
												</div>
												<div id="comm-body" class="modal-body">
													<!-- comment LIST:S -->
													
													<!-- comment LIST:E -->

												</div>
												<div class="modal-footer">
													<!-- comment WRITE:S -->
													<div class="text-right">
														<textarea rows="" cols="" id="comm_contents" class="form-control"></textarea>
														<input type="hidden" value="관리자" id="comm_writer"><!-- 나중에 로그인시 세션으로 해주기 -->
														<input type="hidden" value="${view.board_num}" id="comm_refNum">
														<a id="goComment" class="btn btn-sm btn-default" role="button">SUBMIT</a>
													</div>
													<!-- comment WRITE:E -->
												</div>
											</div>
										</div>
									</div>
									<!-- Comment Modal : E -->
									