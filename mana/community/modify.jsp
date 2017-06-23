<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/manabase?useUnicode=true&characterEncoding=UTF-8";
	String id = "root";
	String pass = "nawy8476*-";
	
	String name = "";
	String password = "";
	String title = "";
	String memo = "";
	int idx = Integer.parseInt(request.getParameter("idx"));
	
	try {
			Connection conn = DriverManager.getConnection(url, id, pass);
			Statement stmt = conn.createStatement();
			
			String sql = "SELECT username, password, title, memo FROM mboard WHERE num=" + idx;
			ResultSet rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				name = rs.getString(1);
				password = rs.getString(2);
				title = rs.getString(3);
				memo = rs.getString(4);
			}
		} catch (SQLException e) {
			out.println( e.toString());
		}
	
%>

<html>
<head>
<title>MANA Community Board</title>
<link href="https://fonts.googleapis.com/css?family=Bungee+Shade" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<style>
	@media screen and (max-width : 772px) {
	    * { margin: 0px; padding: 0px; }
	    html, body { max-width: 772px; height: 100%; }
	    body { position: relative; }
	    #main_wrap { margin-top: 40px; }
	    #main_header { display: none; }
	    #res_toggle_wrap { display: block !important;  }
	    #main_wrap {
		-moz-transition: margin 300ms cubic-bezier(0.17, 0.04, 0.03, 0.94);
		transition: margin 300ms cubic-bezier(0.17, 0.04, 0.03, 0.94);
	    }
       #res_toggle:checked ~ #main_wrap {
                margin-top: 420px;
        }
        .tb {
        	border-left: 0px !important;
        	border-right: 0px !important;
        }
	}
	
a.hdr-left {
	width: 110px;
	left: 20px;
	
	color: #ffffff;
	font-size: 25px;
	font-weight: bold;
	line-height: 59px;
	text-align: center;
}

/* 로그인 혹은 아이디 */
a.hdr-center {
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
a.hdr-right-center {
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
</style>
<style>
	#res_toggle { display: none; }
	#res_toggle_wrap { display: none; }

	#res_main_header {
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

	#res_main_header > a, #res_main_header > label {
	    display: block;
	    height: 100%;
	    position: absolute;
	}

	#res_main_header > a.res_left {
	    width: 110px;
	    left: 20px;

	    color: #ffffff;
	    font-size: 25px;
	    font-weight: bold;
	    line-height: 59px;
	    text-align: center;
	}

	#res_main_header > a.res_right_center {
	    width: 80px;
	    right: 110px;

	    color: #ffffff;
	    font-size: 16px;
	    font-weight: bold;
	    line-height: 59px;
	    text-align: center;
	}

	#res_main_header > label.res_right {
	    right: 30px;
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
	#res_toggle { display: none; cursor: pointer; }
	#res_toggle + #res_toggle_wrap > #res_main_header > label:after {
	    content:"더 보기"
	}
	#res_toggle_wrap { position: relative; }
	#res_toggle_gnb_wrap {
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

	#res_toggle:checked + #res_toggle_wrap > #res_toggle_gnb_wrap {
	    top: 60px;
	}
	
	#res_toggle:checked + #res_toggle_wrap > #res_main_header > label:after {
	    content:"닫기"
	}

	#res_toggle_gnb > ul > li > a {
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
</style>
<style>
	#main_header {
	    position: relative;
	    width: 772px !important;
	    height: 90px;
	    margin-bottom: 30px;
	}

	#main_header > h1.h_logo {
	    position: absolute;
	    left: 5px; top: 5px;

	}

	#main_header > h1.h_logo > a {
	    background-image: -webkit-gradient( linear, left top, right top, color-stop(0, #24FCFF), color-stop(0.5, #48FFFF), color-stop(1, #00C6ED) );
  	    background-image: gradient( linear, left top, right top, color-stop(0, #24FCFF), color-stop(0.5, #48FFFF), color-stop(1, #00C6ED) );
  	    
	    color:transparent;

  	    -webkit-background-clip: text;
	    -moz-background-clip: text;
  	    background-clip: text;

            font-family: 'Bungee Shade', cursive; 
	    font-size: 60px;
	}
	#main_header >h1.h_logo > a:hover { opacity: 1.0; }

	#main_header > h1.h_logo > span {
	    display: block;
	    margin-right: 4px;
	    margin-top: 1px;

	    color: #FF48C7;
	    font-family: 'Roboto', sans-serif;
	    font-size: 14px;
	    font-weight: bold;
	    text-align: right;
	}
	
	#main_header > div.lgn_form {
	    position: absolute;
	    top: 5px; right: 5px;
	    overflow: hidden;
	}

	#main_header >div.lgn_form > div {
	    float: left;
	
	    padding: 0 3px;
	}
	#main_header > div.lgn_form > div > a {
	    color: black;
	}
	#main_header > div.lgn_form > div > button {
	    width: 52px;
	    height: 20px;
	    border-style: none;
	    color: black;
	    background-color: #F9F9F9;
	}
