<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*" %>


 

<%!
   
 public boolean isallowed(String requestedpage,String[] thepagesallowed,int[] theflag)
 {
  for(int k =0;k< thepagesallowed.length ; k++)
  {
    
    if(requestedpage.equalsIgnoreCase(thepagesallowed[k]))
    {
      if(theflag[k] == 1){return true;}
    } 
  }
  
  return false;
 }

            
%>










<%
String username;try{ username =  session.getAttribute("username").toString();}catch(Exception e){username=null;}
String password;try{password =  session.getAttribute("password").toString();}catch(Exception e){password=null;}
if(username==null || password==null) //user not logged in
{
session.invalidate();
response.sendRedirect("login.jsp");
}



  /////get user authorities/////////////
  Connection con=null;
  InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();
  ResultSet rs = null;
  int userid= 0;
  try
  {
   rs = con.createStatement().executeQuery("SELECT userID from fitservice.hawasudan_pgm_Users where username=N'" + username.replaceAll("'", "''") + "' and password=N'" + password.replaceAll("'", "''") + "'");             
   userid = 0;
   while(rs.next()){userid = rs.getInt(1);}
   rs.close();rs = null;
  }catch(Exception e){}
  
  



  int reccount = 0 ;
  rs = null;
  try
  {
   rs = con.createStatement().executeQuery("SELECT count(*) from fitservice.hawasudan_pgm_UsersAuthorities where userID=" + userid);             
   while(rs.next()){reccount = rs.getInt(1);} 
   rs.close();rs = null;
  }catch(Exception e){}
  
  
  String[] thepage = new String[reccount];
  int[] allowed = new int[reccount];
  
  rs = null;
  int z =0;
  try
  {
   rs = con.createStatement().executeQuery("SELECT page, allowed from fitservice.hawasudan_pgm_UsersAuthorities where userID=" + userid);             
   while(rs.next()){thepage[z]=rs.getString(1);allowed[z]=rs.getInt(2);z=z+1;}
   rs.close();rs = null;
  }catch(Exception e){}
    


  /*
  boolean allowedaccess = false;
  for(int k =0;k< thepage.length ; k++)
  {
   if(thepage[k].equalsIgnoreCase("filteration.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k].equalsIgnoreCase("send.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k].equalsIgnoreCase("nicknames.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k].equalsIgnoreCase("smsonair.jsp"){if(theflag[k] == 1){allowedaccess true;}}         
   if(thepage[k].equalsIgnoreCase("search.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k].equalsIgnoreCase("badwords.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k]