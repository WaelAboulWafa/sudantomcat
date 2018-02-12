import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import java.text.*;
import java.net.*;
import javax.naming.*;
import javax.sql.*;

public class d  extends HttpServlet
{ 
    
    public void doPost(HttpServletRequest  request,HttpServletResponse response)throws IOException, ServletException
    {
    	doGet(request,response);
    	return;
    }

    public void doGet(HttpServletRequest  request,HttpServletResponse response)throws IOException, ServletException
    {
    	
    	
     try{ 
     
    	
      Connection con=null;
      InitialContext ic = new InitialContext();
      DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
      con  = ds.getConnection();
      	
    	 
      	BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());

     
         

       
        String id=null;
        String scode=null;
        
         if(request.getParameter("id") != null)   {id = request.getParameter("id");id = id.trim();} 
         if(request.getParameter("scode") != null){scode = request.getParameter("scode");scode = scode.trim();}  
         
        if ( id == null || scode == null)
        {
          response.setContentType("text/html");
          TheAlert(out,"parameter(s) missing.");
         out.flush();
         out.close();
          
          return;    
       	}
   
   
       boolean existingrequest=false;	
      ResultSet rs = con.createStatement().executeQuery("SELECT     id, scode FROM         Push where id='"+ id +"' and scode='"+ scode +"' and downloaded ='0' ORDER BY id");
       while(rs.next()){existingrequest=true;}
       rs.close();rs = null;
  
       if(existingrequest == false)
       {
         response.setContentType("text/vnd.wap.wml");
         TheAlert(out,"invalid request, maybe doesn't exist or downloaded before.");
         out.flush();
         out.close();
         return;
       }
       
          
   
   
   
   
   
       String contents_home= "c:/";
       rs = con.createStatement().executeQuery("SELECT     home FROM         ContentsHomeDir");
       while(rs.next()){contents_home = rs.getString(1);}
       rs.close();rs = null;
       
   
   
     	
       	
       int thecontentcode = 0;
        rs = con.createStatement().executeQuery("SELECT     code FROM         Push where id='"+ id +"' and scode='"+ scode +"' and downloaded ='0' ORDER BY id");
       while(rs.next()){thecontentcode = rs.getInt(1);}
       rs.close();rs = null;
       
      
       //check if the request is for an audio(mp3,amr) content
       boolean isaudio=false;
       rs = con.createStatement().executeQuery("SELECT    FileExtension FROM         Contents where contentcode='"+ thecontentcode +"'");
       while(rs.next())
        {
        	String the_ext="";the_ext = rs.getString(1);if(the_ext.equalsIgnoreCase("mp3") || the_ext.equalsIgnoreCase("amr")){isaudio=true;}
        }
       rs.close();rs = null;
       
      
       
       
       String type="";
       String FileName="";
       String downloadedname="";
       
       String thequery="";
       
       if(isaudio)
       {
  
try{
       	if( (request.getHeader("accept").indexOf("*/*") != -1) || (request.getHeader("Accept").indexOf("*/*") != -1) )
       	{
       		thequery="SELECT    FileExtension, TheFile , downloadname FROM         Contents where contentcode='"+ thecontentcode +"' and FileExtension='mp3'";
       	}
       	else
       	{
       		thequery="SELECT    FileExtension, TheFile , downloadname FROM         Contents where contentcode='"+ thecontentcode +"' and FileExtension='amr'";       		
       	}

}catch(Exception e2){thequery="SELECT    FileExtension, TheFile , downloadname FROM         Contents where contentcode='"+ thecontentcode +"' and FileExtension='amr'";}

       }
       else
       {
       	thequery="SELECT    FileExtension, TheFile , downloadname FROM         Contents where contentcode='"+ thecontentcode +"'";
       }
       
       
       rs = con.createStatement().executeQuery(thequery);
       while(rs.next()){type = rs.getString(1);FileName = rs.getString(2);downloadedname = rs.getString(3);}
       rs.close();rs = null;
                    
       FileInputStream f = null;
       try
       {
              f = new FileInputStream(new File(contents_home + FileName.trim()));
       }catch (Exception e)
                               {
                               	try
                               	   {
                                     response.setContentType("text/vnd.wap.wml");
                                     TheAlert(out,"File Not Found.") ;                                      	   	
                                     out.flush();
                                     out.close();
                                     return;    
                               	   }catch(Exception ex){}
                               	                 
                               }




            
       if(type.equalsIgnoreCase("mid")){response.setContentType("audio/midi");}
       if(type.equalsIgnoreCase("amr")){response.setContentType("video/amr");}
       if(type.equalsIgnoreCase("mp3")){response.setContentType("audio/mp3");}
       if(type.equalsIgnoreCase("wav")){response.setContentType("audio/wav");}
       if(type.equalsIgnoreCase("gif")){response.setContentType("image/gif");}
       if(type.equalsIgnoreCase("jpg")){response.setContentType("image/jpg");}
       if(type.equalsIgnoreCase("3gp")){response.setContentType("video/3gpp");}
       if(type.equalsIgnoreCase("jar")){response.setContentType("application/java-archive");}
       if(type.equalsIgnoreCase("sis")){response.setContentType("application/vnd.symbian.install");}
            
       response.setContentLength((int)(new File(contents_home + FileName.trim())).length());
       response.addHeader("Content-Disposition","attachment;filename=" + downloadedname );
     
       int b = 0;
       while( (b= f.read()) != -1){out.write(b);}
       f.close();f=null;
       con.createStatement().execute( "UPDATE  push   SET downloaded = downloaded + 1 where ID= " + id.trim() );
       out.flush();            
       out.close();
           
  

  
  
           return;        	   	

       	
       	
       	  }catch(Exception e){throw new ServletException(e.getMessage()); }
       	  
       	  
       	  
         
    }
    
    
    
    
    public void TheAlert(OutputStream o,String theAlert) throws Exception
    {
        o.write(("<?xml version=\"1.0\"?>\r\n").getBytes("ASCII"));
        o.write(("<!DOCTYPE wml PUBLIC \"-//WAPFORUM//DTD WML 1.1//EN\" \"http:///www.wapforum.org/DTD/wml_1.1.xml\">\r\n").getBytes("ASCII"));
        o.write(("<wml>\r\n").getBytes("ASCII"));
        o.write( ("<card>\r\n").getBytes("ASCII"));
        o.write( ("<p>\r\n").getBytes("ASCII") );
        o.write(theAlert.getBytes("ASCII"));
        o.write(("\r\n").getBytes("ASCII"));
	    o.write(("</p>\r\n").getBytes("ASCII"));
        o.write(("</card>\r\n").getBytes("ASCII"));
        o.write(("</wml>").getBytes("ASCII"));

    }
   
    

}