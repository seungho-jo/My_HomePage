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
<link rel="stylesheet" href="css/header.css"/>
<link rel="stylesheet" href="css/footer.css"/>
<link rel="stylesheet" href="css/login.css">
<link rel="stylesheet" href="css/reset.css">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type=text/javascript>
function loginCheck(){
	if(document.loginFrm.id.value == ""){
		alert("아이디를 입력해주세요");
		document.loginFrm.id.focus();
		return
	
	}
	if(document.loginFrm.pwd.value == ""){
		alert("비밀번호를 입력해주세요");
		document.loginFrm.pwd.focus();
		return
	}
	document.loginFrm.submit();
}
</script>
</head>
<body>
<%@ include file = "header.jsp"  %>
<div id="login">
<form name="loginFrm" method="post" action="loginProc.jsp">
	<table class="table">
		<tr class="tr">
			<td class="td" colspan="2"><b>로그인</b></td>
		</tr>
		<tr>
			<td class="value">아 이 디</td>
			<td><input name="id" size="30"></td>
		</tr>
		<tr>
			<td class="value">비밀번호</td>
			<td><input type="password" name="pwd" size="30"></td>
		</tr>
		<tr>
			<td colspan="2">
				<div>
					<input type="button" value="로그인" onclick="loginCheck()">&nbsp;
					<input type="button" value="회원가입" onclick="javascript:location.href='member.jsp'">
				</div>
			</td>
	</table>
</form> 
</div>
<%@ include file = "footer.jsp" %>
</body>
</html>