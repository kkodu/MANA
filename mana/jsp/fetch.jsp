<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% 
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/manabase", "root", "nawy8476*-");
	Statement st = conn.createStatement();
	
	String sql = "SELECT id, PASSWORD, NAME, EMAIL, NICKNAME FROM member WHERE id = " + id;
	ResultSet rs = st.executeQuery(sql);
	
	// generate the result in the form of the JSON array
	String list = "[";
	int cnt = 0;
	while(rs.next()) {
		list += rs.getString(1) + ", ";
		list += rs.getString(2) + ", ";
		list += rs.getString(3) + ", ";
		list += rs.getString(4) + ", ";
		list += rs.getString(5);
	}
	list += "]";

	out.print(list);
	
	rs.close();
	st.close();
	conn.close();
%>