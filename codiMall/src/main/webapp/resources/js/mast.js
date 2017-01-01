/**
 * 
 */

/* subMenu 보기 */
/*		$("#goBoard").click(function(){
			$("#sub-board").toggle();
		});
		$("#goMember").click(function(){
			$("#sub-member").toggle();
		});
		$("#goProduct").click(function(){
			$("#sub-product").toggle();
		});		
		$("#goCodination").click(function(){
			$("#sub-codination").toggle();
		});*/

function gotoggle(data) {
	$("#sub-1").css("display", "none");
	$("#sub-2").css("display", "none");
	$("#sub-3").css("display", "none");
	$("#sub-4").css("display", "none");
	$("#sub-" + data).slideToggle();
}




/* subMenu active 변화 */
function aaa() {
	$(".sel_type").click(function() {
		$(this).parent().addClass("active");
	});
}

/*      function EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE     */
function mastBuyStart() {
	$(window).keydown(function() {
		if (47 < event.keyCode && event.keyCode < 55) {
			getBuyList(event.keyCode - 48);
			$("#sel_buy_state").val(event.keyCode - 48);
		}
	});


	var buyState_state = 1;
	getBuyList(buyState_state);
	$("#sel_buy_state").change(function() {
		buyState_state = $(this).val();
		getBuyList(buyState_state);
	});
}


function numcheck() {
	if ( (event.keyCode == 69) ) {
		event.returnValue = false;
	}
	;
}
;

