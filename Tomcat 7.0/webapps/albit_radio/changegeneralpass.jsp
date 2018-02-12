<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*,java.util.regex.*" %>

 


<%
  Connection con=null;
 InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();


  String generalpass="";generalpass = request.getParameter("generalpass");
  
	
 	
 	
  if(generalpass.length() > 0 )
  {
       generalpass = generalpass.replaceAll("'", "''");
      con.createStatement().execute("update sms.albit_superusers set thepassword =N'"+ generalpass + "' where theuser='general'");
   }       
  

con.close();
        
     response.sendRedirect("programs.jsp"); 

 
%>



