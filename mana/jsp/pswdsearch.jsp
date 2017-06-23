<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");

	Class.forName("com.mysql.jdbc.Driver");

	String url = "jdbc:mysql://localhost:3306/manabase";
	
	int id = Integer.parseInt(request.getParameter("uid"));
	
	try {
		
		Connection con = DriverManager.getConnection(url, "root", "nawy8476*-");
		Statement stmt = con.createStatement();
			
		String sql = "SELECT PASSWORD FROM member WHERE id = " + id;
		ResultSet rs = stmt.executeQuery(sql);
		
		if(rs.next() == false) {
			out.println("NA");
		}
		else {
			out.println(rs.getString(1));
		}

		rs.close();
		stmt.close();
		con.close();
	
	} catch (SQLException e) {
		out.print(e.toString());
	}
	
%>