function getBuyList(buyState_state) {
	$.ajax({
		url : "../json/mastBuyList",
		type : "post",
		dataType : 'json',
		data : {
			buyState_state : buyState_state
		},
		success : function(data) {
			var x = "";

			x = x + "<tr><th>구매번호</th><th>ID</th><th>상품번호</th><th>상품명</th><th>사이즈</th>";
			x = x + "<th>색상</th><th>구매수량</th><th>구매금액</th><th>송장번호</th><th>구매날짜</th><th>입금날짜</th>";
			x = x + "<th>배송상황</th>";
			if (buyState_state == 1) {
				x = x + "<th>배송번호변경(1->2)</th>"
			} else if (buyState_state == 2) {
				x = x + "<th>배송번호변경</th></tr>";
			} else if (buyState_state == 3) {
				x = x + "<th>구매확정 && 환불</th></tr>";
			} else if (buyState_state == 5) {
				x = x + "<th>환불 확정</th></tr>";
			}
			$.each(data.ar, function(index, value) {
				x = x + '<tr class="tr_buy_list">';
				x = x + '<td>' + value.buyDTO.buy_num + '</td>';
				x = x + '<td>' + value.buyDTO.member_id + '</td>';
				x = x + '<td class="buy_list_td_product_num">' + value.productDTO.product_num + '</td>';
				x = x + '<td class="buy_list_td_product_name">' + value.productDTO.product_name + '</td>';
				x = x + '<td class="buy_list_td_productSize_size">' + value.buyStateDTO.buyState_size + '</td>';
				x = x + '<td class="buy_list_td_productEach_color">' + value.buyStateDTO.buyState_color + '</td>';
				x = x + '<td class="buy_list_td_productEach_each">' + value.buyStateDTO.buyState_each + '</td>';
				x = x + '<td>' + value.buyStateDTO.buyState_price + '</td>';
				x = x + '<td>' + value.buyStateDTO.buyState_expressNum + '</td>';
				x = x + '<td>' + value.buyStateDTO.buyState_pay_date + '</td>';
				x = x + '<td>' + value.buyStateDTO.buyState_result_date + '</td>';
				x = x + '<td>' + value.buyStateDTO.buyState_state + '</td>';
				if (buyState_state == 1) {
					x = x + '<td>';
					x = x + '<input class="hid_buy_num" name="buy_num" type="hidden" value="' + value.buyDTO.buy_num + '">';
					x = x + '배송번호:<input onkeydown="numcheck()" class="inp_expressNum" type="number" name="buyState_expressNum"><Br>';
					x = x + '<input class="btn_add" type="button" value="ADD"></td>';
				} else if (buyState_state == 2) {
					x = x + '<td>';
					x = x + '<input class="hid_buy_num" name="buy_num" type="hidden" value="' + value.buyDTO.buy_num + '">';
					x = x + '배송번호:<input onkeydown="numcheck()" class="inp_expressNum" type="number" name="buyState_expressNum"><Br>';
					x = x + '<input class="btn_add" type="button" value="추가">';
					x = x + '<input class="btn_expressConfirm" type="button" value="발급"></td>';
				} else if (buyState_state == 3) {
					x = x + '<td>';
					x = x + '<input class="hid_buy_num" name="buy_num" type="hidden" value="' + value.buyDTO.buy_num + '">';
					x = x + '배송번호:<input onkeydown="numcheck()" class="inp_expressNum" type="number" name="buyState_expressNum"><Br>';
					x = x + '<input class="btn_refund" type="button" value="환불"><input class="btn_BuyConfirm" type="button" value="구매확정"></td>';
				} else if (buyState_state == 5) {
					x = x + '<td>';
					x = x + '<input class="hid_buy_num" name="buy_num" type="hidden" value="' + value.buyDTO.buy_num + '">';
					x = x + '<Br>';
					x = x + '<input class="btn_refund_confirm" type="button" value="환불완료"></td>';
				}
				x = x + '</tr>';
				var strAr = value.buyStateDTO.buyState_address.split('_-_');
				x=x+'<tr><td colspan=1 style="border-bottom : dotted 2px #dce2eb;">배송정보</td><td colspan=12 style="border-bottom : dotted 2px #dce2eb;">';
				$.each(strAr, function(index, value) {
				x=x+'<input class="cl_buy_addr_'+index+'" type="text" style="margin-top : 5px; margin-bottom : 5px;" readonly="readonly" value="'+value+'">';	
				});
				x=x+'</td></tr>';
			});
			$("#table_buy_list").html(x);

			$(".tr_buy_list").mouseenter(function() {
				var thisTr = $(this);
				if (buyState_state == 1 || buyState_state == 2) {
					$(thisTr).find(".btn_add").click(function() {
						if ($(thisTr).find(".inp_expressNum").val() != "") {
							var buy_num = $(thisTr).find(".hid_buy_num").val();
							var buyState_expressNum = $(thisTr).find(".inp_expressNum").val();
							alert(buy_num);
							alert(buyState_state);
							alert(buyState_expressNum);
							mastUpState(buy_num, buyState_state, buyState_expressNum,0,"","",0);
						} else {
							alert("송장번호를 입력해주세요");
						}
					});
					$(thisTr).find(".btn_expressConfirm").click(function() {
						var buy_num = $(thisTr).find(".hid_buy_num").val();
						mastUpState(buy_num, buyState_state, 0,0,"","",0);
					});
				} else if (buyState_state == 3) {
					$(thisTr).find(".btn_refund").click(function() {
						refund(buyState_state, thisTr);
					});
				} else if (buyState_state == 5) {
					$(thisTr).find(".btn_refund_confirm").click(function() {
						refundConf(buyState_state, thisTr);
					});
				}


			});
			$(".tr_buy_list").on('mouseleave', function() {
				var thisTr = $(this);
				$(thisTr).find(".btn_add").off("click");
				$(thisTr).find(".btn_expressConfirm").off("click");
				$(thisTr).find(".btn_refund").off("click");
				$(thisTr).find(".btn_refund_confirm").off("click");
			});
			$(".inp_expressNum").on('focus', function() {
				$(window).off('keydown');
			});
			$(".inp_expressNum").on('blur', function() {
				$(window).keydown(function() {
					if (47 < event.keyCode && event.keyCode < 55) {
						getBuyList(event.keyCode - 48);
						$("#sel_buy_state").val(event.keyCode - 48);
					}
				});
			});

		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "error:" + error);
		}
	});

}

