<%@ page import="java.util.*,java.io.*" %>

<%
	// This class has edges as objects.
	// The data members are:
	// 		Source vertex
	//		Target vertex
	//		Weight of the edge.
	class Edge implements Comparable<Edge>
	{		private int s;
			private int t;
			private int w;
			
			Edge(int source,int target,int weight)
			{
				s=source;
				t=target;
				w=weight;
			}
			public int getWeight()
			{
				return this.w;
			}

			public int getSource()
			{
				return this.s;
			}

			public int getTarget()
			{
				return this.t;
			}
			
			// This function is used to compare two objects of the class.
			public int compareTo(Edge v)  
			{
				int compareQuantity=((Edge) v).getWeight();
				return this.w-compareQuantity;
			}
	}
	
	// This class implements the class disjoint set data structure with path compression and rank.
	// Parent stores the parent of the element, and rank stores the rank of the element.
	class DisjointSets
	{
		private int[] Parent;
		private int[] Rank;
	
		public DisjointSets(int numElements)
		{
			Parent=new int[numElements];
			Rank=new int[numElements];
			for(int i=0;i<Parent.length;i++)
			{
				Parent[i]=i;
				Rank[i]=0;
			}
		}
		
		// This function finds the top parent of the element.
		public int Find(int i)
		{
			if (Parent[i] == i)
				return i;
				
			else
			{ 
				int result = Find(Parent[i]);
		 
				// We update its parent to the top parent to optimize.
				Parent[i] = result;
		 
				return result;
			}
		}
	
		// This function performs the union of two sets.
		public void Union(int u,int v)
		{
			int parent_u = Find(u);
			int parent_v = Find(v);
			
			// both are in the same set.
			if(parent_u == parent_v)
				return;
			
			// updating the smaller set.
			if(Rank[u]<Rank[v])
				this.Parent[parent_u] = parent_v;
			else if(Rank[u]>Rank[v])
				this.Parent[parent_v] = parent_u;
			else
			{
				this.Parent[parent_u] = parent_v;
				Rank[parent_v]++;
			}
		}
	}

	PrintWriter reply = response.getWriter();
	String n = request.getParameter("node");
	String edges=request.getParameter("edges");
	String weight=request.getParameter("weight");
	
	String[] edge=edges.split(",");
	String[] w=weight.split(",");
	
	// Creating an array of objects of type Edge
	Edge[] E=new Edge[w.length];
	int s,t,wt;
	for(int i=0;i<w.length;i++)		//parsing the data and Creating an array of objects of Edge
	{	
		String[] temp=edge[i].split(":");
		E[i]=new Edge(Integer.parseInt(temp[0]),Integer.parseInt(temp[1]),Integer.parseInt(w[i]));
	}
	Arrays.sort(E);
	
	String answer="";
	
	// Kruskals algorithm
	DisjointSets set = new DisjointSets(Integer.parseInt(n));
	for(int i=0;i<E.length;i++)
	{
		s=E[i].getSource();
		t=E[i].getTarget();
		if(set.Find(s)!=set.Find(t))
		{
			answer+=s+":"+t+",";
			set.Union(s,t);
		}
	}
	reply.print(answer+"0:0");
%>
