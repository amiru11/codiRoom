/**
 * 
 */

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
			$.ajax({
				url : "/codi/board/memberBoardList2",
				type : "post",
				data : {name : $("#hiddenName").val()},
				success : function(data){
					data = data.trim();
					$("#subView").empty();
					$("#subView").html(data);
					$(".sub_tit_h4").html('일반 문의 내역');
					console.log(data);
				}
			});
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