function refund(buyState_state, thisTr) {
	if ($(thisTr).find(".inp_expressNum").val() != "" || $(thisTr).find(".inp_expressNum").val() != 0) {
		var buy_num = $(thisTr).find(".hid_buy_num").val();
		var buyState_expressNum = $(thisTr).find(".inp_expressNum").val();
		alert(buy_num);
		alert(buyState_expressNum);
		mastUpState(buy_num, buyState_state, buyState_expressNum,0,"","",0);
	} else {
		alert("송장번호를 입력해주세요");
	}
}
function refundConf(buyState_state,thisTr) {
	var buy_num = $(thisTr).find(".hid_buy_num").val();
	var product_num = $.trim($(thisTr).find(".buy_list_td_product_num").text());
	var productSize_size = $.trim($(thisTr).find(".buy_list_td_productSize_size").text()); 
	var productEach_color = $.trim($(thisTr).find(".buy_list_td_productEach_color").text()); 
	var productEach_each = $.trim($(thisTr).find(".buy_list_td_productEach_each").text());
	mastUpState(buy_num, buyState_state, 0,product_num,productSize_size,productEach_color,productEach_each);
}


function mastUpState(buy_num, buyState_state, buyState_expressNum,product_num,productSize_size,productEach_color,productEach_each) {
	$.ajax({
		url : "../json/mastUpState",
		type : "post",
		data : {
			buyState_state : buyState_state,
			buy_num : buy_num,
			buyState_expressNum : buyState_expressNum
		},
		success : function(data) {
			alert(data);
			var a = 1;
			if (data > 0) {
				alert("success");
				if(buyState_state==5){
					alert(product_num);
					alert(productSize_size);
					alert(productEach_color);
					alert(productEach_each);
					
					refundConfEachAdd(product_num,productSize_size,productEach_color,productEach_each);
				}
				
				if (buyState_state == 2 && buyState_expressNum != 0) {
					a--;
				} else if (buyState_state == 3 && buyState_expressNum != 0) {
					a++;
				}
				$("#sel_buy_state").val(buyState_state * 1 + a);
				getBuyList(buyState_state * 1 + a);
			} else {
				alert("fail");
				getBuyList(buyState_state * 1 + 1);
				$("#sel_buy_state").val(buyState_state * 1);
			}
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "error:" + error);
		}
	});
}

