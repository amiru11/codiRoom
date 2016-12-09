<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 / 패스워드 찾기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.bxslider.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/jquery.bxslider.css" rel="stylesheet">
</head>
<script type="text/javascript">


function idFind() {
	var name = $("#nameF").val();
	var tel1 = $("#tel1F").val();
	var mail = $("#mailF").val();
	var check = false;
	
	if(name == '') {
		alert("이름을 입력하세요.");
		$("#nameF").focus();
		return check;
	}
	var nameChar = /[가-힣]/;
	for(var i=0; i<name.length; i++){
		if(nameChar.test(name.charAt(i)) == false ){
			alert("올바른 이름 형식이 아닙니다.");
			$("#nameF").focus();
			return check;
		}
	}
	if(tel1 == ''){
		alert("전화번호를 입력하세요.");
		$("#tel1F").focus();
		return check;
	}
	var telChar = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})[0-9]{3,4}[0-9]{4}$/;
	 if(telChar.test(tel1) == false){
        	alert("전화번호 형식이 다릅니다.");
        	$("#tel1F").focus();
        	return check;
        }
	if($("#tel1F").val().length < 10){
		alert("전화번호를 입력해주세요.")
		$("#tel1F").focus();
		return check;
	}
	if(mail == '') {
		alert('이메일을 입력하세요.');
		$("#mailF").focus();
		return check;
	}
	var emailChar =  /^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	if(emailChar.test(mail) == false){
		alert("이메일 형식이 아닙니다.");
		$("#mailF").focus();
		return check;
	}
	check = true;
	return check;
}

function pwFind() {
	var id = $("#idF").val();
	var check = false;
	
	if(id == '') {
		alert('이메일을 입력하세요.');
		$("#idF").focus();
		return check;
	}
	var emailChar =  /^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	if(emailChar.test(id) == false){
		alert("이메일 형식이 아닙니다.");
		$("#idF").focus();
		return check;
	}
	check = true;
	return check;
}



</script>
<body>

	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>

	<!-- 바디 부분 -->
	<div>
		<h3>아이디 찾기</h3>
		<h5>이름 과 전화번호를 입력해주세요. <br> 작성해주신 메일로 가입 하신 메일 주소를 보내드립니다.</h5>
		<form action="${pageContext.request.contextPath}/member/idFind" method="post">
			이름 : <input type="text" id="nameF" name="name" maxlength="10" placeholder="이름"><br>
			전화번호 : <input type="tel" id="tel1F" name="tel1" maxlength="11" placeholder="'-' 없이 입력해주세요."><br>
			받을 이메일 주소 : <input type="text" id="mailF" name="mail" maxlength="30" placeholder="ID 받을 이메일 주소"><br>
			<input type="submit" value="확인" onclick="return idFind();">
		</form>
	</div>
	<div>
		<h3>비밀번호 찾기</h3>
		<h5>가입하신 이메일 주소를 입력해주세요. <br> 작성해주신 메일로 새로운 비밀번호를 보내드립니다.</h5>
		<form action="${pageContext.request.contextPath}/member/pwFind" method="post">
			아이디 : <input type="text" id="idF" name="id" maxlength="30"  placeholder="가입하신 아이디(이메일 주소)"><br>
			<input type="submit" value="확인" onclick="return pwFind();">
		</form>
	</div>

	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>	
</body>
</html>