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
		var message = "${message}";
		if(message != ""){
			alert(message);
		}

		$("#btn_add_proeach").click(function() {
			$(".div_proeach").clone().appendTo("#div_first_proe");
		});
	});
</script>
</head>
<body>
	<h1>PRODUCT ADDDDDDDDDDDDD</h1>
	<h1>
		<a href="${pageContext.request.contextPath}/">HOME</a>
	</h1>
	<form action="${pageContext.request.contextPath}/product/productAdd"
		method="post">
		PRODUCT_NAME<input type="text" name="product_name"><br>
		<HR>
		PRODUCTINFO<BR> PRODUCT_PRICE<input type="number"
			name="productInfo_price"><br> PRODUCT_saleRate<input
			type="number" step="0.1" name="productInfo_saleRate"><br>
		PRODUCT_searchWord<input type="text" name="productInfo_searchWord"><br>
		<hr>
		PRODUCTKIND<BR> KIND_NUM<input type="number" name="kind_num"><br>
		<button>SUBMIT</button>
	</form>
	<hr>
	<hr>
	<hr>
	<hr>
	<form
		action="${pageContext.request.contextPath}/product/productEachAdd"
		method="post">
		PRODUCT<BR> PRODUCT_NUM<input type="number" name="product_num"><br>
		<hr>
		<input type="button" id="btn_add_proeach" value="ADD">
		<div id="div_first_proe" style="width: 1000px">
			<div class="div_proeach" style="display: inline-block;">
				<br> PRODUCTEACH_SIZE<input type="text" name="productSize_size"><br>
				PRODUCTEACH_COLOR<input type="text" name="productEach_color"><br>
				PRODUCTEACH_EACH<input type="number" name="productEach_each"><br>
				<button>SUBMIT</button>
			</div>
		</div>
	</form>

</body>
</html>
