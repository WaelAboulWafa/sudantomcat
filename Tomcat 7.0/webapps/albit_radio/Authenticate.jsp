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

  
  int validauser=0;

  boolean userlogin=false;
  boolean adminlogin=false;
  boolean generallogin=false;
  
  if(  username.equalsIgnoreCase("admin") || username.equalsIgnoreCase("general") )
  {

		if( username.equalsIgnoreCase("admin"))
		{
				
		  try
		  {
		  
		   int validadmin=0;
		   rs = con.createStatement().executeQuery("SELECT count(*) from sms.albit_superusers where theuser='admin' and thepassword=N'" + password.replaceAll("'", "''") + "'");             
		   while(rs.next()){validadmin = rs.getInt(1); }rs.close(); rs = null;
		   if(validadmin > 0){adminlogin=true;}
		  }catch(Exception e){}

        }
        
        
		if( username.equalsIgnoreCase("general"))
		{
				
		  try
		  {
		  
		   int validgeneral=0;
		   rs = con.createStatement().executeQuery("SELECT count(*) from sms.albit_superusers where theuser='general' and thepassword=N'" + password.replaceAll("'", "''") + "'");             
		   while(rs.next()){validgeneral = rs.getInt(1); }rs.close(); rs = null;
		   if(validgeneral > 0){generallogin=true;}
		  }catch(Exception e){}

        }

        
        
        

    
  }
  else
  {
  
		  try
		  {
		   
		   rs = con.createStatement().executeQuery("SELECT id from sms.albit_pgms where username=N'" + username.replaceAll("'", "''") + "' and password=N'" + password.replaceAll("'", "''") + "'");
		   while(rs.next()){validauser = rs.getInt(1); }rs.close(); rs = null;
		   if(validauser > 0){userlogin=true;}
		  }catch(Exception e){}

  
  
  
  }


  

if( adminlogin || generallogin || userlogin )
{

	if( adminlogin || generallogin)
	{
	
		if( adminlogin)
		{
			session.setAttribute("pgmid","admin");
			session.setAttribute("username",username);
			session.setAttribute("password",password);
		
		    response.sendRedirect("AdminMainPage.jsp");
		}
		
		if( generallogin)
		{
			session.setAttribute("pgmid","0");
			session.setAttribute("username",username);
			session.setAttribute("password",password);
		
		    response.sendRedirect("trackmessages.jsp");
		}
				

	}
		
		if( userlogin)
		{
		
			session.setAttribute("pgmid",validauser);
			session.setAttribute("username",username);
			session.setAttribute("password",password);
		
		    response.sendRedirect("trackmessages.jsp");
		    
		}


 
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

