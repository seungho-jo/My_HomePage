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
<%@ include file = "header.jsp" %>
<div id="main">
	<div class="title" align="center">수정하기</div>
	<form id="table" name="updateFrm" method="post" action="boardUpdate">
		<div class="a">
			<div class="b">성명</div>
			<div><input name="name" value="<%=name%>" size="30" maxlength="20"></div>
		</div>
		<div class="a">
			<div class="b">제목</div>
			<div><input name="subject" value="<%=subject%>" size="50" maxlength="50"></div>
		</div>
		<div class="a">
			<div class="b">내용</div>
			<div class="c">
			<textarea name="content" id="smarteditor" rows="10" cols="100" style="width:766px; height:412px;"> <%=content %></textarea>	
			</div>
		</div>
		<div class="a">
			<div class="b">비밀번호</div>
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
var oEditors = [];// 개발되어 있는 소스에 맞추느라, 전역변수로 사용하였지만, 지역변수로 사용해도 전혀 무관 함. 
$(document).ready(function() { 
// Editor Setting 
nhn.husky.EZCreator.createInIFrame({ 
	oAppRef : oEditors, // 전역변수 명과 동일해야 함. 
	elPlaceHolder : "smarteditor", // 에디터가 그려질 textarea ID 값과 동일 해야 함. 
	sSkinURI : "SE2/SmartEditor2Skin.html", // Editor HTML 
	fCreator : "createSEditor2", // SE2BasicCreator.js 메소드명이니 변경 금지 X 
	htParams : { 
		// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
		bUseToolbar : true, 
		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
		bUseVerticalResizer : true, 
		// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
		bUseModeChanger : true, 
		} 
}); 
// 전송버튼 클릭이벤트
$("#savebutton").click(function(){ 
	//if(confirm("저장하시겠습니까?")) { 
		if(document.updateFrm.pass.value == ""){
			alert("수정을 위해 패스워드를 입력하세요");
			document.updateFrm.pass.focus();
			return false;
		}
		// id가 smarteditor인 textarea에 에디터에서 대입 
		oEditors.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []); 
		// 이부분에 에디터 validation 검증 
		
		if(validation()) { 
			$("#table").submit(); 
			} 
		//} 
	}) 
}); 

// 필수값 Check 
function validation(){ 
	var contents = $.trim(oEditors[0].getContents()); 
	if(contents === '<p>&bnsp;</p>' || contents === ''){ // 기본적으로 아무것도 입력하지 않아도 값이 입력되어 있음. 
		alert("내용을 입력하세요."); 
		oEditors.getById['smarteditor'].exec('FOCUS'); 
		return false;
		} 
	return true; 
}
</script>
</body>
</html>