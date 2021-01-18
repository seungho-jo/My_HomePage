<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
%>
<%@ page import="page.MemberBean" %>
<jsp:useBean id="memberMgr" class="page.MemberMgr"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/header.css"/>
</head>
<body>
<%
if(id == null) {
%>
<header id="header">
        <section id="inner">
            <div class="header_img">
                <a href="home.jsp">
                    <img src="img/로고.png" alt="" style="max-width: 100%; height: auto;">
                    <div class="sss">
                        <h1>캡스톤 디자인실6</h1>
                    </div>
                </a>
            </div>
            <div class="login">
            	<a href="login.jsp"><img src="img/login.jpg" style="max-width: 100%; height: auto;"></a>
            </div>
        </section>
        <div class="list">
        	<ul>
                <li><a href="introduce.jsp" >introduce</a></li>
                <li><a href="member_introduce.jsp">member</a></li>
               	<li><a href="work.jsp">work</a></li>
            </ul>
        </div>
        <div id="top_img">
            <img src="img/main.png" alt="">
        </div>
    </header>
<%
}else{
%>
<header id="header">
        <section id="inner">
            <div class="header_img">
                <a href="home.jsp">
                    <img src="img/로고.png" alt="">
                    <div class="sss">
                        <h1>캡스톤 디자인실6</h1>
                    </div>
                </a>
            </div>
            <div class="login">
            <%
            	MemberBean Bean = memberMgr.getMember(id);
			%>
            <%=Bean.getName() %>님 환영합니다&nbsp;&nbsp;<a href="logout.jsp" style="text-decoration:none"><font color="black">로그아웃</font></a>
            </div>
        </section>
        <div class="list">
            <ul>
                <li><a href="introduce.jsp">introduce</a></li>
                <li><a href="member_introduce.jsp">member</a></li>
                <li><a href="work.jsp">work</a></li>
                <li><a href="memberUpdate.jsp">회원정보수정</a></li>
            </ul>
        </div>
        <div id="top_img">
            <img src="img/main.png" alt="">
        </div>
    </header>
<%
}
%>
</body>
</html>