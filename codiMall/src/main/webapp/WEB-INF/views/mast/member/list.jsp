<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
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
													<th>TEL</th>
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
														<td>${list1.tel0}-${list1.tel1}</td>
														<td>${list1.member_level}</td><!-- 레벨만 수정가능 -->
														<td>
															<div class="btn-group">
																<button type="button"  class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">설정<span class="caret"></span></button>
																<ul class="dropdown-menu" role="menu" style="min-width: 55px;">
																    <li style="text-align: center;">
																      	<a class="mod-btn" style="cursor: pointer;" data-toggle="modal" data-target="#commModal" data-backdrop="true">수정</a>
																    </li>
																      <li style="text-align: center;">
																      	<a class="del-btn"  style="cursor: pointer;"  onclick="delBtn(this);">삭제</a><input type="checkbox" class="checkSet" style="display: none;" value="${list1.id}">
																      </li>
																	<li style="text-align: center;">
																      	<a class="mod-btn" style="cursor: pointer;" data-toggle="modal" data-target="#commModal" data-backdrop="true">구매내역</a>
																     </li>
																     <li style="text-align: center;">
																      	<a class="mod-btn" style="cursor: pointer;" data-toggle="modal" data-target="#commModal" data-backdrop="true">게시물내역</a>
																     </li>
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