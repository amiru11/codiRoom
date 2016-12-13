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

	$(function() {
		
		$("#m_1").css("display", "none");//얘는 수정
		$("#r_1").css("display", "none");//얘는 답글(삭제예정)
		//수정하기 클릭시
		$("#goMod").click(function() {
			$("#v_1").css("display", "none");
			$("#m_1").css("display", "block");
			$("#r_1").css("display", "none");
		});
		//리스트가기
		$("#goList").click(function() {
			location.href = "findList?board_kind=${view.board_kind}";
		});
		//되돌아가기
		$("#goCancel").click(function() {
			$("#v_1").css("display", "block");
			$("#m_1").css("display", "none");
			$("#r_1").css("display", "none");
		});
		//댓글보기
		$("#goReply").click(function() {
			$("#replySet").toggle();
		});
		//수정에서 취소(QNA)
		$("#goCancel2").click(function() {
			$("#v_1").css("display", "block");
			$("#m_1").css("display", "none");
			$("#r_1").css("display", "none");
		});
		//삭제클릭
		$("#goDel").click(function() {
			var check = confirm('삭제하시겠습니까?');
			if (check == true) {
				document.delFrm.submit();
			}
		});
		/////////////////////////////파일셋팅//////////////////////////////////
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
		
		/* 파일체크(등록인지 수정인지) */
		$("[type='file']").change(function(){
			alert($("#checkNum").val());
			$("#checkNum").val("1");
			alert($("#checkNum").val());
		});
		
		$("#addFile").click(function(){
			$("[type='file']").change(function(){	
				if($("#testNum").val()!=null){
					$("#checkNum").val("2");	
				}else{
					$("#checkNum").val();
				}
				alert($("#checkNum").val());
			});
		});
		
		//댓글등록하기//
		$("#goComment").click(function(){
			$.ajax({
        		url :"commentWrite" ,
                type:"POST" ,//type을 겟으로 쓸지 포스트로 쓸지에 따라서 달라진다
                data:{
                  	comm_refNum : $("#comm_refNum").val(),
                  	comm_writer:$("#comm_writer").val(),
                  	comm_contents:$("#comm_contents").val()   
                },
            	success: function(data){
            		alert(data.trim());
            		location.href = "${pageContext.request.contextPath}/board/qnaView?board_num=${view.board_num}&board_kind=${view.board_kind}";
      			}
			});
		});
		
		//댓글수정하기//
		$(".upComment").click(function(){
				var sel=$(this).attr("name");
				$("#"+sel).css("display","block");
				$("."+sel).css("display","none");
		});
		//수정폼에서 submit버튼 클릭시//
		$(".goComment2").click(function(){	
			var index = $(this).attr("id");
			
			$.ajax({
        		url :"commentUpdate" ,
                type:"GET" ,//type을 겟으로 쓸지 포스트로 쓸지에 따라서 달라진다
                data:{
                  	comm_num : $(".up_num"+index).val(),
                  	/* comm_writer:$("#up_writer"+index).val(), */
                  	comm_contents:$(".up_contents"+index).val()
                },
            	success: function(data){
            		alert(data.trim());
            		location.href = "${pageContext.request.contextPath}/board/qnaView?board_num=${view.board_num}&board_kind=${view.board_kind}";
      			}				
			}); 
		});
		//수정폼에서 취소버튼 클릭시->commentList로//
		$(".cancelUp").click(function(){
			var sel=$(this).attr("name");
			$("#"+sel).css("display","none");
			$("."+sel).css("display","block");
		});
		//댓글삭제하기//
		$(".delComment").click(function(){
			var sel=$(this).attr("name");
			$.ajax({
				url : "commentDelete",
                type:"POST" ,//type을 겟으로 쓸지 포스트로 쓸지에 따라서 달라진다
                data:{
                  	comm_num : $("#"+sel).val()
                },
            	success: function(data){
            		alert(data.trim());
            		location.href = "${pageContext.request.contextPath}/board/qnaView?board_num=${view.board_num}&board_kind=${view.board_kind}";
      			}								
			});
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
	<!-- HEADER :S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER :E -->
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
		</div>
	</div>
	<!-- VIEW:E -->

	<!-- MOD:S -->
	<%@ include file="/resources/temp/boardView/boardModify.jspf"%>
	<!-- MOD:E -->


	
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>	
	<!-- Footer:E -->	
</html>