<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/basket/basket.css"
	rel="stylesheet">
<style type="text/css">
#second_now{
	background: url(/codi/resources/images/basket/hgroup_img.gif) no-repeat 0 0;
	background-position: -222px -93px;
}
#order_tit{
	width: 180px;
    background: url(/codi/resources/images/basket/hgroup_img.gif) no-repeat 0 0;
    background-position: -415px 0px;
    text-indent: -9999px;
}
.divide_hr{
	border : 0.8px solid #dce2eb;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#btn_buy").click(function(){
			$("#tab_form").attr("action","${pageContext.request.contextPath}/buy/basketBuy");
			$("#tab_form").submit();
		});
		
		$("#claim_refund").click(function(){
			$("#refund_radio").prop("checked",true);
			$("#exchange_radio").prop('checked',false);
			$("#claim_refund").css("background-color","#eff3f5");
			$("#claim_exchange").css("background-color","white");
		});
		$("#claim_exchange").click(function(){
			$("#refund_radio").prop("checked",false);
			$("#exchange_radio").prop('checked',true);
			$("#claim_exchange").css("background-color","#eff3f5");
			$("#claim_refund").css("background-color","white");
		});
		
		$(".box_choice").click(function(){
			$("#buy_info").toggle();
		});
	});
	
	/* 주소지 찾기 */
	function openDaumPostcode(){
		new daum.Postcode({
			oncomplete : function(data){
				document.getElementById('post1').value=data.postcode;
				document.getElementById('addr').value=data.address;
				document.getElementById('addr2').focus();
			}
		}).open();
	}
		
