<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
													<c:forEach items="${commentList}" var="comment" varStatus="i">
													<div class="listComment">
														<div class="listCommentForm">
															<span class="text-left">${comment.comm_writer}|${comment.comm_date}</span> 
															<input type="hidden" value="${comment.comm_num}" id="delNum${i.index}">
															<a class="delComment goUp${i.index}" name="delNum${i.index}"><span class="comm-remove glyphicon glyphicon-remove" style="float : right; font-size: 17px; color:#30b5e1;"></span></a>
															<%-- <a class="upComment goUp${i.index}" name="goUp${i.index}"><span class="glyphicon glyphicon-edit" style="float : right; font-size: 14px;"></span></a> --%>
															<p style="border-bottom:1px solid #ddd;" class="list_contents goUp${i.index}">${comment.comm_contents}</p>
															<!-- 답글수정 -->
															<div class="upCommentForm" id="goUp${i.index}" style="display:none;">
																<textarea rows="" cols="" class="up_contents${i.index} form-control">${comment.comm_contents}</textarea>
																<a class="goComment2 btn btn-sm btn-default" id="${i.index}" role="button">SUBMIT</a>
																<a class="cancelUp btn btn-sm btn-default" name="goUp${i.index}" role="button">CANCEL</a>
																<input type="hidden" value="관리자" class="up_writer${i.index}"><!-- 나중에 로그인시 세션으로 해주기 -->
																<input type="hidden" value="${comment.comm_num}" class="up_num${i.index}">
															</div>
															<!-- 답글수정 -->
														</div>
													</div>
													</c:forEach>