<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".divv").on("mouseenter",function(event) {
			var x = event.pageX;
			var y = event.pageY;
			$(this).mousedown(function(event) {
				x = event.pageX;
				y = event.pageY;
				var aa = $(this).css('margin-left').replace(/[^0-9]/g, "");
				var bb = $(this).css('margin-top').replace(/[^0-9]/g, "");
				$(this).mousemove(function(event) {
					$("#t1").val($("#div1").css('margin-left').replace(/[^0-9]/g, ""));
					$("#t2").val($("#div1").css('margin-left').replace(/[^0-9]/g, ""));
					$(this).css({
						"margin-left" : aa * 1 + ((event.pageX) * 1 - x * 1) * 1,
						"margin-top" : bb * 1 + ((event.pageY) * 1 - y * 1) * 1
					});
				});
			});
			$(this).mouseup(function(event) {
				$(this).off("mousemove");
			});
			$(this).mouseout(function(event) {
				$(this).off("mousemove");
			});

		});

		/* $(".divv").mouseenter(function(event) {
			var x = event.pageX;
			var y = event.pageY;
			$(this).mousedown(function(event) {
				x = event.pageX;
				y = event.pageY;
				var aa = $(this).css('margin-left').replace(/[^0-9]/g, "");
				var bb = $(this).css('margin-top').replace(/[^0-9]/g, "");
				$(this).mousemove(function(event) {
					$("#t1").val($("#div1").css('margin-left').replace(/[^0-9]/g, ""));
					$("#t2").val($("#div1").css('margin-left').replace(/[^0-9]/g, ""));
					$(this).css({
						"margin-left" : aa * 1 + ((event.pageX) * 1 - x * 1) * 1,
						"margin-top" : bb * 1 + ((event.pageY) * 1 - y * 1) * 1
					});
				});
			});
			$(this).mouseup(function(event) {
				$(this).off("mousemove");
			});
			$(this).mouseout(function(event) {
				$(this).off("mousemove");
			});
		}); */
	});
</script>

</head>
<body>
	<div style="background-color: red; width: 1000px; height: 1000px;">
		<a href="/myweeb/board/boardWrite">BOARDWRITE</a>
		<div class="divv" id="div1"
			style="background-color: blue; position: absolute; margin-left: 300px; margin-top: 300px; width: 200px; height: 200px;">
			<input id="t1" type="text" value="" readonly="readonly"> <input
				id="t2" type="text" value="" readonly="readonly">
		</div>
		<div class="divv" style="background-color: gray; width: 50px;height: 50px;"></div>
	</div>
</body>
</html>
