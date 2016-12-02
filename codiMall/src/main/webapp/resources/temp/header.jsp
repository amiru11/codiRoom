<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
$(function () {
	$("#joinCom").click(function(){
		var id = $("#id").val();
		var pw = $("#pw").val();
		var pwc = $("#pwc").val();
		var name = $("#name").val();
		var birth = $("#birth").val();
		var gender = $('input:radio[name=gender]:checked').val();
		var tel0 = $("#tel0").val();
		var tel1 = $("#tel1").val();
		var tel2 = $("#tel2").val();
		var tel3 = $("#tel3").val();
		var check = false;
		
		if(id == '') {
			alert('이메일을 입력하세요.');
			$("#id").focus();
			return check;
		}
		var emailChar =  /^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	        if(emailChar.test(id) == false){
	        	alert("이메일 형식이 아닙니다.");
	        	$("#id").focus();
	        	return check;
	        }
		//아이디 중복 체크 했는지
	/* 	if(idCount == '0') {
			alert('아이디 중복체크를 해 주세요.');
			$("#id").focus();
			return false;
		} */
		if(pw == ''){
			alert("패스워드를 입력해주세요.");
			$("#pw").focus();
			return check;
		}
		if($("#pw").val().length < 4){
			alert("비밀번호는 4자리 이상으로 입력해주세요.")
			$("#pw").focus();
			return check;
		}
		if(pwc == ''){
			alert("패스워드 확인을 입력해주세요.");
			$("#pwc").focus();
			return check;
		}
		if(pw != pwc){
			alert("패스워드와 패스워드 확인이 다릅니다.");
			 $("#pw").val("");
			 $("#pwc").val("");
			 $("#pw").focus();
			return check;
		}
		if(name == '') {
			alert("이름을 입력하세요.");
			$("#name").focus();
			return check;
		}
		var nameChar = /[가-힣]/;
		for(var i=0; i<name.length; i++){
	        if(nameChar.test(name.charAt(i)) == false ){
	        	alert("올바른 이름 형식이 아닙니다.");
	        	$("#name").focus();
	        	return check;
	        }
		}
		//생일
		if(birth == '') {
			alert('생년월일을 입력해 주세요.');
			$("#birth").focus();
			return check;
		}
		//성별​​
		if(gender == '' || gender == null) {
			alert('성별을 선택해 주세요.');
			return check;
		}
		if(tel0 == ''){
			alert("통신사를 입력해주세요.");
			$("#tel0").focus();
			return check;
		}
		if(tel2 == ''){
			alert("전화번호를 입력하세요.");
			$("#tel2").focus();
			return check;
		}
		if($("#tel2").val().length < 3){
			alert("전화번호를 입력해주세요.")
			$("#tel2").focus();
			return check;
		}
		if(tel3 == ''){
			alert("전화번호를 입력하세요.");
			$("#tel3").focus();
			return check;
		}
		if($("#tel3").val().length < 4){
			alert("전화번호를 입력해주세요.")
			$("#tel3").focus();
			return check;
		}
		check = true;
		if(check == true){
			$("#jfrm").submit();
		}
	});
});
//ID 중복 체크
function idCheck() {
	
}




