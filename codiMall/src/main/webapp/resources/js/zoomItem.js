/**
 *
 * ZOOM ITEM SCRIPT
 */

var image_zoom = new function() {
	
	this.img_idx = 0;
	
	this.bigImages = new Object();		// 큰이미지 객체
	
    this.showLayer = function (layer_id, big_img_id, thum_list_id, img_idx)  {//줌이미지 뜨는경우
		
		var self = image_zoom;//함수인 image_zoom을 객체 self로 사용하겠다!
		self.img_idx = img_idx;//이미지가 몇번째인지 배열주기
		
		// 줌 이미지 설정
		self.setBigImage(thum_list_id, big_img_id, self.img_idx);
		
		// 줌 이미지 마우스 작동
		$("#" + layer_id + " div.spotlight").mousemove(function(event) {//마우스이동시 줌이미지를 이동하게
			var box_offset = $("#" + layer_id + " div.spotlight").offset();//좌표변환 함수 offset 사용
			var box_width = $("#" + layer_id + " div.spotlight").width();//박스가로
			var box_height = $("#" + layer_id + " div.spotlight").height();//박스세로
			var img_width = $("#" + big_img_id).width();//이미지가로
			var img_height = $("#" + big_img_id).height();//이미지세로
			//박스보다 큰 이미지가 박스안에 담기기 때문에 top과 left로 이동시킨다
			var top = (parseInt(box_offset.top) - event.pageY)*((img_height/box_height)-1);
			var left = (parseInt(box_offset.left) - event.pageX)*((img_width/box_width)-1);
			$("#" + big_img_id).css("top", top + "px");
			$("#" + big_img_id).css("left", left + "px");
		});
		
		$("#" + layer_id).show("slow");
    };
	
	this.hideLayer = function (layer_id) {//줌이미지 숨기는 경우
		
		$("#" + layer_id).hide("slow");
    };
	
	this.rollImage = function (thum_list_id, big_img_id, direction) {
		
		var self = image_zoom;
		var thum_img_length = $("#" + thum_list_id + " img").length - 1;
		
		if ( thum_img_length < 0 ) return;
		
		if ( direction == "next" ) {
			//Do Next
			if ( self.img_idx >= thum_img_length ) {
				self.img_idx = 0;
			} else {
				self.img_idx++;
			}
		} else {
			//Do Prev
			if ( self.img_idx < 1 ) {
				self.img_idx = thum_img_length ;
			} else {
				self.img_idx--;
			}
		}

		self.setBigImage(thum_list_id, big_img_id, self.img_idx);
    };
	
	this.setBigImage = function (thum_list_id, big_img_id, img_idx) {//큰 이미지 설정 (줌으로 나타나는 이미지)
		
		var self = image_zoom;
		self.img_idx = img_idx;
		var thum_img_src = $("#" + thum_list_id + " img:eq(" + self.img_idx + ")").attr("src");	// 썸네일 이미지 소스
		var big_yn = $("#" + thum_list_id + " img:eq(" + self.img_idx + ")").attr("big_yn");	// 썸네일 이미지 큰사이즈 여부
		console.log(thum_list_id);
		console.log(self.img_idx);
		console.log(thum_img_src);
		console.log(big_yn);
		if(self.bigImages[self.img_idx] == undefined) {//무조건 처음에 undefined 왜냐면 self.bigImages는 Object 객체로 선언했기때문
		
			// 이미지 객체 만들기
			self.bigImages[self.img_idx] = new Image();//배열로 bigImage를 Image객체로 만들어 준다

			if(big_yn == "Y") {//줌된 이미지 라면
				var big_img_src = thum_img_src.replace("_60.", "_big.");
			} else {//썸네일 이미지라면
				var big_img_src = thum_img_src;
			}
			self.bigImages[self.img_idx].src = big_img_src;						// 이미지 소스
			console.log(big_img_src);
			console.log(self.bigImages[self.img_idx].src);
		}

		$('#' + big_img_id).css("top", "-50px");
		$('#' + big_img_id).css("left", "-50px");
		$('#' + big_img_id).attr("src", self.bigImages[self.img_idx].src);
    };
}

