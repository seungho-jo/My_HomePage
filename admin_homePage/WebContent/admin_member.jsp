<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="page.MemberBean" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="regMgr" class="page.MemberMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
	String Id = request.getParameter("id");
	String nowPage = request.getParameter("nowPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	MemberBean bean = regMgr.getMember(Id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
function list(){
	document.listFrm.submit();
}
function member_delete(){
	document.member_delete.submit();
}
</script>
<link rel="stylesheet" href="css/header.css"/>
<link rel="stylesheet" href="css/footer.css"/>
<link rel="stylesheet" href="css/reset.css"/>
<link rel="stylesheet" href="css/admin_member.css"/>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div id="main">
		<div class="title">회원정보</div>
		<div class="a">
			<div class="b">아이디</div>
			<div class="c"><%=Id %></div>
		</div>
		<div class="a">
			<div class="b">패스워드</div>
			<div class="c"><%=bean.getPwd()%></div>
		</div>
		<div class="a">
			<div class="b">이름</div>
			<div class="c"><%=bean.getName() %></div>
		</div>
		<div class="a">
			<div class="b">성별</div>
			<div class="c">남<input type="radio" name="gender" value="1" <%=bean.getGender().equals("1") ? "checked" : "" %>>여<input type="radio" name="gender" value="2" <%=bean.getGender().equals("2") ? "checked" : "" %>></div>
		</div>
		<div class="a">
			<div class="b">생년월일</div>
			<div class="c"><%=bean.getBirthday() %></div>
		</div>
		<div class="a">
			<div class="b">Email</div>
			<div class="c"><%=bean.getEmail() %></div>
		</div>
		<div class="a">
			<div class="b">우편번호</div>
			<div class="c"><%=bean.getZipcode() %></div>
		</div>
		<div class="a">
			<div class="b">주소</div>
			<div class="c"><%=bean.getAddress() %> <%=bean.getExtraAddress() %> <%=bean.getDetailAddress()%></div>
		</div>
		<div class="a">
			<div class="b">취미</div>
			<div class="c">
				<%
					String list[] = {"인터넷","여행","게임","영화","운동"};
					String hobbys[] = bean.getHobby();
					for(int i = 0; i < list.length; i++){
						out.println("<input type=checkbox name=hobby ");
						out.println("value=" + list[i] +" "  + (hobbys[i].equals("1") ? "checked" : "") +">" + list[i]);
					}
					%>
			</div>
		</div>
		<div class="a">
			<div class="b">선택</div>
			<div class="c">
				<%=bean.getVisit()%>
			</div>
		</div>
		<div class="d">[<a href="javascript:list()" style="text-decoration:none"> 리스트</a> ]&nbsp;&nbsp;
		<form name="member_delete" action="admin_delete.jsp">[<a href="javascript:member_delete()" style="text-decoration:none">삭 제</a>]
		<input type="hidden" name="Id" value="<%=Id %>">
		</form></div>
		<form name="listFrm" method="post" action="member_management.jsp">
		<input type="hidden" name="nowPage" value="<%=nowPage %>">
		<%if(!(keyWord==null || keyWord.equals(""))){%>
		<input type="hidden" name="keyField" value="<%=keyField %>">
		<input type="hidden" name="keyWord" value="<%=keyWord %>">
		<%} %>
	</form>
</div>
<%@ include file = "footer.jsp" %>
</body>
</html>