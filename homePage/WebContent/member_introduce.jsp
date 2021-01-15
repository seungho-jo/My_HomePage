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
<title>구성원</title>
<link rel="stylesheet" href="css/header.css"/>
<link rel="stylesheet" href="css/footer.css"/>
<link rel="stylesheet" href="css/reset.css"/>
<link rel="stylesheet" href="css/member_introduce.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<%@ include file = "header.jsp" %>
<section id="main">
        <div class="main_inner">
            <div class="member">
                <div class="home">

                </div>
                <div class="member_introduce">
                    구성원
                </div>
                <div class="Professor">
                    <img src="img/gntech_staff_김병철교수님.jpg" alt="">
                    <p>김병철 교수님</p>
                </div>
                <div class="line_1"></div>
                <div class="line_2"></div>
                <div class="line_collection">
                    <div class="line_3"></div>
                    <div class="line_4"></div>
                    <div class="line_5"></div>
                    <div class="line_6"></div>
                </div>
                <div id="student_collection">
                    <div class="student_4">
                        <div class="class_4">4학년</div>
                        <div class="class_4_member">
                            <img src="img/profile.jpg" alt="">
                            <div>김성훈</div>
                        </div>
                        <div class="class_4_member">
                            <img src="img/profile.jpg" alt="">
                            <div>이해솔</div>
                        </div>
                        <div class="class_4_member">
                            <img src="img/profile.jpg" alt="">
                            <div>조승호</div>
                        </div>
                        <div class="class_4_member">
                            <img src="img/profile.jpg" alt="">
                            <div>천정빈</div>
                        </div>
                    </div>
                    <div class="student_3">
                        <div class="class_3">3학년</div>
                        <div class="class_3_member">
                            <img src="img/profile.jpg" alt="">
                            <div>송영훈</div>
                        </div>
                    </div>
                    <div class="student_2">
                        <div class="class_2">2학년</div>
                        <div class="class_2_member">
                            <img src="img/profile.jpg" alt="">
                            <div>서휘</div>
                        </div>
                    </div>
                    <div class="student_1">
                        <div class="class_1">1학년</div>
                    </div>
                </div>
            </div>
        </div>
    </section>
<%@ include file = "footer.jsp" %>
</body>
</html>