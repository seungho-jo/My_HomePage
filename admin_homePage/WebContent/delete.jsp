<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="page.BoardBean" %>
<jsp:useBean id="bMgr" class="page.BoardMgr"/>
<jsp:useBean id="cMgr" class="page.CommentMgr"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	if(request.getParameter("pass") != null){
		String inPass = request.getParameter("pass");
		BoardBean bean = (BoardBean)session.getAttribute("bean");
		String dbPass = bean.getPass();
		if(inPass.equals(dbPass)){
			bMgr.deleteBoard(num);
			cMgr.delete(num);
			String url = "work.jsp?nowPage=" + nowPage;
			response.sendRedirect(url);
		}else{
%>
<script type="text/javascript">
alert("입력하신 비밀번호가 아닙니다.")
history.back();
</script>
<%
	}
		}else{
%>
<script type="text/javascript">
function check(){
		if(document.delFrm.pass.value ==""){
			alert("패스워드를 입력하세요.");
			document.delFrm.pass.focus();
			return false;
		}
		document.delFrm.submit();
	}
</script>
<link rel="stylesheet" href="css/header.css"/>
<link rel="stylesheet" href="css/footer.css"/>
<link rel="stylesheet" href="css/reset.css"/>
<link rel="stylesheet" href="css/delete.css"/>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div align="center" id="main">
	<table class="delete">
		<tr>
			<td align="center">사용자의 비밀번호를 입력해주세요</td>
		</tr>
	</table>
	<form class="delete_table" name="delFrm" method="post" action="delete.jsp">
		<table class="delete_table1">
		<tr>
			<td align="center">
			<table class="table_mid">
				<tr>
					<td align="center">
					<input class="c" type="password" name="pass" size="30" maxlength="30">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input class="d" type="reset" value="다시쓰기">
					</td>
				</tr>
				<tr>
					<td class="a"></td>
				</tr>
				<tr>
					<td align="center">
					<input class="b" type="button" value="뒤로" onclick="history.go(-1)">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input class="b" type="button" value="삭제완료" onclick="check()">
					</td>
				</tr>
			</table>
			</td>
		</tr>
		</table>
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
		<input type="hidden" name="num" value="<%=num%>">
	</form>
</div>
<%} %>
<%@ include file = "footer.jsp" %>
</body>
</html>