<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
							<td colspan="6">	
							<c:forEach items="${pComm}" var="cList1">	
									<span>${cList1.comm_contents}</span>
									<span>${cList1.comm_writer}</span>
									<hr><br>
							</c:forEach>
							</td>