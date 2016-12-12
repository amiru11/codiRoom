<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(function() {
	$("#delete").click(function() {
		var check = confirm("삭제 하시겠습니까?");
		if(check){
			$.ajax({
				url : "${pageContext.request.contextPath}/member/memberDelete",
				type : "post",
				data : {
					id : $("#idD").val(),
					pw : $("#pwD").val()
				},
				success : function(data) {
					if(data.result > 0){
						window.location = "${pageContext.request.contextPath}/";
					}else {
						$("#subView").html(data.message);
					}
				}
			});
		}
	});

});
</script>
${data.result}
<input type="hidden" id="idD" value="${member.id }">
	<label>이메일</label> <span>${member.id }</span><br>
	<label>비밀번호</label> <input type="password" id="pwD" name="pw" maxlength="15" placeholder="비밀번호"><br>
	<button type="button" id="delete">회원 탈퇴</button>