<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	Class.forName("com.mysql.jdbc.Driver");

	String url = "jdbc:mysql://localhost:3306/manabase";
	
	int id = Integer.parseInt(request.getParameter("uid"));
	String password = request.getParameter("upass");
	String name = request.getParameter("uname");
	String nicknm = request.getParameter("nicknm");
	String email = request.getParameter("umail");
	
	try {
			Connection conn = DriverManager.getConnection(url, "root", "nawy8476*-");
			
			String sql = "INSERT INTO member (id, password, name, email, nickname) VALUES (?,?,?,?,?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, id);
			pstmt.setString(2, password);
			pstmt.setString(3, name);
			pstmt.setString(4, email);
			pstmt.setString(5, nicknm);
			
			pstmt.execute();
			pstmt.close();
			
			conn.close();
	} catch(SQLException e) {
		out.println(e.toString());
	}
%>
