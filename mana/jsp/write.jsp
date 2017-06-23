<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.json.simple.*" %>
<% 
	request.setCharacterEncoding("UTF-8");

	ServletFileUpload sfu = new ServletFileUpload(new DiskFileItemFactory());
	sfu.setSizeMax(16 * 1024 * 1024);
	sfu.setHeaderEncoding("UTF-8"); 
	
	try {
		String id = null, desc = null;
		JSONArray images = new JSONArray();
		
		List items = sfu.parseRequest(request);
		Iterator iter = items.iterator();
		while(iter.hasNext()) {
			FileItem item = (FileItem) iter.next();
			if (item.isFormField()) {
				String name = item.getFieldName();
				String value = item.getString("UTF-8").trim();
				
				if(name.equals("id")) {
					id = value;
				}
				else if(name.equals("desc")) {
					desc = value;
				}
				System.out.println(name + ": " + value);
			}
			else {
				if (id == null) continue;

				// initialze the path to save the image file
				String path = application.getRealPath(File.separator) + "/images"; 
				(new File(path)).mkdirs();
				
				path += "/" + id;
				(new File(path)).mkdirs();

				String filename = item.getName();
				path += "/" + filename; 

				// save the image with the given path
				byte[] data = item.get();
				FileOutputStream fos = new FileOutputStream(path);
				fos.write(data);
				fos.close();

				images.add(filename);

				System.out.println("image: " + filename);
			}
		}
		
		// create an JSON object for the database insertion
		JSONObject jsonobj = new JSONObject();
		jsonobj.put("id", id);
		jsonobj.put("desc", desc);
		jsonobj.put("images", images);
		
		// database insertion logic
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/manabase", "root", "nawy8476*-");
		Statement st = conn.createStatement();
		
		String sql = "INSERT INTO feed(id, jsonobj) VALUES(" + id + ", '" + jsonobj.toJSONString() + "')";
		st.executeUpdate(sql);
		
		out.println("OK");
		
	} catch(Exception ex) {
		ex.printStackTrace();
	}
%>