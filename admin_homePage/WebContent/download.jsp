<%@ page language="java" contentType="application; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="page.BoardMgr" />
<%
	bMgr.downLoad(request, response, out, pageContext);
%>
