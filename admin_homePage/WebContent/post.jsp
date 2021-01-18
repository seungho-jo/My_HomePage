<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="page.BoardBean"%>
<%@ page import="page.MemberBean" %>
<jsp:useBean id="regMgr" class="page.MemberMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("idKey");
	MemberBean been = regMgr.getAdmin(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 작성</title>
<link rel="stylesheet" href="css/header.css" />
<link rel="stylesheet" href="css/footer.css" />
<link rel="stylesheet" href="css/post.css" />
<link rel="stylesheet" href="css/reset.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="SE2/js/HuskyEZCreator.js"
	charset="utf-8"></script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div id="main">
		<table class="d">
			<tr>
				<td class="dd">글쓰기</td>
			</tr>
			<tr>
				<td><hr></td>
			</tr>
		</table>
		<form id="postfrm" name="postFrm" method="post" action="boardPost"
			enctype="multipart/form-data">
			<table align="center" id="form">
				<tr>
					<td>성 명</td>
					<td><input name="name" value="<%=been.getName()%>"
						size="10"></td>
				</tr>
				<tr>
					<td>제 목</td>
					<td><input name="subject" size="50" maxlength="30"></td>
				</tr>
				<tr>
					<td>내 용</td>
					<td>
						<textarea rows="10" cols="30" id="smarteditor" name="content" rows="10" cols="100" style="width:766px; height:412px;"></textarea>
					</td>
				</tr>
				<tr>
					<td>비밀 번호</td>
					<td><input type="password" name="pass" size="15"
						maxlength="15"></td>
				</tr>
				<tr>
					<td>파일찿기</td>
					<td><input type="file" name="filename" size="50"
						maxlength="30"></td>
				</tr>
				<tr>
					<td colspan="2"><hr></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" id="savebutton" value="등록">
					 <input type="reset" value="다시쓰기">
						<input type="button" value="리스트"
						onclick="javascript:location.href='work.jsp'"></td>
				</tr>
				<tr>
					<td><input type="hidden" name="contentType" value="TEXT"></td>
				</tr>
			</table>
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
		</form>
	</div>
	<%@ include file="footer.jsp"%>
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
	if(document.postFrm.pass.value == ""){
		alert("패스워드를 입력하세요");
		document.postFrm.pass.focus();
		return false;
	}
	//if(confirm("저장하시겠습니까?")) { 
		oEditors.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []); 
		if(validation()) { 
			$("#postFrm").submit(); 
			} 
		//} 
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