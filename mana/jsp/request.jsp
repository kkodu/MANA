<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%request.setCharacterEncoding("UTF-8"); %>  
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/style.css">
<meta charset="UTF-8">
<title>문의 사항</title>
</head>
<body>


<%

	Class.forName("com.mysql.jdbc.Driver"); //드라이브 로드 
	Connection conn = DriverManager.getConnection(   //디비 연결, 원래 컨넥션풀이라는 것을 써야함 미리 컨넥션을 만들어놓는것(더빠름)
		"jdbc:mysql://localhost:3306/manastory?useUnicode=true&characterEncoding=utf8",
		"root","nawy8476*-");
	Statement st = conn.createStatement();  //여기 까지 똑같음.
	
	String sql = "INSERT INTO request(rq) VALUES('"+request.getParameter("QA")+"')";
	sql.replaceAll("<br>", "\n");
	st.executeUpdate(sql);
	
	st.close();
	conn.close();

%>
 
<script type="text/javascript">
	window.location.href="../main.html";
</script>
</body>
</html>
