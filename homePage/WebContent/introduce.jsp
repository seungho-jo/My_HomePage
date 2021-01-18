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
<title>소개</title>
<link rel="stylesheet" href="css/header.css"/>
<link rel="stylesheet" href="css/footer.css"/>
<link rel="stylesheet" href="css/reset.css"/>
<link rel="stylesheet" href="css/introduce.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
  <!--main-->
    <section id="main">
        <div class="main_inner">
            <div class="main_img">
                <div class="main_img1">
                    <img src="img/단체사진.jpg" alt="">
                    <div class="text">창업동아리 경진대회</div>
                </div>
                <div class="main_img1">
                    <img src="img/단체사진2.jpg" alt="">
                    <div class="text">
                        창의적 종합설계 경진대회 <br/>
                        공학페스티벌
                    </div>
                </div>
                <div class="main_img1">
                    <img src="img/단체사진3.jpg" alt="">
                    <div class="text">메이커문화확산사업 시너지톤</div>
                </div>
            </div>

            <div class="introduce">
                <div class="introduce_a">
                    인사말
                </div>
                <div class="introduce_b">
                    안녕하세요 저희는 전자공학과 캡스톤디자인팀입니다<br/><br/>
                    간단하게 저희팀 소개를 하자면, 2019 교내 창업지원단에서 주관하는 창업동아리 경진대회에서
                    우수상, 교내 창의적 종합설계 아이디어대회 우수상, 창의적 종합설계 경진대회에서 1위를
                    하고 학교대표로 선발돼 곧 있을 전국대회[공학페스티벌]을 준비하고 있습니다.<br/><br/>
                    주로 하는 활동은 캡스톤디자인실에 모여서 아이디어 공유, 작품 설계·제작이
                    대부분이고 그 외에는 개인공부도 합니다. 팀 내의 분위기는 매우 자유로운 편이고, 무섭고 성질
                    더러운 사람은 한명도 없습니다. 특출나게 똑똑한 친구가 들어오길 바라는 것은 아닙니다.
                    여기 팀원들은 모두 평범한 학부생이고 지금까지 각종 공모전에서 좋은 성적을 받을 수 있었던
                    이유는 자유로운 분위기와 서로의 시너지가 잘 맞아떨어졌기 때문입니다.<br/><br/>
                    만약 개인공부가 하고싶거나 각종 공모전에 참여하고싶은분이 있으시다면 거리낌없이 문을 열고 와주세요.
                </div>
            </div>
        </div>
    </section>
<%@ include file = "footer.jsp" %>
</body>
</html>