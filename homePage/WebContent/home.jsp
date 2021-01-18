<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
<link rel="stylesheet" href="css/header.css"/>
<link rel="stylesheet" href="css/footer.css"/>
<link rel="stylesheet" href="css/home.css"/>
<link rel="stylesheet" href="css/reset.css"/>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<section id="main">
        <div id="main_inner">
            <img src="img/main.png" alt="">
            <span class="mask_a"></span>
            <span class="mask_b"></span>
            <span class="mask_c"></span>
            <span class="mask_d"></span>
        </div>
</section>
<%@ include file = "footer.jsp" %>
<script>
	document.getElementById("top_img").style.display="none";
</script>
</body>
</html>