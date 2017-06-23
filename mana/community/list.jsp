<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>

<%
	final int ROWSIZE = 7; // 한 페이지에 보일 게시물 수
	final int BLOCK = 5;   // 아래에 보일 페이지 최대개수 1~5 / 6~10 / 11~15 5개씩 고정
	
	int pg = 1; //기본 페이지값
	
	if(request.getParameter("pg") != null) {  //받아온 페이지값이 있을 때, 다른 페이지 일 때
		pg = Integer.parseInt(request.getParameter("pg")); // pg값을 저장
	}
	
	int start = (pg*ROWSIZE) - (ROWSIZE-1); // 해당페이지에서 시작번호(step2)
	int end = (pg*ROWSIZE); // 해당페이지에서 끝번호(step2);
	
	int allPage = 0; // 전체 페이지 수
	
	int startPage = ((pg-1)/BLOCK*BLOCK) + 1; // 시작블럭숫자 (1~5페이지일경우 1, 6~10일경우 6)
	int endPage = ((pg-1)/BLOCK*BLOCK)+BLOCK; // 끝 블럭 숫자 (1~5일 경우 5, 6~10일 경우 10)
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
	right: 170px;
	
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
	* { margin: 0; padding: 0; }
	li { list-style: none; }
	a { text-decoration: none; }
	a:hover { text-decoration: none; }
	a:active { text-decoration: none; }
	a:link { text-decoration: none; }
	a:visited { text-decoration: none; }
	body { width: 772px; margin: 0 auto; background: #F9F9F9; }
	
	.new { width: 30px; color: #FF5E00; font-size: 12px; }
	
	.tb { margin-top: 50px; }
	
	/* tr header */
	.tr-hdr {
		height: 40px;
		background: #3fe5e8;
       background-image: -webkit-linear-gradient(top, #3fe5e8, #aee8e5);
       background-image: -moz-linear-gradient(top, #3fe5e8, #aee8e5);
       
       text-align: center;
	}
	
	.td-hdr {
		height: 100%;
		
		font-weight: bold;
		color: #fff;
		line-height: 40px;
	}
	
	
	.tr-sub {
		color: #121212;
		background: #fff;
	}
	.tr-sub:hover {
		background: #D4F4FA;
		opacity: 0.3;
		color: #ED006D;
	}
	
	.tr-sub > td:nth-of-type(2) {
		display: block;
		width: 374px; height: 32px;
		line-height: 32px;
		overflow: hidden;
	}
	
	.tr-sub > td:nth-of-type(2) span {
		display: block;
		height: 100%;
		float: left;
		
		line-height: 32px;
	}
	
	.title { 
		width: 344px;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;		
	}
	
	.tr-sub > td:nth-of-type(3) > span {
		display: block;
		width: 112px;
		height: 100%;
		
		line-height: 32px;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;	
	}
	
	.pg-ing > span {
		color: #FF73B8;
	}
	
	.pg-ing > a {
		color: #4C4C4C;
	}
	
	.btn {
		width: 160px; height: 48px;
		
		margin-top: 25px;
  		padding: 10px 20px 10px 20px;		
		 
		-webkit-box-shadow: 0px 1px 3px #666666;
		-moz-box-shadow: 0px 1px 3px #666666;
		box-shadow: 0px 1px 3px #666666;
		
		-webkit-border-radius: 18px;
		-moz-border-radius: 18px;
		border-radius: 18px;
		
		font-family: 'Roboto', sans-serif;
		color: #ffffff;
		font-size: 20px;
		font-weight: bold;
		text-align: center;
		line-height: 24px;
		border: none;
  
		background: #3fe5e8;
		background-image: -webkit-linear-gradient(top, #3fe5e8, #aee8e5);
		background-image: -moz-linear-gradient(top, #3fe5e8, #aee8e5);
	}
	.btn:hover {
		background: #3cb0fd;
		background-image: -webkit-linear-gradient(top, #3cb0fd, #3498db);
		background-image: -moz-linear-gradient(top, #3cb0fd, #3498db);
		
		color: #fff;
	}	
	.btn:active { outline: none; color: #fff; }
	.btn:link { outline: none; color: #fff; }
	.btn:visited { outline: none; color: #fff; }
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
<%
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/manabase";
	String id = "root";
	String pass = "nawy8476*-";
	int total = 0;
	
	try {
		Connection conn = DriverManager.getConnection(url,id,pass);
		Statement stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		String sql = "";

		String sqlCount = "SELECT COUNT(*) FROM mboard";
		ResultSet rs = stmt.executeQuery(sqlCount);
		
		if(rs.next()){
			total = rs.getInt(1);
		}
		
		int sort = 1;
		String sqlSort = "SELECT num FROM mboard order by ref desc, step asc";
		rs = stmt.executeQuery(sqlSort);
		
		while(rs.next()){
			int stepNum = rs.getInt(1);
			sql = "UPDATE mboard SET STEP2=" + sort + " where NUM=" +stepNum;
		 	stmt1.executeUpdate(sql);
		 	sort++;
		}
		
		allPage = (int)Math.ceil(total/(double)ROWSIZE);
		
		if(endPage > allPage) {
			endPage = allPage;
		}
		
		String sqlList = "SELECT NUM, USERNAME, TITLE, TIME, HIT, INDENT from mboard where STEP2 >="+start + " and STEP2 <= "+ end +" order by step2 asc";
		rs = stmt.executeQuery(sqlList);
			
%>
	<table class="tb" width="100%" cellpadding="0" cellspacing="0">
		<tr class="tr-hdr">
			<td class="td-hdr" style="width: 65px;">번호</td>
			<td class="td-hdr" style="width: 320px;">제목</td>
			<td class="td-hdr" style="width: 105px;">작성자</td>
			<td class="td-hdr" style="width: 100px;">작성일</td>
			<td class="td-hdr" style="width: 70px;">조회수</td>
		</tr>
<%
	if(total==0) {
%>
	 		<tr align="center" bgcolor="#FFFFFF" height="30">
	 	   <td colspan="6">등록된 글이 없습니다.</td>
	 	  </tr>
<%
	 	} else {
	 		
		while(rs.next()) {
			int idx = rs.getInt(1);
			String name = rs.getString(2);
			String title = rs.getString(3);
			String time = rs.getString(4);
			int hit = rs.getInt(5);
			int indent = rs.getInt(6);
			
			Date date = new Date();
			SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
			String year = (String)simpleDate.format(date);
			String yea = time.substring(0, 10);
		
%>
		<tr class="tr-sub" height="32" align="center" onclick="javascript:move(<%=idx %>)">
			<td><%=idx%></td>
			<td align="left">
			<%
				for(int j=0; j<indent; j++) {
			%>
			&nbsp;&nbsp;&nbsp;
			<%
				}
				if(indent!=0) {
			%>  <span>┗▶</span>
			<%
				}
				if(year.equals(yea)) {
			%>
			<span class="new">new</span>
			<%
				}
			%>
			<span class="title"><%=title %></span>
			</td>
			<td align="center"><span><%=name %></span></td>
			<td align="center"><%=yea%></td>
			<td align="center"><%=hit %></td>
		</tr>
		<tr height="1" bgcolor="#D2D2D2"><td colspan="5"></td></tr>
		<% 
				}
			} 
			rs.close();
			stmt.close();
			conn.close();
		} catch(SQLException e) {
			out.println( e.toString() );
		}
		%>
		<tr height="2" bgcolor="#82B5DF"><td colspan="5" width="660"></td></tr>
	</table>
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr><td colspan="4" height="15"></td></tr>
		<tr>
			<td class="pg-ing" align="center">
				<%
					if(pg>BLOCK) {
				%>
					<a href="list.jsp?pg=1"><b>[ 처음 ]&nbsp;</b></a>
					<a href="list.jsp?pg=<%=startPage-1%>"><b>[ 이전 ]&nbsp;</b></a>
				<%
					}
				%>
				
				<%
					for(int i=startPage; i<= endPage; i++) {
						if(i==pg) {
				%>
					<span><b>[<%=i %>]</b></span>
				<%
						} else {
				%>
					<a href="list.jsp?pg=<%=i %>"><b>[<%=i %>]</b></a>
				<%
						}
					}
				%>
				
				<%
					if(endPage<allPage) {
				%>
					<a href="list.jsp?pg=<%=endPage+1 %>"><b>&nbsp;[ 다음 ]</b></a>
					<a href="list.jsp?pg=<%=allPage %>"><b>&nbsp;[ 마지막 ]</b></a>
				<%
					}
				%>
				</td>
				</tr>
		<tr align="center">
			<td><input class="btn" type="button" value="글쓰기" OnClick="window.location='write.jsp'"></td>
		</tr>
	</table>
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
function move(obj) {
	var idx = obj;
	window.location.href = "view.jsp?idx=" + idx;
}
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
</script>