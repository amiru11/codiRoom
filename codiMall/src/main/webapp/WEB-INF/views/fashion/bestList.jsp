<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
				
				<c:forEach var="list" items="${blist}" begin="0" end="3" >
					<div class="slide codi-item" style="display:inline-block; width:290px;">
						<table class="table table-bordered" style="margin-bottom: 0;">
							<tr>
								<td style="padding: 0;"><img
									src="${pageContext.request.contextPath}/resources/codiUpload/${list.fileName}"></td>
							</tr>
							<tr>
								<td style="padding: 0;">
									<p style="padding-top: 10px;">
												<a
													href="${pageContext.request.contextPath}/fashion/codiView?num=${list.num}">${list.title}</a>
									</p>
									<p>
										${list.member_id}
									</p>
								</td>
							</tr>
						</table>
					</div>
				</c:forEach>
				