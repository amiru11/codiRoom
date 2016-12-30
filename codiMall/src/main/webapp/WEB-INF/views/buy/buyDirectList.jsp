<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
<link
	href="${pageContext.request.contextPath}/resources/css/basket/basket.css"
	rel="stylesheet">
<style type="text/css">
#second_now {
	background: url(/codi/resources/images/basket/hgroup_img.gif) no-repeat
		0 0;
	background-position: -222px -93px;
}

#order_tit {
	width: 180px;
	background: url(/codi/resources/images/basket/hgroup_img.gif) no-repeat
		0 0;
	background-position: -415px 0px;
	text-indent: -9999px;
}

.divide_hr {
	border: 0.8px solid #dce2eb;
}

.thirdAgreeDetail {
	height: 100px;
	overflow-y: scroll;
}
</style>
<script type="text/javascript">
	$(function() {
		buyConfirm();
		addrCheck();
		payInfoShow('credit');

	});

	function addrCheck() {
		var count = $(".cl_radio_addr:checked").val();
		if (count == 1) {
			$(".cl_member_addr").css('display', 'inline-block');
			$(".cl_member_addr2").css('display', 'none');
		} else {
			$(".cl_member_addr").css('display', 'none');
			$(".cl_member_addr2").css('display', 'inline-block');
		}
		$(".cl_radio_addr").click(function() {
			var count = $(".cl_radio_addr:checked").val();
			if (count == 1) {
				$(".cl_member_addr").css('display', 'inline-block');
				$(".cl_member_addr2").css('display', 'none');
			} else {
				$(".cl_member_addr").css('display', 'none');
				$(".cl_member_addr2").css('display', 'inline-block');
			}
		});
	}

	function buyConfirm() {
		$("#btn_buy").click(function() {
			var count = $(".cl_radio_addr:checked").val();
			var nullcount = -1;
			var checkcount = 0;
			if (count == 1) {
				$.each($(".cl_member_addrad"), function(key, value) {
					alert($(value).val());
					if ($(value).val() == "") {
						nullcount++;
					}
				});

				if ($(".cl_pilsu_checkbox:checked").length != 2) {
					checkcount++
				}
				alert("null"+nullcount);
				alert("check"+checkcount)
				if (nullcount > 0 && checkcount > 0) {
					alert("모두 입력해 주세요");
					alert("약관을 체크해 주세요");
				} else if ( 0 >= nullcount  && checkcount > 0) {
					alert("약관을 체크해 주세요");
				} else if(nullcount > 0 && checkcount ==0){
					alert("모두 입력해 주세요");
				}else if(nullcount <= 0 && checkcount ==0){
					var xxx = "";
					$.each($(".cl_member_addrad"), function(key, value) {
						if (key == $(".cl_member_addrad").length * 1 - 1) {
							alert("key---"+key);
							alert("addr each_val()"+$(value).val());
							xxx = xxx + $(value).val();
						} else {
							xxx = xxx + $(value).val() + '_-_';
						}
					});
					$("#inh_buyStateAddr").val(xxx);
					alert($("#inh_buyStateAddr").val());
					$("#buy_form_aa").submit();
				}
			} else {
				$.each($(".cl_member_addr2ad"), function(key, value) {
					alert($(value).val());
					if ($(value).val() == "") {
						nullcount++;
					}
				});
				if ($(".cl_pilsu_checkbox:checked").length != 2) {
					checkcount++
				}
				alert(nullcount);
				if (nullcount > 0 && checkcount > 0) {
					alert("모두 입력해 주세요");
					alert("약관을 체크해 주세요");
				} else if ( 0 >= nullcount  && checkcount > 0) {
					alert("약관을 체크해 주세요");
				} else if(nullcount > 0 && checkcount ==0){
					alert("모두 입력해 주세요");
				}else if(nullcount <= 0 && checkcount ==0){
					var xxx = "";
					$.each($(".cl_member_addr2ad"), function(key, value) {
						if (key == $(".cl_member_addr2ad").length * 1 - 1) {
							alert("key---"+key);
							alert("addr each_val()"+$(value).val());
							xxx = xxx + $(value).val();
						} else {
							xxx = xxx + $(value).val() + '_-_';
						}
					});
					$("#inh_buyStateAddr").val(xxx);
					alert($("#inh_buyStateAddr").val());
					$("#buy_form_aa").submit();
				}
			}
		})
	}
					

	//function eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee

	/* 주소지 찾기 */
	function openDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.getElementById('post1').value = data.postcode;
				document.getElementById('addr').value = data.address;
				document.getElementById('addr2').focus();
			}
		}).open();
	}
	function openDaumPostcode2() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.getElementById('ppost1').value = data.postcode;
				document.getElementById('aaddr').value = data.address;
				document.getElementById('aaddr2').focus();
			}
		}).open();
	}


	function payInfoShow(data) {
		$("#buy_info").css("display", "block");
		if (data == 'credit') {
			$("#" + data + "_info").css("display", "block");
			$("#account_info").css("display", "none");
			$("#transfer_info").css("display", "none");
			$("#payco_info").css("display", "none");
		} else if (data == 'account') {
			$("#" + data + "_info").css("display", "block");
			$("#credit_info").css("display", "none");
			$("#transfer_info").css("display", "none");
			$("#payco_info").css("display", "none");
		} else if (data == 'transfer') {
			$("#" + data + "_info").css("display", "block");
			$("#credit_info").css("display", "none");
			$("#account_info").css("display", "none");
			$("#payco_info").css("display", "none");
		} else if (data == 'payco') {
			$("#" + data + "_info").css("display", "block");
			$("#credit_info").css("display", "none");
			$("#account_info").css("display", "none");
			$("#transfer_info").css("display", "none");
		}
	}

	function ToggleThirdAgree() {
		console.log($("#thirdBtn").html());
		if ($("#thirdBtn").html() == '자세히') {
			$("#thirdBtn").html('닫기');
		} else {
			$("#thirdBtn").html('자세히');
		}
		$("#thirdAgreeDetail").toggle();
	}

	function CheckAgree() {
		console.log($(":input[name='all_agree']").prop('checked'));

		if ($(":input[name='all_agree']").prop('checked') == true) {
			$("input[name^='agree_']").prop("checked", true);
		} else {
			$("input[name^='agree_']").prop("checked", false);
		}
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
				<h1 id="cart_title" class="page-heading">Order/Payment summary
				</h1>
				<div>
					<ul class="step list-inline" id="order_step">
						<li id="order_tit" class="title_img">TITLE</li>
						<li class="step-li first"><span>주문 완료</span></li>
						<li class="arrow-li"></li>
						<li id="second_now" class="step-li second"><span> 주문서
								작성</span></li>
						<li class="arrow-li"></li>
						<li class="step-li third"><span> 장바구니</span></li>
					</ul>
				</div>
				<div style="border: 2px solid #dce2eb;">
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
						<tr>
							<td style="width: 200px;"><input type="hidden"
								name="product_num" value="${list.productDTO.product_num}">
								<div class="bas_td_hid_proeach"
									style="display: inline-block; float: left;">
									<a
										href="${pageContext.request.contextPath}/product/productView?product_num=${list.productDTO.product_num}">
										<img
										src="${pageContext.request.contextPath}/resources/testPic/${list.productPicDTO.productPic_pic}"
										width="60" height="60">
									</a>
								</div>
								<div
									style="display: inline-block; margin-top: 20px; float: left;">
									<p>
										<a
											href="${pageContext.request.contextPath}/product/productView?product_num=${list.productDTO.product_num}">
											${list1.product_name} </a>
									</p>
								</div></td>
							<td><fmt:formatNumber
									value="${list.productInfoDTO.productInfo_price}"
									currencySymbol="" type="currency" />원</td>
							<td>${list.productInfoDTO.productInfo_saleRate}%</td>
							<td><input type="hidden" name="productSize_size"
								value="${productSize_size}">${productSize_size}</td>
							<td><input type="hidden" name="productEach_color"
								value="${productEach_color}">${productEach_color}</td>
							<td><input type="hidden" name="productEach_each"
								value="${productEach_each}">${productEach_each}</td>
							<td><fmt:formatNumber
									value="${list.productInfoDTO.productInfo_price*productEach_each*(100-list.productInfoDTO.productInfo_saleRate)/100}"
									currencySymbol="" type="currency" />원</td>
						</tr>
					</table>
				</div>

				<div class="recipient-info">
					<h3 class="product_tit">RECIPIENT INFO</h3>
					<hr>
					<div class="clearfix">
						<ul class="box_receiver_info list-inline">
							<li class="info_tit">배송지 선택</li>
							<li class="cell_discount_detail"><label class="box_choice">
									<input type="radio" id="address_old" class="cl_radio_addr"
									name="adress_chk" value="1" onclick="" checked="checked">
									기본 배송지(구매자 정보)
							</label> <label class="box_choice"> <input class="cl_radio_addr"
									type="radio" value="2" id="address_new" name="adress_chk"
									onclick=""> 새로운 배송지
							</label></li>
						</ul>
						<hr class="divide_hr">
						<ul class="box_receiver_info list-inline">
							<li class="info_tit">수령인 / 배송지명</li>
							<li class="cell_discount_detail2 order_address_form box_receiver">
								<input type="text" value="${sessionScope.member.name}"
								name="receiver"
								class="form-control info_name cl_member_addr cl_member_addrad">
								<input type="text" value="" name="receiver"
								class="form-control info_name cl_member_addr2 cl_member_addr2ad">
							</li>
						</ul>
						<hr class="divide_hr">
						<ul class="box_receiver_info list-inline">
							<li class="info_tit">전화번호</li>
							<li style="margin-top: 5px;"><select
								class="form-control input-group-addon cl_member_addr cl_member_addrad"
								id="tel0" name="tel0"
								style="height: 34px; background-color: white; display: inline-block; float: left; width: 50px;">
									<option value="SKT"
										<c:if test="${sessionScope.member.tel0 == SKT}">selected="selected"</c:if>>SKT</option>
									<option value="KT"
										<c:if test="${sessionScope.member.tel0 == KT}">selected="selected"</c:if>>KT</option>
									<option value="LGU"
										<c:if test="${sessionScope.member.tel0 == LGU}">selected="selected"</c:if>>LGU</option>
							</select><select
								class="form-control input-group-addon cl_member_addr2 cl_member_addr2ad"
								id="tel0" name="tel0"
								style="height: 34px; background-color: white; display: inline-block; float: left; width: 50px;">
									<option value="SKT">SKT</option>
									<option value="KT">KT</option>
									<option value="LGU">LGU</option>
							</select> <input type="tel"
								class="form-control decorative-input cl_member_addr cl_member_addrad"
								id="tel1" name="tel1" maxlength="11"
								placeholder="'-' 없이 입력해주세요." onkeyup="telCheck()"
								style="height: 34px; width: 200px; background-position: right -145px;"
								value="${sessionScope.member.tel1}"><input type="tel"
								class="form-control decorative-input cl_member_addr2 cl_member_addr2ad"
								id="tel1" name="tel1" maxlength="11"
								placeholder="'-' 없이 입력해주세요." onkeyup="telCheck()"
								style="height: 34px; width: 200px; background-position: right -145px;"
								value=""></li>
						</ul>
						<hr class="divide_hr">
						<ul class="box_receiver_info list-inline">
							<li class="info_tit" style="vertical-align: top;">배송지 주소</li>
							<li><input type="text" id="post1"
								class="address form-control cl_member_addr" readonly="readonly"
								name="m_zipcode" size="10" style="width: 200px;"> <input
								type="button" onclick="openDaumPostcode()" value="우편번호 찾기"
								class="btn btn-default cl_member_addr" style=""> <br
								class="cl_member_addr"> <input type="text" id="addr"
								class="address form-control cl_member_addr cl_member_addrad"
								value="${fn:substring(member.address,0,fn:indexOf(member.address,'_-_'))}"
								readonly="readonly" name="a1" style="width: 250px;"> <c:set
									var="addd2"
									value="${fn:substring(member.address,fn:indexOf(member.address,'_-_')+3,fn:length(member.address)) }" /><br
								class="cl_member_addr"> <input type="text" id="addr2"
								class="address form-control cl_member_addr cl_member_addrad"
								name="a2" value="${addd2}" style="width: 300px;"> <input
								type="text" id="ppost1"
								class="address form-control cl_member_addr2" readonly="readonly"
								name="m_zipcode" size="10" style="width: 200px; display: none;">
								<input type="button" onclick="openDaumPostcode2()"
								value="우편번호 찾기" class="btn btn-default cl_member_addr2"
								style="display: none;"><br class="cl_member_addr2">
								<input type="text" id="aaddr"
								class="address form-control cl_member_addr2 cl_member_addr2ad"
								value="" readonly="readonly" name="aa1"
								style="display: none; width: 250px;"><br
								class="cl_member_addr2"> <input type="text" id="aaddr2"
								class="address form-control cl_member_addr2 cl_member_addr2ad"
								name="aa2" value="" style="display: none; width: 300px;">
								<br></li>
						</ul>
						<hr class="divide_hr">

					</div>
				</div>
				<div class="payment-info">
					<h3 class="product_tit">PAYMENT INFO / AGREEMENT</h3>
					<hr>
					<div class="clearfix">
						<ul class="box_receiver_info list-inline">
							<li class="info_tit">결제 방법</li>
							<li class="cell_discount_detail"><label class="box_choice">
									<input type="radio" id="credit-card" checked="checked"
									name="paymentType" onclick="payInfoShow('credit')"> 신용
									카드
							</label> <label class="box_choice"> <input type="radio"
									id="virtual-account" name="paymentType"
									onclick="payInfoShow('account');"> 가상계좌
							</label> <label class="box_choice"> <input type="radio"
									id="transfer-account" name="paymentType"
									onclick="payInfoShow('transfer');"> 계좌이체
							</label> <label class="box_choice"> <input type="radio"
									id="payco" name="paymentType" onclick="payInfoShow('payco');">
									페이코
							</label></li>
						</ul>
						<hr class="divide_hr">
						<ul id="buy_info" class="box_receiver_info list-inline"
							style="display: none;">
							<li class="info_tit" style="vertical-align: top;">결제 안내</li>
							<li style="width: 800px;">
								<!-- 라디오버튼 클릭시 나타나게해야함 -->
								<div id="credit_info" class="info_hidden">
									<p class="txt_tit_payment"
										style="font-size: 16px; font-weight: bold;">안전결제(ISP)?
										(국민카드/BC카드/우리카드)</p>
									<p class="txt_desc_payment"
										style="line-height: 18px; color: #ccc;">온라인 쇼핑시 주민등록번호,
										비밀번호 등의 주요 개인정보를 입력하지 않고 고객님이 사전에 미리 설정한 안전결제(ISP) 비밀번호만 입력,
										결제하도록 하여 개인정보 유출 및 카드 도용을 방지하는 서비스입니다.</p>
									<p class="txt_tit_payment follow"
										style="font-size: 16px; font-weight: bold;">안심 클릭 결제?
										(삼성/외환/롯데/현대/신한/시티/하나/NH/수협/전북/광주/산업은행/제주은행)</p>
									<p class="txt_desc_payment"
										style="line-height: 18px; color: #ccc;">온라인 쇼핑시 주민등록번호,
										비밀번호 등의 주요 개인 정보를 입력하지 않고 고객님이 사전에 미리 설정한 전자 상거래용 안심 클릭 비밀번호를
										입력하여 카드 사용자 본인 여부를 확인함으로써 온라인상에서의 카드 도용을 방지하는 서비스입니다.</p>
								</div>
								<div id="account_info" class="info_hidden">
									<p class="txt_tit_payment"
										style="font-size: 16px; font-weight: bold;">가상 계좌 안내</p>
									<p class="txt_desc_payment"
										style="line-height: 18px; color: #ccc;">무통장입금(가상 계좌)는 각
										주문별로 새로운 계좌번호가 생성되는 방식으로 해당계좌로 주문금액을 입금하시면 자동으로 입금확인처리됩니다. 단,
										자동으로 처리되기 때문에 주문금액과 정확히 동일한 금액을 입금하셔야만 입금이 가능합니다. 주문금액이
										87,950원일 경우 88,000원이나 90,000원을 입금하시면 입금되지 않습니다. 인터넷뱅킹, 텔레뱅킹,
										ATM/CD 기계, 은행 창구 등에서 입금하실 수 있습니다.</p>
								</div>
								<div id="transfer_info" class="info_hidden">
									<p class="txt_tit_payment"
										style="font-size: 16px; font-weight: bold;">계좌이체(에스크로) 안내</p>
									<p class="txt_desc_payment"
										style="line-height: 18px; color: #ccc;">계좌이체는 ATM이나 은행
										홈페이지에 접속하지 않고 무신사 홈페이지 내에서 즉시 결제, 출금되는 결제 방식입니다. 현재 약 20여 개의
										은행이 가능하며 현금영수증 발행은 결제 시 즉시 발급받으실 수 있습니다.</p>
								</div>
								<div id="payco_info" class="info_hidden">
									<p class="txt_tit_payment"
										style="font-size: 16px; font-weight: bold;">PAYCO 결제 안내</p>
									<p class="txt_desc_payment"
										style="line-height: 18px; color: #ccc;">PAYCO는 NHN엔터테인먼트가
										만든 안전한 간편결제 서비스입니다. 본인인증한 휴대폰과 카드 명의자가 동일해야 결제 가능하며, 결제금액 제한은
										없습니다.</p>
									<p class="txt_desc_payment"
										style="line-height: 18px; color: red;">- 지원카드 : 모든 국내
										신용/체크카드</p>
									<p class="txt_desc_payment"
										style="line-height: 18px; color: red;">- 이벤트 : 첫 구매 시(1만원
										이상) 3,500원 즉시할인쿠폰</p>
								</div>
							</li>
						</ul>
						<hr class="divide_hr">
						<ul class="box_receiver_info list-inline">
							<li class="info_tit" style="vertical-align: top;">주문자 동의</li>
							<li style="width: 800px;"><label> <input
									type="checkbox" name="all_agree" onclick="CheckAgree();">
									<span class="font_basic">전체 동의</span>
							</label>
								<p class="box_check_agree individual">
									<label> <input class="cl_pilsu_checkbox"
										type="checkbox" name="agree_third"> <span>개인정보
											제3자 제공 동의(필수)</span>
									</label>
								</p>
								<p class="box_summary_agree">
									배송 등 거래를 위해 판매자에게 개인정보가 공유됩니다. <a href="#"
										onclick="ToggleThirdAgree(); return false;"><span
										class="detail_close" id="thirdBtn">자세히</span></a>
								</p>
								<p class="box_detail_agree thirdAgreeDetail"
									id="thirdAgreeDetail" style="display: none;">
									무신사의 회원계정으로 상품 및 서비스를 구매하고자 할 경우, 무신사((주)그랩)는 거래 당사자간 원활한 의사소통
									및 배송, 상담 등 거래이행을 위하여 필요한 최소한의 개인정보만을 무신사 입점업체 판매자 및 배송업체에 아래와
									같이 공유하고 있습니다.<br> 1. 무신사((주)그랩)는 귀하께서 무신사 입점업체 판매자로부터 상품 및
									서비스를 구매하고자 할 경우, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 제 24조의 2(개인정보 공유동의
									등)에 따라 아래와 같은 사항은 안내하고 동의를 받아 귀하의 개인정보를 판매자에게 공유합니다. "개인정보 제3자
									공유 동의"를 체크하시면 개인정보 공유에 대해 동의한 것으로 간주합니다.<br> 2. 개인정보를
									공유받는자 : 입점업체 상호명(주문마다 변경)<br> 3. 공유하는 개인정보 항목 : 구매자 성명,
									전화번호, ID, 휴대폰 번호, 상품 구매정보, 상품 수취인 정보(성명, 주소, 전화번호)<br> 4.
									개인정보를 공유받는 자의 이용 목적 : 판매자와 구매자의 거래의 원활한 진행, 본인의사의 확인, 고객 상담 및
									불만처리, 상품과 경품 배송을 위한 배송지 확인 등<br> 5. 개인정보를 공유받는 자의 개인정보 보유
									및 이용 기간 : 개인정보 수집 및 이용 목적 달성 시까지 보관합니다.<br> 6. 동의 거부 시 불이익
									: 본 개인정보 공유에 동의하지 않으시는 경우, 동의를 거부할 수 있으며, 이 경우 거래가 제한됩니다.
								</p>
								<p class="box_check_agree condition">
									<label> <input class="cl_pilsu_checkbox"
										type="checkbox" name="agree_pay"> <span>위 상품 정보
											및 거래 조건을 확인하였으며, 구매 진행에 동의 합니다.(필수)</span>
									</label>
								</p></li>
						</ul>
					</div>
				</div>
				<div class="button-set" style="font-family: hanna;">
					<form action="${pageContext.request.contextPath}/buy/buyDirect"
						id="buy_form_aa" method="post">
						<input type="hidden" name="product_num"
							value="${list.productDTO.product_num}"><input
							type="hidden" name="total_price"
							value="${list.productInfoDTO.productInfo_price*productEach_each*(100-list.productInfoDTO.productInfo_saleRate)/100}">
						<input type="hidden" name="productSize_size"
							value="${productSize_size}"> <input type="hidden"
							name="productEach_color" value="${productEach_color}"> <input
							type="hidden" name="productEach_each" value="${productEach_each}"><input
							type="button" value="구매하기" id="btn_buy"
							class="btn btn-default center-block"> <input
							type="hidden" name="buyState_address" id="inh_buyStateAddr">
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer:S -->
	<%@ include file="/resources/temp/footer.jsp"%>
	<!-- Footer:E -->
</body>
</html>
