<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="http://fonts.googleapis.com/earlyaccess/hanna.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/mast/mast.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/font-awesome/css/font-awesome.min.css">
<script src="${pageContext.request.contextPath}/resources/js/mast.js"></script>
<script type="text/javascript">

	$(function() {
		alert("${list.size()}");
		$("#1").parent("li").addClass("active");
		mastProductListSt();
		selBox();
		allCheckBoxes();
		pageing();
		$(".cl_proadd_action").click(function() {
			mastProductAddClick();
		});
		$(".cl_kindadd_action").click(function() {
			mastKindAddClick();
		});
	});
	function mastKindAddClick() {
		$("#div_modin_main").html("");
		$.ajax({
			url : "../json/allKindNum",
			type : "post",
			dataType : 'json',
			success : function(data) {
				var x = "";
				x=x+'<table id="id_tab_kind_list" class="table" style="display:inline-block;"><tr><th>KIND_NUM</th><th>KIND_NAME</th></tr>'
				$.each(data.kindNumList, function(index, value) {
					x = x + '<tr><td>' + value.kind_num + '</td><td>'+value.kind_name + '</td></tr>'
				});
				$.ajax({
					url : "../json/mastAllProductSelectGet",
					type : "post",
					dataType : 'json',
					success : function(data) {
						x=x+'</table><form id="id_form_kind_add"  action="${pageContext.request.contextPath}/mast/mastKindAdd" method="post"';
						x=x+'style="display:inline-block;">';
						x=x+'PRODUCTSELECT<select name="productSelect_num">'
						$.each(data, function(index, value) {
							x=x+'<option value="'+value.productSelect_num+'">'+value.productSelect_name+'</option>';
						});
						x=x+'</select>'
						x=x+'KIND_NAME<input name="kind_name" id="inp_kind_name_aa" style="width:100px;">';
						x=x+'<input id="btn_kindAdd_submit" type="button" value="ADD"></form>'
						$("#div_modin_main").html(x);

						$("#btn_kindAdd_submit").click(function(){
							if($("#inp_kind_name_aa").val()==""){
								alert("비어있습니다");
							}else{
								$("#id_form_kind_add").submit();
							}
							
						})
					},
					error : function(request, status, error) {
						alert("code:" + request.status + "\n" + "error:" + error);
					}
				});
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
				x = x + '<tr><td colspan=2><button id="btn_productAdd_ss">PRODUCTADD</button></td></tr>'
				x=x+'</td></tr>';
				x = x + '<tr><td colspan=2><button id="btn_productAdd_ss" class="btn btn-info btn-lg">등록하기</button></td></tr>'
				x = x + '</table>';

				$("#div_modin_main").html(x);
				$("#inp_productAdd_saleRate").focus(function() {
					$(this).change(function() {
						if ($(this).val() > 90) {
							alert("90보다 크게 입력할수없습니다.")
							$(this).val(90);
						}
					})
					$(this).keydown(function() {
						if ($(this).val() > 90) {
							alert("90보다 크게 입력할수없습니다.")
							$(this).val(90);
						}
					})
					$(this).keyup(function() {
						if ($(this).val() > 90) {
							alert("90보다 크게 입력할수없습니다.")
							$(this).val(90);
						}
					})
					$(this).blur(function() {
						if ($(this).val() > 90) {
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
					if (count > 0) {
						alert("빈값을 모두 입력해 주세요")
					} else {
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


	function mastProductListSt() {
		$(".div_cl_img_asd").on('click', function() {
			var product_num = $(this).find(".inh_product_num").val();
			ajaxfirst(product_num);
		});
	}
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	function mastProductPicFix() {
		$("#btn_pic_fix").click(function() {
			if ($("#in_file_pic").val() != "") {
				var ext = $('#in_file_pic').val().split('.').pop().toLowerCase();
				if ($.inArray(ext, [ 'gif', 'png', 'jpg', 'jpeg' ]) == -1) {
					alert('gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
				} else {
					$("#form_id_picFix").submit();
				}
			} else {
				alert("사진을 선택해 주세요");
			}

		});
	}

	function ajaxfirst(product_num) {
		$.ajax({
			url : "../json/mastProductAllInfo",
			type : "post",
			dataType : 'json',
			data : {
				product_num : product_num,
			},
			success : function(data) {
				$("#div_modin_main").html("");
				var x = "";
				x = x + '<table id="tab_modin"><tr>';
				x = x + '<td class="modin_td"><div class="modin_div"><img src="${pageContext.request.contextPath}/resources/testPic/' + data.ar.productPic_pic + '"></div>';
				x = x + '<div><label style="width:120px;text-align: center;">사진변경</label><BR>';
				x = x + '<form id="form_id_picFix" action="${pageContext.request.contextPath}/mast/mastProductPicFix" method="post" enctype="multipart/form-data">';
				x = x + '<input type="hidden" name="product_num" value="' + product_num + '">';
				x = x + '<input id="in_file_pic" type="file" name="productPic_pic"><input id="btn_pic_fix" type="button" value="변경하기"></div></td>';
				x = x + '</td><td class="modin_td"><div class="modin_div"><table id="tabin_tab_12"><tr>';
				x = x + '<td>productSelect_num</td><td>' + data.ar.productSelect_num + '</td>';
				x = x + '</tr><tr><td>productSelect_name</td><td>' + data.ar.productSelect_name + '</td>';
				x = x + '</tr><tr><td>kind_num</td><td>' + data.ar.kind_num + '</td></tr>';
				x = x + '<tr><td>kind_name</td><td>' + data.ar.kind_name + '</td></tr>';
				x = x + '</tr><tr><td>product_name</td><td>' + data.ar.product_name + '</td>';
				x = x + '</tr><tr><td>product_num</td><td>' + data.ar.product_num + '</td></tr>';
				x = x + '</table><div><div id="div_tab_size_List"></div></td></tr>';
				x = x + '<tr><td class="modin_td"><div class="modin_div"><table id="tabin_tab_11">';
				x = x + '<tr><td>PRICE</td><td>' + numberWithCommas(data.ar.productInfo_price) + '원</td></tr>';
				x = x + '<tr><td>REG_DATE</td><td>' + data.ar.productInfo_reg_date + '</td></tr>';
				x = x + '<tr><td>REC_DATE</td><td>' + data.ar.productInfo_rec_date + '</td></tr>';
				x = x + '<tr><td>SALERATE</td><td>' + data.ar.productInfo_saleRate + '</td></tr>';
				x = x + '<tr><td>TOTALPRICE</td><td>' + numberWithCommas(data.ar.productInfo_price * 1 * ((100 * 1) - (data.ar.productInfo_saleRate) * 1) / 100) + '원</td></tr>';

				x = x + '<tr><td>SEARCHWORD</td><td>' + data.ar.productInfo_searchWord + '</td></tr>';
				x = x + '<tr><td>BRAND</td><td>' + data.ar.productInfo_brand + '</td></tr>';
				x = x + '</table><div class="div_fix_pro_info">수정할가격<input class="inp_cl_price" type="number" name="productInfo_price" min="0"><br>';
				x = x + '수정할할인율<input class="inp_cl_saleRate" type="number" name="productInfo_saleRate" step="0.1" min="0"><br>';
				x = x + '수정할검색단어<input class="inp_cl_searchWord" type="text" name="productInfo_searchWord"><br>';
				x = x + '<button class="btn_submit_bt">수 정 하 기</button>';
				x = x + '<input type="hidden" class="inph_cl_pro_num" name="product_num" value="' + data.ar.product_num + '">' + '</div></td>';
				x = x + '<td class="modin_td"><div class="modin_div"><table id="tabin_tab_22">';
				x = x + '<tr><th>SIZE</th><th>COLOR</th><th>EACH</th><th>EACHFIX</th></tr>'
				$.each(data.ar.productEachDTOs, function(index, value) {

					x = x + '<tr class="tr_each_fix"><td>' + value.productSize_size + '</td><td>' + value.productEach_color + '</td>';
					x = x + '<td><label>&nbsp </label>' + value.productEach_each + '&nbsp </td>'
					x = x + '<td>';
					x = x + '<input type="hidden" class="inph_cl_pro_num" name="product_num" value="' + data.ar.product_num + '">';
					x = x + '<input type="hidden" class="inph_cl_pro_size" name="productSize_size" value="' + value.productSize_size + '">';
					x = x + '<input type="hidden" class="inph_cl_pro_color" name="productEach_color" value="' + value.productEach_color + '">';
					x = x + '<input style="width:40px;" type="number" class="inp_cl_each" name="productEach_each>">';
					x = x + '<input type="button" class="each_fix_button_submit" value="수정"></td></tr>'
				});

				x = x + '</table><div></td></tr></table>'
				$("#div_modin_main").html(x);
				mastProductEachFix();
				mastProductInfoFix();
				mastProductViewSizeList(product_num);
				mastProductPicFix();
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});

	}

	function mastProductInfoFix() {
		$(".div_fix_pro_info").on('mouseenter', function() {
			var tis_div = $(this);
			$(this).find(".btn_submit_bt").on('click', function() {
				var product_num = $(tis_div).find(".inph_cl_pro_num").val();
				var productInfo_price = $(tis_div).find(".inp_cl_price").val();
				var productInfo_saleRate = $(tis_div).find(".inp_cl_saleRate").val();
				var productInfo_searchWord = $(tis_div).find(".inp_cl_searchWord").val();
				if (productInfo_price != "" && productInfo_saleRate != "" && productInfo_searchWord != "") {
					$.ajax({
						url : "../json/mastProductInfoFix",
						type : "post",
						data : {
							product_num : product_num,
							productInfo_price : productInfo_price,
							productInfo_saleRate : productInfo_saleRate,
							productInfo_searchWord : productInfo_searchWord
						},
						success : function(data) {
							if (data == 1) {
								alert("수정성공");
							} else {
								alert("수정실패");
							}
							ajaxfirst(product_num);
						},
						error : function(request, status, error) {
							alert("code:" + request.status + "\n" + "error:" + error);
						}
					});
				} else {
					alert("값을 모두 입력해 주세요");
				}
			});
		});
		$(".div_fix_pro_info").on('mouseleave', function() {
			$(this).find(".btn_submit_bt").off('click');
		});
	}

	function mastProductViewSizeList(product_num) {
		$.ajax({
			url : "../json/mastProductViewSizeList",
			type : "post",
			data : {
				product_num : product_num,
			},
			success : function(data) {
				$("#div_tab_size_List").html("");
				var x = '<table id="tab_size_Listss">';
				$.each(data.ar, function(index, value) {
					x = x + '<tr><td>' + value.productSize_size;
					x = x + '<input class="inh_cl_prosize_sizess" type="hidden" value="' + value.productSize_size + '">' + '</td></tr>';
				});
				x = x + '</table>';
				var y = '<label style="width:120px;text-align: center;">SIZE 추가</label><BR>';
				y = y + 'Size<input id="in_prosize_ss" type="text" name="productSize_size" style="width:60px;">';
				y = y + '<input type="hidden" name="product_num" value="' + product_num + '">';
				y = y + '<input type="button" value="ADD" id="btn_form_submit_add"><br><br>';

				var z = "";
				z = z + '<table><tr><th colspan="3" style="text-align: center;">COLOR 추가</th></tr></tr>'
				z = z + '<td><select id="sel_Size_sd" name="productSize_size">';
				$.each(data.ar, function(index, value) {
					z = z + '<option value="' + value.productSize_size + '">' + value.productSize_size + '</option>';
				});
				z = z + '</select></td><td>COLOR<br><input id="in_proEach_color_ss" type="text" name="productEach_color"style="width:70px;"></td>'
				z = z + '<td>EACH<br><input min=0 type="number" value="" id="in_pro_each_each" name="productEach_each" style="width:40px;"></td></tr><tr><td colspan=3>';
				z = z + '<input type="button" value="ADD" id="btn_each_submit_add" style="width:160px;"></td></tr></table>'


				$("#div_tab_size_List").html(x + y + z);
				$("#btn_form_submit_add").on('click', function() {
					var productSize_size = $("#in_prosize_ss").val();
					if (productSize_size != "") {
						if (productSize_size.length > 6) {
							alert("6자리 이하로 입력해주세요");
						} else {
							mastProductSizeAdd(product_num, productSize_size);
						}
					} else {
						alert("제대로 입력해주세요");
					}
				});
				$("#btn_each_submit_add").on('click', function() {
					var productSize_size = $("#sel_Size_sd").val();
					var productEach_color = $("#in_proEach_color_ss").val();
					var productEach_each = $("#in_pro_each_each").val();
					if (productEach_color != "") {
						if (productEach_each == "") {
							alert("수량을 올바르게 입력해주세요")
						} else {
							mastProductEachAdd(product_num, productSize_size, productEach_color, productEach_each);
						}
					} else {
						alert("COLOR를 입력해주세요")
					}
				});

			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});

	}


	function mastProductSizeAdd(product_num, productSize_size) {
		$.ajax({
			url : "../json/mastProductSizeAdd",
			type : "post",
			data : {
				product_num : product_num,
				productSize_size : productSize_size
			},
			success : function(data) {
				if (data == 1) {
					alert("Size 등록성공");
				} else {
					alert("Size 등록실패");
				}
				ajaxfirst(product_num);
			},
			error : function(request, status, error) {
				alert("이미 있는 SIZE 입니다");
			}
		});
	}

	function mastProductEachAdd(product_num, productSize_size, productEach_color, productEach_each) {
		alert(product_num);
		alert(productSize_size)
		alert(productEach_color)
		alert(productEach_each)
		$.ajax({
			url : "../json/mastProductEachAddaa",
			type : "post",
			data : {
				product_num : product_num,
				productSize_size : productSize_size,
				productEach_color : productEach_color,
				productEach_each : productEach_each
			},
			success : function(data) {
				if (data > 0) {
					alert("Color 등록 성공");
				} else {
					alert("Color 등록 실패");
				}
				ajaxfirst(product_num);
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "error:" + error);
			}
		});
	}


	function mastProductEachFix() {
		$(".tr_each_fix").on('mouseenter', function() {
			var tis_tr = $(this);

			$(this).find(".each_fix_button_submit").on('click', function() {
				var product_num = $(tis_tr).find(".inph_cl_pro_num").val();
				var productSize_size = $(tis_tr).find(".inph_cl_pro_size").val();
				var productEach_color = $(tis_tr).find(".inph_cl_pro_color").val();
				var productEach_each = $(tis_tr).find(".inp_cl_each").val();

				if (productEach_each != "") {
					$.ajax({
						url : "../json/mastProductEachFix",
						type : "post",
						data : {
							product_num : product_num,
							productSize_size : productSize_size,
							productEach_color : productEach_color,
							productEach_each : productEach_each
						},
						success : function(data) {
							if (data == 1) {
								alert("수정성공");
							} else {
								alert("수정실패");
							}
							ajaxfirst(product_num);

						},
						error : function(request, status, error) {
							alert("code:" + request.status + "\n" + "error:" + error);
						}
					});

				} else {
					alert("수량을 입력해주세요");
				}
			});
		});
		$(".tr_each_fix").on('mouseleave', function() {
			$(this).find(".each_fix_button_submit").off('click');
		});
	}
	$(".cl1").on('change', function() {
		$(".div1").html("");
		for (var i = 0; i < $(".cl1").length; i++) {
			if ($(".cl1").eq(i).is(":checked")) {
				$(".div1").append('<input type="text" name="cl1" value="' + $(".cl1").eq(i).val() + '">')
			}
		}
	});
	function divhiddenForm() {
		$("#div_hid_sel").html('');
		$("#div_hid_mtpsel").html('');
		$("#div_hid_prosel").html('');
		$("#div_hid_kind").html('');
		$("#div_hid_pro").html('');
		$("#div_hid_size").html('');
		$("#div_hid_color").html('');
		$("#div_hid_sel").append('<input type="hidden" name="sel" value="' + $("input:radio[name='sel']:checked").val() + '">');
		$("#div_hid_mtpsel").append('<input type="hidden" name="mtpSel" value="' + $("input:radio[name='mtpSel']:checked").val() + '">');
		for (var i = 0; i < $("input:checkbox[name='productSelect_num']:checked").length; i++) {
			$("#div_hid_prosel").append('<input type="hidden" name="productSelect_num" value="' + $("input:checkbox[name='productSelect_num']:checked").eq(i).val() + '">');
		}
		for (var i = 0; i < $("input:checkbox[name='kind_num']:checked").length; i++) {
			$("#div_hid_kind").append('<input type="hidden" name="kind_num" value="' + $("input:checkbox[name='kind_num']:checked").eq(i).val() + '">');
		}
		for (var i = 0; i < $("input:checkbox[name='product_num']:checked").length; i++) {
			$("#div_hid_pro").append('<input type="hidden" name="product_num" value="' + $("input:checkbox[name='product_num']:checked").eq(i).val() + '">');
		}
		for (var i = 0; i < $("input:checkbox[name='productSize_size']:checked").length; i++) {
			$("#div_hid_size").append('<input type="hidden" name="productSize_size" value="' + $("input:checkbox[name='productSize_size']:checked").eq(i).val() + '">');
		}
		for (var i = 0; i < $("input:checkbox[name='productEach_color']:checked").length; i++) {
			$("#div_hid_color").append('<input type="hidden" name="productEach_color" value="' + $("input:checkbox[name='productEach_color']:checked").eq(i).val() + '">');
		}
		$("#form_hidden_asd").submit();
	}
	function pageing() {
		$(".n_pageing").on('click', function() {
			$("input:hidden[name='curPage']").val($(this).text());
			divhiddenForm();
		})
		$(".a_prev").on('click', function() {
			$("input:hidden[name='curPage']").val($(this).find(".inh_prev").val());
			divhiddenForm();
		})
		$(".a_next").on('click', function() {
			$("input:hidden[name='curPage']").val($(this).find(".inh_next").val());
			divhiddenForm();
		})
	}
	function selBox() {
		$(".p_param").on('change', function() {
			divhiddenForm();
		});
	}
	function allCheckBoxes() {
		$("#inp_id_ck_prosel").on('change', function() {
			if ($(this).is(':checked')) {
				$("input:checkbox[name='productSelect_num']").prop("checked", true);
			} else {
				$("input:checkbox[name='productSelect_num']").prop("checked", false);
			}
			divhiddenForm();
		});
		$("#inp_id_ck_kind").on('change', function() {
			if ($(this).is(':checked')) {
				$("input:checkbox[name='kind_num']").prop("checked", true);
			} else {
				$("input:checkbox[name='kind_num']").prop("checked", false);
			}
			divhiddenForm();
		});
		$("#inp_id_ck_pro").on('change', function() {
			if ($(this).is(':checked')) {
				$("input:checkbox[name='product_num']").prop("checked", true);
			} else {
				$("input:checkbox[name='product_num']").prop("checked", false);
			}
			divhiddenForm();
		});
		$("#inp_id_ck_size").on('change', function() {
			if ($(this).is(':checked')) {
				$("input:checkbox[name='productSize_size']").prop("checked", true);
			} else {
				$("input:checkbox[name='productSize_size']").prop("checked", false);
			}
			divhiddenForm();
		});
		$("#inp_id_ck_color").on('change', function() {
			if ($(this).is(':checked')) {
				$("input:checkbox[name='productEach_color']").prop("checked", true);
			} else {
				$("input:checkbox[name='productEach_color']").prop("checked", false);
			}
			divhiddenForm();
		});
	}


	jQuery.ajaxSettings.traditional = true;
</script>
<style type="text/css">
table, table tr, tr td, th {
	border: 2px solid #dce2eb;
}

th {
	text-align: center;
}

#tab_modin {
	
}

.modin_div {
	width: 240px;
	height: 340px;
	overflow-y: scroll;
}

.modin_div>img {
	width: 230px;
	height: 230px;
}

input[type="checkbox"], input[type="radio"] {
	width: 15px;
	height: 15px;
}

.labelccc {
	text-align: center;
	font-weight: bold;
}

#div_product_list {
	width: 100%;
	/* 	height: 1000px;
	border: 2px solid #dce2eb; */
}

.div_list_in_list {
	margin-left: 30px;
	margin-top: 30px;
	padding: 2px;
	width: 360px;
	height: 230px;
	border: 2px solid #dce2eb;
	text-align: center;
	float: left;
}

.tab_mast_productList {
	float: right;
	width: 160px;
}
.cl_pro_pic{
	width: 175px;
	height: 175px;
}
</style>
</head>
<body style="height: 1800px; font-family: 'hanna';">
	<div class="container-fluid" style="padding: 0; height: 100%">
		<div class="row" style="height: 100%;">
			<div class="col-sm-2" style="height: 100%;">
				<%@ include file="/resources/temp/mast/sideBar.jspf"%>
			</div>

			<div class="col-sm-8" style="margin: 20px; height: 100%;">
				<div class="container-fluid">
					<div id="view">
						<header id="topbar" class="text-center bg-white alt ph10 br-b-ddd">
							<nav class="navbar">
								<div class="navbar-collapse collapse"
									style="padding-left: 0; border-bottom: 1px solid #eee;">
									<ul id="category-type" class="nav navbar-nav"
										style="vertical-align: top;">
										<li class="category-li"><a id="1" class="sel_type"
											href="${pageContext.request.contextPath}/mast/mastProductList">상품리스트</a></li>
										<li class="category-li"><a id="2" class="sel_type"
											href="${pageContext.request.contextPath}/mast/mastProductListEach0">매진상품재고충전</a></li>
										<li class="category-li"><a id="3" class="sel_type cl_proadd_action"
											style="cursor: pointer;" data-toggle="modal"
											data-target="#basketModal" data-backdrop="true">상품추가</a></li>
											<li class="category-li"><a id="4"
											class="sel_type cl_kindadd_action" style="cursor: pointer;"
											data-toggle="modal" data-target="#basketModal"
											data-backdrop="true">품목추가</a></li>
									</ul>
								</div>
							</nav>
						</header>
						<section id="section" class="jumbotron">
							<div style="display: inline-block;">
								<form id="form_hidden_asd"
									action="${pageContext.request.contextPath}/mast/mastProductList"
									method="post">
									<div id="div_hid_sel"></div>
									<div id="div_hid_mtpsel"></div>
									<div id="div_hid_prosel"></div>
									<div id="div_hid_kind"></div>
									<div id="div_hid_pro"></div>
									<div id="div_hid_size"></div>
									<div id="div_hid_color"></div>
									<div id="div_hid_curPage">
										<input type="hidden" name="curPage" value="${pageing.curPage}">
									</div>
									<div id="div_hid_perPage"></div>
								</form>
							</div>
							<!-- HIDDEN VALUE FORM : E -->

							<div class="panel" style="background: #fff; margin-bottom: 30px;">
								<div class="panel-heading">
									<a id="subList" class="subBtn btn btn-default btn-lg"> <span
										class="fa fa-list"></span> 상품리스트
									</a>
									<%@ include file="/resources/temp/mast/productSelBox.jspf"%>
								</div>
								<div class="panel-body" style="background-color: white;">
									<div id="div_product_list">
										<c:forEach var="list1" items="${list}">
											<div class="div_list_in_list">
												<div class="div_cl_img_asd"
													style="display: inline-block; cursor: pointer; float: left;">
													<input class="inh_product_num" type="hidden"
														name="product_num" value="${list1.productDTO.product_num}">
													<img width="175" height="175"
														<c:if test="${!empty sessionScope.member}">
														data-toggle="modal" data-target="#basketModal"
														data-backdrop="true"
													</c:if>
														src="${pageContext.request.contextPath}/resources/testPic/${list1.productPicDTO.productPic_pic}">
												</div>
												<table class="tab_mast_productList">
													<tr>
														<td>판매수</td>
														<td>${list1.selCount}</td>
													</tr>
													<tr>
														<td>pS.num</td>
														<td>${list1.productSelectDTO.productSelect_num}</td>
													</tr>
													<tr>
														<td>pS.name</td>
														<td>${list1.productSelectDTO.productSelect_name}</td>
													</tr>
													<tr>
														<td>k.num</td>
														<td>${list1.kindDTO.kind_num}</td>
													</tr>
													<tr>
														<td>k.name</td>
														<td>${list1.kindDTO.kind_name}</td>
													</tr>
													<tr>
														<td>p.num</td>
														<td>${list1.productDTO.product_num}</td>
													</tr>
													<tr>
														<td>p.name</td>
														<td>${list1.productDTO.product_name}</td>
													</tr>
													<tr>
														<td>price</td>
														<td><fmt:formatNumber
																value="${list1.productInfoDTO.productInfo_price}"
																pattern="#,###" />원</td>
													</tr>
													<tr>
														<td>sale</td>
														<td>${list1.productInfoDTO.productInfo_saleRate}</td>
													</tr>
													<tr>
														<td>totalPrice</td>
														<td><c:set var="number"
																value="${list1.productInfoDTO.productInfo_price*(100-list1.productInfoDTO.productInfo_saleRate)/100}" />
															<fmt:parseNumber var="total" value="${number}"
																type="number" integerOnly="true" /> <fmt:formatNumber
																value="${total}" pattern="#,###" />원</td>
													</tr>
												</table>
											</div>
										</c:forEach>
									</div>
								</div>
								<div class="panel-footer" style="background-color: white;">
									<!-- PAGINATION : S -->
									<div class="center-block" style="width: 200px;">
										<nav aria-label="Page navigation">
											<ul class="pagination">
												<c:if test="${!empty list}">
													<li><c:if test="${pageing.curBlock>1}">
															<a class="a_prev pageMove" aria-label="Previous"
																style="cursor: pointer"><input class="inh_prev"
																type="hidden" value="${pageing.startNum-1}"> <span
																aria-hidden="true">&laquo;</span> </a>
														</c:if></li>
													<li><c:forEach begin="${pageing.startNum}" step="1"
															end="${pageing.lastNum}" var="i">

															<a style="cursor: pointer" class="n_pageing">${i}</a>
														</c:forEach></li>
													<li><c:if
															test="${pageing.curBlock<pageing.totalBlock}">
															<a class="a_next" aria-label="Next"
																style="cursor: pointer"> <input class="inh_next"
																type="hidden" value="${pageing.lastNum+1}"><span
																aria-hidden="true">&raquo;</span>
															</a>
														</c:if></li>
												</c:if>
											</ul>
										</nav>
									</div>
									<!-- PAGENATION : E -->
								</div>
							</div>


						</section>


						<!--      -->
						<!--     임시 페이지 이동   -->





					</div>
					<!--  view E  -->
				</div>
			</div>
		</div>

	</div>


	<div class="modal fade" id="basketModal" role="dialog" >
		<div class="modal-dialog">
			<!-- Modal content-->
			<div class="modal-content">
				<div id=div_modin_main></div>
				<!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
			</div>
		</div>
	</div>

</body>
</html>