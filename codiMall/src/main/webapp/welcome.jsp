<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/plugin/mb.YTplayer/css/jquery.mb.YTPlayer.min.css" media="all" rel="stylesheet" type="text/css">
<script src="resources/plugin/mb.YTplayer/jquery.mb.YTPlayer.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="http://fonts.googleapis.com/earlyaccess/hanna.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>취향저격</title>
<script type="text/javascript">
	$(function(){
	    jQuery(".player").YTPlayer();
	    var filter = {
	    		invert : 30
	    }
	    $(".player").YTPApplyFilters(filter);
	    
	    $(".video-section").click(function(){
	    	location.href="/codi/";
	    });
	    
	  });	
</script>
<style>
html{
	height : 100%;
}
body{
	font-family: 'Hanna', sans-serif;
	height : 100%;
}
.video-section{
	width : 100%;
	height: 100%;
	background-color: #eeeeee;
}

.video-section .mb_YTPBar{
	background: none;
}
.video-section .buttonBar{display:none;}
.video-section .mb_YTPProgress{display:none;}

#text-area > p{
	font-size : 16px;
	color : #000;
}
#text-area > h2{
	color : #ffffff;
}
/* 재생버튼 */
.command{
	font-size: 20px;
    line-height: 64px;
    width: 70px;
    border: 3px solid #ffffff;
    border-radius: 50%;
    text-decoration: none;
    -moz-backface-visibility: hidden;
	-webkit-transition: all 0.3s;
	-moz-transition: all 0.3s;
	-o-transition: all 0.3s;
	transition: all 0.3s;
	text-decoration: none;
	color:#ffffff;
}
.command:HOVER {
	background-color: #ffffff;
	color: #282828;
	-webkit-transform: scale( 1.12 );
	-moz-transform: scale( 1.12 );
	-o-transform: scale( 1.12 );
	-ms-transform: scale( 1.12 );
	transform: scale( 1.12 );
	text-decoration: none;
}
/* 재생버튼 */
</style>
</head>
<body class="start">

	<!--Video Section:S-->
		<div class="video-section" style="cursor : pointer;">
			<div class="pattern-overlay">
				<a id="bgndVideo" class="player"
			data-property="{videoURL:'https://youtu.be/dZV0_kkzhEY',containment:'.video-section', autoPlay:true, mute:true, opacity:1}" style="margin-top : 100px;">bg</a>
			</div>
			<div id="text-area" class="container text-center" style="top : 200px;">
				<h2 style="text-align: center;">남자의 패션이 바뀌면 &nbsp;남자의 인생이 바뀝니다</h2>
				<div class="clear offsetTopS"></div>
				<p>옷 잘 입는 남자들 대부분 이쁜 여자친구를 사귀는 현실! 그만큼 여자들은 남자들의 패션을 많이 봅니다.</p>
				<p>얼굴은 조인성 / 원빈처럼 태어나지 못해서 슬프지만, &nbsp;노력만으로 옷을 잘 입는 것은 가능합니다.</p>
				<p>남자도 옷을 잘 입고 싶어합니다. 하지만 생각보다 어렵고, 들여야 하는 시간이 많기 때문에 포기하는 것이 대다수입니다.</p>
				<p>이런 환경속에서 &nbsp;오프라인 → 웹 , 이제는 모바일 시대로 변화 하고 있고 우리는 기회가 왔다고 생각합니다.</p>
				<p>이제 남자들도 적은 시간을 투자해서 &nbsp;멋있어질 수 있게 되었습니다. &nbsp;이제 취향 저격하러갑시다.</p>
				<div class="clear offsetTopL"></div>
				<p>&nbsp;</p>
				<!-- <a class="btn btn-default btn-lg" role="button">취향저격의 길</a> -->
			</div>			
		</div>
	<!--Video Section:E-->
	<!-- ENTER INDEX:S -->
<!-- 	<div class="container">
		<div class="text-center">
		</div>
	</div> -->
	<!-- ENTER INDEX:E -->
</body>
</html>
<!-- 	<div class="container-fluid video-section">
		<div class="pattern-overlay">
		재생,정지 컨트롤버튼
			<div class="row text-center">
				<div class="col-md-12" style="top:300px;">
					<a id="togglePlay" class="command fa fa-play"
						onclick="jQuery('#bgndVideo').YTPTogglePlay()"></a>재생버튼
				</div>
			</div>
		</div>
	</div> -->