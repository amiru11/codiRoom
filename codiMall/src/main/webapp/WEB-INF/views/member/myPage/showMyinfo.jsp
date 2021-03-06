<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript">
	$(function() {
		var gender = $("#gender").val();
		console.log(gender);
		if (gender == 'men') {
			$(".male").addClass("on");
		} else {
			$(".female").addClass("on");
		}

		$("#update").click(function() {
			var pw = $("#pwM").val();
			var pwc = $("#pwcM").val();
			var tel0 = $("#tel0M").val();
			var tel1 = $("#tel1M").val();
			var check = false;
			var address = $("#addr").val();
			if (address != "") {
				address = address + "_-_" + $("#addr2").val();
			}


			if (pw == '') {
				alert("패스워드를 입력해주세요.");
				$("#pwM").focus();
				return check;
			}
			if ($("#pwM").val().length < 4) {
				alert("비밀번호는 4자리 이상으로 입력해주세요.")
				$("#pwM").focus();
				return check;
			}
			if (pwc == '') {
				alert("패스워드 확인을 입력해주세요.");
				$("#pwcM").focus();
				return check;
			}
			if (pw != pwc) {
				alert("패스워드와 패스워드 확인이 다릅니다.");
				$("#pwM").val("");
				$("#pwcM").val("");
				$("#pwM").focus();
				return check;
			}
			if (tel0 == '') {
				alert("통신사를 입력해주세요.");
				$("#tel0M").focus();
				return check;
			}
			if (tel1 == '') {
				alert("전화번호를 입력하세요.");
				$("#tel1M").focus();
				return check;
			}
			var telChar = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})[0-9]{3,4}[0-9]{4}$/;
			if (telChar.test(tel1) == false) {
				alert("전화번호 형식이 다릅니다.");
				$("#tel1").focus();
				return check;
			}
			if ($("#tel1M").val().length < 10) {
				alert("전화번호를 입력해주세요.")
				$("#tel1M").focus();
				return check;
			}
			check = true;
			if (check == true) {
				$.ajax({
					url : "${pageContext.request.contextPath}/member/memberUpdate",
					type : "post",
					data : {
						id : "${member.id}",
						pw : pw,
						name : "${member.name}",
						birth : "${member.birth}",
						gender : "${member.gender}",
						tel0 : tel0,
						tel1 : tel1,
						address : address
					},
					success : function(data) {
						data = data.trim();
						$("#subView").empty();
						$("#subView").html(data);
					}
				});
			}
		});

		$("#delete").click(function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/member/myPage/deleteFrom",
				type : "post",
				success : function(data) {
					data = data.trim();
					$("#subView").empty();
					$("#subView").html(data);
				}
			});
		});
	});

	function telCheck() {
		var tel1 = $("#tel1").val();
		var telChar = /[0-9]/;
		for (var i = 0; i < tel1.length; i++) {
			if (telChar.test(tel1.charAt(i)) == false) {
				alert("잘못입력하였습니다.");
				$("#tel1").focus();
				return false;
			}
		}
	}
	;
</script>
<h2>개인정보 확인 및 수정</h2>
<div id="my_email" class="my_info">
	<strong>E-MAIL(ID)</strong>
	<p>
		<input type="text" class="form-control" readonly="readonly"
			value="${member.id}">
	</p>
</div>
<div id="my_pw" class="my_info">
	<strong>비밀번호</strong>
	<p>
		<input type="password" id="pwM" class="form-control" name="pw"
			maxlength="15" placeholder="비밀번호" value="${member.pw}">
	</p>
</div>
<div id="my_pwRe" class="my_info">
	<strong>비밀번호 확인</strong>
	<p>
		<input type="password" id="pwcM" class="form-control" name="pwc"
			maxlength="15" placeholder="비밀번호 확인">
	</p>
</div>
<div id="my_name" class="my_info">
	<strong style="width: 40%; display: inline-block;">이름</strong> <strong
		style="width: 40%; display: inline-block; margin-left: 120px;">성별</strong>
	<p>
		<input type="text" id="info_name" class="form-control"
			readonly="readonly" value="${member.name}">
	</p>
	<div class="user_gender">
		<a class="male  disabled" href="">남</a> <a class="female  disabled"
			href="">여</a> <input type="hidden" name="gender" id="gender"
			value="${member.gender}">
	</div>
</div>
<div id="my_birth" class="my_info">
	<strong>생년월일</strong>
	<p>
		<input type="date" class="form-control" value="${member.birth}">
	</p>
</div>
<div id="my_tel" class="my_info">
	<strong>휴대폰</strong>
	<div class="form-group input-group">
		<span class="input-group-addon"
			style="background: none; border: none; padding: 0;"> <select
			class="form-control" id="tel0M" name="tel0"
			style="width: 80px; padding: 0; height: 56px; border-radius: 4px;">
				<option value="${member.tel0}">${member.tel0}</option>
				<option value="">통신사 선택</option>
				<option value="SKT">SKT</option>
				<option value="KT">KT</option>
				<option value="LGU">LGU</option>
		</select>
		</span> <input type="tel" class="form-control decorative-input" id="tel1M"
			name="tel1" maxlength="11" placeholder="'-' 없이 입력해주세요."
			value="${member.tel1}" onkeyup="telCheck()">
	</div>
</div>
<div id="my_email" class="my_info"
	style="border-bottom: 1px solid #dce2eb;">
	<strong>주소(선택사항)</strong>
	<p>



		<input type="button" onclick="openDaumPostcode()" value="우편번호 찾기"
			class="btn btn-default address_btn"> <input type="text"
			id="addr" class="address form-control" readonly="readonly" name="a1"
			style="width: 67.57%; float: right;"
			value="${fn:substring(member.address,0,fn:indexOf(member.address,'_-_'))}">

		<c:set var="addd2"
			value="${fn:substring(member.address,fn:indexOf(member.address,'_-_')+3,fn:length(member.address)) }" />
		<input type="text" id="addr2" class="address form-control" name="a2"
			value="${addd2}">
	</p>
</div>
<div class="center-block" style="margin-top: 50px;">

	<button type="button"
		class="btn btn-lg btn-default center-block info_btn"
		style="width: 100%; height: 55px;" id="update">회원 수정</button>
	<button type="button"
		class="btn btn-lg btn-default center-block info_btn"
		style="width: 100%; height: 55px;" id="delete">회원 탈퇴</button>

</div>