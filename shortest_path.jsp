<%@ page import="java.util.*,java.io.*" %>
<%
	PrintWriter reply = response.getWriter();
	final int nodes = Integer.parseInt(request.getParameter("node"));
	String edges_string = request.getParameter("edges");
	String weights_string = request.getParameter("weights");
	final int start = Integer.parseInt(request.getParameter("start"));
	final int end = Integer.parseInt(request.getParameter("end"));
	
	
	String[] edges = edges_string.split(",");
	String[] weights = weights_string.split(",");
	
	int adj_matrix[][] = new int[nodes][nodes];
	for(int i=0; i<nodes; i++)
	{
		for(int j=0; j<nodes; j++)
			adj_matrix[i][j] = 0;
	}
	
	String send = "";
	for(int i=0; i<edges.length; i++)
	{
		String[] temp = edges[i].split(":");
		int temp_weight = Integer.parseInt(weights[i]);
		adj_matrix[Integer.parseInt(temp[0])][Integer.parseInt(temp[1])] = temp_weight;
		adj_matrix[Integer.parseInt(temp[1])][Integer.parseInt(temp[0])] = temp_weight;
	}
	
	class node
	{
			public int index, distance, source;
			
			public node()
			{
				distance = 1000000000;
				source = -1;
			}
	}
	
	List <node> dijkstra = new LinkedList<node>();
	node[] vertices = new node[nodes];
	for(int i=0; i<nodes; i++)
	{
		vertices[i] = new node();
		vertices[i].index = i;
		if(i==start)
			vertices[i].distance = 0;
		dijkstra.add(vertices[i]);
	}
	
	node temp = new node();
	while(!dijkstra.isEmpty())
	{
		Collections.sort(dijkstra, new Comparator<node>(){
			public int compare(node i, node j){
				if(i.distance<j.distance)
					return -1;
				else if(i.distance>j.distance)
					return 1;
				else return 0;
			}
		});
		temp = dijkstra.get(0);
		dijkstra.remove(temp);
		if(temp.index==end)
			break;
		
		for(int i=0; i<dijkstra.size(); i++)
		{
			node temp_dij = dijkstra.get(i);
			if(adj_matrix[temp.index][temp_dij.index]>0)
			{
				if(temp.distance + adj_matrix[temp.index][temp_dij.index] < temp_dij.distance)
				{
					dijkstra.remove(temp_dij);
					temp_dij.distance = temp.distance + adj_matrix[temp.index][temp_dij.index];
					temp_dij.source = temp.index;
					vertices[temp_dij.index].source = temp.index;
					vertices[temp_dij.index].distance = temp.distance + adj_matrix[temp.index][temp_dij.index];
					dijkstra.add(temp_dij);
				}
			}
		}
	}
	
	if(temp.index!=end || temp.distance==1000000000)
		reply.print("failed!");
	else
	{
		String res = "";
		while(temp.source!=-1)
		{
			res += temp.index+",";
			temp = vertices[temp.source];
		}
		res += start;
		reply.print(res);
	}
%>
