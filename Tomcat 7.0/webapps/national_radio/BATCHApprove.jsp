<%@ page contentType="text/html;charset=Cp1252"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*" %>



<%
Connection con=null;
 InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();


int pagesize = 50 ;

String resultorder = "asc";try{resultorder =  request.getParameter("resultorder").trim();    }catch(Exception e){resultorder = "asc";}


 int theoffset = Integer.parseInt(request.getParameter("theoffset"));
 
//  out.println("theoffset : " + theoffset);  
//  out.println("<br><br>");

   String[] ischeck = new String[pagesize];
   String[] id = new String[pagesize];
   
for (int i=0; i < pagesize;i++)
{
   ischeck[i] = request.getParameter("ischeck"+ Integer.toString(i+theoffset) );
   id[i] = request.getParameter("id"+ Integer.toString(i+theoffset));
   
   
  out.println(ischeck[i]); 
  out.println(id[i]); 
//  out.println(tel[i]); 
//  out.println(msg[i]);
//   out.println(messagetarget[i]);
//   out.println("<br><br>");
   
}
 	
 
	
for (int i =0;i< pagesize ;i ++)
{
  if(ischeck[i] != null)
  {
   
   try{

       
	   con.createStatement().execute("update sms.nradio_cdrs set readtime=NOW() , status=1 where id=" + id[i]);
          
        }catch(Exception e){out.println(e.toString()); return;}

  }

}



       String offset ="0";
       String thefilter ="ALL";
       try{ 
           offset = request.getParameter("thebase");
           }catch(Exception e){offset ="0";}
         try
         {             
           thefilter = URLEncoder.encode(request.getParameter("countrysc"));
           }catch(Exception e){thefilter ="ALL";}

con.close();
                      
     response.sendRedirect("trackmessages.jsp?resultorder=" + resultorder + "&filtertheshortcode="+thefilter + "&offset=" + offset); 
 
%>


 