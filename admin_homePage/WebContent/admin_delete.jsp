<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mMgr" class="page.MemberMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
	String Id = request.getParameter("Id");
	mMgr.deleteMember(Id);
	String url = "admin.jsp";
	String msg = "회원정보를 삭제하였습니다.";
	response.sendRedirect(url);
		
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>