</style>
<style>
	* { padding: 0; margin: 0; }
	a { text-decoration: none; }
	a:hover { text-decoration: none; }
	a:active { text-decoration: none; }
	a:link { text-decoration: none; }
	li { list-style: none; }
	body { width: 772px; margin: 0 auto; background: #F9F9F9; }
	
	.tb {
		margin-top: 50px;
	 	border: 2px solid #008299; 
	 	border-radius: 10px;
	 	background: #fff;
	 }
	
	.hdr-tr {
		height: 70px;
		
		font-size: 16px;
		font-weight: bold;
	}
	
	.input {
		width: 500px;
		height: 40px;
		padding: 5px;
	}
	.input:focus {
		padding: 10px;
		border: 1px solid;
		border-color: rgba(82, 168, 236, 0.8);
		border-radius: 5px;
		outline: 0;
		outline: thin dotted \9;
		/* IE6-9 */
		
		-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px rgba(82, 168, 236, 0.6);
		-moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px rgba(82, 168, 236, 0.6);
		box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px rgba(82, 168, 236, 0.6);	
	}
	
	#hdr-memo { height: 412px; }
	
	.memo {
		width: 100%; height: 400px;
		padding: 16px;
		
		background: #ede6ed;
		background-image: -webkit-linear-gradient(top, #ede6ed, #f2f4f5);
		background-image: -moz-linear-gradient(top, #ede6ed, #f2f4f5);
		border: 1px solid #A6A6A6;
		border-radius: 10px;
		
		font-family: 'Roboto', sans-serif;
		
	}
	.memo:focus {
		padding: 16px;
		border: 1px solid;
		border-color: rgba(82, 168, 236, 0.8);
		border-radius: 5px;
		outline: 0;
		outline: thin dotted \9;
		/* IE6-9 */
		
		-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px rgba(82, 168, 236, 0.6);
		-moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px rgba(82, 168, 236, 0.6);
		box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075), 0 0 8px rgba(82, 168, 236, 0.6);		
	}

	.btn {
		width: 140px; height: 40px;
		padding: 5px;
		margin-right: 5px;
		
		color: #212121;
		font-size: 14px;
		font-weight: bold;
	}
	.btn:nth-of-type(2) {
		margin-right: 0px;
	}
	.btn:hover { opacity: 0.4; background: #474747; color: #fff; }
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="../js/core.js"></script>
</head>
<body>
   <input id="res_toggle" type="checkbox" />
    <div id="res_toggle_wrap">
        <div id="res_main_header">
        <a class="hdr-left" href="../main.html">MANA</a>
        <a id="login-case" class="hdr-center" href="../login.html">로그인</a>
        <a id="logout-case" class="hdr-right-center" onclick="logout()">로그아웃</a>
            <label class="res_right" for="res_toggle" onclick=" "></label>
        </div>
        <div id="res_toggle_gnb_wrap">
            <div id="res_toggle_gnb">
                <ul>
	                <li><a href="../aboutus.html">About us</a></li>
	                <li><a href="../map.html">Map</a></li>
	                <li><a href="../booklist.html">Book List</a></li>
	                <li><a href="list.jsp">Community</a></li>
	                <li><a href="../event.html">Event</a></li>
	                <li><a href="../request.html">Story Request</a></li>
                </ul>
            </div>
        </div>
    </div>
<div id="main_wrap">  
    <div id="main_header">
	<h1 class="h_logo">
	    <a href="../main.html">MANA</a>
	    <span>마음을 나누는 공간</span>
	</h1>
	<div class="lgn_form">
	    <div><a id="login-case-2" href="../login.html">로그인</a></div>
	    <div><button id="signup-case" type="button" onclick="location.href = '../signup.html'">회원가입</button></div>
	    <div><a href="../request.html">고객센터</a></div>
	</div>
	</div>
<form name=modifyform method=post action="modify_ok.jsp?idx=<%=idx%>">
	<table class="tb" width="100%">
		<tr>
			<td>
			    <table width="100%">
			    	<tr height="10"></tr>
			    	<tr class="hdr-tr">					
			    		<td>&nbsp;</td>
			    		<td align="center">&nbsp;&nbsp;제목&nbsp;&nbsp;</td>
			    		<td><input class="input" type="text" name="title" size="50" maxlength="50" value="<%=title%>" autofocus></td>
			    		<td>&nbsp;</td>
			    	</tr>
			    	<tr height="2" bgcolor="#dddddd"><td colspan="4" width="100%"></td></tr>
			    	<tr class="hdr-tr">
			    		<td>&nbsp;</td>
			    		<td align="center">&nbsp;&nbsp;작성자&nbsp;&nbsp;</td>
			    		<td>&nbsp;<%=name%><input type="hidden" name="name" size="50" maxlength="50" value="<%=name%>"></td>
      					<td>&nbsp;</td>
     				</tr>
      				<tr height="2" bgcolor="#dddddd"><td colspan="4" width="100%"></td></tr>
    				<tr class="hdr-tr">
      					<td>&nbsp;</td>
      					<td align="center">&nbsp;&nbsp;비밀번호&nbsp;&nbsp;</td>
      					<td><input class="input" type="password" name="password" size="50" maxlength="50" id="pass"></td>
      					<td>&nbsp;</td>
     				</tr>
     				<tr height="2" bgcolor="#dddddd"><td colspan="4" width="100%"></td></tr>
     				<tr id="hdr-memo" class="hdr-tr">
      					<td>&nbsp;</td>
      					<td align="center">&nbsp;&nbsp;내용&nbsp;&nbsp;</td>
      					<td><textarea class="memo" name="memo" cols="50" rows="13"><%=memo%></textarea></td>
      					<td>&nbsp;</td>
    				</tr>
     				<tr height="1" bgcolor="#dddddd"><td colspan="4" width="100%"></td></tr>
     				<tr height="3" bgcolor="#82B5DF"><td colspan="4"></td></tr>
     				<tr align="center" height="60">
      					<td>&nbsp;</td>
      					<td colspan="2"><input class="btn" type=button value="수정" OnClick="javascript:modifyCheck();">
       				<input class="btn" type=button value="취소" OnClick="javascript:history.back(-1)">
       				</td>
      					<td>&nbsp;</td>
     				</tr>
    			</table>
   			</td>
 		</tr>
 	</table>
</form>
</div>
</body>
</html>

<script type="text/javascript">
$(document).ready(function() {
	AJAX.call("../jsp/session.jsp", null, function(data) {
		var id = data.trim();
		if (id == "NA") {
			window.location.href = "../login.html";
		}
		else {
			document.getElementById('login-case').innerHTML = id + "님";
			document.getElementById('login-case').onclick = function(e) { location.href='../mypage.html'; }
			document.getElementById('logout-case').style.display = 'block';
			
			document.getElementById('login-case-2').innerHTML = id + "님";
			document.getElementById('login-case-2').onclick = function(e) { location.href='../mypage.html'; }
			document.getElementById('signup-case').innerHTML = "로그아웃";
			document.getElementById('signup-case').onclick = function(e) { logout(); }
		}
	});
});
function logout() {
	if(confirm("로그아웃하시겠습니까?") == true) {
		/* 먼저 로그아웃 리퀘스트를 날리고 성공적으로 완료한 후 function을 실행, 즉 로그아웃 완료 후 로그인 페이지로 이동 */
		AJAX.call("../jsp/logout.jsp", null, function(data) {
			window.location.href = "../login.html"
		});
		
		/* AJAX.call("jsp/logout.jsp");  비동기적이기 때문에 로그아웃 리퀘스트를 날리고, 로그인페이지로 이동, 로그아웃이 되기 전에 로그인페이지로 이동하기 때문에 익셉션이 일어남*/
		/* window.location.href = "login.html" */
	}
}
function modifyCheck()
{
	var form = document.modifyform;
	
	if( !form.password.value )
	{
		alert("비밀번호를 적어주세요");
		return;
	}
	
	if( !form.title.value )
	{
		alert("제목을 적어주세요");
		form.title.focus();
		return;
	}
	
	if( !form.memo.value ) 
	{
		alert("내용을 적어주세요");
		form.memo.focus();
		return;
	}
	
	form.submit();
}
</script>