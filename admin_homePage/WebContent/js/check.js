/**
 * 
 */
function check(){
	if(document.postFrm.pass.value == ""){
		alert("비밀번호를 입력해 주세요");
		document.postFrm.pass.focus();
		return;
	}
	document.postFrm.submit();
}