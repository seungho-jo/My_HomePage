<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="comMgr" class="page.CommentMgr"/>
<jsp:useBean id="bean" class="page.commentBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	String nowPage = request.getParameter("nowPage");
	String name = request.getParameter("name");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	String num = request.getParameter("num");
	String id = (String)session.getAttribute("idKey");
	String url = null;
	boolean result = comMgr.insertComment(bean);
	
	if(result){
		url = "read.jsp?num=" + num + "&nowPage=" + nowPage + "&keyField=" + keyField + "&keyWord=" + keyWord;
	}
%>
<html>
<script>
	location.href="<%=url%>";
</script>
</html>