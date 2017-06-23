<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	if (session.isNew() || session.getAttribute("id") == null) {
		out.println("NA");
	}
	else {
		out.println(session.getAttribute("id"));
	}
%>