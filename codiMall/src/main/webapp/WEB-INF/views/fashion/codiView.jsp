<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>    
<!DOCTYPE html>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/product/productList.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/pagination.css" rel="stylesheet">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>코디보기</title>
<style type="text/css">
#contents {
    /* margin-top: 138px; */
    position: relative;
}
#sub_contents {
    width: 1200px;
    margin-left: -15px;
}
.item_ul {
    min-height: 752px;
}
.item_ul li > div {
    display: inline-block;
    zoom: 1;
}
.item_ul li div.img {
    width: 600px;
    height: 600px;
    border: 1px solid #eeeeee;
    margin-left: 15px;
    margin-top: 50px;
    margin-bottom: 30px;
    margin-right: 30px;
    background-color: #f7f7f7;
}
.item_ul li div.cont {
    width: 470px;
    text-align: center;
    vertical-align: top;
    margin-top: 120px;
    position: relative;
    height: 600px;
}
.item_ul li div.cont span.photo {
    width: 100px;
    height: 100px;
    margin-top: 30px;
    display: inline-block;
    zoom: 1;
    position: relative;
    margin-bottom: 10px;
}
.item_ul li div.cont span.photo img {
    width: 100px;
    height: 100px;
}
.item_ul li div.cont span.photo .mask_span {
    background: url(../img/main/photo_bg100.png) left no-repeat;
    position: absolute;
    top: 0;
    left: 0;
    width: 100px;
    height: 100px;
}
.item_ul li div.cont .user {
    font-size: 14px;
    color: #b6b6b6;
    display: block;
    line-height: 20px;
}
.item_ul li div.cont .s_line {
    margin-top: 20px;
    margin-bottom: 25px;
}
.item_ul li div.cont .msg {
    font-size: 14px;
    color: #333333;
    line-height: 18px;
}
ul.items_item {
    overflow: hidden;
    margin-left: 15px;
    width: 1200px;
}
ul.items_item li div.mc {
    width: 250px;
    height: 300px;
    border: 1px solid #eeeeee;
}
ul.items_item li {
    position: relative;
    width: 250px;
    background-color: #ffffff;
    float: left;
    margin-right: 30px;
    margin-bottom: 30px;
}
ul.items_item li span.img {
    width: 250px;
    height: 250px;
    display: block;
    border-bottom: 1px solid #eeeeee;
    position: relative;
}
ul.items_item li .info {
    margin-left: 20px;
    position: relative;
}
ul.items_item li .info .tit {
    margin-top: 15px;
}
ul.items_item li .info .tit a {
    display: inline-block;
    zoom: 1;
    color: #444;
    font-size: 14px;
    width: 185px;
    line-height: 20px;
}
ul.items_item li .info p.brand {
    font-size: 12px;
    color: #bababa;
    line-height: 15px;
}
ul.items_item li .info p.price {
    font-size: 14px;
    line-height: 40px;
    letter-spacing: -1px;
}
ul#codi_item_li li {
    position: relative;
    width: 270px;
    float: left;
}
</style>
</head>
<body>
	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->
	
	<div class="container" style="padding-top: 20px;">
		<div class="row">
			<div class="col-sm-12">
				<div id="contents">		    
				    <div id="sub_contents">
						<ul class="item_ul">
							<li>
								<div class="img">
									<img src="${pageContext.request.contextPath}/resources/codiUpload/${view.fileName}" alt="${view.title}" width="600" height="600">
								</div>
								<div class="cont">
		   							<span class="photo">
		    							<img src="${pageContext.request.contextPath}/resources/images/ic_profilepic.png" alt="">
		    							<span class="mask_span"></span>
		   							</span>
		   					
				   					<p class="user">
				   						${view.member_id}
				   					</p>
					    			<p class="s_line">
					    				<img src="${pageContext.request.contextPath}/resources/images/line_s.png" alt="">
					    			</p>
				   					<div class="msg">
				   						<p>
											${view.title}
				   						</p>
				    				</div>
								</div>
							</li>
						</ul>
						<ul class="items_item" id="codi_item_li">
							<c:forEach items="${list}" var="list1">
							<li>
								<div class="mc" style="border: 1px solid #eee;">
									<span class="img"> <a
										href="${pageContext.request.contextPath}/product/productView?product_num=${list1.productDTO.product_num}">
											<img
											src="${pageContext.request.contextPath}/resources/testPic/${list1.productPicDTO.productPic_pic}"
											width="250" height="250">
									</a>
									</span>
									<div class="item-info" style="padding-left: 10px;">
										<p style="padding-top: 10px;">
											<a
												href="${pageContext.request.contextPath}/product/productView?product_num=${list1.productDTO.product_num}">${list1.productDTO.product_name}</a>
										</p>
									</div>
								</div>
				    		</li></c:forEach></ul>				
					</div>
				</div>
			</div>
		</div>
	</div>	
	
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>
	<!-- Footer:E -->
</body>
</html>