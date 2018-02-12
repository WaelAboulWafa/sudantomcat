<%@ page contentType="text/html;charset=Cp1252"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*" %>



<%
Connection con=null;
 InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();





 int count = Integer.parseInt(request.getParameter("count"));
 
 String pgmtomodify =  request.getParameter("pgmtomodify");
 
 out.println(pgmtomodify);

   String[] ischeck = new String[count];
   String[] id = new String[count];
   
for (int i=0; i < count;i++)
{
   ischeck[i] = request.getParameter("ischeck"+ Integer.toString(i) );
   id[i] = request.getParameter("id"+ Integer.toString(i));
   
   
//  out.println(ischeck[i]); 
//  out.println(id[i]); 
   
}
 	
 
	
for (int i =0;i< count ;i ++)
{
  if(ischeck[i] != null)
  {
   
   try{

          con.createStatement().execute("update sms.nradio_cdrs set pgmid=" + pgmtomodify + " where id=" + id[i]);
          
        }catch(Exception e){out.println(e.toString()); return;}

  }

}



con.close();
                      
     response.sendRedirect("search.jsp"); 
 
%>


 