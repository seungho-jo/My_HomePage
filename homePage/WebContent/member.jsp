<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<link rel="stylesheet" href="css/header.css"/>
<link rel="stylesheet" href="css/footer.css"/>
<link rel="stylesheet" href="css/reset.css"/>
<link rel="stylesheet" href="css/member.css"/>
<script type="text/javascript" src="js/test.js"></script>
<script type="text/javascript">
function idCheck(id){
	frm = document.regFrm;
	if(id == ""){
		alert("아이디를 입력해 주세요.");
		frm.id.focus();
		return;
	}
	//아이디 유효성 검사 (영문소문자, 숫자만 허용)
    for (var i = 0; i < document.regFrm.id.value.length; i++) {
        var ch = document.regFrm.id.value.charAt(i)
         if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
            alert("아이디는 영문 대소문자, 숫자만 입력가능합니다.")
            document.regFrm.id.focus();
            return;
        }
    }
    //아이디에 공백 사용하지 않기
    if (document.regFrm.id.value.indexOf(" ") >= 0) {
        alert("아이디에 공백을 사용할 수 없습니다.")
        document.regFrm.id.focus();
        return;
    }
    //아이디 길이 체크 (4~12자)
   if (document.regFrm.id.value.length<4 || document.regFrm.id.value.length>12) {
        alert("아이디를 4~12자까지 입력해주세요.")
        document.regFrm.id.focus();
        return;
   }
	url = "idCheck.jsp?id=" + id;
	window.open(url,"IDCheck","width=300,height=150");
}
</script> 
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
<%@ include file = "header.jsp" %>
<div id="main">
	<div class="box">
		<form name="regFrm" method="post" action="memberProc.jsp">
			<table class="large_box">
				<tr>
					<td colspan="3 "class="a">회원가입</td>
				</tr>
				<tr>
					<td class="b1">아이디</td>
					<td class="b2">
						<input name="id" size="15">
						<input type="button" value="중복확인" onclick="idCheck(this.form.id.value)">
					</td>
					<td class="b3">아이디를 입력해 주세요.</td>
				</tr>
				<tr>
					<td class="b1">비밀번호</td>
					<td class="b2"><input type="password" size="15" name="pwd"></td>
					<td class="b3">패스워드를 입력해 주세요.</td>
				</tr>
				<tr>
					<td class="b1">비밀번호 확인</td>
					<td class="b2"><input type="password" size="15" name="repwd"></td>
					<td class="b3">패스워드를 확인합니다.</td>
				</tr>
				<tr>
					<td class="b1">이름</td>
					<td class="b2"><input name="name" size="15"></td>
					<td class="b2">이름을 입력해 주세요.</td>
				</tr>
				<tr>
					<td class="b1">성별</td>
					<td class="b2">남<input type="radio" name="gender" value="1" checked="checked">
					여<input type="radio" name="gender" value="2"></td>
					<td class="b2">성별을 선택해 주세요.</td>
				</tr>
				<tr>
					<td class="b1">생년월일</td>
					<td class="b2"><input name="birthday" size="6">
					ex)950905</td>
					<td class="b2">생년월일을 입력해 주세요.</td>
				</tr>
				<tr>
					<td class="b1">Email</td>
					<td class="b2"><input name="email" size="30"></td>
					<td class="b2">이메일을 입력해 주세요.</td>
				</tr>
				<tr>
					<td class="b1">우편번호</td>
					<td class="b2"><input id="zipcode" name="zipcode" size="5" readonly>
					<input type="button" value="우편번호찿기" onclick="zipCheck()"></td>
					<td class="b2">우편번호를 검색하세요.</td>
				</tr>
				<tr>
					<td class="b1">주소</td>
					<td class="b2"><input id="zipaddress" name="address" size="45"><input id="extraAddress" name="extraAddress"><input id="detailAddress" name="detailAddress"></td>
					<td class="b2">주소를 입력해 주세요.</td>
				</tr>
				
				<tr>
					<td class="b1">취미</td>
					<td class="b2">인터넷<input type="checkbox" name="hobby" value="인터넷">
					여행<input type="checkbox" name="hobby" value="여행">
					게임<input type="checkbox" name="hobby" value="게임">
					영화<input type="checkbox" name="hobby" value="영화">
					운동<input type="checkbox" name="hobby" value="운동"></td>
					<td class="b2">취미를 선택해 주세요.</td>
				</tr>
				<tr>
					<td class="b1">선택</td>
					<td class="b2"><select name="visit">
					<option value="0" selected>선택하세요.
					<option value="학부생">학부생
					<option value="대학원생">대학원생
					<option value="직원">직원
					<option value="방문자">방문자
					</select></td>
					<td class="b2">선택해 주세요.</td>
				</tr>
				<tr>
					<td class="c" colspan="3">
						<input type="button" value="회원가입" onclick="inputCheck()">
						&nbsp; &nbsp; 
						<input type="reset" value="다시쓰기">
						&nbsp; &nbsp;
						<input type="button" value="로그인" onClick="javascript:location.href='login.jsp'">
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
<%@ include file = "footer.jsp" %>
</body>
</html>