<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${view.board_title}</title>
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">	
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/SE2/js/HuskyEZCreator.js" charset="utf-8"></script>	
<script type="text/javascript">
	var message = "${message}";
	if (message != '') {
		alert(message);
	}
	$(function() {
		$("#m_1").css("display", "none");
		$("#r_1").css("display", "none");
		$("#goMod").click(function() {
			$("#v_1").css("display", "none");
			$("#m_1").css("display", "block");
			$("#r_1").css("display", "none");
		});
		$("#goList").click(function() {
			location.href = "findList?board_kind=${view.board_kind}";
		});
		$("#goCancel").click(function() {
			$("#v_1").css("display", "block");
			$("#m_1").css("display", "none");
			$("#r_1").css("display", "none");
		});
		$("#goReply").click(function() {
			$("#v_1").css("display", "none");
			$("#m_1").css("display", "none");
			$("#r_1").css("display", "block");
		});
		$("#goCancel2").click(function() {
			$("#v_1").css("display", "block");
			$("#m_1").css("display", "none");
			$("#r_1").css("display", "none");
		});
		$("#goDel").click(function() {
			var check = confirm('삭제하시겠습니까?');
			if (check == true) {
				document.delFrm.submit();
			}
		});
		$("#modCom").click(function() {
			document.modFrm.submit();
		});
		$("#replyCom").click(function() {
			document.replyFrm.submit();
		})
	});
</script>
</head>
<body>
	<%@ include file="/resources/temp/header.jsp"%>
	<div class="container">
		<h2>게시판입니다.</h2>
		<div class="row">
			<div class="col-lg-12" style="height: 50px;"></div>
		</div>
		<!-- VIEW:S -->
		<div id="v_1">
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
								<c:forEach items="${fileView}" var="fileView">
									<img alt="" style="width: 200px; height: 200px;" src="${context.request.contextPath}/codi/resources/upload/${fileViews.fileName}"><br>
								</c:forEach>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="6">
							<div>
								<form action="${pageContext.request.contextPath}/board/boardDelete"
									name="delFrm" method="post">
									<a id="goList" class="btn btn-md btn-primary" role="button">LIST</a>
									<a id="goMod" class="btn btn-md btn-primary" role="button">MODIFY</a>
<%-- 									<c:if test="${view.board_kind eq 3}">
									<a id="goReply" class="btn btn-md btn-primary" role="button">REPLY</a>
									</c:if> --%>
									<a id="goDel" class="btn btn-md btn-primary" role="button">DELETE</a>
									<input type="hidden" value="${view.board_num}" name="board_num" id="data1">
									<input type="hidden" value="${view.board_kind}" name="board_kind">
								</form>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- VIEW:E -->

	<!-- MOD:S -->
	<div class="container">
		<div id="m_1">
			<form action="${pageContext.request.contextPath}/board/boardUpdate"
				name="modFrm" method="post">

				<table class="table table-bordered">
					<thead>
						<tr>
							<td class="active">TITLE</td>
							<td colspan="5">
								<div class="form-group">
									<input type="text" class="form-control" id="tit" name="board_title"
										value="${view.board_title}">
								</div>
							</td>
						</tr>
						<tr>
							<td class="active">WRTIER</td>
							<td>${view.board_writer}</td>
							<td class="active">CATEGORY</td>
							<td>
								<div class="form-group">
									<select class="form-control" name="board_category">
										<option value="공지">공지</option>
										<option value="정보">정보</option>
										<option value="질문">질문</option>
										<option value="답변">답변</option>
									</select>
								</div>
							</td>
							<td class="active">DATE</td>
							<td>${view.board_date}</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="6" class="info">
								<div class="form-group">
									<label for="content">Content:</label>
									<textarea class="form-control" name="board_contents" rows="5"  id="smarteditor" rows="10" cols="100" style="width:100%; height:100%;">
										${view.board_contents}
									</textarea>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="6">
								<div>
									<a id="modCom" class="btn btn-md btn-primary" role="button">SUBMIT</a>
									<a id="goCancel" class="btn btn-md btn-primary" role="button">CANCEL</a>
									<input type="hidden" value="${view.board_kind}" name="board_kind">
									<input type="hidden" value="${view.board_num}" name="board_num" id="data1">
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	<!-- MOD:E -->

	<!-- REPLY:S -->
	<div class="container">
		<div id="r_1">
			<form action="${pageContext.request.contextPath}/board/boardReply"
				name="replyFrm" method="post">

				<table class="table table-bordered">
					<thead>
						<tr>
							<td class="active">TITLE</td>
							<td colspan="5">
								<div class="form-group">
									<input type="text" class="form-control" id="tit" name="board_title"
										placeholder="답글을 입력하세요">
								</div>
							</td>
						</tr>
						<tr>
							<td class="active">WRTIER</td>
							<td>
								<div class="form-group">
									<input type="text" class="form-control" id="wri" name="board_writer"
										placeholder="당신은 누구인가요">
								</div>
							</td>
							<td class="active">CATEGORY</td>
							<td>
								<div class="form-group">
									<select class="form-control" name="board_category">
										<option value="답변">답변</option>
									</select>
								</div>
							</td>
							<td class="active">DATE</td>
							<td>${view.board_date}</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="6" class="info">
								<div class="form-group">
									<label for="content">Content:</label>
									<textarea class="form-control" rows="5" id="content"
										name="contents" placeholder=""></textarea>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="6">
								<div>
									<a id="replyCom" class="btn btn-md btn-primary" role="button">SUBMIT</a>
									<a id="goCancel2" class="btn btn-md btn-primary" role="button">CANCEL</a>
									<input type="hidden" value="${view.board_ref}" name="board_ref"> 
									<input type="hidden" value="${view.board_step}" name="board_step"> 
									<input type="hidden" value="${view.board_depth}" name="board_depth"> 
									<input type="hidden" value="${view.board_kind}" name="board_kind"> 
									<input type="hidden" value="${view.board_num}" name="board_num" id="data1">
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	<!-- REPLY:E -->
	
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>	
	<!-- Footer:E -->	
</html>