<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="page.commentBean" %>
<%@ page import="page.BoardBean" %>
<%@ page import="page.MemberBean" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="cMgr" class="page.CommentMgr"/>
<jsp:useBean id="regMgr" class="page.MemberMgr"/>
<jsp:useBean id="bMgr" class="page.BoardMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	String comment = request.getParameter("comment");
	
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	bMgr.upCount(num);
	BoardBean bean = bMgr.getBoard(num);
	String name = bean.getName();
	String subject = bean.getSubject();
	String regdate = bean.getRegdate();
	String content = bean.getContent();
	String filename = bean.getFilename();
	int filesize = bean.getFilesize();
	String ip = bean.getIp();
	int count = bean.getCount();
	session.setAttribute("bean", bean);
	MemberBean been = regMgr.getMember(id);
	Vector<commentBean> vlist = cMgr.getComment(num);
	String url = "read.jsp?num=" + num + "&nowPage=" + nowPage + "&keyField=" + keyField + "&keyWord=" + keyWord;
	if(request.getParameter("text")!= null){
		int number = Integer.parseInt(request.getParameter("number"));
		cMgr.deleteComment(number);
		response.sendRedirect(url);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
  textarea { box-sizing: border-box; resize: none; }
</style>
<script type="text/javascript">
function list(){
	document.listFrm.submit();
}

function down(filename){
	document.downFrm.filename.value=filename;
	document.downFrm.submit();
}
function cmdelete(){
	var msg = confirm("댓글을 삭제합니다");
	if(msg == true){
		console.log("yes");
		document.getElementById('delFrm').submit();
	}
	else {
		return false;
	}
}
</script>
<link rel="stylesheet" href="css/header.css"/>
<link rel="stylesheet" href="css/footer.css"/>
<link rel="stylesheet" href="css/reset.css"/>
<link rel="stylesheet" href="css/read.css"/>
</head>
<body>
<%@ include file = "header.jsp" %>
<div id="main" align="center">
	<table class="table">
		<tr>
			<td class="title"><%=subject %></td>
		</tr>
		<tr>
			<td colspan="6">
				<table class="table_top">
					<tr>
						<td class="ab">작성자</td>
						<td class="b" ><%=name %></td>
						<td class="ab">작성일</td>
						<td class="b" ><%=regdate %></td>
						<td class="ab">조회수</td>
						<td class="b" ><%=count %></td>
					</tr>
					<tr>
						<td class="ab">첨부파일</td>
						<td class="c" colspan="5">
						<% if(filename != null && !filename.equals("")){%>
						<a href="javascript:down('<%=filename %>')"><%=filename %></a>
						&nbsp;&nbsp;<font color="blue">(<%=filesize %>kBytes)</font>
						<%}else{ %> <%} %>
						</td>
					</tr>
					<tr>
						<td colspan="6"><br><pre><%=content %></pre><br></td>
					</tr>
					<%
						for(int i=0;i<vlist.size();i++){
							commentBean dean =vlist.get(i);
					%>
					<tr class="cc">
						<td class="comName"><%=dean.getName() %></td>
						<td class="comComment" colspan="4"><%=dean.getComment() %></td>
						<%
							if(id != null){
							if(been.getName().equals(dean.getName())){
						%>
						<td class="delete" colspan="1">
							<form name="delFrm" id="delFrm" method="post" action="">
								<a href="#" onclick="cmdelete()" style="text-decoration:none">[삭 제]</a>
								<input type="hidden" name="text" value="ok">
								<input type="hidden" name="number" value="<%=dean.getNumber() %>">
							</form>
						</td>
						<%} }%>
					</tr>
					<%} %>
					<tr>
						<td>
							<form name="comFrm" method="post" accept-charset="utf-8" action="commentProc.jsp" width="100%">
								<table id="comment">
									<tr>
										<%
												if(id != null){
										%>
										<td class="e">
										<div align="center">
										<input type="hidden" name="num" value="<%=num%>">
										<input type="hidden" name="nowPage" value="<%=nowPage%>">
										<input type="hidden" name="name" value="<%=been.getName()%>">
										<input type="hidden" name="keyField" value="<%=keyField%>">
										<input type="hidden" name="keyWord" value="<%=keyWord%>">
										<textarea class="textarea" name="comment" data-autoresize rows="4"></textarea>
										<input type="submit" value="등록">
										</div>
										</td>
										<%
											}
										%>
									</tr>
								</table>
							</form>
						</td>
					</tr>
					<tr>
						<td width="100%" colspan="6" align="right">
						<%=ip %>로 부터 글을 남기셨습니다./조회수<%=count %>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
			<hr/>
			[<a href="javascript:list()" style="text-decoration:none"> 리스트</a> ]
			<%if(id != null){ %>
			[<a href="reply.jsp?nowPage=<%=nowPage%>" style="text-decoration:none"> 답 변</a> ]
			<%
			
			if(been.getName().equals(name)){
			%>
			[<a href="update.jsp?nowPage=<%=nowPage%>&num=<%=num%>" style="text-decoration:none"> 수 정 </a>]
			[<a href="delete.jsp?nowPage=<%=nowPage%>&num=<%=num%>" style="text-decoration:none"> 삭 제 </a>]<br>
			<%
					}
			}
			%>
			</td>
		</tr>
	</table>
	<form name="downFrm" action="download.jsp" method="post">
		<input type="hidden" name="filename">
	</form>
	<form name="listFrm" method="post" action="work.jsp">
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
		<%if(!(keyWord==null || keyWord.equals(""))){%>
		<input type="hidden" name="keyField" value="<%=keyField %>">
		<input type="hidden" name="keyWord" value="<%=keyWord %>">
		<%} %>
	</form>
</div>
<%@ include file = "footer.jsp" %>
</body>
</html>