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
		
		function gotoggle(data){
			$("#sub-1").css("display","none");
			$("#sub-2").css("display","none");
			$("#sub-3").css("display","none");
			$("#sub-4").css("display","none");
			$("#sub-"+data).slideToggle();
		}
		

		
		
		/* subMenu active 변화 */
		function aaa(){
			$(".sel_type").click(function(){
				$(this).parent().addClass("active");
			});			
		}