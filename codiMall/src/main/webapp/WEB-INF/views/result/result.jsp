<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script>
	var message = "${message}"
	if (message != "") {
		alert(message);
		location.href="${pageContext.request.contextPath}${location}"
	} else {
		alert("잘못된접근");
		location.href="${pageContext.request.contextPath}/"
	}
	
</script>