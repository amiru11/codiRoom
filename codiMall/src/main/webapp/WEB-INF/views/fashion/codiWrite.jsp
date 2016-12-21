<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/capture/html2canvas.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/capture/html2canvas.svg.js"></script>
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

//상품 리스트
$(".sel_kindsel").on('change',function(){
	alert(123);
});
$(function(){
	
	getProductSelectList();
	$("#sel_prosel").on('change',function(){
		alert($(this).val());
		getKindList($(this).val());
		
	});
	
	
	
});

function getProductSelectList(){
	$.ajax({
		url : "../json/codiProductSelectList",
		type : "post",
		dataType : 'json',
		data : {
		},
		success : function(data) {
			$("#div_productSelect").html("");
			var x="<select id='sel_prosel' name='productSelect_num'>";
			$.each(data.ar, function( index, value ) {
	    		x=x+"<option value='"+value.productSelect_num;
	    		x=x+"'>"+value.productSelect_name+"</option>"
	    	});
			x=x+"</select>"
			$("#div_productSelect").html(x);
			$("#sel_prosel").on('change',function(){
				getKindList($("#sel_prosel").val());
				getCodiProductList(1);
			});
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "error:" + error);
		}
	});
	
	
}

function getKindList(productSelect_num){
	$.ajax({
		url : "../json/codiKindList",
		type : "post",
		dataType : 'json',
		data : {
			productSelect_num:productSelect_num
		},
		success : function(data) {
			$("#div_kind").html("");
			var x="<select class='sel_kindsel' name='kind_num'>";
			$.each(data.ar, function( index, value ) {
				alert(value.kind_num);
	    		x=x+"<option value='"+value.kind_num+"'>"+value.kind_name+"</option>"
	    	});
			x=x+"</select>"
			$("#div_kind").html(x);
			$(".sel_kindsel").on('change',function(){
				alert($(this).val());
				getCodiProductList($(this).val());
			});
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "error:" + error);
		}
	});
}

function getCodiProductList(kind_num){
	$.ajax({
		url : "../json/codiProductList",
		type : "post",
		dataType : 'json',
		data : {
			kind_num:kind_num
		},
		success : function(data) {
			$("#div_product").html("");
			var x="<table>";
			$.each(data.ar, function( index, value ) {
	    		x=x+"<tr><td>"+value.productDTO.product_num+"</td><td>"+value.productDTO.product_name+"</td></tr>"
	    	});
			x=x+"</table>"
			$("#div_product").html(x);
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "error:" + error);
		}
	});
}



//이미지 무빙
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
});

</script>
</head>
<body>
<div style="background-color: black; width: 500px; height: 500px;" id="a">
	<div class="divv" id="div1" style="background : url(${pageContext.request.contextPath}/resources/images/btn_search.png); position: absolute; margin-left: 200px; margin-top: 200px; width: 200px; height: 200px;">
		<input id="t1" type="text" value="" readonly="readonly">
		<input id="t2" type="text" value="" readonly="readonly">
	   <!-- <img alt="" src=""> -->
	</div>
	<div class="divv" style="background-color: gray; width: 100px; height: 100px;">
		<img alt="" src="${pageContext.request.contextPath}/resources/images/btn_search.png">
	</div>
	
	<!-- 상품 리스트 -->
	<div id="div_productSelect"></div>
	<div id="div_kind">
	<select class="sel_kindsel" style="display: none;"></select></div>
	<div id="div_product"></div>
	
</div>
	<button>코디 생성</button><br>
	
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
                url: "${pageContext.request.contextPath}/fashion/codiCreate",
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