<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
	<ul class="list-inline" style="width : 850px;">
		<c:forEach items="${list}" var="list1">
		<li style="padding-left:20px;" class="viewItem">
			<div class="mc" style="border : 1px solid #eee;">
				<span class="img">
					<a href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">
						<img src="http://placehold.it/500x150&text=FooBar1" width="250" height="250">
					</a>
				</span>
				<div class="item-info" style="padding-left: 10px;">
					<p style="padding-top:10px;">
	  					<a href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">${list1.product_name}</a>
	  				</p>
  					<p>브랜드</p>
  					<p>
	  					<span>
	  						<fmt:formatNumber value="${list1.productInfo_price}" currencySymbol="" type="currency"/>원
	  					</span>
  						<strong style="color:#b5172e;">→639,200 원(20%)</strong>
  					</p>								
				</div>
				<div class="cart">
					<span style="font-size: 20px; color: #ffffff;">ADD TO CART</span>
				</div>
			</div>
		</li>
		</c:forEach>
	</ul>