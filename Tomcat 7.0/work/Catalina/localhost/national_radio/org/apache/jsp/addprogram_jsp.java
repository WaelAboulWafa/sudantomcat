/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2014-09-12 19:42:29 UTC
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

public final class addprogram_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

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
      response.setContentType("text/html;charset=windows-1256");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");


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

   		          
 

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
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
