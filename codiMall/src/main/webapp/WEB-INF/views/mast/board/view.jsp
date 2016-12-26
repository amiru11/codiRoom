<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>      
<!DOCTYPE html>
		<!-- VIEW:S -->
		
			<table class="table table-bordered">
				<thead>
					<tr>
						<td class="active">TITLE</td>
						<td colspan="5">${view.board_title}</td>
					</tr>
					<tr>
						<td class="active">WRTIER</td>
						<td>${view.board_writer}</td>
						<td class="active">CATEGORY</td>
						<td>${view.board_category}</td>
						<td class="active">DATE</td>
						<td>${view.board_date}</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="6">
						
							${view.board_contents}<br>
							<c:if test="${fileView ne null }">
								<c:forEach items="${fileView}" var="fileView0">
									<img alt="" style="width: 200px; height: 200px;" src="${pageContext.request.contextPath}/resources/upload/${fileView0.bFile_fileName}"><br>
								</c:forEach>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="6">

							<div class="text-right">
								<form action="${pageContext.request.contextPath}/board/boardDelete"
									name="delFrm" method="post">
									<a id="goList" class="btn btn-md btn-primary" role="button">LIST</a>
									<a id="goMod" class="btn btn-md btn-primary" role="button">MODIFY</a>
 									<c:if test="${view.board_kind eq 3}">
									<a id="goReply" class="btn btn-md btn-primary" role="button">REPLY</a>
									</c:if> 
									<a id="goDel" class="btn btn-md btn-primary" role="button">DELETE</a>
									<input type="hidden" value="${view.board_num}" name="board_num" id="data1">
									<input type="hidden" value="${view.board_kind}" name="board_kind">
								</form>
							</div>
						</td>
					</tr>
					<!-- 댓글 부분 :S -->
					<tr id="replySet" style="display:none;">
						<td colspan="6">
							<!-- comment LIST:S -->
							<c:forEach items="${commentList}" var="comment" varStatus="i">
							<div class="listComment">
								<div class="listCommentForm">
									<span class="text-left">${comment.comm_writer}|${comment.comm_date}</span> 
									<input type="hidden" value="${comment.comm_num}" id="delNum${i.index}">
									<a class="delComment goUp${i.index}" name="delNum${i.index}"><span class="glyphicon glyphicon-remove" style="float : right; font-size: 14px;"></span></a>
									<a class="upComment goUp${i.index}" name="goUp${i.index}"><span class="glyphicon glyphicon-edit" style="float : right; font-size: 14px;"></span></a>
									<p style="border-bottom:1px solid #ddd;" class="list_contents goUp${i.index}">${comment.comm_contents}</p>
									<div class="upCommentForm" id="goUp${i.index}" style="display:none;">
										<textarea rows="" cols="" class="up_contents${i.index} form-control">${comment.comm_contents}</textarea>
										<a class="goComment2 btn btn-sm btn-default" id="${i.index}" role="button">SUBMIT</a>
										<a class="cancelUp btn btn-sm btn-default" name="goUp${i.index}" role="button">CANCEL</a>
										<input type="hidden" value="관리자" class="up_writer${i.index}"><!-- 나중에 로그인시 세션으로 해주기 -->
										<input type="hidden" value="${comment.comm_num}" class="up_num${i.index}">
									</div>
								</div>
							</div>
							</c:forEach>
							<!-- COMMENT LIST:E -->
							
							<!-- comment WRITE -->
							<div class="text-right">
								<textarea rows="" cols="" id="comm_contents" class="form-control"></textarea>
								<input type="hidden" value="관리자" id="comm_writer"><!-- 나중에 로그인시 세션으로 해주기 -->
								<input type="hidden" value="${view.board_num}" id="comm_refNum">
								<a id="goComment" class="btn btn-sm btn-default" role="button">SUBMIT</a>
							</div>
						</td>
					</tr>
					<!-- 댓글 부분 :E -->
				</tbody>
			</table>
		
	
	<!-- VIEW:E -->