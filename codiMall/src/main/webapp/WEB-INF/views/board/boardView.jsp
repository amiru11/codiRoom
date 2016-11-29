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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/previewImage.js"></script>
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
			$("#replySet").toggle();
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
		
		var f = '<input type="file" name="files" class="form-control sImg">';		
		/* 파일타입 추가하기 */
		$("#addFile").click(function(){
			var r = $("[type='file']");
			if(r.length < 5){				
				$("#fileSet").append(f);
			}else{
				alert('5개까지 가능');
			}
		});
		/* 파일타입 삭제하기 */
		$("#delFile").on("click","input",function(){
			$("#fileSet").closest("input").remove();
		});			
		
		/* 파일타입 접고열기 */
		$("#fileToggle").click(function(){
			$("#fileSet").toggle();
		});		
		
		$("#modQna").click(function(){
			document.modQnA.submit();
		});
		
		
		//image 미리보기//
/* 		$(":file").on('change', function(){
            readURL(this);
        });
		function readURL(input) {
	        if (input.files && input.files[0]) {
		        var reader = new FileReader();
		
		        reader.onload = function (e) {
		                $('#holder').attr('src', e.target.result);
		        }
	        reader.readAsDataURL(input.files[0]);
        	}	
		} */
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
	     
		//전송버튼 클릭이벤트
	    $("#modCom").click(function(){
	        //id가 smarteditor인 textarea에 에디터에서 대입
	        editor_object.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
	         
	        // 이부분에 에디터 validation 검증
	         
	        //폼 submit
	        document.modFrm.submit();
	    });		
		

		
		$("#replyCom").click(function() {
			document.replyFrm.submit();
		});
		
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
								<c:forEach items="${fileView}" var="fileView0">
									${fileView0.bFile_num}
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
					<tr id="replySet" style="display:none;">
						<td colspan="6">
							Writer         수정 삭제 <br>
							Contents
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
			<c:choose>
				<c:when test="${view.board_kind eq 1 }">
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
				</c:when>
				<c:when test="${view.board_kind eq 2 }">
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
				</c:when>
				<c:when test="${view.board_kind eq 3 }">
					<form action="${pageContext.request.contextPath}/board/qnaUpdate"
				name="modQnA" method="post" enctype="multipart/form-data">
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
										<option value="코디/상품">코디/상품</option>
										<option value="주문/배송">주문/배송</option>
										<option value="입금/결제">입금/결제</option>
										<option value="기타">기타</option>
									</select>
								</div>
							</td>
							<td class="active">DATE</td>
							<td>${view.board_date}</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="6" class="bg-grey">
								<div class="form-group">
									<label for="content">Content:</label>
									<textarea class="form-control" name="board_contents" rows="5" rows="10" cols="100" style="width:100%; height:100%;">
										${view.board_contents}
									</textarea>
									<c:if test="${fileView ne null }">
										<c:forEach items="${fileView}" var="fileView0">
											<img alt="${fileView0.bFile_num}" style="width: 200px; height: 200px;" src="${pageContext.request.contextPath}/resources/upload/${fileView0.bFile_fileName}"><br>
										</c:forEach>
									</c:if>
								</div>
							</td>
						</tr>
					<tr>
						<td colspan="6">
							<button type="button" class="btn btn-default btn-sm" id="fileToggle">
          						<span class="glyphicon glyphicon-chevron-down"></span> FLIE UP
        					</button>
							<div id="fileSet" style="display: none;">
								<a id="addFile" class="btn btn-default btn-sm" role="button">ADDFILE</a>
								<a id="delFile" class="btn btn-default btn-sm" role="button">DELFILE</a>
								<input type="file" name="files" id="firstFile" class="form-control sImg">
									<c:forEach items="${fileView}" var="fileView0">
									<input type="hidden" value="${fileView0.bFile_num}" name="bFile_num">
									</c:forEach>
							</div>
						</td>
					</tr>							
					<tr>
						<td colspan="6">
							<div>
								<a id="modQna" class="btn btn-md btn-primary" role="button">SUBMIT</a>
								<a id="goCancel" class="btn btn-md btn-primary" role="button">CANCEL</a>
								<input type="hidden" value="${view.board_kind}" name="board_kind">
								<input type="hidden" value="${view.board_num}" name="board_num" id="data1">
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="6">
							
						</td>
					</tr>
					</tbody>
				</table>
			</form>
				</c:when>
			</c:choose>

		</div>
	</div>
	<!-- MOD:E -->

	<!-- REPLY:S -->
<%-- 	<div class="container">
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
	</div> --%>
	<!-- REPLY:E -->
	
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>	
	<!-- Footer:E -->	
</html>