<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*,java.util.regex.*" %>





<%

  Connection con=null;
 InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();
  

   String pgmname = request.getParameter("pgmname").replaceAll("'", "''").trim();
   String pgmairingday = request.getParameter("pgmairingday").replaceAll("'", "''").trim();
   String pgmairingstart = request.getParameter("pgmairingstart").replaceAll("'", "''").trim();
   String pgmairingend = request.getParameter("pgmairingend").replaceAll("'", "''").trim();
   String pgmreplayday = request.getParameter("pgmreplayday").replaceAll("'", "''").trim();
   String pgmreplaystart = request.getParameter("pgmreplaystart").replaceAll("'", "''").trim();
   String pgmreplayend = request.getParameter("pgmreplayend").replaceAll("'", "''").trim();
   String usrname = request.getParameter("usrname").replaceAll("'", "''").trim();
   String password = request.getParameter("password").replaceAll("'", "''").trim();
	

 
   pgmname = (new String(pgmname.getBytes("Cp1252"),"Cp1256"));
   usrname = (new String(usrname.getBytes("Cp1252"),"Cp1256"));
   password = (new String(password.getBytes("Cp1252"),"Cp1256"));
   
 
  int nextid=0;
  ResultSet rs = con.createStatement().executeQuery("SELECT max(id)+1 FROM sms.nradio_pgms");            
  while(rs.next()){nextid = rs.getInt(1);} rs.close(); rs = null;
  
 
 

try
{
    if( !(pgmname.length() == 0) && !(usrname.length() == 0) && !(password.length() == 0) )
    {   
      con.createStatement().execute("insert into  sms.nradio_pgms(id, pgm_name,airing_weekday,airing_from,airing_to,replay_weekday,replay_from,replay_to,username,password ) values('" + nextid + "','"+ pgmname + "','"+ pgmairingday +"','" + pgmairingstart + "','" + pgmairingend + "','" + pgmreplayday + "','" + pgmreplaystart + "','" + pgmreplayend + "','" + usrname + "','" + password + "')"); 
      con.close();  
      response.sendRedirect("programs.jsp");    
    }
    else
    {
      con.close();  
      response.sendRedirect("programs.jsp");        
    }

}catch(Exception e){
                         out.println(e.toString());
						//response.sendRedirect("programs.jsp"); 
					}

   		          
 
%>


