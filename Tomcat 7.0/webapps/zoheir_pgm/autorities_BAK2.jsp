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
 
 

 public boolean ispageallowed(String[] thepage,String[] theright,String pagerequired)
 {

  for(int k=0;k<thepage.length;k++)
  {
    if(thepage[k].equalsIgnoreCase(pagerequired))
    {
     if(theright[k].equalsIgnoreCase("1")){return true;}  
    }
  }

  return false;
 } 
 
 
 
 
public String getuid(String the_uname,Connection thecon)throws Exception
{

 int thisid= 0;
 ResultSet thers;
 
 thers = thecon.createStatement().executeQuery("select userid from fitservice.hawasudan_pgm_Users where username=N'"+ the_uname + "'");            
 while(thers.next()){thisid=thers.getInt(1);}thers.close();thers = null;
 
 return Integer.toString(thisid);
 
}
 
            
%>










<%
String username;try{ username =  session.getAttribute("username").toString();}catch(Exception e){username=null;}
String password;try{password =  session.getAttribute("password").toString();}catch(Exception