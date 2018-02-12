<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*,java.util.regex.*" %>


<%
Connection con=null;
 InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();

 
  String pgmstatus = request.getParameter("pgmstatus");
  

 	
 	out.println(pgmstatus);
 	
	
  try{

         
                             
          con.createStatement().execute("update sms.albit_operations set status= " +  pgmstatus);
          
        }catch(Exception e){out.println(e.toString()); return;}


        con.close();

     response.sendRedirect("programs.jsp"); 
 
%>


