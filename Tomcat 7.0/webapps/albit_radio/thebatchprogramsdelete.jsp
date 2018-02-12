<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*,java.util.regex.*" %>








<%

  Connection con=null;
 InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();
 

 int count = 0 ;


 count = Integer.parseInt(request.getParameter("count"));
 
   String[] ischeck = new String[count];
   String[] id = new String[count];
   
   String[] pgmname = new String[count];
     
   String[] pgmairingday = new String[count];
   String[] pgmairingstart = new String[count];
   String[] pgmairingend = new String[count];
   
   String[] pgmreplayday =   new String[count];
   String[] pgmreplaystart =   new String[count];
   String[] pgmreplayend=   new String[count];

   String[] theusr  =   new String[count];
   String[] thepass =   new String[count];

   

for (int i=0; i < count;i++)
{
   ischeck[i] = request.getParameter("ischeck"+ Integer.toString(i) );
   id[i] = request.getParameter("id"+ Integer.toString(i));
   
   pgmname[i] = request.getParameter("pgmname"+ Integer.toString(i));
   
   pgmairingday[i] = request.getParameter("pgmairingday"+ Integer.toString(i));
   pgmairingstart[i] = request.getParameter("pgmairingstart"+ Integer.toString(i));
   pgmairingend[i] = request.getParameter("pgmairingend"+ Integer.toString(i));
   
   pgmreplayday[i] = request.getParameter("pgmreplayday"+ Integer.toString(i));
   pgmreplaystart[i] = request.getParameter("pgmreplaystart"+ Integer.toString(i));
   pgmreplayend[i] = request.getParameter("pgmreplayend"+ Integer.toString(i));
   
   theusr[i] = request.getParameter("theusr"+ Integer.toString(i));
   thepass[i] = request.getParameter("thepass"+ Integer.toString(i));
   
      
  out.println("<br><br>");
   
}
 	
 	
 
	
ResultSet rs = null; 	

for (int i =0;i< count ;i ++)
{
  if(ischeck[i] != null)
  {
      try{

    	  String query="";
          query= "delete from sms.albit_pgms where id= " +id[i] ;
   



 //  out.println(query);
  con.createStatement().execute(query); 
     
         }catch(Exception e){}
  }

}

con.close();

     response.sendRedirect("programs.jsp");    



   		          
 
%>