function refundConfEachAdd(product_num,productSize_size,productEach_color,productEach_each){
	$.ajax({
		url : "../json/mastRefundEachAdd",
		type : "post",
		data : {
			product_num:product_num,
			productSize_size:productSize_size,
			productEach_color:productEach_color,
			productEach_each:productEach_each
		},
		success : function(data) {
			alert(data);
			var a = 1;
			if (data > 0) {
				alert("갯수수정success");
			} else {
				alert("갯수수정fail");
			}
		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "error:" + error);
		}
	});
}
function mastProductAddClick() {
	$("#div_modin_main").html("");
	$.ajax({
		url : "../json/allKindNum",
		type : "post",
		dataType : 'json',
		data : {
		},
		success : function(data) {
			var zz = "";
			zz = zz + '<select id="sel_kind_proadd" class="form-control">';
			$.each(data.kindNumList, function(index, value) {
				zz = zz + '<option value="' + value.kind_num + '">' + value.kind_num + "--" + value.kind_name + '</option>'
			});
			zz = zz + '</select>';
			var x = "";
			x = x + '<table id="tab_proadd_sa" class="table"><tr><td colspan=2><label>상품등록</label></td></tr>';
			x = x + '<tr><td>상품명</td><td><input id="inp_productAdd_name" class="form-control" type="text"></td></tr>';
			x = x + '<tr><td>상품종류</td><td>' + zz + '</td></tr>';
			x = x + '<tr><td>상품가격</td><td><input id="inp_productAdd_price" class="form-control" type="number" min=0 step=1></td></tr>';
			x = x + '<tr><td>할인율</td><td><input id="inp_productAdd_saleRate" class="form-control" type="number" min=0 step=0.1></td></tr>';
			x = x + '<tr><td>키워드</td><td><input id="inp_productAdd_searchWord" class="form-control" type="text"></td></tr>';
			x = x + '<tr><td>브랜드</td><td><input id="inp_productAdd_brand" class="form-control" type="text"></td></tr>';
			x = x + '<tr><td>';
			x = x + '<form id="hid_form_proadd" action="${pageContext.request.contextPath}/mast/mastProductAdd"';
			x = x + 'method="post" enctype="multipart/form-data">';
			x = x + '<input type="hidden" id="inph_productAdd_product_name" name="product_name">';
			x = x + '<input type="hidden" id="inph_productAdd_kind_num" name="kind_num">';
			x = x + '<input type="hidden" id="inph_productAdd_price" name="productInfo_price">';
			x = x + '<input type="hidden" id="inph_productAdd_saleRate" name="productInfo_saleRate">';
			x = x + '<input type="hidden" id="inph_productAdd_searchWord" name="productInfo_searchWord">';
			x = x + '<input type="hidden" id="inph_productAdd_brand" name="productInfo_brand">';
			x = x + '<input type="file" id="inph_productAdd_pic" class="form-control" name="productPic_pic">';
			x = x + '</form>';
			x=x+'</td></tr>';
			x = x + '<tr><td colspan=2><button id="btn_productAdd_ss" class="btn btn-info btn-lg">등록하기</button></td></tr>'
			x = x + '</table>';
			
			$("#div_modin_main").html(x);
			$("#inp_productAdd_saleRate").focus(function(){
				$(this).change(function(){
					if($(this).val()>90){
						alert("90보다 크게 입력할수없습니다.")
						$(this).val(90);
					}
				})
				$(this).keydown(function(){
					if($(this).val()>90){
						alert("90보다 크게 입력할수없습니다.")
						$(this).val(90);
					}
				})
				$(this).keyup(function(){
					if($(this).val()>90){
						alert("90보다 크게 입력할수없습니다.")
						$(this).val(90);
					}
				})
				$(this).blur(function(){
					if($(this).val()>90){
						alert("90보다 크게 입력할수없습니다.")
						$(this).val(90);
					}
				})
			});
			$("#btn_productAdd_ss").click(function() {
				var count = 0;
				var product_name = $("#inp_productAdd_name").val();
				var kind_num = $("#sel_kind_proadd").val();
				var productInfo_price = $("#inp_productAdd_price").val();
				var productInfo_saleRate = $("#inp_productAdd_saleRate").val();
				var productInfo_searchWord = $("#inp_productAdd_searchWord").val();
				var productInfo_brand = $("#inp_productAdd_brand").val();
				var productPic_pic = $("#inph_productAdd_pic").val();
				if (product_name == "") {
					count++;
				}
				if (kind_num == "") {
					count++;
				}
				if (productInfo_price == "") {
					count++;
				}
				if (productInfo_saleRate == "" || productInfo_saleRate < 0) {
					count++;
				}
				if (productInfo_searchWord == "") {
					count++;
				}
				if (productInfo_brand == "") {
					count++;
				}
				if (productPic_pic == "") {
					count++;
				}
				if(count > 0){
					alert("빈값을 모두 입력해 주세요")
				}else{
					$("#inph_productAdd_product_name").val(product_name);
					$("#inph_productAdd_kind_num").val(kind_num);
					$("#inph_productAdd_price").val(productInfo_price);
					$("#inph_productAdd_saleRate").val(productInfo_saleRate);
					$("#inph_productAdd_searchWord").val(productInfo_searchWord);
					$("#inph_productAdd_brand").val(productInfo_brand);
					$("#hid_form_proadd").submit();
				}

			});



		},
		error : function(request, status, error) {
			alert("code:" + request.status + "\n" + "error:" + error);
		}
	});
}