</script>
<nav class="navbar navbar-inverse navbar-fixed-top"
	style="z-index: 100;" id="header">
	<div class="container">
		<div class="navbar-header">
			<h1 style="margin-top: 40px;">
				<a href="${pageContext.request.contextPath}/"><img
					src="${pageContext.request.contextPath}/resources/images/ci2.png"
					alt="MAPSSI"></a>
			</h1>
		</div>
		<div id="navbar" class="navbar-collapse collapse">

			<ul class="nav navbar-nav" style="margin-top: 60px;">
				<!--            test li s -->
				<li><a href="${pageContext.request.contextPath}/ttt/t1">T1</a></li>
				<li><a href="${pageContext.request.contextPath}/ttt/t2">T2</a></li>
				<!-- 관리자할 때 상품등록 -->
				<li><a
					href="${pageContext.request.contextPath}/ttt/product_add">ADD</a></li>
				<li><a
					href="${pageContext.request.contextPath}/ttt/view?product_num=1">VEIW</a></li>
				<li><a href="${pageContext.request.contextPath}/basket/basketList">BASKET</a></li>
				<li><a href="${pageContext.request.contextPath}/product/productList">PRODUCTLIST</a></li>
				<li><a href="${pageContext.request.contextPath}/basket/log">TESTLOGIN</a></li>
				

				<!--            test li e -->

			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li><a
					href="${pageContext.request.contextPath}/board/findList?board_kind=1">고객센터</a></li>
				<!-- 기본적으로 notice로 가게 -->
				<li><a href=""><span
						class="glyphicon glyphicon-shopping-cart"></span> CART</a></li>
				<c:if test="${sessionScope.member eq null}">
					<li><a href="" data-toggle="modal" data-target="#loginModal"
						data-backdrop="true"><span class="glyphicon glyphicon-log-in"></span>
							LOGIN</a></li>
					<li><a href="" data-toggle="modal" data-target="#signModal"
						data-backdrop="true"><span class="glyphicon glyphicon-user"></span>
							Sign Up</a></li>
				</c:if>
				<c:if test="${sessionScope.member ne null}">
					<li><a href="${pageContext.request.contextPath}/member/myPage">MY PAGE</a></li>
					<li><a href="${pageContext.request.contextPath}/member/memberLogout">LOGOUT</a></li>
				</c:if>
			</ul>
			<form class="navbar-form navbar-right" style="margin-left: 200px;">
				<!-- <div class="col-lg-6"> -->
				<div class="input-group">
					<input type="text" class="form-control"
						placeholder="Search Product"> <span
						class="input-group-btn"> <a class="btn btn-default"
						type="button"><span class="glyphicon glyphicon-search"></span></a>
					</span>
				</div>
				<!-- /input-group -->
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
				<form action="${pageContext.request.contextPath}/member/memberLogin" method="post">
					<div class="form-group">
						<label for="content">ID</label>
						<input type="text" class="form-control" id="idL" name="id" maxlength="30" placeholder="이메일">
					</div>
					<div class="form-group">
						<label for="content">PW</label>
						<input type="password" class="form-control" id="pwL" name="pw" maxlength="15" placeholder="비밀번호">
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
				<form action="${pageContext.request.contextPath}/member/memberJoin" method="post" name="jfrm">
					<div class="form-group">
						<label for="content">ID</label> <input type="text"
							class="form-control" id="id" name="id" maxlength="30" placeholder="이메일">
					</div>
					<div class="form-group">
						<label for="content">PW</label> <input type="password"
							class="form-control" id="pw" name="pw" maxlength="15" placeholder="비밀번호">
					</div>
					<div class="form-group">
						<label for="content">비밀번호 확인</label> <input type="password"
							class="form-control" id="pwc" name="pwc" maxlength="15" placeholder="비밀번호 확인">
					</div>
					<div class="form-group">
						<label for="content">NAME</label> <input type="text"
							class="form-control" id="name" name="name" placeholder="이름">
					</div>
					<div class="form-group">
						<label for="content">BIRTH</label> <input type="text"
							class="form-control" id="birth" name="birth">
					</div>
					<div class="form-group">
						<label for="gender">GENDER</label>
						<label class="radio-inline"><input type="radio" class="gender" name="gender" value="men">Men</label> 
						<label class="radio-inline"><input type="radio" class="gender" name="gender" value="women">Women</label>
					</div>
					<div class="form-group form-group-sm">
						<div>
							<label for="tel">TEL</label>
						</div>
						<div class="col-sm-12">
							<span class="col-sm-3"> <select class="form-control"
								id="tel0">
									<option value="SKT">SKT</option>
									<option value="KT">KT</option>
									<option value="LGU">LGU</option>
							</select>
							</span> <span class="col-sm-3"> <select class="form-control"
								id="tel1">
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
							</select>
							</span>
							<span class="col-sm-3">
								<input type="text" class="form-control" id="tel2" name="tel2" maxlength="4" placeholder="전화번호">
							</span> 
							<span class="col-sm-3">
								<input type="text" class="form-control" id="tel3" name="tel3" maxlength="4" placeholder="전화번호">
							</span>
						</div>
					</div>
					<div class="form-group" style="height: 15px;"></div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" id="joinCom" class="btn btn-md btn-success">Sign
					In</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>