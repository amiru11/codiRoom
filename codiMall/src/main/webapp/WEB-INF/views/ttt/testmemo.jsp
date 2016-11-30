<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
	table{
		width: 400px;
		border : 1px solid black;
		border-collapse: collapse;
		border-spacing: 0;
		margin : 0 auto;
	}
	
	.td2{
		width : 150px;
	}
	.t1{
		width  : 400px;
		
		margin : 0 auto;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#btn").click(function(){
		        $.ajax({ 
		        		url :"memoWrite" ,
		                type:"POST" ,//type을 겟으로 쓸지 포스트로 쓸지에 따라서 달라진다
		                data:{
		                  writer:$("#c1").val(),
		                  contents:$("#c2").val()   
		                },
		            	success: function(data){
		            		alert(data.trim());
		            		location.href = "${pageContext.request.contextPath}/ttt/memoList";
		      			}
		        });
		});
	  
		$("#btn2").click(function(){
			$(".ch:checked").each(function(){				
				$.ajax({
					url :"memoDel.memo",
					type:"POST",
					data:{
						num:$(this).val()
					},
					success: function(data){
						alert(data);
					}
				});
			});
		});	
			
/* 			$.post("memoWrite.memo", {
				writer : $("#c1").val() ,
				contents : $("#c2").val()
			},function(data){
				//before & after를 사용해서 써야한다
				alert(data);
				$("#title").after(data);//data자체가 table tag다!
				$("#c1").val('');
				$("#c2").val('');
			}); */
			
		
		
        //체크박스 전체선택 and 해제//
		$("#aChk").click(function(){
			if($("#aChk").prop("checked")){
				$(".ch").each(function(){					
					$(this).prop("checked", true);
				});
			}else{					
				$(".ch").each(function(){					
					$(this).prop("checked", false);
				});
			}
		});
	});
</script>
<title>LIST</title>
</head>
<body>
	<div class="t1">
		<input type="text" name="writer" id="c1"> <br>
		<textarea rows="3" cols="" name="contents" id="c2"></textarea> <br>
		<input type="button" value="WRITE" id="btn">
		<input type="button" value="DELETE" id="btn2">
	</div>
	<table>
		<tr id="title">
			<td><input type="checkbox" id="aChk"></td>
			<td>NUM</td>
			<td>WRITER</td>
			<td>CONTENTS</td>
		</tr>
	<c:if test="${list ne null }">
		<c:forEach items="${list}" var="memo">
			<tr>
				<td><input type="checkbox" class="ch" value="${memo.num}"></td>
				<td>${memo.num}</td>
				<td>${memo.writer}</td>
				<td class="td2">${memo.contents}</td>
				<%-- <td>${memo.reg_date}</td> --%>
			</tr>	
		</c:forEach>
	</c:if>	
	</table>
</body>
</html>