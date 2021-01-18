<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="page.MemberBean" %>
<jsp:useBean id="mMgr" class="page.MemberMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
	MemberBean mBean = mMgr.getMember(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/header.css"/>
<link rel="stylesheet" href="css/footer.css"/>
<link rel="stylesheet" href="css/reset.css"/>
<link rel="stylesheet" href="css/memberUpdate.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function zipCheck() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipcode').value = data.zonecode;
            document.getElementById("zipaddress").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
        }
    }).open();
}
</script>
</head>
<body onLoad="regFrm.id.focus()">
<jsp:include page="header.jsp"></jsp:include>
<div id="main">
	<form name="regFrm" method="post" action="memberUpdateProc.jsp">
		<div class="title">회원정보수정</div>
		<div class="line">
			<div class="line_first">아이디</div>
			<div class="line_second"><input name="id" value="<%=id %>" readonly></div>
		</div>
		<div class="line">
			<div class="line_first">패스워드</div>
			<div class="line_second"><input type="password" name="pwd" value="<%=mBean.getPwd() %>"></div>
		</div>
		<div class="line">
			<div class="line_first">이름</div>
			<div class="line_second"><input name="name" value="<%=mBean.getName() %>"></div>
		</div>
		<div class="line">
			<div class="line_first">성별</div>
			<div class="line_second">남<input type="radio" name="gender" value="1" <%=mBean.getGender().equals("1") ? "checked" : "" %>></div>
			<div class="line_second">여<input type="radio" name="gender" value="2" <%=mBean.getGender().equals("2") ? "checked" : "" %>></div>
		</div>
		<div class="line">
			<div class="line_first">생년월일</div>
			<div class="line_second"><input name="birthday" value="<%=mBean.getBirthday() %>"> ex)950905</div>
		</div>
		<div class="line">
			<div class="line_first">Email</div>
			<div class="line_second"><input name="email" value="<%=mBean.getEmail() %>"></div>
		</div>
		<div class="line">
			<div class="line_first">우편번호</div>
			<div class="line_second"><input id="zipcode" name="zipcode" value="<%=mBean.getZipcode() %>" readonly><input type="button" value="우편번호찾기" onclick="zipCheck()"></div>
		</div>
		<div class="line">
			<div class="line_first">주소</div>
			<div class="line_second"><input id="zipaddress" name="address" value="<%=mBean.getAddress() %>"><input id="extraAddress" name="extraAddress" value="<%=mBean.getExtraAddress() %>"><input id="detailAddress" name="detailAddress" value="<%=mBean.getDetailAddress() %>"></div>
		</div>
		<div class="line">
			<div class="line_first">취미</div>
			<div class="line_second">
				<%
					String list[] = {"인터넷","여행","게임","영화","운동"};
					String hobbys[] = mBean.getHobby();
					for(int i = 0; i < list.length; i++){
						out.println("<input type=checkbox name=hobby ");
						out.println("value=" + list[i] +" "  + (hobbys[i].equals("1") ? "checked" : "") +">" + list[i]);
					}
				%>
			</div>
		</div>
		<div class="line">
			<div class="line_first">선택</div>
			<div class="line_second">
				<select name="visit">
					<option value="0" selected>선택하세요.
					<option value="학부생">학부생
					<option value="대학원생">대학원생
					<option value="직원">직원
					<option value="방문자">방문자
				</select>
				<script>document.regFrm.job.value="<%=mBean.getVisit()%>"</script>
			</div>
		</div>
		<div class="submit" align="center"><input type="submit" value="수정완료"></div>
	</form>
</div>
<%@ include file = "footer.jsp" %>
</body>
</html>