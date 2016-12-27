<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/SE2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/mast.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/mast/mast.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="http://fonts.googleapis.com/earlyaccess/hanna.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 관리</title>
<style type="text/css">
body{
	font-family: 'hanna';
}
.category-li:HOVER{
	background: none;
}
.category-li > a{
	color: #AAA;
    font-weight: 600;
    border-bottom: 3px solid transparent;
	padding: 16px 14px 12px;
	cursor:pointer;
}

#category-type > li > a:HOVER{
	color: #444;
    background-color: transparent;
}
.active > a{
	color: #444;
	border-bottom: 3px solid #43c7d7;
}
.subBtn{
	font-weight: 600 !important;
    border: 2px solid transparent;
    white-space: nowrap;
    text-transform: uppercase;
    letter-spacing: 0.02em;
    transition: 0.3s ease-out;
    color: #30b5e1;
    background-color: #fff;
    border-color: initial;
}
.subBtn:HOVER{
	color: #fff;
    background-color: #30b5e1;
    border-color: initial;
}
.container .jumbotron, .container-fluid .jumbotron{
	padding-left: 15px;
	padding-right: 15px;
}
.pagination>li>a, .pagination>li>span {
    position: relative;
    float: left;
    padding: 6px 12px;
    margin-left: -1px;
    line-height: 1.42857143;
    color: #337ab7;
    text-decoration: none;
    background-color: transparent;
    border: none; 
}
.comm-remove{
	cursor: pointer;
}
.comm-remove:HOVER {
	opacity: 0.5;
}
</style>
<script type="text/javascript">
	var board_kind = '';
    var editor_object = [];
	$(function(){
		if(${message ne null}){
			alert('${message}');
		}
		
		
		listAjax();//ajax로 보드종류에 따른 리스트뿌리기
 		$(".sel_type").click(function(){
 			//alert($(this).prop("id"));
 			subAjax(this);
 		});
 			    
		$("#goList").click(function(){
			listAjax();
		});
	     	     
		//답글버튼 클릭이벤트
		$(".com-btn").on("click",function(){
			
		});
	});
	
	function comBtn(data){
		alert($(data).next("input").val());
		$.ajax({
			url : "${pageContext.request.contextPath}/mast/mastCommList",
			type : "GET",
			data : {
				board_num : $(data).next("input").val()
			},
			success : function(data){
				console.log(data.trim());
				
			}
		});
	}
	
	function goComment(){
		$("#replySet").toggle();
	}
	
	
	//체크박스에 체크해주기
	function delBtn(data){
		board_kind = ${board_kind};
		var board_num = parseInt($(data).next().val());
		var con = confirm('삭제하시겠습니까?');
		if(con == true){
			$(data).next().prop("checked",true);
			$.ajax({
				//삭제시켜버리기
				url : "boardDelete",
				type : "get",
				data : {
					board_num : board_num,
					board_kind : board_kind
				},
				success : function(data){
					var data = data.trim();
					console.log(data);
					$("#section").empty();
					$("#section").html(data);
					$("#1").parent("li").removeClass("active");
					$("#2").parent("li").removeClass("active");
					$("#3").parent("li").removeClass("active");
					$("#4").parent("li").removeClass("active");
					$("#"+board_kind).parent("li").addClass("active");

				}
			});
		}else{
			$(data).next().prop("checked",false);
		}
		
		
	}
	
	function goWrite(){
	    //id가 smarteditor인 textarea에 에디터에서 대입
        editor_object.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
         
        // 이부분에 에디터 validation 검증
         
        //폼 submit
        document.writeFrm.submit();
	}
	
	function goList(){
		$.ajax({
			url : "resultBoard",
			type : "get",
			data : {
				curPage : 1,
				perPage : 10,
				board_kind : $("#data2").val()
			},
			success : function(data){
				var data = data.trim();
				//console.log(data);
				$("#section").empty();
				$("#section").html(data);
				$("#1").parent("li").removeClass("active");
				$("#2").parent("li").removeClass("active");
				$("#3").parent("li").removeClass("active");
				$("#4").parent("li").removeClass("active");
				$("#"+board_kind).parent("li").addClass("active");

			}
		});
	}
	
	function listAjax(){
		board_kind = ${board_kind};
		$.ajax({
			url : "resultBoard",
			type : "get",
			data : {
				curPage : 1,
				perPage : 10,
				board_kind : ${board_kind}
			},
			success : function(data){
				var data = data.trim();
				//console.log(data);
				$("#section").empty();
				$("#section").html(data);
				$("#1").parent("li").removeClass("active");
				$("#2").parent("li").removeClass("active");
				$("#3").parent("li").removeClass("active");
				$("#4").parent("li").removeClass("active");
				$("#"+board_kind).parent("li").addClass("active");

			}
		});
	}
		function subAjax(data){
			//alert(board_kind);
			board_kind = $(data).prop("id");
			$.ajax({
				url : "resultBoard",
				type : "get",
				data : {
					curPage : 1,
					perPage : 10,
					board_kind : $(data).prop("id")
				},
				success : function(data){
					var data = data.trim();
					console.log(data);
					$("#section").empty();
					$("#section").html(data);
					$("#1").parent("li").removeClass("active");
					$("#2").parent("li").removeClass("active");
					$("#3").parent("li").removeClass("active");
					$("#4").parent("li").removeClass("active");
					$("#"+board_kind).parent("li").addClass("active");
				}
			});                                                                                                                                                                                               	
	}
		function goView(data){
			$.ajax({
				url : "${pageContext.request.contextPath}/mast/boardView",
				type : "get",
				data : {
					board_num : $(data).prop("id"),//a태그의 id
					board_kind : $(data).prop("class")//a태그의 class
				},
				success : function(data){
					var data = data.trim();

					console.log(data);

				//	console.log(data);

					$("#section").empty();
					$("#section").html(data);
					$("#1").parent("li").removeClass("active");
					$("#2").parent("li").removeClass("active");
					$("#3").parent("li").removeClass("active");
					$("#4").parent("li").removeClass("active");
					$("#"+board_kind).parent("li").addClass("active");
				}			
			});
		} 
</script>
</head>
<body style="height:1200px;">
	<div class="container-fluid" style="padding : 0; height: 100%">
		<div class="row"  style="height: 100%;">
				<div class="col-sm-2" style="height: 100%;">
					<%@ include file="/resources/temp/mast/sideBar.jspf"%>
				</div>
				<div class="col-sm-8" style="margin: 20px;">
					<div class="container-fluid">
						<div id="view">
							<header id="topbar" class="text-center bg-white alt ph10 br-b-ddd">
								<nav class="navbar">
									<div class="navbar-collapse collapse"
										style="padding-left: 0; border-bottom: 1px solid #eee;">
										<ul id="category-type" class="nav navbar-nav" style="vertical-align: top;">
											<li class="category-li"><a id="1" class="sel_type">Notice</a></li>
											<li class="category-li"><a id="2" class="sel_type">FAQ</a></li>
											<li class="category-li"><a id="3" class="sel_type">QNA</a></li>
											<li class="category-li"><a id="4" class="sel_type">PRODUCT BOARD</a></li>
											<li class="category-li"><a id="sub5" class="sel_type">Dashboard</a></li>
										</ul>
									</div>
								</nav>
							</header>
						
							<section id="section" class="jumbotron">						
							</section>
						</div>
					</div>				
				</div>

		</div>		

	</div>
</body>
</html>