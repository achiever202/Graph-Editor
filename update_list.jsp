<%@ page import="java.util.*,java.io.*" %>
<%
	PrintWriter reply = response.getWriter();
	String current_files = "";
	File file = new File(request.getRealPath("/adarsh/Saved Graphs"));
	
	File[] list_files = file.listFiles();
	for(int i=0;i<list_files.length;i++){
		current_files += list_files[i].getName()+",";
	}
	
	reply.print(current_files);
%>
