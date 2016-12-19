<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/product/qnaForm.css" rel="stylesheet">
<link rel="stylesheet" href="http://fonts.googleapis.com/earlyaccess/hanna.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		console.log(${product_num});
		console.log($("#qproduct_num").val());
		$("#writeQnA").click(function(){
		 	
 			$.ajax({
				url :"${pageContext.request.contextPath}/board/qnaWrite",
				type : "GET",
				data : {
					board_title : $("#qtitle").val(),
					board_writer: $("#qwriter").val(),
					board_category:	$('input:radio[name="category"]:checked').val(),
					board_contents:	$("#qcontents").val(),
					product_num: $("#qproduct_num").val()
				},
				success: function(data){
					alert(data.trim());
					console.log(data.trim());
					opener.location.reload();
					close();
				}
			}); 
		});
		
	});
</script>
</head>
<body>
	<div class="container">
		<div class="qa_write_pop"> 
	<!-- 컨텐츠 영역 -->
			<!--page title-->
		    <div class="box_title">
		        <span class="txt_tit_page">PRODUCT Q&amp;A</span><span class="fr"><a href="#" onclick="self.close(); return false;"><img src="//image.musinsa.com/skin/musinsa/images/btn_lyr_x.gif" alt="close"></a></span>
		    </div>
		    <!--//page title-->
			<form action="${pageContext.request.contextPath}/board/qnaWrite" name="frm">
				<input type="hidden" value="관리자" id="qwriter">
				<input type="hidden" value="${product_num}" id="qproduct_num">
		    <div class="section_contents">
				        <div class="qa_product">
		            <div class="connect_qa_img">
		                <img src="//image.musinsa.com/images/goods_img/20160919/413888/413888_8_125.jpg" alt="[크리스마스패키지] SSTZ 컬러립 양말 5P 기프트세트 / 21color 선택가능">
		            </div>
		            <div class="article_info connect_info">
		                <p class="item_title">[삭스타즈]</p>
		                <p class="list_info">[크리스마스패키지] SSTZ 컬러립 양말 5P 기프트세트 / 21color 선택가능</p>
		                <p class="box_price">
							<span class="txt_origin_price">22,000원</span>
							19,800<span class="txt_unit_price">원</span>
							<span class="payment_off qa_payment_off">10% SALE</span>
						</p>
					</div>
		        </div>
				        <div class="box_contents">
		            <ul>
		                <li class="qa_write_tit">구분</li>
		                <li class="txt_input_qa">
							<input type="radio" class="qcategory" name="category" value="사이즈"> 사이즈
							<input type="radio" class="qcategory" name="category" value="배송"> 배송
							<input type="radio" class="qcategory" name="category" value="재입고"> 재입고
							<input type="radio" class="qcategory" name="category" value="기타"> 기타
						</li>
		             </ul>   
		            <ul>
		                <li class="qa_write_tit">제목</li>
		                <li class="txt_input_qa">
							<input type="text" id="qtitle" name="" class="tit" value=""> 
							<input type="checkbox" name="is_secret" value="1"> 잠금사용
						</li>
		             </ul>      
		            <ul>    
		                <li class="qa_write_tit">내용</li>
		                <li>
		                    <textarea id="qcontents" name="question" rows="10" cols="45"></textarea>
		                </li>
		            </ul>    
		        </div>
		    </div>
		    <div class="box_contents">
		        <p><img src="//image.musinsa.com/skin/musinsa/images/guide_write.gif" alt=""></p>
		        <div class="address_btn_pop">
		            <a href="#" id="writeQnA" class="plain-btn btn btn-default" role="button">등록하기</a>
		            <a href="#" onclick="location.reload(); return false;" class="plain-btn btn btn-default" role="button">다시쓰기</a>
		        </div>
		    </div>
		    </form>
		<!--// 컨텐츠 영역 -->
		</div>
	</div>
</body>
</html>