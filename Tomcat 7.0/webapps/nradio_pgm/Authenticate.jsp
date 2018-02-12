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
  ResultSet rs1 = null;
  int userexit= 0;
  try
  {
   rs = con.createStatement().executeQuery("SELECT count(*) from fitservice.nradio_pgm_Users where username=N'" + username.replaceAll("'", "''") + "' and password=N'" + password.replaceAll("'", "''") + "'");             
   userexit= 0;
   while(rs.next()){
	   userexit = rs.getInt(1);
	   }
   rs.close();
   rs = null;
  }catch(Exception e){}


if(userexit > 0 )
{

//String progid = "";
//rs1 = con.createStatement().executeQuery("SELECT * from fitservice.nradio_pgm_Users where username=N'" + username.replaceAll("'", "''") + "' and password=N'" + password.replaceAll("'", "''") + "'");

session.setAttribute("username",username);
session.setAttribute("password",password);

//session.setAttribute("", arg1)
con.createStatement().execute("update fitservice.nradio_pgm_Users set   lastlogintime= NOW() where username=N'" + username.replaceAll("'", "''") + "' and password=N'" + password.replaceAll("'", "''") + "'");             
response.sendRedirect("MainPage.jsp");    
}
else
{
session.invalidate();
%>


<html dir='rtl'>
<head>
<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt arial, geneva, lucida, "lucida grande", arial, helvetica, sans-serif; COLOR: #000000 }</style>
<meta http-equiv="Content-Language" content="en-ar">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<title>ÏÎÜÜæá ... National Radio</title>
</head>


<body >
	
<br><br><br>
<table border='0' bgcolor='#E6E6E6' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#BBBBBB' width='30%' height='100'>
	<tr height=10 align="center">
		<td width='80%'><font size='4' color=#000000>ÇÓã ÇáãÓÊÎÏã Çæ æ ßáãÉ ÇáãÑæÑ ÛíÑ ÕÍíÍ Çæ ÕÍíÍíä</font></td>
	</tr>
	<tr height=10 align="center">
		<td><font size='5' color=#000000><a href=login.jsp>ÍÇæá ãÑå ÇÎÑí</a></td>
	</tr>

</table>
</body>
</html>

<%
}
%>

