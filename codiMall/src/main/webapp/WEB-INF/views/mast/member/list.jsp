<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<script>
$(function(){
	var message = "${message}";
	if(message != ''){
		alert(message);
	}
});	
</script>
								<div class="panel" style="background: #fff;    margin-bottom: 30px;">
									<div class="panel-heading">
										<a id="subList" class="subBtn btn btn-default btn-lg">
											<span class="fa fa-list"></span> List
										</a>
										<form name="fname" role="search"
											class="navbar-form navbar-right" style="margin-top: 0;">
											<select id="memType" name="type" class="form-control"
												style="height: 54px; border: 2px solid #30b5e1; border-radius: 6px; color: #30b5e1; font-weight: 600 !important;">
												<option value="id">ID</option>
												<option value="name">NAME</option>
												<option value="member_level">LEVEL</option>
											</select>
								
											<div class="input-group"
												style="height: 52px; border: 2px solid #30b5e1; border-radius: 6px; color: #30b5e1; font-weight: 600 !important;">
												<input type="text" id="memFind" class="form-control" placeholder="Search for..."
													id="search" name="find" style="height: 52px;"> <input
													type="hidden" name="board_kind" value="1"> 
													<span	class="input-group-btn"
													style="height: 52px; border-left: 2px solid #30b5e1;"> 
													<a class="btn btn-default" type="button" id="search_btn" onclick="searchMember();"
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
													<th>ID</th>
													<th>NAME</th>
													<th>GENDER</th>
													<th>TELCOM</th>
													<th>MOBILE</th>
													<th>LEVEL</th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${list}" var="list1" varStatus="i">
													<tr>
														<td>${i.count}<%-- ${list.board_num} --%></td>
														<td>${list1.id}</td>
														<td>${list1.name}</td>
														<td>${list1.gender}</td>
														<td>${list1.tel0}</td>
														<td>${list1.tel1}</td>
														<td>
															<select class="form-control" onchange="select(this,${i.index});">
																<c:choose>
																<c:when test="${list1.member_level eq 1}"><option value="${list1.member_level}">BRONZE</option></c:when>
																<c:when test="${list1.member_level eq 2}"><option value="${list1.member_level}">SILVER</option></c:when>
																<c:when test="${list1.member_level eq 3}"><option value="${list1.member_level}">GOLD</option></c:when>
																<c:when test="${list1.member_level eq 4}"><option value="${list1.member_level}">DIAMOND</option></c:when>
																</c:choose>
																<option value="1">BRONZE</option>
																<option value="2">SILVER</option>
																<option value="3">GOLD</option>
																<option value="4">DIAMOND</option>
															</select>
															
														</td><!-- 레벨만 수정가능 -->
														<td>
															<div class="btn-group">
																<button type="button"  class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">설정<span class="caret"></span></button>
																<ul class="dropdown-menu" role="menu" style="min-width: 55px;">
																    <li style="text-align: center;">
																      	<input type="hidden" id="lv${i.index}"><a class="mod-btn" style="cursor: pointer;" onclick="upBtn(this);">수정</a><input type="checkbox" class="checkSet" style="display: none;" value="${list1.id}">
																    </li>
																      <li style="text-align: center;">
																      	<a class="del-btn" style="cursor: pointer;">삭제</a><input type="checkbox" class="checkSet" style="display: none;" value="${list1.id}">
																      </li>
																	<!-- <li style="text-align: center;">
																      	<a class="mod-btn" style="cursor: pointer;" data-toggle="modal" data-target="#Modal" data-backdrop="true">구매내역</a>
																     </li>
																     <li style="text-align: center;">
																      	<a class="mod-btn" style="cursor: pointer;" data-toggle="modal" data-target="#boardModal" data-backdrop="true">게시물내역</a>
																     </li> -->
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
								<!-- Board Modal : S -->
									<div class="modal fade" id="boardModal" role="dialog">
										<div class="modal-dialog">
											<!-- Modal content-->
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">&times;</button>
													<h4 class="modal-title">Board</h4>
													<ul class="list-inline">
														<li><a>상품후기</a></li>
														<li><a>상품문의</a></li>
														<li><a>QnA</li>
													</ul>
												</div>
												<div id="board-body" class="modal-body">
													<!-- Board LIST:S -->
														리스트
													<!-- Board LIST:E -->

												</div>
												<%-- <div class="modal-footer">
													<!-- comment WRITE:S -->
													<div class="text-right">
														<textarea rows="" cols="" id="comm_contents" class="form-control"></textarea>
														<input type="hidden" value="관리자" id="comm_writer"><!-- 나중에 로그인시 세션으로 해주기 -->
														<input type="hidden" value="${view.board_num}" id="comm_refNum">
														<a id="goComment" class="btn btn-sm btn-default" role="button">SUBMIT</a>
													</div>
													<!-- comment WRITE:E -->
												</div> --%>
											</div>
										</div>
									</div>
									<!-- Comment Modal : E -->