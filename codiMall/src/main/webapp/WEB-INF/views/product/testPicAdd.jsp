<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<style type="text/css">
table, table tr, tr td, th {
	border: 1px solid black;
}
</style>
<script type="text/javascript">
	$(function() {

	});
</script>
</head>
<body>
	<h1>PRODUCT ADDDDDDDDDDDDD</h1>
	<h1>
		<a href="${pageContext.request.contextPath}/">HOME</a>
	</h1>
	<form action="${pageContext.request.contextPath}/product/testPicAdd"
		method="post" enctype="multipart/form-data">
		<input type="file" name="pic">
		<input type="file" name="pic">
		<button>SUBMIT</button>
	</form>
	<hr>
	<hr>
	<hr>
	<hr>


</body>
</html>
