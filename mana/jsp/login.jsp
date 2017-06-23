<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% 
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pass = request.getParameter("upass");

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/manabase", "root", "nawy8476*-");
	Statement st = conn.createStatement();
	
	String sql = "SELECT id, PASSWORD FROM member WHERE id = " + id;
	ResultSet rs = st.executeQuery(sql);
	if (!rs.next()) {
		out.print("NA");
	}
	else {
		String dbpass = rs.getString("PASSWORD");
		if (pass.equals(dbpass) == false) {
			out.print("PS");
		}
		else {
			// session handling for login 
			// NOTE THAT session check is done by calling session.jsp in each html ...
			if (session.isNew() || session.getAttribute("id") == null) {
				session.setAttribute("id", id);
				session.setMaxInactiveInterval(24*60*60);
			}
			out.print("OK");
		}
	}
	
	rs.close();
	st.close();
	conn.close();
%>