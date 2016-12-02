<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function() {
	$("#update").click(function() {
		var pw = $("#pwM").val();
		var pwc = $("#pwcM").val();
		var tel0 = $("#tel0M").val();
		var tel1 = $("#tel1M").val();
		var tel2 = $("#tel2M").val();
		var tel3 = $("#tel3M").val();
		var check = false;
		
		if(pw == ''){
			alert("패스워드를 입력해주세요.");
			$("#pwM").focus();
			return check;
		}
		if($("#pwM").val().length < 4){
			alert("비밀번호는 4자리 이상으로 입력해주세요.")
			$("#pwM").focus();
			return check;
		}
		if(pwc == ''){
			alert("패스워드 확인을 입력해주세요.");
			$("#pwcM").focus();
			return check;
		}
		if(pw != pwc){
			alert("패스워드와 패스워드 확인이 다릅니다.");
			 $("#pwM").val("");
			 $("#pwcM").val("");
			 $("#pwM").focus();
			return check;
		}
		if(tel0 == ''){
			alert("통신사를 입력해주세요.");
			$("#tel0M").focus();
			return check;
		}
		if(tel2 == ''){
			alert("전화번호를 입력하세요.");
			$("#tel2M").focus();
			return check;
		}
		if($("#tel2M").val().length < 3){
			alert("전화번호를 입력해주세요.")
			$("#tel2M").focus();
			return check;
		}
		if(tel3 == ''){
			alert("전화번호를 입력하세요.");
			$("#tel3M").focus();
			return check;
		}
		if($("#tel3M").val().length < 4){
			alert("전화번호를 입력해주세요.")
			$("#tel3M").focus();
			return check;
		}
		check = true;
		if(check == true){
			$.ajax({
				url : "${pageContext.request.contextPath}/member/memberUpdate",
				type : "post",
				data : {
					id : $("#idM").val(),
					pw : pw,
					tel0 : tel0,
					tel1 : tel1,
					tel2 : tel2,
					tel3 : tel3
				},
				success : function(data){
					data = data.trim();
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
				$("#subView").html(data);
			}
		});
	});
});
</script>
<input type="hidden" id="idM" value="${member.id }">
	<label>이메일</label> <span>${member.id }</span><br>
	<label>비밀번호</label> <input type="password" id="pwM" name="pw" maxlength="15" placeholder="비밀번호"><br>
	<label>비밀번호 확인</label> <input type="password" id="pwcM" name="pwc" maxlength="15" placeholder="비밀번호 확인"><br>
	<label>이름</label> <span>${member.name }</span><br>
	<label>생일</label> <span>${member.birth }</span><br>
	<label>성별</label> <span>${member.gender }</span><br>
	<label>핸드폰</label>
	<select id="tel0M" name="tel0">
			<option value="${member.tel0 }">${member.tel0 }</option>
			<option value="">선택하세요.</option>
			<option value="SKT">SKT</option>
			<option value="KT">KT</option>
			<option value="LGU">LGU</option>
	</select>
	<select id="tel1M" name="tel1" >
		<option value="${member.tel1 }">${member.tel1 }</option>
		<option value="010">010</option>
		<option value="011">011</option>
		<option value="016">016</option>
		<option value="017">017</option>
		<option value="018">018</option>
		<option value="019">019</option>
	</select>
	<input type="text" id="tel2M" name="tel2" maxlength="4" placeholder="전화번호" value="${member.tel2 }">
	<input type="text" id="tel3M" name="tel3" maxlength="4" placeholder="전화번호" value="${member.tel3 }"><br>
	<button type="button" id="update">회원 수정</button>
	<button type="button" id="delete">회원 탈퇴</button>