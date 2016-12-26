<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/mast/mast.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/font-awesome/css/font-awesome.min.css">
<script src="${pageContext.request.contextPath}/resources/js/mast.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
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
}
.subBtn:HOVER{
	color: #30b5e1;
    background-color: #fff;
    border-color: initial;
}
</style>
<script type="text/javascript">
	var board_kind = '';
	$(function(){
		
		listAjax();
 		$(".sel_type").click(function(){
 			alert($(this).prop("id"));
 			subAjax(this);
 		});
	});
	
	
	
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
		function subAjax(data){
			alert(board_kind);
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
					<div class="container">
						<div id="view">
							<header id="topbar" class="text-center bg-white alt ph10 br-b-ddd">
								<nav class="navbar">
									<div class="navbar-collapse collapse"
										style="padding-left: 0; border-bottom: 1px solid #eee;">
										<ul id="category-type" class="nav navbar-nav" style="vertical-align: top; margin-left: 350px;">
											<li class="category-li"><a id="1" class="sel_type">Notice</a></li>
											<li class="category-li"><a id="2" class="sel_type">FAQ</a></li>
											<li class="category-li"><a id="3" class="sel_type">QNA</a></li>
											<li class="category-li"><a id="4" class="sel_type">PRODUCT BOARD</a></li>
											<li class="category-li"><a id="sub5" class="sel_type">Dashboard</a></li>
										</ul>
									</div>
								</nav>
							<div class="mt-30 hidden-xs">
								<a id="subList" class="subBtn btn btn-default btn-lg">
									<span class="fa fa-list"></span> List
								</a>
								<a id="subView" class="subBtn btn btn-default btn-lg">
									<span class="fa fa-wrench"></span> View
								</a>
								<a id="subWrite" class="subBtn btn btn-default btn-lg">
									<span class="fa fa-pencil"></span> Write
								</a>
							</div>
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