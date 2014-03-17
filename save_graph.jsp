<%@ page import="java.util.*,java.io.*" %>
<%
	String nodes = request.getParameter("vertices");
	String edges = request.getParameter("edges");
	String file_name = request.getParameter("filename");
	String file_data = nodes+"$"+edges;
	String file_path = "C:\\xampp\\tomcat\\webapps\\ROOT\\adarsh\\Saved Graphs\\"+file_name+".txt";
	PrintWriter reply = response.getWriter();
	
	try
	{
		PrintWriter output = new PrintWriter(new FileOutputStream(file_path));
		output.println(file_data);
		output.close();
		
		File temp = new File(request.getRealPath("/Adarsh/Saved Graphs"));
		File[] list_files = temp.listFiles();
		String current_files = "";
		for(int i=0;i<list_files.length;i++)
			current_files += list_files[i].getName()+",";
			
		reply.print(current_files);
	}
	catch(IOException e)
	{
		reply.print("failed");
	}
%>
	
	
