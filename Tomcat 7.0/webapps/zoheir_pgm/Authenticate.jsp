<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*" %>




<%


String username = request.getParameter("username");
String password = request.getParameter("password");
if(username==null || password==null)
{
response.sendRedirect("login.jsp");
}


  Connection con=null;
  InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();
  ResultSet rs = null;
  int userexit= 0;
  try
  {
   rs = con.createStatement().executeQuery("SELECT count(*) from fitservice.zoheir_pgm_Users where username=N'" + username.replaceAll("'", "''") + "' and password=N'" + password.replaceAll("'", "''") + "'");             
   userexit= 0;
   while(rs.next()){userexit = rs.getInt(1);}
   rs.close();rs = null;
  }catch(Exception e){}


if(userexit > 0 )
{
session.setAttribute("username",username);
session.setAttribute("password",password);
con.createStatement().execute("update fitservice.zoheir_pgm_Users set   lastlogintime= NOW() where username=N'" + username.replaceAll("'", "''") + "' and password=N'" + password.replaceAll("'", "''") + "'");             
response.sendRedirect("MainPage.jsp");    
}
else
{
session.invalidate();
%>


<html dir='rtl'>
<head>
<STYLE type=text/css>BODY {MARGIN: 0