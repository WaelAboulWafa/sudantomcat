/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2015-05-05 13:21:17 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.jsp.plugin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class plugin_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<title> Plugin example </title>\r\n");
      out.write("<body bgcolor=\"white\">\r\n");
      out.write("<h3> Current time is : </h3>\r\n");
      out.write("<object classid=\"clsid:8AD9C840-044E-11D1-B3E9-00805F499D93\"" + " width=\"" + "160" + "\"" + " height=\"" + "150" + "\"" + " codebase=\"http://java.sun.com/products/plugin/1.2.2/jinstall-1_2_2-win.cab#Version=1,2,2,0\">");
      out.write("\n");
      out.write("<param name=\"java_code\" value=\"Clock2.class\">");
      out.write("\n");
      out.write("<param name=\"java_codebase\" value=\"applet\">");
      out.write("\n");
      out.write("<param name=\"type\" value=\"application/x-java-applet;version=1.2\">");
      out.write("\n");
      out.write("<comment>");
      out.write("\n");
      out.write("<EMBED type=\"application/x-java-applet;version=1.2\"" + " width=\"" + "160" + "\"" + " height=\"" + "150" + "\"" + " pluginspage=\"http://java.sun.com/products/plugin/\" java_code=\"Clock2.class\" java_codebase=\"applet\"");
      out.write("/>");
      out.write("\n");
      out.write("<noembed>");
      out.write("\n");
      out.write("\r\n");
      out.write("        Plugin tag OBJECT or EMBED not supported by browser.\r\n");
      out.write("    ");
      out.write("\n");
      out.write("</noembed>");
      out.write("\n");
      out.write("</comment>");
      out.write("\n");
      out.write("</object>");
      out.write("\n");
      out.write("\r\n");
      out.write("<p>\r\n");
      out.write("<h4>\r\n");
      out.write("<font color=red>\r\n");
      out.write("The above applet is loaded using the Java Plugin from a jsp page using the\r\n");
      out.write("plugin tag.\r\n");
      out.write("</font>\r\n");
      out.write("</h4>\r\n");
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
