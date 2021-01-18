<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="page.BoardBean" %>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
	int num = Integer.parseInt(request.getParameter("num"));
	String nowPage = request.getParameter("nowPage");
	BoardBean bean = (BoardBean)session.getAttribute("bean");
 	String subject = bean.getSubject();
 	String name = bean.getName(); 
	String content = bean.getContent(); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/header.css"/>
<link rel="stylesheet" href="css/footer.css"/>
<link rel="stylesheet" href="css/update.css"/>
<link rel="stylesheet" href="css/reset.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="SE2/js/HuskyEZCreator.js" charset="utf-8"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div id="main">
	<div class="title" align="center">수정하기</div>
	<form id="table" name="updateFrm" method="post" action="boardUpdate">
		<div class="line">
			<div class="value">성명</div>
			<div><input name="name" value="<%=name%>" size="30" maxlength="20"></div>
		</div>
		<div class="line">
			<div class="value">제목</div>
			<div><input name="subject" value="<%=subject%>" size="50" maxlength="50"></div>
		</div>
		<div class="line">
			<div class=valueb">내용</div>
			<div class="textarea">
			<textarea name="content" id="smarteditor" rows="10" cols="100" style="width:766px; height:412px;"> <%=content %></textarea>	
			</div>
		</div>
		<div class="line">
			<div class="value">비밀번호</div>
			<div><input type="password" name="pass" size="15" maxlength="15"></div>
			<div>수정시에는 비밀번호가 필요합니다.</div>
		</div>
		<hr>
		<div class="button">
			<input type="button" id="savebutton" value="수정완료">
			<input type="reset" value="다시수정">
			<input type="button" value="뒤로" onclick="history.go(-1)">
		</div>
		 <input type="hidden" name="nowPage" value="<%=nowPage %>">
		 <input type='hidden' name="num" value="<%=num%>">
	</form>
</div>
<%@ include file = "footer.jsp" %>
<script>
var oEditors = []; 
$(document).ready(function() { 
// Editor Setting 
nhn.husky.EZCreator.createInIFrame({ 
	oAppRef : oEditors, 
	elPlaceHolder : "smarteditor",
	sSkinURI : "SE2/SmartEditor2Skin.html", 
	fCreator : "createSEditor2", 
	htParams : { 
		bUseToolbar : true, 
		bUseVerticalResizer : true, 
		bUseModeChanger : true, 
		} 
}); 
// 전송버튼 클릭이벤트
$("#savebutton").click(function(){ 
	
		if(document.updateFrm.pass.value == ""){
			alert("수정을 위해 패스워드를 입력하세요");
			document.updateFrm.pass.focus();
			return false;
		}
		oEditors.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []); 
		if(validation()) { 
			$("#table").submit(); 
			} 
	}) 
}); 

// 필수값 Check 
function validation(){ 
	var contents = $.trim(oEditors[0].getContents()); 
	if(contents === '<p>&bnsp;</p>' || contents === ''){ 
		alert("내용을 입력하세요."); 
		oEditors.getById['smarteditor'].exec('FOCUS'); 
		return false;
		} 
	return true; 
}
</script>
</body>
</html>