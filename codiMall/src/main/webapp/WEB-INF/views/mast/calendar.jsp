<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel='stylesheet' href='${pageContext.request.contextPath}/resources/fullcalendar-3.1.0/lib/cupertino/jquery-ui.min.css' />
<link href='${pageContext.request.contextPath}/resources/fullcalendar-3.1.0/fullcalendar.min.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/resources/fullcalendar-3.1.0/fullcalendar.print.min.css' rel='stylesheet' media='print' />
<script src='${pageContext.request.contextPath}/resources/fullcalendar-3.1.0/lib/moment.min.js'></script>
<script src='${pageContext.request.contextPath}/resources/fullcalendar-3.1.0/lib/jquery.min.js'></script>
<script src='${pageContext.request.contextPath}/resources/fullcalendar-3.1.0/fullcalendar.min.js'></script>
<script>
$('#calendar').fullCalendar({
	theme: true,
	header: {
		left: 'prev,next today',
		center: 'title',
		right: 'month,agendaWeek,agendaDay,listMonth'
	},
	defaultDate: '2016-12-12',
	navLinks: true, // can click day/week names to navigate views
	editable: true,
	eventLimit: true, // allow "more" link when too many events
});
</script>
<div id="calendar"></div>