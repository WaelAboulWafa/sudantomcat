<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*" %>



<%


String username = "";
String password = "";

Connection con=null;
 InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();

  try
  {
   username = session.getAttribute("username").toString();
   password = session.getAttribute("password").toString();
   con.createStatement().execute("update pgm_Users set   lastlogouttime= getdate() where username=N'" + username.replaceAll("'", "''") + "' and password=N'" + password.replaceAll("'", "''") + "'");             
  }catch(Exception e){}
  session.invalidate();
  response.sendRedirect(request.getContextPath());    
%>