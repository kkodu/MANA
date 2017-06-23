<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/manabase?useUnicode=true&characterEncoding=UTF-8";
	String id = "root";
	String pass = "nawy8476*-";
	String password = "";
	
		try {
		
				 int idx = Integer.parseInt(request.getParameter("idx"));
				 String title = request.getParameter("title");
				 String memo = request.getParameter("memo");
				 String passw = request.getParameter("password");
				 
				 Connection conn = DriverManager.getConnection(url, id, pass);
				 Statement stmt = conn.createStatement();
				 
				 String sql = "SELECT password FROM mboard WHERE num=" + idx;
				 ResultSet rs = stmt.executeQuery(sql);
				 
				 if(rs.next()) {
					 password = rs.getString(1);
				 }
				 
				 if(password.equals(passw)) {
					 sql = "UPDATE mboard SET title='" + title + "', memo='" + memo + "' WHERE num=" + idx; 
							 stmt.executeUpdate(sql);
%>
<script language=javascript>
	self.window.alert("글이 수정되었습니다.");
	location.href="view.jsp?idx=<%=idx%>";
</script>
<%
	rs.close();
	stmt.close();
	conn.close();
	
				 } else {
%>
<script language = javascript>
	self.window.alert("비밀번호를 틀렸습니다.");
	location.href="javascript:history.back()";
</script>
<%
				 }
		} catch (SQLException e) {
			out.println(e.toString());
		}
%>
<html>
<head>
<title>Insert title here</title>
</head>
<body>

</body>
</html>