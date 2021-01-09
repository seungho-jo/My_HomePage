/**
 * 
 */
function inputCheck(){
	if(document.regFrm.id.value==""){
		alert("아이디를 입력해 주세요");
		document.regFfm.id.focus();
		return;
	}
	if(document.regFrm.pwd.value==""){
		alert("비밀번호를 입력해 주세요");
		document.regFfm.pwd.focus();
		return;
	}
	if(document.regFrm.repwd.value==""){
		alert("비밀번호를 확인해 주세요");
		document.regFfm.repwd.focus();
		return;
	}
	if(document.regFrm.pwd.value != document.regFrm.repwd.value){
		alert("비밀번호가 일치하지 않습니다");
		document.regFfm.repwd.value="";
		document.regFfm.repwd.focus();
		return;
	}
	if(document.regFrm.name.value ==""){
		alert("이름을 입력해 주세요");
		document.regFfm.name.focus();
		return;
	}
	if(document.regFrm.birthday.value ==""){
		alert("생년월일을 입력해 주세요");
		document.regFfm.birthday.focus();
		return;
	}
	if(document.regFrm.email.value ==""){
		alert("이메일을 입력해 주세요");
		document.regFfm.email.focus();
		return;
	}
	var str = document.regFrm.email.value;
	var atPos = str.indexOf('@');
	var atLastPos = str.lastIndexOf('@');
	var dotPos = str.indexOf('.');
	var spacePos = str.indexOf(' ');
	var commaPos = str.indexOf(',');
	var eMailSize = str.length;
	if(atPos > 1 && atPos == atLastPos && dotPos > 3 && spacePos == -1 && commaPos == -1 && atPos + 1 < dotPos && dotPos + 1 <eMailSize);
	else{
		alert('E-mail주소 형식이 잘못되었습니다. \n\r 다시 입력해 주세요!');
		document.regFfm.email.focus();
		return;
	}
	if(document.regFrm.zipcode.value == ""){
		alert("우편번호를 검색해 주세요");
		return;
	}
	if(document.regFrm.visit.value == "0"){
		alert("직업을 검색해 주세요");
		document.regFfm.visit.focus();
		return;
	}
	document.regFrm.submit();
}
function win_close(){
	self.close();
}