/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2015-05-18 08:35:53 UTC
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

public final class getReport_jsp extends org.apache.jasper.runtime.HttpJspBase
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






String leday = "2001-01-01";try{leday = request.getParameter("theday").trim();}catch(Exception e){leday = "2001-01-01";}




  Connection con=null;
  InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();
  ResultSet rs = null;


String query3 = "";
query3 = query3 + " SELECT ID, DATE_FORMAT(call_start_date,' %H:%i:%S') as callstart, DATE_FORMAT(call_end_date,' %H:%i:%S')  as callend, operator , dst ,src, TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) as Seconds , case 	when  ( TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) < 1 ) then 0 	else CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) end as BilledMinutes ";
query3 = query3 + " FROM cdr " ; 
query3 = query3 + " where DATE_FORMAT(call_start_date,'%Y-%m-%d') = '"+ leday +"'  ";





String theoperator = "ALL";

if( request.getParameter("theoperator")!=null) 
{
 if( !(request.getParameter("theoperator").trim().equalsIgnoreCase("ALL")) ) 
 { 
  theoperator= request.getParameter("theoperator");
  query3 = query3 + " and operator ='"+ theoperator +"' ";
  query3 = query3 + " and DATE_FORMAT(call_start_date,'%H:%i:%S') >= '"+(request.getParameter("filtercallstart").trim())+"'";
  query3 = query3 + " and ATE_FORMAT(call_end_date,'%H:%i:%S) <= '"+(request.getParameter("filtercallstart").trim())+"' ";
   
 }
} 




   


 



query3 = query3 + " order by id ";

   





             

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<html dir=ltr>\r\n");
      out.write("\r\n");
      out.write("<head>\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"datepicker.css\"/>\r\n");
      out.write("<script type=\"text/javascript\" src=\"datepicker.js\">\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("function getcdr(day,shortcode)\r\n");
      out.write("{\r\n");
      out.write("alert(day + ' ' + shortcode);\r\n");
      out.write("var myWindow = window.open(\"http://www.yahoo.com\", 'null' , \"MsgWindow,toolbar=no,scrollbars=yes,location=no,resizable=yes\", \"width=200, height=100\");\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
      out.write("\r\n");
      out.write("<STYLE type=text/css>\r\n");
      out.write("\tBODY {MARGIN: 0px; FONT: 14pt arial, geneva, lucida, \"lucida grande\", arial, helvetica, sans-serif; COLOR: #000000;background-color: #FFFFFF; }\r\n");
      out.write("\r\n");
      out.write("\t\t.clickable:hover\r\n");
      out.write("\t\t{\r\n");
      out.write("\t\t    background:#ffa;\r\n");
      out.write("\t\t    cursor: hand;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\r\n");
      out.write("\t</style>\r\n");
      out.write("<meta http-equiv=\"Content-Language\" content=\"en-us\">\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1256\">\r\n");
      out.write("<title>CDRs Report</title>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write(" \r\n");
      out.write("\r\n");
      out.write(" \r\n");
      out.write("\r\n");
      out.write("<form action='getReport.jsp' method='post'>\r\n");
      out.write("<input type='hidden' name='uid' value='41'>\r\n");
      out.write("<table border='0' bgcolor=#FFFFFF cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%' height='80'>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td width='21%' align='center'></td>\r\n");
      out.write("    <td width='35%' align='center'>\r\n");
      out.write("\r\n");
      out.write("    </td>\r\n");
      out.write("    <td width='19%' align='center'>\r\n");
      out.write("\r\n");
      out.write("    </td>\r\n");
      out.write("    <td bgcolor='#FFFFFF' width='15%' align='center'><IMG src='logo.png'></td>\r\n");
      out.write("  </tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("<br>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<table border='0' align='center' bgcolor=#FFFFFF cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='90%' height='40' >\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write(" </table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("            <table border='1' align='center' bgcolor=#F9DEA9 cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='40%'>\r\n");
      out.write("                  <tr>\r\n");
      out.write("                        <td>\r\n");
      out.write("                              <table border='0' align='center' bgcolor=#f4f4f4 cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>\r\n");
      out.write("                                          \r\n");
      out.write("                                          <td width='20%' align='center'><b>CDRs</b> </td>\r\n");
      out.write("                                          \r\n");
      out.write("                                          <td width='20%' align='center'>Day : <b>");
      out.print(leday);
      out.write("</b> </td>\r\n");
      out.write("                                          \r\n");
      out.write("                                          \r\n");
      out.write("                                          <td width='2%' align='center'>&nbsp;</td>\r\n");
      out.write("                                          \r\n");
      out.write("                                          \r\n");
      out.write("                                          <td width='20%' align='center'>Operator : <b>");
      out.print(theoperator);
      out.write("</b> </td>                                          \r\n");
      out.write("                                          \r\n");
      out.write("                                         \r\n");
      out.write("                              </table>\r\n");
      out.write("                        </td>\r\n");
      out.write("                  </tr>\r\n");
      out.write("\r\n");
      out.write("            </table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write(" \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<table width='55%' align='center'>\r\n");
      out.write("\t\r\n");
      out.write("\t<tr >\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("<td width=100% valign=top>\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\r\n");
      out.write(" <table border='1' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>\r\n");
      out.write("\t\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("                 \t\r\n");
      out.write("                  <tr height=20 bgcolor=#f4f4f4>\r\n");
      out.write("                  <td  align='center'><font size='2'><b>ID</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>Call Start</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>Call End</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>Operator</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>Shortcode</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>Caller</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>Seconds</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>Minutes</b></font></td>                        \r\n");
      out.write("                  </tr>\r\n");
      out.write("                  \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("                                    \r\n");
      out.write("                  \t\r\n");
      out.write("\t\r\n");
      out.write("\t\t");

	
			   rs = null;
			   rs = con.createStatement().executeQuery(query3);  
			while(rs.next())
			{
				String id =rs.getString(1);
				String start =rs.getString(2);
				String end =rs.getString(3);
				String operator= rs.getString(4);
				String shortcode =rs.getString(5);
				String caller =rs.getString(6);
				String seconds =rs.getString(7);
				String minutes =rs.getString(8);								
				
			
	
			
      out.write("\r\n");
      out.write("\t\t\t\t\t\t  <tr height=20 bgcolor=#ffffff   >\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'  ><font size='2'>");
      out.print(id);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'  ><font size='2'>");
      out.print(start);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'  ><font size='2'>");
      out.print(end);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'  ><font size='2'>");
      out.print(operator);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'  ><font size='2'>");
      out.print(shortcode);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'  ><font size='2'>");
      out.print(caller);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'  ><font size='2'>");
      out.print(seconds);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'  ><font size='2'>");
      out.print(minutes);
      out.write("</font></td>\t\t\t\t\t\t\t\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t\t\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t  </tr>\r\n");
      out.write("\t\t\t");

			}
			rs.close();rs = null;
			
			
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t  </table>\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t<textarea>");
      out.print(query3);
      out.write("</textarea>\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t\t\r\n");
      out.write("\t</td>\t\r\n");
      out.write("\t\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t</tr>\r\n");
      out.write("   \r\n");
      out.write("</table>   \r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("</body>\r\n");
      out.write("\r\n");
      out.write("</html>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");



con.close();



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
