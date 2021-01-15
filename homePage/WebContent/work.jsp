<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="page.BoardBean" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="bMgr" class="page.BoardMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
	
	  int totalRecord=0; //전체레코드수
	  int numPerPage=10; // 페이지당 레코드 수 
	  int pagePerBlock=15; //블럭당 페이지수 
	  
	  int totalPage=0; //전체 페이지 수
	  int totalBlock=0;  //전체 블럭수 

	  int nowPage=1; // 현재페이지
	  int nowBlock=1;  //현재블럭
	  
	  int start=0; //디비의 select 시작번호
	  int end=10; //시작번호로 부터 가져올 select 갯수
	  
	  int listSize=0; //현재 읽어온 게시물의 수

	String keyWord = "", keyField = "";
	Vector<BoardBean> vlist = null;
	if (request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	if (request.getParameter("reload") != null){
		if(request.getParameter("reload").equals("true")) {
			keyWord = "";
			keyField = "";
		}
	}
	
	if (request.getParameter("nowPage") != null) {
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	 start = (nowPage * numPerPage)-numPerPage;
	 end = numPerPage;
	 
	totalRecord = bMgr.getTotalCount(keyField, keyWord);
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
	  
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" href="css/header.css"/>
<link rel="stylesheet" href="css/footer.css"/>
<link rel="stylesheet" href="css/reset.css"/>
<link rel="stylesheet" href="css/style_work.css"/>
<script type="text/javascript">
function list(){
	document.listFrm.action = "work.jsp";
	document.listFrm.submit();
}

function pageing(page) {
	document.readFrm.nowPage.value = page;
	document.readFrm.submit();
}

function block(value){
	 document.readFrm.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
	 document.readFrm.submit();
} 

function read(num){
	document.readFrm.num.value=num;
	document.readFrm.action="read.jsp";
	document.readFrm.submit();
}

function check() {
     if (document.searchFrm.keyWord.value == "") {
   alert("검색어를 입력하세요.");
   document.searchFrm.keyWord.focus();
   return;
     }
  document.searchFrm.submit();
 }
</script>
</head>
<body>
<%@ include file = "header.jsp" %>
<div id="main">
<div id="a">

<div class="a_1">
게시판 목록
</div>
</div>
<div id="b">
<div class="title">
	<b>게시판</b>
</div>
<form name="searchFrm" method="get" action="work.jsp">
<table border="0" class="search">
 	<tr>
 		<td>
 			<select name="keyField" size="1">
 				<option value="name">작성자</option>
 				<option value="subject">제 목</option>
 				<option value="content">내 용</option>
 			</select>
 			<input size="16" name="keyWord">
 			<input type="button" value="찾기" onclick="javascript:check()">
 			<input type="hidden" name="nowPage" value="1">
 			</td>
 		</tr>
</table>
</form>
<table class="total" border="0">
	<tr>
		<td>Total : <%=totalRecord%>Articles(<font color = "red"> <%=nowPage %>/<%=totalPage %>Pages</font>)</td>
	</tr>
</table>
<table border="0" class="total_field">
	<tr>
		<td class="none" colspan="2">
		<%
			vlist = bMgr.getBoardList(keyField, keyWord, start, end);
			listSize = vlist.size();
			if(vlist.isEmpty()){
				out.println("등록된 게시물이 없습니다.");
			}else{
		%>
		<table border="0" class="field">
			<tr bgcolor="#D0D0D0" class="first_line">
				<td width="5%"><b>번 호</b></td>
				<td width="62%"><b>제 목</b></td>
				<td width="10%"><b>작성자</b></td>
				<td width="15%"><b>작성일</b></td>
				<td width="8%"><b>조회수</b></td>
			</tr>
		<%
			for(int i = 0; i<numPerPage; i++){
				if(i==listSize) break;
				BoardBean bean = vlist.get(i);
				int num = bean.getNum();
				String name = bean.getName();
				String subject = bean.getSubject();
				String regdate = bean.getRegdate();
				int depth = bean.getDepth();
				int count = bean.getCount();
		%>
			<tr class="field_contents">
				<td><%=totalRecord-((nowPage-1)*numPerPage)-i %></td>
				<td>
				<%
					if(depth>0){
						for(int j=0; j<depth; j++){
							out.println("&nbsp;&nbsp;");
						}
					}
				%>
				<a href="javascript:read('<%=num %>')" style="text-decoration:none"><font color="black"><%=subject %></font></a>
				</td>
				<td><%=name %></td>
				<td><%=regdate %></td>
				<td><%=count %></td>
				</tr>
					<%} %>
			</table>
			<%} %>
		</td>
	</tr>
	<tr>
	<td class="button" align="right">
		<%
		if(id != null){
		%>
			<a href="post.jsp" style="text-decoration:none">[글쓰기]</a>
			<%} %>
			<a href="javascript:list()" style="text-decoration:none">[처음으로]</a>
		</td>
	</tr>
	<tr>
		<td align="center">
		<!-- 페이징 및 블럭 처리 Start--> 
			<%
   				  int pageStart = (nowBlock -1)*pagePerBlock + 1 ; //하단 페이지 시작번호
   				  int pageEnd = ((pageStart + pagePerBlock ) <= totalPage) ?  (pageStart + pagePerBlock): totalPage+1; 
   				  //하단 페이지 끝번호
   				  if(totalPage !=0){
    			  	if (nowBlock > 1) {%>
    			  		<a href="javascript:block('<%=nowBlock-1%>')" style="text-decoration:none">prev...</a><%}%>&nbsp; 
    			  		<%for ( ; pageStart < pageEnd; pageStart++){%>
     			     	<a href="javascript:pageing('<%=pageStart %>')" style="text-decoration:none"> 
     					<%if(pageStart==nowPage) {%><font color="blue"> <%}%>
     					[<%=pageStart %>] 
     					<%if(pageStart==nowPage) {%></font> <%}%></a> 
    					<%}//for%>&nbsp; 
    					<%if (totalBlock > nowBlock ) {%>
    					<a href="javascript:block('<%=nowBlock+1%>')" style="text-decoration:none">.....next</a>
    				<%}%>&nbsp;  
   				<%}%>
 				<!-- 페이징 및 블럭 처리 End-->
		</td>
	</tr>
</table>

<form name="listFrm" method="post">
	<input type="hidden" name="reload" value="true"> 
	<input type="hidden" name="nowPage" value="1">
</form>
<form name="readFrm" method="get">
	<input type="hidden" name="num"> 
	<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
	<input type="hidden" name="keyField" value="<%=keyField%>"> 
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
</form>
</div>
</div>
<%@ include file = "footer.jsp" %>
</body>
</html>