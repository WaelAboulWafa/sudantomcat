/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2014-08-14 11:19:08 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.text.*;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;
import java.net.*;
import java.util.regex.*;

public final class submit_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {






public String getReadable(String theUnicode,String thelang)
 {
   if( thelang.equalsIgnoreCase("E") ){return theUnicode;}
   
   if(theUnicode.length() < 4){return "";}
   try 
    {
     byte[] by = new byte[theUnicode.length()/2];
     for(int i=0;i<theUnicode.length()/2;i++)
     by[i] = (new Integer(Integer.parseInt(theUnicode.substring(i*2,i*2 + 2),16))).byteValue();
     String theReadable = new String(by,"UTF-16");
     return theReadable;
    }catch(Exception e){return "";}

 }




public boolean insertcdr(String theprovider,String theshortcode,String themsisdn,String thelang,String thecontents,Connection con ) throws Exception

{

String thereadable = "";
String themodifiedcontents  = thecontents.replaceAll("'", "''");
if( thelang.equalsIgnoreCase("A") ){thereadable =  getReadable(thecontents,thelang).replaceAll("'", "''");}
else{thereadable =  thecontents.replaceAll("'", "''");}

try{
	

//	String thequery ="insert into fitservice.CDRs(Contents,Readable,provider,msisdn,shortcode,lang) values('" + thecontents + "','" + thereadable + "','" + theprovider + "','" +  themsisdn + "','" + theshortcode + "','" + thelang + "')" ;
	String thequery ="insert into fitservice.CDRs(Contents,Readable,provider,msisdn,shortcode,lang) values('" + thecontents + "','','" + theprovider + "','" +  themsisdn + "','" + theshortcode + "','" + thelang + "')" ;



con.createStatement().execute(thequery);
	

}catch(Exception e){ return false; }

return true;              
}





            

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=windows-1256");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;



        String provider=null;
        String msisdn=null ;
        String shortcode=null;
        String lang=null;
        String contents = null;

         if(request.getParameter("provider") != null)   {provider = request.getParameter("provider");provider = provider.trim();} 
         if(request.getParameter("msisdn") != null)     {msisdn = request.getParameter("msisdn");msisdn = msisdn.trim();} 
         if(request.getParameter("shortcode") != null)  {shortcode = request.getParameter("shortcode");shortcode = shortcode.trim();} 
         if(request.getParameter("lang") != null)       {lang = request.getParameter("lang");lang = lang.trim();}           
         if(request.getParameter("contents") != null)   {contents = request.getParameter("contents");contents = contents.trim();}                    
           
        if ( (provider == null)    ||
             (msisdn == null)      ||
             (shortcode == null)   ||
             (lang == null)        ||
             (contents == null)    

           )
        {
          out.print("Rejected. parameter(s) missing.");
          out.close();
          return;    
       	}       	
       	
       	


        Connection con=null;
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
        con  = ds.getConnection();
        
        

        
  
       	
        if(! (lang.equalsIgnoreCase("A") || lang.equalsIgnoreCase("E") ))
        {
              out.print("Rejected. unknown language");
              out.close();
              return;         	   	
        }

       	
        if( lang.equalsIgnoreCase("A") )
        {
        
        try{
             StringBuffer stb = new StringBuffer();
             for(int i=0;i< contents.length();i=i+4)
             {
              if(contents.substring(i,i+3).equalsIgnoreCase("066")){stb.append("003");stb.append( contents.substring(i+3,i+4) );}
              else{stb.append(contents.substring(i,i+4));}
             }
             contents = stb.toString();
           }catch(Exception e){contents = contents;}
        
        }


         boolean dbstatus =  false;
         try{dbstatus = insertcdr(provider,shortcode,msisdn,lang,contents,con);}catch(Exception e){out.print(e.toString());}
         
         
         if (dbstatus){out.print("OK");out.close();return;}
         else{out.print("ERROR");out.close();return;}   

       
          
     
  
            
            
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
