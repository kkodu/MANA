<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  

<!DOCTYPE html>
<html>
<meta name=viewport content="width=device-width, initial-scale=1, user-scalable=0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Gloria+Hallelujah" rel="stylesheet"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="css/core.css">
<link rel="stylesheet" href="css/core2.css" media="only screen and (min-width:800px)">
<title>MANA-1minute</title>
<style>
body {
	margin: 0;
	background: #FCFCFC;
}
li { list-style: none; list-style-type: none; }
ul { padding: 0px; }
a {
	text-decoration: none;
	-webkit-transition: all 150ms ease;
	-moz-transition: all 150ms ease;
	-ms-transition: all 150ms ease;
	-o-transition: all 150ms ease;
	transition: all 150ms ease;
}
a:hover {
	-ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=50)"; /* IE 8 */
	filter: alpha(opacity=50); /* IE7 */
	opacity: 0.9;
	
	text-decoration: none;
}
a:active { text-decoration: none; }
a:link { text-decoration: none; }
a:visited { text-decoration: none; }

.mtop-10 { margin-top: 10px;}
.mtop-20 { margin-top: 20px;}
.mtop-30 { margin-top: 30px;}

.mbot-10 { margin-bottom: 10px;}
.mbot-20 { margin-bottom: 20px;}
.mbot-30 { margin-bottom: 30px;}

@media (max-width: 485px) {
	#wrap {
		width: 485px !important;
	}
}
#content-wrap {
	width: 90%;
	margin: 0 auto;
	padding: 6% 1% 1% 5%;
	-moz-transition: margin 300ms cubic-bezier(0.17, 0.04, 0.03, 0.94);
	transition: margin 300ms cubic-bezier(0.17, 0.04, 0.03, 0.94);
	font-size: 30px;
	font-family: 'Gloria Hallelujah', cursive;
	font-style: italic;
	text-align: center;
	
}
#hdr-toggle:checked ~ #content-wrap {
	margin-top: 420px;
}

#hdr-toggle { display: none; }
#hdr-wrap { position: relative; }

#main-hdr {
	width: 100%;
	height: 60px;
	
	position: relative;
	line-height: 60px;
	
	z-index: 9999;
	
	border-bottom: 1px solid #e5e5e5;
	
	
	-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
	-moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
	box-shadow: 0 1px 2px rgba(0,0,0,.05);
	
	background: #3fe5e8;
	background-image: -webkit-linear-gradient(top, #3fe5e8, #aee8e5);
	background-image: -moz-linear-gradient(top, #3fe5e8, #aee8e5);
	background-image: -ms-linear-gradient(top, #3fe5e8, #aee8e5);
	background-image: -o-linear-gradient(top, #3fe5e8, #aee8e5);
	background-image: linear-gradient(to bottom, #3fe5e8, #aee8e5);
}

#main-hdr > a, #main-hdr > label {
	display: block;
	height: 100%;
	position: absolute;
}

#main-hdr > a.hdr-left {
	width: 110px;
	left: 20px;
	
	color: #ffffff;
	font-size: 25px;
	font-weight: bold;
	line-height: 59px;
	text-align: center;
}

/* 로그인 혹은 아이디 */
#main-hdr > a.hdr-center {
	width: 80px;
	right: 180px;
	
	color: #ffffff;
	font-size: 16px;
	font-weight: bold;
	line-height: 59px;
	text-align: center;
	cursor: pointer
}

/* 로그아웃 */
#main-hdr > a.hdr-right-center {
	display: none;
	width: 80px;
	right: 100px;
	
	color: #ffffff;
	font-size: 16px;
	font-weight: bold;
	line-height: 59px;
	text-align: center;
	cursor: pointer;
}

/* 드롭 다운 */
#main-hdr > label.hdr-right {
	right: 20px;
	width: 80px;
	
	color: #ffffff;
	font-size: 18px;
	font-weight: bold;
	text-align: center;
	line-height: 59px;
	cursor: pointer;
	
	-moz-transition: all 500ms ease;
	transition: all 500ms ease;
}
#hdr-toggle { display: none; cursor: pointer; }
#hdr-toggle + #hdr-wrap > #main-hdr > label:after {
	content:"더 보기"
}

