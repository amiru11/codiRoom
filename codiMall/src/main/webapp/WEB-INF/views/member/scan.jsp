<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/capture/html2canvas.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/capture/html2canvas.svg.js"></script>
<title>Insert title here</title>
<style type="text/css">
	body {
		margin: 0;
	}
	canvas {
		border: 1px solid black;
		background-color: black;
	}
</style>
<script type="text/javascript">
   $(function() {
      $(".divv").on("mouseenter",function(event) {
         var x = event.pageX;
         var y = event.pageY;
         
         
         $(this).mousedown(function(event) {
            x = event.pageX;
            y = event.pageY;
            var t=$(this).attr("id");
            t="#"+t+"t1";
            var v=$(t).val();
            
            
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
   <div style="background-color: black; width: 500px; height: 500px;" id="a">
      <a href="/myweeb/board/boardWrite">BOARDWRITE</a>
      <div class="divv" id="div1" 
         style="background : url(${pageContext.request.contextPath}/resources/images/btn_search.png); position: absolute; margin-left: 200px; margin-top: 200px; width: 200px; height: 200px;">
         <input id="t1" type="text" value="" readonly="readonly"> <input
            id="t2" type="text" value="" readonly="readonly">
            <!-- <img alt="" src=""> -->
      </div>
      <div class="divv" style="background-color: gray; width: 100px; height: 100px;">
      	<img alt="" src="${pageContext.request.contextPath}/resources/images/btn_search.png">
      </div>
   </div>
   <button>Run html2canvas</button>
<h1>Existing canvas:</h1>
<canvas width="501px" height="501px"></canvas>



   
   
<script type="text/javascript">
    var canvas = document.querySelector("canvas");

    document.querySelector("button").addEventListener("click", function() {
        html2canvas(document.querySelector("#a"), {canvas: canvas}).then(function(canvas) {
        	var data = canvas.toDataURL();
        	alert(data);
            $.ajax({
                type: "POST",
                data : {
                	data : data
                },
                url: "${pageContext.request.contextPath}/member/scanA",
                dataType:"json",
                success: function(response, textStatus, xhr) {
              alert('success');
                },
                error: function(xhr, textStatus, errorThrown) {
                 alert('fail');
                }
            }); 
        });
    }, false);

</script>
</body>
</html>