<%@ page import="java.util.*,java.io.*" %>
<%
	PrintWriter reply = response.getWriter();
	String file_name = request.getParameter("file_name");
	String loaded_graph = "";
	
	try
	{
		File graph = new File("C:\\xampp\\tomcat\\webapps\\ROOT\\adarsh\\Saved Graphs\\"+file_name);
		FileInputStream input = new FileInputStream(graph);
		DataInputStream data = new DataInputStream(input);
		BufferedReader buffer = new BufferedReader(new InputStreamReader(data));
		loaded_graph = buffer.readLine();
		reply.print(loaded_graph);
	}
	catch(IOException e)
	{
		reply.print("Failed");
	}
%>
