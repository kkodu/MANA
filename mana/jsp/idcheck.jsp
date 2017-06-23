<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	Class.forName("com.mysql.jdbc.Driver");

	String url = "jdbc:mysql://localhost:3306/manabase";
	
	int id = Integer.parseInt(request.getParameter("uid"));
	String str = "";
	
	try {
		
		Connection con = DriverManager.getConnection(url, "root", "nawy8476*-");
		Statement stmt = con.createStatement();
			
		String sql = "SELECT id FROM member WHERE id = " + id;
		ResultSet rs = stmt.executeQuery(sql);
		
		if(rs.next()) {
			str = "NO";
			out.print(str);
		}
		else {
			str = "YES";
			out.print(str);
		}

		rs.close();
		stmt.close();
		con.close();
	
	} catch (SQLException e) {
		out.print(e.toString());
	}
	
%>