<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>  
 <script>
	function viewMyqna(data){
		
		var a = $(data).attr("id");
		
		$.ajax({
		    url : "/codi/board/viewMyqna",
		    type : "get",
		    data : {
		    	board_num : $(data).attr("title"),
				board_kind : $(data).attr("class")
		    },
		    success: function(data) {
		    	console.log(data.trim());
		    	data = data.trim();
				$("#subView").empty();
				$("#subView").html(data);
		    },
		    error:function(request,status,error){
		        console.log("code:"+request.status+"\n"+"error:"+error);
		    }						
		});
		$(data).next("tr").toggle();
		$(data).next("tr").next("tr").toggle();
		$(data).next("tr").next("tr").next("tr").toggle();
		//$("."+a).toggle();
		//$(data).next("tr").next("tr").next("tr").toggle();
	} 
 
 </script>
 <style>
.goView > a:HOVER {
	font-weight: bold;
} 
 </style>   
    				<table class="table">
						<thead>
							<tr>
								<th>#</th>
								<th>TITLE</th>
								<th>WRITER</th>
								<th>DATE</th>
								<th>VIEW</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="list" varStatus="i">
								<tr>
									<td>${list.board_num}</td>
									<td class="goView"><c:forEach begin="1" end="${list.board_depth}">
								&nbsp;&nbsp;&nbsp;&nbsp;
						</c:forEach> <a id="viewMyqna${i.index}" title="${list.board_num}" class="${list.board_kind}" onclick="viewMyqna(this);"
										style=" color : #006633; cursor: pointer; text-decoration: none;">${list.board_title}</a>
									</td>
									<td>${list.board_writer}</td>
									<td>${list.board_date}</td>
									<td>${list.board_counts}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>	
 						<div class="pagination">
							<ul class="pagination pagination-sm">
							  <li><a href="#">1</a></li>
							  <li><a href="#">2</a></li>
							  <li><a href="#">3</a></li>
							  <li><a href="#">4</a></li>
							  <li><a href="#">5</a></li>
							</ul>
						</div>   
    
    