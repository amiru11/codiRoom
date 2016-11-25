<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WRITE</title>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/SE2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#goList").click(function() {
			location.href = "findList?board_kind=${board_kind}";
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
	     
	    //전송버튼 클릭이벤트
	    $("#goWrite").click(function(){
	        //id가 smarteditor인 textarea에 에디터에서 대입
	        editor_object.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
	         
	        // 이부분에 에디터 validation 검증
	         
	        //폼 submit
	        document.writeFrm.submit();
	    });
		
		
	});
</script>
</head>
<body>
	<div class="container">
		<%@ include file="/resources/temp/header.jsp"%>
		<h2>글쓰기입니다.</h2>
		
		<!-- WRITE:S -->
		<div id="v_1" class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-heading">글쓰기</div>
			<form action="${pageContext.request.contextPath}/board/boardWrite" name="writeFrm" method="post">
			<table class="table table-bordered">
				<thead>
					<tr>
						<td class="active">TITLE</td>
						<td colspan="3">
							<div class="form-group"> 
								<input type="text" class="form-control" id="tit" name="board_title" placeholder="제목을 입력하세요">
							</div>
						</td>
					</tr>
					<tr>
						<td class="active">WRTIER</td>
						<td>
							<div class="form-group"> 
								<input type="text" class="form-control" id="wri" name="board_writer" placeholder="당신은 누구인가요">
							</div>
						</td>
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
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="4" class="active">Content</td>
					</tr>
					<tr>
						<td colspan="4">
							<div class="form-group">
								<textarea class="form-control" name="board_contents" rows="5"  id="smarteditor" rows="10" cols="100" style="width:100%; height:100%;"  placeholder="내용을 입력하세요"></textarea>
							</div>
							<input type="hidden" name="board_kind" value="${board_kind}">
							<a id="goList" class="btn btn-md btn-primary" role="button">LIST</a>
							<a id="goWrite" class="btn btn-md btn-primary" role="button">SUBMIT</a>
						</td>
					</tr>
				</tbody>
			</table>
			</form>
		</div>
	</div>
	<!-- WRITE:E -->
	
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>	
	<!-- Footer:E -->	
	</body>
</html>