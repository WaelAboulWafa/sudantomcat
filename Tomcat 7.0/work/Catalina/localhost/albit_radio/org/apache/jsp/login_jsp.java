/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2015-06-14 07:19:06 UTC
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

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<html dir='rtl'>\r\n");
      out.write("<head>\r\n");
      out.write("<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt arial, geneva, lucida, \"lucida grande\", arial, helvetica, sans-serif; COLOR: #000000 }</style>\r\n");
      out.write("<meta http-equiv=\"Content-Language\" content=\"en-ar\">\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1256\">\r\n");
      out.write("<title>دخــول ... National Radio</title>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body >\r\n");
      out.write("<table border='2' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#BBBBBB' width='100%'>\r\n");
      out.write("\t<tr height=60>\r\n");
      out.write("    <td bgcolor='#E6E6E6' width='15%' align='center'><IMG src='logo.png'></td>\r\n");
      out.write("\t\t<td bgcolor='#E6E6E6' width='85%' align='center'>&nbsp;<font size='5'><b><i> من فضلك ادخل اسم المستخدم و كلمة المرور</i></b></font>&nbsp;</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</table>\t\r\n");
      out.write("<br><br><br>\r\n");
      out.write("<table border='1' bgcolor='#E6E6E6' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#BBBBBB' width='30%' height='100'>\r\n");
      out.write("<form action=\"Authenticate.jsp\" method=\"post\">\r\n");
      out.write("\t<tr height=80 align=\"center\">\r\n");
      out.write("\t\t<td width='80%'><font color=#000000><b>اسـم المسـتخدم&nbsp;&nbsp;</b></font><input dir='ltr' type=\"text\" name=\"username\"><font color=#000000></font></td>\r\n");
      out.write("\t\t<td width='20%'><IMG src='user.gif'></TD>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr height=80 align=\"center\">\r\n");
      out.write("\t\t<td><font color=#000000><b>كلمـة المــرور&nbsp;&nbsp;</b></font><input dir='ltr' type=\"password\" name=\"password\"><font color=#000000></font></td>\r\n");
      out.write("\t\t<td><IMG src='pass.gif'></TD>\r\n");
      out.write("\t</tr>\r\n");
      out.write("\t<tr height='40'>\r\n");
      out.write("\t\t<td colspan='3' align='center'><input type=\"submit\" value=\"دخـول\" style=\"font-weight:bold;font-size:14pt;width:12em;height:3em\"></td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</form>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<br>\r\n");
      out.write("\r\n");
      out.write(" \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
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