#hdr-gnb-wrap {
	position: absolute;
	top: -570px;
	
	width: 100%;
	max-height: 360px;
	
	-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.05);
	-moz-box-shadow: 0 1px 2px rgba(0,0,0,.05);
	box-shadow: 0 1px 2px rgba(0,0,0,.05);
	
	background: #3fe5e8;
	background-image: -webkit-linear-gradient(top, #3fe5e8, #aee8e5);
	background-image: -moz-linear-gradient(top, #3fe5e8, #aee8e5);
	background-image: -ms-linear-gradient(top, #3fe5e8, #aee8e5);
	background-image: -o-linear-gradient(top, #3fe5e8, #aee8e5);
	background-image: linear-gradient(to bottom, #3fe5e8, #aee8e5);
	
	-moz-transition: top 300ms cubic-bezier(0.17, 0.04, 0.03, 0.94);
	transition: top 300ms cubic-bezier(0.17, 0.04, 0.03, 0.94);
}

#hdr-toggle:checked + #hdr-wrap > #hdr-gnb-wrap {
	top: 60px;
}

#hdr-toggle:checked + #hdr-wrap > #main-hdr > label:after {
	content:"닫기"
}

#hdr-gnb > ul > li > a {
	display: block;
	width: 100%;
	height: 60px;
	padding: 10px;
	padding-left: 30px;
	line-height: 40px;
	
	color: #ffffff;
	font-size: 18px;
	font-weight: bold;
	
	border: 1px solid #e5e5e5;
}
.refresh{
	float: Left;
	width: 100%;
	padding: 15px;
	box-sizing: border-box;
	font-size: 1.1em;
	color : white;
	font-weight: bold;  /*굵게*/
	text-align: center;
	border: 1px solid #e7e7e7;
	position : fixed;
	bottom:0px;
	background: #3fe5e8;
	background-image: -webkit-linear-gradient(top, #3fe5e8, #aee8e5);
	background-image: -moz-linear-gradient(top, #3fe5e8, #aee8e5);
	background-image: -ms-linear-gradient(top, #3fe5e8, #aee8e5);
	background-image: -o-linear-gradient(top, #3fe5e8, #aee8e5);
	background-image: linear-gradient(to bottom, #3fe5e8, #aee8e5);
	cursor : pointer;
}
.refresh:hover{
	background: blue;
	opacity: 0.6;
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="js/core.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	AJAX.call("jsp/session.jsp", null, function(data) {
		var id = data.trim();
		if (id == "NA") {
			window.location.href = "login.html";
		}
		else {
			document.getElementById('login-case').innerHTML = id + "님";
			document.getElementById('login-case').onclick = function(e) { location.href='mypage.html'; }
			document.getElementById('logout-case').style.display = 'block';
		}
	});
});

function logout() {
	if(confirm("로그아웃하시겠습니까?") == true) {
		/* 먼저 로그아웃 리퀘스트를 날리고 성공적으로 완료한 후 function을 실행, 즉 로그아웃 완료 후 로그인 페이지로 이동 */
		AJAX.call("jsp/logout.jsp", null, function(data) {
			window.location.href = "login.html"
		});
		
		/* AJAX.call("jsp/logout.jsp");  비동기적이기 때문에 로그아웃 리퀘스트를 날리고, 로그인페이지로 이동, 로그아웃이 되기 전에 로그인페이지로 이동하기 때문에 익셉션이 일어남*/
		/* window.location.href = "login.html" */
	}
}
</script>
</head>
<body>
<div id="wrap">
<input id="hdr-toggle" type="checkbox" />
<div id="hdr-wrap">
    <div id="main-hdr">
        <a class="hdr-left" href="main.html">MANA</a>
        <a id="login-case" class="hdr-center" href="login.html">로그인</a>
        <a id="logout-case" class="hdr-right-center" onclick="logout()">로그아웃</a>
        <label class="hdr-right" for="hdr-toggle" onclick=" "></label>
    </div>
    <div id="hdr-gnb-wrap">
        <div id="hdr-gnb">
            <ul>
                <li><a href="aboutus.html">About us</a></li>
                <li><a href="map.html">Map</a></li>
                <li><a href="booklist.html">Book List</a></li>
                <li><a href="community/list.jsp">Community</a></li>
                <li><a href="event.html">Event</a></li>
                <li><a href="request.html">Story Request</a></li>
            </ul>
        </div>
    </div>
</div>
<div id="content-wrap">
<%

	Class.forName("com.mysql.jdbc.Driver"); //드라이브 로드 
	Connection conn = DriverManager.getConnection(   //디비 연결, 원래 컨넥션풀이라는 것을 써야함 미리 컨넥션을 만들어놓는것(더빠름)
		"jdbc:mysql://localhost:3306/manastory",
		"root","nawy8476*-");
	Statement st = conn.createStatement();  //여기 까지 똑같음.
	
	String sql = "SELECT lit FROM 5min order by rand() LIMIT 1";
	
	ResultSet rs = st.executeQuery(sql);
	
	
	while(rs.next()){
		out.println(rs.getString("lit")); 
	}

	st.close();
	conn.close();
	rs.close();	
%>
</div>
<div>
	<input class="refresh" type="text" onclick="location.reload()" value="다른글보기">
</div>
</div>
</body>
</html>