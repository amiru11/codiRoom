/**
 * 
 */
$(document).ready(function(){
	var myWindow = window.outerWidth;
	/* footer */
	var m_footer =

'		<ul class="footer_awards_slider">' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 일자리창출 유공포상 대통령 표창" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award01.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 고용창출 100대 우수기업 대통령 표창(3년 연속)" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award02.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 장애인 고용 우수사업주 인증" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award03.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 기업혁신대상 대한상의회장상" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award05.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 대한민국 청소년육성대상 기업사회공헌 활동 부문" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award06.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 대한민국 지속가능성지수 KSI 1위 (5년 연속)" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award07.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 대한민국 서비스품질지수 KS-SQI 1위 (5년 연속)" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award08.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 코리아 탑 브랜드 대상 동반성장 부문 (4년 연속)" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award10.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 국가지속경영 대상 일자리창출 부문 (2년 연속)" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award12.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 대한민국 경영대상 CSR 부문 (2년 연속)" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award13.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 행복더함 사회공헌대상 고용창출 부문 (2년 연속)" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award15.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 대한민국 미래창조경영 대상 일자리창출 부문" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award16.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 대한민국 사회공헌기업 대상 동반성장 부문" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award17.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 고객의 마음을 움직이는 공감브랜드 대상" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award19.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 웹 어워드 코리아 모바일웹/웹사이트 통합대상" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award21.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 스마트앱 어워드 코리아 회원서비스 분야 최우수상" src="//image.istarbucks.co.kr/common/img/footer/m_footer_award22.jpg"></a></li>' +
'		</ul>';

	var w_footer =
'		<ul class="footer_awards_slider">' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 일자리창출 유공포상 대통령 표창" src="//image.istarbucks.co.kr/common/img/footer/footer_award01.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 고용창출 100대 우수기업 대통령 표창(3년 연속)" src="//image.istarbucks.co.kr/common/img/footer/footer_award02.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 장애인 고용 우수사업주 인증" src="//image.istarbucks.co.kr/common/img/footer/footer_award03.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 기업혁신대상 대한상의회장상" src="//image.istarbucks.co.kr/common/img/footer/footer_award05.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 대한민국 청소년육성대상 기업사회공헌 활동 부문" src="//image.istarbucks.co.kr/common/img/footer/footer_award06.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 대한민국 지속가능성지수 KSI 1위 (5년 연속)" src="//image.istarbucks.co.kr/common/img/footer/footer_award07.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 대한민국 서비스품질지수 KS-SQI 1위 (5년 연속)" src="//image.istarbucks.co.kr/common/img/footer/footer_award08.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 코리아 탑 브랜드 대상 동반성장 부문 (4년 연속)" src="//image.istarbucks.co.kr/common/img/footer/footer_award10.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 국가지속경영 대상 일자리창출 부문 (2년 연속)" src="//image.istarbucks.co.kr/common/img/footer/footer_award12.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 대한민국 경영대상 CSR 부문 (2년 연속)" src="//image.istarbucks.co.kr/common/img/footer/footer_award13.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 행복더함 사회공헌대상 고용창출 부문 (2년 연속)" src="//image.istarbucks.co.kr/common/img/footer/footer_award15.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 대한민국 미래창조경영 대상 일자리창출 부문" src="//image.istarbucks.co.kr/common/img/footer/footer_award16.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 대한민국 사회공헌기업 대상 동반성장 부문" src="//image.istarbucks.co.kr/common/img/footer/footer_award17.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 고객의 마음을 움직이는 공감브랜드 대상" src="//image.istarbucks.co.kr/common/img/footer/footer_award19.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 웹 어워드 코리아 모바일웹/웹사이트 통합대상" src="//image.istarbucks.co.kr/common/img/footer/footer_award21.jpg"></a></li>' +
'			<li><a taget="_blank" href="javascript:void(0);"><img alt="2015 스마트앱 어워드 코리아 회원서비스 분야 최우수상" src="//image.istarbucks.co.kr/common/img/footer/footer_award22.jpg"></a></li>' +
'		</ul>';

	if (myWindow < 640) {
		$('.footer_awards_wrap_inner').prepend(m_footer);
		//$('.footer_awards_slider').hide();
		
	
	} else {
		$('.footer_awards_wrap_inner').prepend(w_footer);
	}

/*	$('.footer_awards_wrap_inner p.footer_award_btn').click(function(){
		console.log('d');
		$('ul.footer_awards_slider').slideToggle();
		$(this).children().children().toggleClass('footer_arrow_up');
	});*/
		

});

