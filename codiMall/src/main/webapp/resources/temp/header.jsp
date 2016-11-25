<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<script type="text/javascript">
	$(function(){
		//회원가입 클릭시 //
		$("#joinCom").click(function(){
			var tel = $("#tel0").val() + "/" + $("#tel1").val() + "/" + $("#tel2").val() + "/" + $("#tel3").val();
			document.jfrm.submit();
			//alert(tel);
			
/* 			$.ajax({
				url : "memberJoin",
				type :"POST",
				data : {
					id : $("#id").val(),
					pw : $("#pw").val(),
					name : $("#name").val(),
					age : $("#age").val(),
					sung : $("#sung").val(),
					tel : tel
				},
				success : function(data){
					alert(data);
				}
			}); */
		});		
	});
</script>
<nav class="navbar navbar-inverse navbar-fixed-top" style="z-index: 100;">
	<div class="container">		
		<div class="navbar-header">
			<h1 style="margin-top: 40px;">
				<a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/resources/images/ci2.png" alt="MAPSSI"></a>
			</h1>
		</div>
		<div id="navbar" class="navbar-collapse collapse">

			<ul class="nav navbar-nav" style="margin-top: 60px;">
				<li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
				<!--            test li s -->
				<li><a href="${pageContext.request.contextPath}/ttt/t1">T1</a></li>
				<li><a href="${pageContext.request.contextPath}/ttt/t2">T2</a></li>
				<li><a href="${pageContext.request.contextPath}/ttt/product_add">ADD</a></li>
				<li><a href="${pageContext.request.contextPath}/smart/boardWrite">smart</a></li>
				
				<!--            test li e -->
								
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a href="${pageContext.request.contextPath}/board/findList?board_kind=1">고객센터</a></li>
				<li><a href=""><span class="glyphicon glyphicon-shopping-cart"></span> CART</a></li>
				<c:if test="${sessionScope.member eq null}">			
				<li><a href="" data-toggle="modal" data-target="#loginModal"
					data-backdrop="true"><span class="glyphicon glyphicon-log-in"></span> LOGIN</a></li>
				<li>
				<a href="" data-toggle="modal" data-target="#signModal"
					data-backdrop="true"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
				</c:if>
				<c:if test="${sessionScope.member ne null}">
				<li><a href="">MY PAGE</a></li>
				<li><a href="${pageContext.request.contextPath}/memberLogout">LOGOUT</a></li>			
				</c:if>
			</ul>
		    <form class="navbar-form navbar-right" style="margin-left: 200px;">
			  <!-- <div class="col-lg-6"> -->
			    <div class="input-group">
			      <input type="text" class="form-control" placeholder="Search Product">
			      <span class="input-group-btn">
			        <a class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></a>
			      </span>
			    </div><!-- /input-group -->
   			</form>			
		</div>
	<!--/.nav-collapse -->
	</div>
</nav>

<!-- Modal -->
<div class="modal fade" id="loginModal" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">LOGIN</h4>
			</div>
			<div class="modal-body">
				<form action="memberLogin" method="post">
					<div class="form-group">
						<label for="content">ID</label> 
						<input type="text" class="form-control" id="idd" name="id">
					</div>
					<div class="form-group">
						<label for="content">PW</label> 
						<input type="password" class="form-control" id="pww" name="pw">
					</div>
					<input type="submit" class="btn btn-success" value="LOGIN">
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="signModal" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">SIGN IN</h4>
			</div>
			<div class="modal-body">
				<form action="memberJoin" method="post" name="jfrm">
					<div class="form-group">
						<label for="content">ID</label> <input type="text"
							class="form-control" id="id" name="id">
					</div>
					<div class="form-group">
						<label for="content">PW</label> <input type="text"
							class="form-control" id="pw" name="pw">
					</div>
					<div class="form-group">
						<label for="content">NAME</label> <input type="text"
							class="form-control" id="name" name="name">
					</div>
					<div class="form-group">
						<label for="content">AGE</label> <input type="number"
							class="form-control" id="age" name="age">
					</div>
					<div class="form-group">
						<label for="gender">GENDER</label> 
							<label class="radio-inline"><input type="radio" id="sung" name="sung" value="남">M</label> 
							<label class="radio-inline"><input type="radio" id="sung" name="sung" value="여">W</label>
					</div>
					<div class="form-group form-group-sm">
						<div>
							<label for="tel">TEL</label>
						</div>
						<div class="col-sm-12">
							<span class="col-sm-2"> 
								<select class="form-control" id="tel0">
										<option value="SKT">SKT</option>
										<option value="KT">KT</option>
										<option value="LGU">LGU</option>
								</select>
							</span> 
							<span class="col-sm-3"> 
								<select class="form-control" id="tel1">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
								</select>
							</span> 
							<span class="col-sm-3">
								<input type="text" class="form-control" id="tel2">
							</span> 
							<span class="col-sm-3">
								<input type="text" class="form-control" id="tel3">
							</span>
						</div>
					</div>
					<div class="form-group"style="height: 15px;"></div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="joinCom" class="btn btn-md btn-success">Sign In</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>