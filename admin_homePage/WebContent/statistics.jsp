<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<jsp:useBean id="bMgr" class="page.BoardMgr" />
<jsp:useBean id="mMgr" class="page.MemberMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
	String[] total = bMgr.getWeek();
	String[] total_member = mMgr.getMemberWeek();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/header.css"/>
<link rel="stylesheet" href="css/footer.css"/>
<link rel="stylesheet" href="css/statistics.css"/>
<link rel="stylesheet" href="css/reset.css"/>
<script src="js/Chart.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div id="main">
<canvas id="myChart" width="400px" height="400px" style="display:inline"></canvas>
<canvas id="myChart2" width="600px" height="400px"></canvas>
</div>

<script type="text/javascript">
var currentDay = new Date();  
var theYear = currentDay.getFullYear();
var theMonth = currentDay.getMonth();
var theDate  = currentDay.getDate();
var theDayOfWeek = currentDay.getDay();
 
var thisWeek = [];
 
for(var i=0; i<7; i++) {
  var resultDay = new Date(theYear, theMonth, theDate + (i - theDayOfWeek));
  var yyyy = resultDay.getFullYear();
  var mm = Number(resultDay.getMonth()) + 1;
  var dd = resultDay.getDate();
 
  mm = String(mm).length === 1 ? '0' + mm : mm;
  dd = String(dd).length === 1 ? '0' + dd : dd;
 
  thisWeek[i] = yyyy + '-' + mm + '-' + dd;
}

var ctx = document.getElementById('myChart').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: ['일', '월', '화', '수', '목', '금', '토'],
        datasets: [{
            label: '회원수',
            data: <%=Arrays.toString(total_member) %>,
            fill: false,
            borderColor: [
            'rgb(51, 153, 255)',
            ],
            pointBackgroundColor:[
            	'rgb(51, 153, 255)',
            	'rgb(51, 153, 255)',
            	'rgb(51, 153, 255)',
            	'rgb(51, 153, 255)',
            	'rgb(51, 153, 255)',
            	'rgb(51, 153, 255)',
            	'rgb(51, 153, 255)',
            	'rgb(51, 153, 255)',
            ],
            borderWidth: 1
        }]
    },
    options: {
		responsive: false,
		scales: {
			yAxes: [{
				ticks: {
					beginAtZero: true
				}
			}]
		},
	}
});
var ctx = document.getElementById('myChart2').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: thisWeek,
        datasets: [{
            label: '게시글 수',
            data: <%=Arrays.toString(total)%>,
            fill: false,
            borderColor: [
            
            ],
            pointBackgroundColor:[
            	'rgb(51, 153, 255)',
            	'rgb(51, 153, 255)',
            	'rgb(51, 153, 255)',
            	'rgb(51, 153, 255)',
            	'rgb(51, 153, 255)',
            	'rgb(51, 153, 255)',
            	'rgb(51, 153, 255)',
            	'rgb(51, 153, 255)',
            ],
            borderWidth: 1
        }]
    },
    options: {
		responsive: false,
		scales: {
			yAxes: [{
				ticks: {
					beginAtZero: true
				}
			}]
		},
	}
});
</script>
<%@ include file = "footer.jsp" %>
</body>
</html>