<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/manabase?useUnicode=true&characterEncoding=UTF-8";
	String id = "root";
	String pass = "nawy8476*-";
	String password = null;
	int idx = Integer.parseInt(request.getParameter("idx"));
	String passw = request.getParameter("password");
	
	try {
			Connection conn = DriverManager.getConnection(url, id, pass);
			Statement stmt = conn.createStatement();
			
			String sql = "SELECT password from mboard WHERE num=" + idx;
			ResultSet rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				password = rs.getString(1);
			}
			
			if(password.equals(passw)) {
				sql = "DELETE FROM mboard WHERE num=" + idx;
				stmt.executeUpdate(sql);
				
				sql = "ALTER TABLE mboard AUTO_INCREMENT= 1";
				stmt.executeUpdate(sql);
				
				sql = "UPDATE mboard SET num=num-1 where num>" + idx;
				stmt.executeUpdate(sql);
				
				sql = "ALTER TABLE mboard AUTO_INCREMENT= 1";
				stmt.executeUpdate(sql);
%>

<script language=javascript>
	self.window.alert("해당 글을 삭제하였습니다.");
	location.href="list.jsp";
</script>

<%
	rs.close();
	stmt.close();
	conn.close();
	
	} else {
%>

<script language=javascript>
	self.window.alert("비밀번호를 틀렸습니다.");
	location.href="javascript:history.back()";
</script>

<%
		}
	} catch(SQLException e) {
			out.println(e.toString());
	}
%>

		