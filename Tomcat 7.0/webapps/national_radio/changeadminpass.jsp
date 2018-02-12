<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*,java.util.regex.*" %>

 


<%
  Connection con=null;
 InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();


  String adminpass="";adminpass = request.getParameter("adminpass");
  
	
 	
 	
  if(adminpass.length() > 0 )
  {
       adminpass = adminpass.replaceAll("'", "''");
      con.createStatement().execute("update sms.nradio_superusers set thepassword =N'"+ adminpass + "' where theuser='admin'");
   }       
  

con.close();
        
     response.sendRedirect("programs.jsp"); 

 
%>



