/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2015-05-05 13:21:18 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.jsp.jsp2.tagfiles;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class panel_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(1);
    _jspx_dependants.put("/WEB-INF/tags/panel.tag", Long.valueOf(1400527982000L));
  }

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
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("    <title>JSP 2.0 Examples - Panels using Tag Files</title>\r\n");
      out.write("  </head>\r\n");
      out.write("  <body>\r\n");
      out.write("    <h1>JSP 2.0 Examples - Panels using Tag Files</h1>\r\n");
      out.write("    <hr>\r\n");
      out.write("    <p>This JSP page invokes a custom tag that draws a\r\n");
      out.write("    panel around the contents of the tag body.  Normally, such a tag\r\n");
      out.write("    implementation would require a Java class with many println() statements,\r\n");
      out.write("    outputting HTML.  Instead, we can use a .tag file as a template,\r\n");
      out.write("    and we don't need to write a single line of Java or even a TLD!</p>\r\n");
      out.write("    <hr>\r\n");
      out.write("    <table border=\"0\">\r\n");
      out.write("      <tr valign=\"top\">\r\n");
      out.write("        <td>\r\n");
      out.write("          ");
      if (_jspx_meth_tags_005fpanel_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("        </td>\r\n");
      out.write("        <td>\r\n");
      out.write("          ");
      if (_jspx_meth_tags_005fpanel_005f1(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("        </td>\r\n");
      out.write("        <td>\r\n");
      out.write("          ");
      if (_jspx_meth_tags_005fpanel_005f2(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("        </td>\r\n");
      out.write("      </tr>\r\n");
      out.write("    </table>\r\n");
      out.write("  </body>\r\n");
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

  private boolean _jspx_meth_tags_005fpanel_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  tags:panel
    org.apache.jsp.tag.webpanel_tag _jspx_th_tags_005fpanel_005f0 = (new org.apache.jsp.tag.webpanel_tag());
    _jsp_instancemanager.newInstance(_jspx_th_tags_005fpanel_005f0);
    _jspx_th_tags_005fpanel_005f0.setJspContext(_jspx_page_context);
    // /jsp/jsp2/tagfiles/panel.jsp(34,10) name = color type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
    _jspx_th_tags_005fpanel_005f0.setColor("#ff8080");
    // /jsp/jsp2/tagfiles/panel.jsp(34,10) name = bgcolor type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
    _jspx_th_tags_005fpanel_005f0.setBgcolor("#ffc0c0");
    // /jsp/jsp2/tagfiles/panel.jsp(34,10) name = title type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
    _jspx_th_tags_005fpanel_005f0.setTitle("Panel 1");
    _jspx_th_tags_005fpanel_005f0.setJspBody(new Helper( 0, _jspx_page_context, _jspx_th_tags_005fpanel_005f0, null));
    _jspx_th_tags_005fpanel_005f0.doTag();
    _jsp_instancemanager.destroyInstance(_jspx_th_tags_005fpanel_005f0);
    return false;
  }

  private boolean _jspx_meth_tags_005fpanel_005f1(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  tags:panel
    org.apache.jsp.tag.webpanel_tag _jspx_th_tags_005fpanel_005f1 = (new org.apache.jsp.tag.webpanel_tag());
    _jsp_instancemanager.newInstance(_jspx_th_tags_005fpanel_005f1);
    _jspx_th_tags_005fpanel_005f1.setJspContext(_jspx_page_context);
    // /jsp/jsp2/tagfiles/panel.jsp(39,10) name = color type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
    _jspx_th_tags_005fpanel_005f1.setColor("#80ff80");
    // /jsp/jsp2/tagfiles/panel.jsp(39,10) name = bgcolor type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
    _jspx_th_tags_005fpanel_005f1.setBgcolor("#c0ffc0");
    // /jsp/jsp2/tagfiles/panel.jsp(39,10) name = title type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
    _jspx_th_tags_005fpanel_005f1.setTitle("Panel 2");
    _jspx_th_tags_005fpanel_005f1.setJspBody(new Helper( 1, _jspx_page_context, _jspx_th_tags_005fpanel_005f1, null));
    _jspx_th_tags_005fpanel_005f1.doTag();
    _jsp_instancemanager.destroyInstance(_jspx_th_tags_005fpanel_005f1);
    return false;
  }

  private boolean _jspx_meth_tags_005fpanel_005f2(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  tags:panel
    org.apache.jsp.tag.webpanel_tag _jspx_th_tags_005fpanel_005f2 = (new org.apache.jsp.tag.webpanel_tag());
    _jsp_instancemanager.newInstance(_jspx_th_tags_005fpanel_005f2);
    _jspx_th_tags_005fpanel_005f2.setJspContext(_jspx_page_context);
    // /jsp/jsp2/tagfiles/panel.jsp(47,10) name = color type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
    _jspx_th_tags_005fpanel_005f2.setColor("#8080ff");
    // /jsp/jsp2/tagfiles/panel.jsp(47,10) name = bgcolor type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
    _jspx_th_tags_005fpanel_005f2.setBgcolor("#c0c0ff");
    // /jsp/jsp2/tagfiles/panel.jsp(47,10) name = title type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
    _jspx_th_tags_005fpanel_005f2.setTitle("Panel 3");
    _jspx_th_tags_005fpanel_005f2.setJspBody(new Helper( 2, _jspx_page_context, _jspx_th_tags_005fpanel_005f2, null));
    _jspx_th_tags_005fpanel_005f2.doTag();
    _jsp_instancemanager.destroyInstance(_jspx_th_tags_005fpanel_005f2);
    return false;
  }

  private boolean _jspx_meth_tags_005fpanel_005f3(javax.servlet.jsp.tagext.JspTag _jspx_parent, javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  tags:panel
    org.apache.jsp.tag.webpanel_tag _jspx_th_tags_005fpanel_005f3 = (new org.apache.jsp.tag.webpanel_tag());
    _jsp_instancemanager.newInstance(_jspx_th_tags_005fpanel_005f3);
    _jspx_th_tags_005fpanel_005f3.setJspContext(_jspx_page_context);
    _jspx_th_tags_005fpanel_005f3.setParent(_jspx_parent);
    // /jsp/jsp2/tagfiles/panel.jsp(49,12) name = color type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
    _jspx_th_tags_005fpanel_005f3.setColor("#ff80ff");
    // /jsp/jsp2/tagfiles/panel.jsp(49,12) name = bgcolor type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
    _jspx_th_tags_005fpanel_005f3.setBgcolor("#ffc0ff");
    // /jsp/jsp2/tagfiles/panel.jsp(49,12) name = title type = java.lang.String reqTime = true required = false fragment = false deferredValue = false expectedTypeName = java.lang.String deferredMethod = false methodSignature = null
    _jspx_th_tags_005fpanel_005f3.setTitle("Inner");
    _jspx_th_tags_005fpanel_005f3.setJspBody(new Helper( 3, _jspx_page_context, _jspx_th_tags_005fpanel_005f3, null));
    _jspx_th_tags_005fpanel_005f3.doTag();
    _jsp_instancemanager.destroyInstance(_jspx_th_tags_005fpanel_005f3);
    return false;
  }

  private class Helper
      extends org.apache.jasper.runtime.JspFragmentHelper
  {
    private javax.servlet.jsp.tagext.JspTag _jspx_parent;
    private int[] _jspx_push_body_count;

    public Helper( int discriminator, javax.servlet.jsp.JspContext jspContext, javax.servlet.jsp.tagext.JspTag _jspx_parent, int[] _jspx_push_body_count ) {
      super( discriminator, jspContext, _jspx_parent );
      this._jspx_parent = _jspx_parent;
      this._jspx_push_body_count = _jspx_push_body_count;
    }
    public boolean invoke0( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("\r\n");
      out.write("            First panel.<br/>\r\n");
      out.write("          ");
      return false;
    }
    public boolean invoke1( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("\r\n");
      out.write("            Second panel.<br/>\r\n");
      out.write("            Second panel.<br/>\r\n");
      out.write("            Second panel.<br/>\r\n");
      out.write("            Second panel.<br/>\r\n");
      out.write("          ");
      return false;
    }
    public boolean invoke2( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("\r\n");
      out.write("            Third panel.<br/>\r\n");
      out.write("            ");
      if (_jspx_meth_tags_005fpanel_005f3(_jspx_parent, _jspx_page_context))
        return true;
      out.write("\r\n");
      out.write("            Third panel.<br/>\r\n");
      out.write("          ");
      return false;
    }
    public boolean invoke3( javax.servlet.jsp.JspWriter out ) 
      throws java.lang.Throwable
    {
      out.write("\r\n");
      out.write("              A panel in a panel.\r\n");
      out.write("            ");
      return false;
    }
    public void invoke( java.io.Writer writer )
      throws javax.servlet.jsp.JspException
    {
      javax.servlet.jsp.JspWriter out = null;
      if( writer != null ) {
        out = this.jspContext.pushBody(writer);
      } else {
        out = this.jspContext.getOut();
      }
      try {
        Object _jspx_saved_JspContext = this.jspContext.getELContext().getContext(javax.servlet.jsp.JspContext.class);
        this.jspContext.getELContext().putContext(javax.servlet.jsp.JspContext.class,this.jspContext);
        switch( this.discriminator ) {
          case 0:
            invoke0( out );
            break;
          case 1:
            invoke1( out );
            break;
          case 2:
            invoke2( out );
            break;
          case 3:
            invoke3( out );
            break;
        }
        jspContext.getELContext().putContext(javax.servlet.jsp.JspContext.class,_jspx_saved_JspContext);
      }
      catch( java.lang.Throwable e ) {
        if (e instanceof javax.servlet.jsp.SkipPageException)
            throw (javax.servlet.jsp.SkipPageException) e;
        throw new javax.servlet.jsp.JspException( e );
      }
      finally {
        if( writer != null ) {
          this.jspContext.popBody();
        }
      }
    }
  }
}