</script>
</head>
<body>
	<!-- HEADER:S -->
	<%@ include file="/resources/temp/header.jsp"%>
	<!-- HEADER:E -->

	<div class="container cart-body">
		<div class="row">
			<div class="col-sm-12">
				<h1 id="cart_title" class="page-heading">Order/Payment summary </h1>
				<div>
					<ul class="step list-inline" id="order_step">
						<li id="order_tit" class="title_img">TITLE</li>
						<li class="step-li first">
							<span>주문 완료</span>
						</li>
						<li class="arrow-li"></li>
						<li id="second_now" class="step-li second">
							<span> 주문서 작성</span>
						</li>
						<li class="arrow-li"></li>
						<li class="step-li third">
							<span> 장바구니</span>
						</li>
					</ul>
				</div>
				<form id="tab_form" method="post">
					<div style="	border: 2px solid #dce2eb;">
						<h3 class="product_tit">PRODUCT INFO</h3>
						<table class="table cart-table">
						<tr>
							<th class="bas_th_01">상품명</th>
							<th class="bas_th_02">판매가</th>
							<th class="bas_th_03">할인율</th>
							<th class="bas_th_04">옵션</th>
							<th class="bas_th_05">색상</th>
							<th class="bas_th_06">수량</th>
							<th class="bas_th_07">주문금액</th>
						</tr>
						<c:forEach var="list1" items="${list}">
							<tr>
								<td style="width: 200px;"><input type="hidden" name="basket_num"  value="${list1.basket_num}"><input type="hidden" name="product_num"  value="${list1.product_num}">
										<div class="bas_td_hid_proeach" style="display: inline-block; float: left;" >
										<a href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">
											<img alt="" src="${pageContext.request.contextPath}/resources/images/noimage.jpg" width="60" height="60">
										</a>
										</div>
										<div style="display: inline-block; margin-top: 20px;float: left;">
										<p>
											<a
												href="${pageContext.request.contextPath}/product/productView?product_num=${list1.product_num}">
													${list1.product_name}
											</a>
										</p>
										</div>
								</td>
								<td><input type="hidden" name=""  value="${list1.productInfo_price}"><fmt:formatNumber value="${list1.productInfo_price}" currencySymbol="" type="currency"/>원</td>
								<td><input type="hidden" name=""  value="${list1.productInfo_saleRate}">${list1.productInfo_saleRate}%</td>
								<td><input type="hidden" name=""  value="${list1.basketInfo_size}">${list1.basketInfo_size}</td>
								<td><input type="hidden" name=""  value="${list1.basketInfo_color}">${list1.basketInfo_color}</td>
								<td><input type="hidden" name=""  value="${list1.basketInfo_each}">${list1.basketInfo_each}</td>
								<td>
									<fmt:formatNumber
										value="${list1.productInfo_price*list1.basketInfo_each*(100-list1.productInfo_saleRate)/100}"
										currencySymbol="" type="currency" />원
								</td>
							</tr>
						</c:forEach>
					</table>
					</div>
			
					<div class="recipient-info">
						<h3 class="product_tit">RECIPIENT INFO</h3>
						<hr>
						<div class="clearfix">
							<ul class="box_receiver_info list-inline">
								<li class="info_tit">배송지 선택</li>
								<li class="cell_discount_detail">
									<label class="box_choice">
										<input type="radio" id="address_old" name="adress_chk" onclick=""> 기본 배송지(구매자 정보)
									</label>
									<label class="box_choice">
										<input type="radio" id="address_new" name="adress_chk" onclick=""> 새로운 배송지
									</label>
								</li>
							</ul>
							<hr class="divide_hr">
							<ul class="box_receiver_info list-inline">
								<li class="info_tit">수령인 / 배송지명</li>
								<li class="cell_discount_detail2 order_address_form box_receiver">
									<input type="text" name="receiver" class="form-control info_name">
								</li>
							</ul>			
							<hr class="divide_hr">				
							<ul class="box_receiver_info list-inline">
								<li class="info_tit">전화번호</li>
								<li style="margin-top : 5px;">
									<select class="form-control input-group-addon" id="tel0" name="tel0" style="height: 34px; background-color:white; display: inline-block; float: left; width : 50px;">
										<option value="SKT">SKT</option>
										<option value="KT">KT</option>
										<option value="LGU">LGU</option>
									</select>
									<input type="tel" class="form-control decorative-input" id="tel1" name="tel1" maxlength="11" placeholder="'-' 없이 입력해주세요." onkeyup="telCheck()" style=" height: 34px; width: 200px; background-position: right -145px;">	
								</li>
							</ul>
							<hr class="divide_hr">
							<ul class="box_receiver_info list-inline">
								<li class="info_tit" style="vertical-align: top;">배송지 주소</li>
								<li>
									<input type="text" id="post1" class="address form-control" readonly="readonly" name="m_zipcode" size="10" style="width: 200px; float:left;">
									<input type="button" onclick="openDaumPostcode()" value="우편번호 찾기" class="btn btn-default" style="float:right;"><br>
									<input type="text" id="addr" class="address form-control" readonly="readonly" name="a1" style="width:250px; float:left;"><input type="text" id="addr2" class="address form-control" name="a2" style="width:300px;"><br>
								</li>
							</ul>
							<hr class="divide_hr">
							<ul class="box_receiver_info list-inline">
								<li class="info_tit" style="vertical-align: top;">배송메모</li>
								<li>
									<textarea rows="" cols="90" class="form-control"></textarea>
								</li>
							</ul>
						</div>
					</div>
					<div class="payment-info">
						<h3 class="product_tit">PAYMENT INFO / AGREEMENT</h3>
						<hr>
						<div class="clearfix">
							<ul class="box_receiver_info list-inline">
								<li class="info_tit">결제 방법</li>
								<li class="cell_discount_detail">
									<label class="box_choice">
										<input type="radio" id="credit-card" name="paymentType" onclick=""> 신용 카드
									</label>
									<label class="box_choice">
										<input type="radio" id="virtual-account" name="paymentType" onclick=""> 가상계좌
									</label>
									<label class="box_choice">
										<input type="radio" id="transfer-account" name="paymentType" onclick=""> 계좌이체
									</label>
									<label class="box_choice">
										<input type="radio" id="payco" name="paymentType" onclick=""> 페이코
									</label>
								</li>
							</ul>
							<hr class="divide_hr">
							<ul id="buy_info" class="box_receiver_info list-inline" style="display: none;">
								<li class="info_tit" style="vertical-align: top;">결제 안내</li>
								<li style="width : 800px;"><!-- 라디오버튼 클릭시 나타나게해야함 -->
									<div id="credit_info">
										<p class="txt_tit_payment" style="font-size:16px; font-weight: bold;">안전결제(ISP)? (국민카드/BC카드/우리카드)</p>
										<p class="txt_desc_payment" style="line-height: 18px; color : #ccc;">
											온라인 쇼핑시 주민등록번호, 비밀번호 등의 주요 개인정보를 입력하지 않고 고객님이 사전에 미리 설정한 안전결제(ISP) 비밀번호만 입력, 결제하도록 하여 개인정보 유출 및 카드 도용을 방지하는 서비스입니다.
										</p>
										<p class="txt_tit_payment follow" style="font-size:16px; font-weight: bold;">안심 클릭 결제? (삼성/외환/롯데/현대/신한/시티/하나/NH/수협/전북/광주/산업은행/제주은행)</p>
										<p class="txt_desc_payment" style="line-height: 18px; color : #ccc;">
											온라인 쇼핑시 주민등록번호, 비밀번호 등의 주요 개인 정보를 입력하지 않고 고객님이 사전에 미리 설정한 전자 상거래용 안심 클릭 비밀번호를 입력하여 카드 사용자 본인 여부를 확인함으로써 온라인상에서의 카드 도용을 방지하는 서비스입니다.
										</p>
									</div>
									<div id="account_info">
										<p class="txt_tit_payment" style="font-size:16px; font-weight: bold;">가상 계좌 안내</p>
										<p class="txt_desc_payment" style="line-height: 18px; color : #ccc;">
											무통장입금(가상 계좌)는 각 주문별로 새로운 계좌번호가 생성되는 방식으로 해당계좌로 주문금액을 입금하시면 자동으로 입금확인처리됩니다. 단, 자동으로 처리되기 때문에 주문금액과 정확히 동일한 금액을 입금하셔야만 입금이 가능합니다. 주문금액이 87,950원일 경우 88,000원이나 90,000원을 입금하시면 입금되지 않습니다. 인터넷뱅킹, 텔레뱅킹, ATM/CD 기계, 은행 창구 등에서 입금하실 수 있습니다.
										</p>
									</div>
									<div id="transfer_info">
										<p class="txt_tit_payment" style="font-size:16px; font-weight: bold;">계좌이체(에스크로) 안내</p>
										<p class="txt_desc_payment" style="line-height: 18px; color : #ccc;">
											계좌이체는 ATM이나 은행 홈페이지에 접속하지 않고 무신사 홈페이지 내에서 즉시 결제, 출금되는 결제 방식입니다.
											현재 약 20여 개의 은행이 가능하며 현금영수증 발행은 결제 시 즉시 발급받으실 수 있습니다.
										</p>
									</div>
									<div id="payco_info">
										<p class="txt_tit_payment" style="font-size:16px; font-weight: bold;">PAYCO 결제 안내</p>
										<p class="txt_desc_payment" style="line-height: 18px; color : #ccc;">
											PAYCO는 NHN엔터테인먼트가 만든 안전한 간편결제 서비스입니다. 본인인증한 휴대폰과 카드 명의자가 동일해야 결제 가능하며, 결제금액 제한은 없습니다.
										</p>
										<p class="txt_desc_payment" style="line-height: 18px; color : red;">
											- 지원카드 : 모든 국내 신용/체크카드
										</p>
										<p class="txt_desc_payment" style="line-height: 18px; color : red;">
											- 이벤트 : 첫 구매 시(1만원 이상) 3,500원 즉시할인쿠폰
										</p>
									</div>
								</li>
							</ul>
							<hr class="divide_hr">
							<ul class="box_receiver_info list-inline">
								<li class="info_tit" style="vertical-align: top;">품절 시 처리 방법</li>
								<li style="width: 800px;">
									<input type="hidden" id="clm_soldout_type" name="" value="1">
									<div class="select_cancel" id="claim_refund">
										<div class="box_claim_order">
											<div>
												<label for="refund_radio">												
													<input type="radio" name="claim_btn" id="refund_radio" style="margin-right: 5px;">REFUND(환불)
												</label>
											</div>
											<p class="box_desc">환불을 선택하시면 별도의 연락 없이<br>선택하신 결제 방법으로 환불해 드립니다.</p>
										</div>
									</div>
									<div class="select_cancel" id="claim_exchange">
										<div class="box_claim_order">
											<div>
												<label for="exchange_radio">
													<input type="radio" name="claim_btn" id="exchange_radio" style="margin-right: 5px;">EXCHANGE(교환) 
												</label>
											</div>
											<p class="box_desc">교환을 선택하시면 주문자 정보를 통해<br>연락드린 후 교환을 도와드리겠습니다.</p>
										</div>
									</div>
									<p class="box-desc_out">업체 배송 특성상 품절일 가능성이 있습니다. 이에 품절시 고객님이 선택하신 방법으로 처리 해드립니다.</p>
								</li>
							</ul>
							<hr class="divide_hr">
							<ul class="box_receiver_info list-inline">
								<li class="info_tit" style="vertical-align: top;">주문자 동의</li>
								<li style="width: 800px;"></li>
							</ul>
						</div>		
					</div>
					<div class="button-set" style="float:right; font-family: hanna;">
						<input type="button" value="구매하기" id="btn_buy" class="btn btn-default">
					</div>
				</form>	
			</div>
		</div>
	</div>		
	
	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>
	<!-- Footer:E -->
</body>
</html>
