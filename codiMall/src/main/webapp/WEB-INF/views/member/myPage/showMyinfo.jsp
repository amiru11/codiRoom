<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function() {
	$("#update").click(function() {
		var pw = $("#pwM").val();
		var pwc = $("#pwcM").val();
		var tel0 = $("#tel0M").val();
		var tel1 = $("#tel1M").val();
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
		if(tel1 == ''){
			alert("전화번호를 입력하세요.");
			$("#tel1M").focus();
			return check;
		}
		var telChar = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})[0-9]{3,4}[0-9]{4}$/;
		 if(telChar.test(tel1) == false){
	        	alert("전화번호 형식이 다릅니다.");
	        	$("#tel1").focus();
	        	return check;
	        }
		if($("#tel1M").val().length < 10){
			alert("전화번호를 입력해주세요.")
			$("#tel1M").focus();
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
					tel1 : tel1
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

function telCheck() {
	var tel1 = $("#tel1").val();
	var telChar = /[0-9]/;
	for(var i=0; i<tel1.length; i++){
        if(telChar.test(tel1.charAt(i)) == false ){
        	alert("잘못입력하였습니다.");
        	$("#tel1").focus();
        	return false;
        }
	}
};

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
			<option value="">통신사 선택</option>
			<option value="SKT">SKT</option>
			<option value="KT">KT</option>
			<option value="LGU">LGU</option>
	</select>
	<input type="text" id="tel1M" name="tel1" maxlength="11" placeholder="'-' 없이 입력해주세요." value="${member.tel1 }" onkeyup="telCheck()">
	<button type="button" id="update">회원 수정</button>
	<button type="button" id="delete">회원 탈퇴</button>