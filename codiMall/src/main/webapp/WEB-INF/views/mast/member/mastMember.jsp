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
<title>회원 관리</title>
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

	$(function(){
		listAjax();//ajax로 멤버 리스트뿌리기
	});	
	
	//select 변경시 input에 담아주기//
	function select(data,index){
		var lv = $(data).val();
		$("#lv"+index).val(lv);
	}
	
	
	//체크박스에 체크해주기
	//삭제//
 	function delBtn(data){
		
		var mID = $(data).next().val();
		//alert(mID);
		var con = confirm('삭제하시겠습니까?');
		if(con == true){
			$(data).next().prop("checked",true);
			$.ajax({
				//삭제시켜버리기
				url : "mastMemberDelete",
				type : "get",
				data : {
					id : mID
				},
				success : function(data){
					var data = data.trim();
					//console.log(data);
					$("#section").empty();
					$("#section").html(data);
					$("#1").parent("li").addClass("active");
				}
			});
		}else{
			$(data).next().prop("checked",false);
		}
	} 
	
	//수정//
	function upBtn(data){
		var mID = $(data).next().val();
		var mLv = $(data).prev().val();
		//alert(mLv);
		var con = confirm('수정하시겠습니까?');
		if(con == true){
			$(data).next().prop("checked",true);
			$.ajax({
				//수정시켜버리기
				url : "mastMemberUpdate",
				type : "get",
				data : {
					id : mID,
					member_level : mLv
				},
				success : function(data){
					var data = data.trim();
					console.log(data);
					$("#section").empty();
					$("#section").html(data);
					$("#1").parent("li").addClass("active");
				}
			});
		}else{
			$(data).next().prop("checked",false);
		}
	}
//멤버리스트뿌려주기//	
	function listAjax(){
		
		$.ajax({
			url : "mastMemberList",
			type : "get",
			data : {
				curPage : 1,
				perPage : 10
			},
			success : function(data){
				var data = data.trim();
				//console.log(data);
				$("#section").empty();
				$("#section").html(data);
				$("#1").parent("li").addClass("active");

			}
		});
	}
//멤버 검색하기//
	function searchMember(){
		//alert($("#memType").val());
		//alert($("#memFind").val());
 		$.ajax({
			url : "mastMemberList",
			type : "post",
			data : {
				curPage : 1,
				perPage : 10,
				type : $("#memType").val(),
				find : $("#memFind").val()
			},
			success : function(data){
				var data = data.trim();
				console.log(data);
				$("#section").empty();
				$("#section").html(data);
				$("#1").parent("li").addClass("active");

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
											<li class="category-li"><a id="1" class="sel_type">MEMBER</a></li>
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