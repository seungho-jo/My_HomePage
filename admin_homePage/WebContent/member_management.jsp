<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="page.MemberBean" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="mMgr" class="page.MemberMgr" />
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
	Vector<MemberBean> vlist = null;
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
	 
	totalRecord = mMgr.getTotalCount(keyField, keyWord);
	totalPage = (int)Math.ceil((double)totalRecord / numPerPage);  //전체페이지수
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock); //현재블럭 계산
	  
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock);  //전체블럭계산
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/header.css"/>
<link rel="stylesheet" href="css/footer.css"/>
<link rel="stylesheet" href="css/reset.css"/>
<link rel="stylesheet" href="css/admin.css"/>
<script type="text/javascript">
function list(){
	document.list.action = "admin.jsp";
	document.list.submit();
}

function pageing(page) {
	document.read.nowPage.value = page;
	document.read.submit();
}

function block(value){
	 document.read.nowPage.value=<%=pagePerBlock%>*(value-1)+1;
	 document.read.submit();
} 

function read(Id){
	document.read.id.value=Id;
	document.read.action="admin_member.jsp";
	document.read.submit();
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
<jsp:include page="header.jsp"></jsp:include>
<div id="main">
	<div class="title">회원관리</div>
		<div class="search">
		<form name="searchFrm" method="get" action="admin.jsp">
			<select name="keyField" size="1">
				<option value="Id">아이디</option>
				<option value="name">이름</option>
				<option value="logdate">가입날자</option>
				<option value="visit">회원유형</option>
			</select>
			<input size="16" name="keyWord">
 			<input class="asdf" type="button" value="찾기" onclick="javascript:check()">
 			<input type="hidden" name="nowPage" value="1">
 		</form>
		</div>
	<div class="member_table">
	<div class="total">
		Total : <%=totalRecord%>Articles(<font color = "red"> <%=nowPage %>/<%=totalPage %>Pages</font>)
	</div>
		<%
			vlist = mMgr.getMemberList(keyField, keyWord, start, end);
			listSize = vlist.size();
			if(vlist.isEmpty()){
				out.println("가입한 회원이 없습니다.");
			}else{
		%>
		<div class="a">
			<div class="a_a"><b>번호</b></div>
			<div class="a_a"><b>아이디</b></div>
			<div class="a_a"><b>이름</b></div>
			<div class="a_a"><b>가입날자</b></div>
			<div class="a_a"><b>회원유형</b></div>
		</div>
		<%
			for(int i = 0; i<numPerPage; i++){
				if(i==listSize) break;
				MemberBean bean = vlist.get(i);
				String Id = bean.getId();
				String name = bean.getName();
				String logdate = bean.getLogdate();
				String visit = bean.getVisit();
		%>
		<div class="b">
			<div class="b_a"><%=totalRecord-((nowPage-1)*numPerPage)-i %></div>
			<div class="b_a"><a href="javascript:read('<%=Id %>')" style="text-decoration:none"><font color="black"><%=Id %></font></a></div>
			<div class="b_a"><%=name %></div>	
			<div class="b_a"><%=logdate %></div>	
			<div class="b_a"><%=visit %></div>	
		</div>
		<%} %>
		<%} %>
		<div class="back"><a href="javascript:list()" style="text-decoration:none">[처음으로]</a></div>
		<div class="paging">
			<!-- 페이징 및 블럭 처리 -->
			<%
				int pageStart = (nowBlock -1)*pagePerBlock + 1;
				int pageEnd = ((pageStart + pagePerBlock) <= totalPage) ? (pageStart + pagePerBlock): totalPage+1;
				if(totalPage != 0){
					if(nowBlock >1){%>
						<a href="javascript:block('<%=nowBlock-1 %>>')" style="text-decoration:none">prev...</a><%}%>&nbsp;
						<%for( ; pageStart < pageEnd; pageStart++){ %>
						<a href="havascript:pageing('<%=pageStart %>')" style="text-decoration:none">
						<%if(pageStart == nowPage) {%><font color="black"><%} %>
						[<%=pageStart %>]
						<%if(pageStart == nowPage) {%></font><%} %></a>
						<%} %>&nbsp;
						<%if(totalBlock > nowBlock) {%>
						<a href="javascript:block('<%=nowBlock+1 %>')" style="text-decoration:none">.....next</a>
						<%} %>&nbsp;
						<%} %>
			<!-- 페이징 및 블럭처리 종료 -->
		</div>
	</div>
	<form name="list" method="post">
		<input type="hidden" name="reload" value="true"> 
		<input type="hidden" name="nowPage" value="1">
	</form>
	<form name="read" method="get">
		<input type="hidden" name="id" value="<%=id%>"> 
		<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
		<input type="hidden" name="keyField" value="<%=keyField%>"> 
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
	</form>
</div>
<%@ include file = "footer.jsp" %>
</body>
</html>