/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2015-09-07 08:17:39 UTC
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

public final class test_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html; charset=ISO-8859-1");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE HTML>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("<title>Rittal Call Center</title>\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\n");
      out.write("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1\">\n");
      out.write("<link href=\"css/style.css\" rel=\"stylesheet\" type=\"text/css\" media=\"all\"/>\n");
      out.write("<link href=\"css/nav.css\" rel=\"stylesheet\" type=\"text/css\" media=\"all\"/>\n");
      out.write("<link href='css/font.css' rel='stylesheet' type='text/css'>\n");
      out.write("\n");
      out.write("<!-- Latest compiled and minified CSS -->\n");
      out.write("\t<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css\">\n");
      out.write("\n");
      out.write("\t<!-- Optional theme -->\n");
      out.write("\t<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css\">\n");
      out.write("\t\n");
      out.write("\n");
      out.write("<script type=\"text/javascript\" src=\"js/jquery.js\"></script>\n");
      out.write("<script type=\"text/javascript\" src=\"js/login.js\"></script>\n");
      out.write("<script type=\"text/javascript\" src=\"js/Chart.js\"></script>\n");
      out.write(" <script type=\"text/javascript\" src=\"js/jquery.easing.js\"></script>\n");
      out.write(" <script type=\"text/javascript\" src=\"js/jquery.ulslide.js\"></script>\n");
      out.write(" <!----Calender -------->\n");
      out.write("  <link rel=\"stylesheet\" href=\"css/clndr.css\" type=\"text/css\" />\n");
      out.write("  <script src=\"js/underscore-min.js\"></script>\n");
      out.write("  <script src= \"js/moment-2.2.1.js\"></script>\n");
      out.write("  <script src=\"js/clndr.js\"></script>\n");
      out.write("  <script src=\"js/site.js\"></script>\n");
      out.write("  <!----End Calender -------->\n");
      out.write("\n");
      out.write("\n");
      out.write("  <style>\n");
      out.write("  body {\n");
      out.write("      position: relative; \n");
      out.write("  }\n");
      out.write(" \n");
      out.write("  #section1 {padding-top:30px;height:500px;}\n");
      out.write("  #section2 {padding-top:30px;height:500px;}\n");
      out.write("  </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");


////////////// Session Attributes //////////////////

String username = session.getAttribute("username").toString().trim();
String service_id = session.getAttribute("service_id").toString().trim();



/////////////////////////// Dates //////////////////////////////////

	String theSdate =(new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date((new java.util.Date()).getTime())).trim();
	String theEdate =(new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date( (new java.util.Date()).getTime())).trim();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	Calendar c = Calendar.getInstance();
	c.setTime(sdf.parse(theEdate));
	c.add(Calendar.DATE, 1);  // number of days to add
	theEdate = sdf.format(c.getTime());
	
	Calendar cal = Calendar.getInstance();
	String month = new SimpleDateFormat("MMM").format(cal.getTime());
	Calendar ye = Calendar.getInstance();
	String year = new SimpleDateFormat("YYYY").format(ye.getTime());
	Calendar tday = Calendar.getInstance();
	String today = new SimpleDateFormat("YYYY-MM-dd").format(tday.getTime());
	
	String fdate = "";try{fdate = request.getParameter("fdate").trim();}catch(Exception e){fdate = theSdate;}
	String tdate = "";try{tdate = request.getParameter("tdate").trim();}catch(Exception e){tdate = theEdate;}
	
	   
	String sdate_formated = fdate.substring(0,4) + "-" + fdate.substring(4,6) + "-" + fdate.substring(6,8);
	String edate_formated = tdate.substring(0,4) + "-" + tdate.substring(4,6) + "-" + tdate.substring(6,8);
	
	String month_start = fdate.substring(0,4) + "-" + fdate.substring(4,6) + "-01";
	
////////////////////////// End Of Dates ///////////////////////////

	Connection con=null;
	InitialContext ic = new InitialContext();
	DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
	con  = ds.getConnection();
	ResultSet rs = null;
	
	Connection con1=null;
	InitialContext ic1 = new InitialContext();
	DataSource ds1 = (DataSource) ic1.lookup("java:comp/env/jdbc/TheDB2");
	con1  = ds1.getConnection();
	ResultSet rs1 = null;
	
	String theService = "";
	String queryService = "";
	queryService = "SELECT service_name FROM reporting.rep_user WHERE username ='"+username+"' ";
	rs = con.createStatement().executeQuery(queryService);
	
	while(rs.next()){
		theService = rs.getString(1);
	}
	rs = null;
	int srvcount = 0;
	rs = con.createStatement().executeQuery("SELECT count(*) from reporting.rep_service where appname ='"+theService+"' ");
	while(rs.next()){
		srvcount = rs.getInt(1);
	}
	
	rs = null;

	String queryservdetails = "SELECT dst, operator ";
	queryservdetails = queryservdetails + "FROM ucp_user.cdr ";
	queryservdetails = queryservdetails + "WHERE app_name='"+ theService +"' and operator !='Unknown'";
	queryservdetails = queryservdetails + "group by operator ";
	
	String detailQuery = "SELECT operator, app_name,dst,count(*) as thecnt , sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as Minutes"; 
		   detailQuery = detailQuery + " FROM ucp_user.cdr ";
		   detailQuery = detailQuery + " where call_start_date between '"+sdate_formated+"' and '"+edate_formated+"'"; 
		   detailQuery = detailQuery + " and operator in ('SudaTel' , 'MTN' , 'Zain') and app_name='"+theService+"'";
		   detailQuery = detailQuery + " group by app_name,dst, operator order by app_name" ;
	
	
	String[] theShortcodes = new String[srvcount] ;
	String[] theOperators = new String[srvcount] ;

    // Totals
    
    String totalsquery = "SELECT count(*) ,sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) )";
    	   totalsquery = totalsquery + "FROM ucp_user.cdr where call_start_date between '"+sdate_formated+"' and '"+edate_formated+"'";
    	   totalsquery = totalsquery + "and operator in ('SudaTel' , 'MTN' , 'Zain') and app_name='"+theService+"'";
	
 ////////////// getting Dashboard stuff ////////////////

  
  //Connection con1=null;
  //InitialContext ic1 = new InitialContext();
  //DataSource ds1 = (DataSource) ic1.lookup("java:comp/env/jdbc/TheDB2");
  //con1  = ds1.getConnection();
  rs1 = null;
  int Zain = 1;
  rs1 = con1.createStatement().executeQuery("select sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as minutes from cdr  where dst  in ('1653','87015002', '6631') and operator = 'Zain' and call_start_date between '"+month_start+"' and '"+today+"';");
  while(rs1.next()){
	  Zain = rs1.getInt(1); 
  }
  rs1 = null;
 
  int MTN = 1;
  rs1 = con1.createStatement().executeQuery("select sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as minutes from cdr  where dst  in ('1653','87015002', '6631') and operator = 'MTN' and call_start_date between '"+month_start+"' and '"+today+"';");
  while(rs1.next()){
	  MTN = rs1.getInt(1); 
  }
  rs1 = null;
  
  int SudaTel = 1;
  rs1 = con1.createStatement().executeQuery("select sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as minutes from cdr  where dst  in ('1653','87015002', '6631') and operator = 'SudaTel' and call_start_date between '"+month_start+"' and '"+today+"';");
  while(rs1.next()){
	  SudaTel = rs1.getInt(1); 
  }
  rs1 = null;
 
  int Total = 1;
  rs1 = con1.createStatement().executeQuery("select sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as minutes from cdr  where dst  in ('1653','87015002', '6631') and call_start_date between '"+month_start+"' and '"+today+"';");
  while(rs1.next()){
	  Total = rs1.getInt(1); 
  }
  rs1 = null;
  
  int zain = (int) Math.floor((float) (Zain*100)/Total);
  int sudatel = (int) Math.floor((float) (SudaTel*100)/Total);
  int mtn = (int) Math.floor((float) (MTN*100)/Total);
////////////////////// End of Dashboard stuff /////////////////////////////


      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<header>\n");
      out.write("\t\t<div class=\"navbar navbar-default navbar-fixed-top navbar-inverse\">\n");
      out.write("\t\t\t<div class=\"container\">\n");
      out.write("\t\t\t\t<div class=\"navbar-header\">\n");
      out.write("\t\t\t\t\t<button type=\"button\" class=\"navbar-toggle\" data-toggle=\"collapse\" data-target=\"#example\">\n");
      out.write("\t\t\t\t\t\t<span class=\"icon-bar\"></span>\n");
      out.write("\t\t\t\t\t\t<span class=\"icon-bar\"></span>\n");
      out.write("\t\t\t\t\t\t<span class=\"icon-bar\"></span>\n");
      out.write("\t\t\t\t\t</button>\n");
      out.write("\t\t\t\t\t<a class=\"navbar-brand\" href=\"#\">Admin Panel</a>\n");
      out.write("\t\t\t\t\t<a href=\"\" class=\"navbar-brand\">Settings</a>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t\t<div class=\"collpase navbar-collapse\" id=\"example\">\n");
      out.write("\t\t\t\t\t<ul class=\"nav navbar-nav\">\n");
      out.write("\t\t\t\t\t\t<li class=\"active\"><a href=\"#section1\">IVR Report</a></li>\n");
      out.write("\t\t\t\t\t\t<li ><a href=\"#section2\">Agent Report</a></li>\n");
      out.write("\t\t\t\t\t</ul>\n");
      out.write("\n");
      out.write("\t\t\t\t\t\n");
      out.write("\n");
      out.write("\t\t\t\t\t\n");
      out.write("             \t  <div class=\"profile_details\">\n");
      out.write("\t\t\t\t    \t\t   <div id=\"loginContainer\">\n");
      out.write("\t\t\t\t                  <a id=\"loginButton\" class=\"\"><span>Me</span></a>   \n");
      out.write("\t\t\t\t                    <div id=\"loginBox\">                \n");
      out.write("\t\t\t\t                      <form id=\"loginForm\">\n");
      out.write("\t\t\t\t                        <fieldset id=\"body\">\n");
      out.write("\t\t\t\t                            <div class=\"user-info\">\n");
      out.write("\t\t\t\t\t\t\t        \t\t\t<h4>Hello,<a href=\"#\"> Username</a></h4>\n");
      out.write("\t\t\t\t\t\t\t        \t\t\t<ul>\n");
      out.write("\t\t\t\t\t\t\t        \t\t\t\t<li class=\"profile active\"><a href=\"#\">Profile </a></li>\n");
      out.write("\t\t\t\t\t\t\t        \t\t\t\t<li class=\"logout\"><a href=\"#\"> Logout</a></li>\n");
      out.write("\t\t\t\t\t\t\t        \t\t\t\t<div class=\"clear\"></div>\t\t\n");
      out.write("\t\t\t\t\t\t\t        \t\t\t</ul>\n");
      out.write("\t\t\t\t\t\t\t        \t\t</div>\t\t\t                            \n");
      out.write("\t\t\t\t                        </fieldset>\n");
      out.write("\t\t\t\t                    </form>\n");
      out.write("\t\t\t\t                </div>\n");
      out.write("\t\t\t\t            </div>\n");
      out.write("\t\t\t\t             <div class=\"profile_img\">\t\n");
      out.write("\t\t\t\t             \t<a href=\"#\"><img src=\"images/profile_img40x40.jpg\" alt=\"\" />\t</a>\n");
      out.write("\t\t\t\t             </div>\t\t\n");
      out.write("\t\t\t\t             <div class=\"clear\"></div>\t\t  \t\n");
      out.write("\t\t\t\t\t    </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t</div>\n");
      out.write("\t\t\t<div class=\"jumbotron\">\n");
      out.write("\t\t\t\t<div class=\"container\">\n");
      out.write("\t\t\t\t<div align=\"center\" id=\"div-1c\">\n");
      out.write("<table border='1' align='center' bgcolor=#1975FF cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='50%' >\n");
      out.write("                 <form action='test.jsp' method='post'>\n");
      out.write("                  <tr>\n");
      out.write("                        <td>\n");
      out.write("                              <table border='0' align='center' bgcolor=#4FC4F6 cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>\n");
      out.write("                                          <td width='5%' align='center'><b><input class=\"button-secondary pure-button\" type=button value=\"From\" onclick=\"displayDatePicker('fdate', this);\"></td>\n");
      out.write("                                          <td width='20%' align='center'><input  style='font-size:10pt;color:#000000;font-weight:bold;width:8em;height:1.7em' type=\"text\" readonly name=\"fdate\" id=\"idate\" value='");
      out.print(fdate);
      out.write("' ></td>\n");
      out.write("                                          <td width='5%' align='center'><b><input class=\"button-secondary pure-button\" type=button value=\"To\" onclick=\"displayDatePicker('tdate', this);\"></b></td>\n");
      out.write("                                          <td width='20%' align='center'><input style='font-size:10pt;color:#000000;font-weight:bold;width:8em;height:1.7em' type=\"text\"  readonly name=\"tdate\" id=\"idate\" value='");
      out.print(tdate);
      out.write("'></td>\n");
      out.write("                                         \n");
      out.write("                                          <td width='10%' align='right'><input class=\"button-success pure-button pure-button-primary\" type='submit' name='subReport' value='Get Report' STYLE='font-weight:bold ; color:#ffffff; width:8em; height:2.2em'></td>\n");
      out.write("                              </table>\n");
      out.write("                        </td>\n");
      out.write("                  </tr>\n");
      out.write("                </form>\n");
      out.write("            </table>\n");
      out.write("\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("\t\t\t\t</div> \n");
      out.write("\t\t\t</div> \n");
      out.write("\t</header>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!-- vd -->\n");
      out.write("\n");
      out.write("<div class=\"container-fluid\">\n");
      out.write("            <div class=\"row-fluid\">\n");
      out.write("                <div class=\"span3\" id=\"sidebar\">\n");
      out.write("                    <ul class=\"nav nav-list bs-docs-sidenav nav-collapse collapse\">\n");
      out.write("                        <li class=\"active\">\n");
      out.write("                            <a href=\"index.html\"><i class=\"icon-chevron-right\"></i> Dashboard iiiiii</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"calendar.html\"><i class=\"icon-chevron-right\"></i> Calendar</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"stats.html\"><i class=\"icon-chevron-right\"></i> Statistics (Charts)</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"form.html\"><i class=\"icon-chevron-right\"></i> Forms</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"tables.html\"><i class=\"icon-chevron-right\"></i> Tables</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"buttons.html\"><i class=\"icon-chevron-right\"></i> Buttons & Icons</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"editors.html\"><i class=\"icon-chevron-right\"></i> WYSIWYG Editors</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"interface.html\"><i class=\"icon-chevron-right\"></i> UI & Interface</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"#\"><span class=\"badge badge-success pull-right\">731</span> Orders</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"#\"><span class=\"badge badge-success pull-right\">812</span> Invoices</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"#\"><span class=\"badge badge-info pull-right\">27</span> Clients</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"#\"><span class=\"badge badge-info pull-right\">1,234</span> Users</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"#\"><span class=\"badge badge-info pull-right\">2,221</span> Messages</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"#\"><span class=\"badge badge-info pull-right\">11</span> Reports</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"#\"><span class=\"badge badge-important pull-right\">83</span> Errors</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"#\"><span class=\"badge badge-warning pull-right\">4,231</span> Logs</a>\n");
      out.write("                        </li>\n");
      out.write("                    </ul>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("<!-- dcd-->\n");
      out.write("\t    \n");
      out.write("            \n");
      out.write("             \n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("    <div  id= \"section1\" class=\"container\">\n");
      out.write("\n");
      out.write("    \t<div class=\"row\">\n");
      out.write("    \t\t<div class=\"col-ms-12\">\n");
      out.write("\t\t\t\t\n");
      out.write("<!-- End of Date Picker -->\n");
      out.write("\n");
      out.write("<div align='center' style=\"width:30%; float:right;\"  id=\"div-1a\">\n");
      out.write("\n");
      out.write("\t<table class=\"pure-table\" border='1'  bgcolor=#f4f4f4 cellpadding='0' cellspacing='0' style='border-collapse: collapse;float:right;' bordercolor='#111111' width='100%'>\n");
      out.write("\t\t<tr height=20 bgcolor=#1975FF>\n");
      out.write("                        <td colspan=4 align='center'><font size='2' color=\"white\"><b>Per Shortcode/Operator</b></font></td>\n");
      out.write("        </tr>\n");
      out.write("\t\t<tr bgcolor=#4791FF>\n");
      out.write("\t\t\t<th><font color=\"white\"> Operator</font> </th>\n");
      out.write("\t\t\t<th><font color=\"white\"> Service owner</font> </th>\n");
      out.write("\t\t\t<!--<th><font color=\"white\"> ShortCode </font></th>-->\n");
      out.write("\t\t\t<th><font color=\"white\"> Hits </font></th>\n");
      out.write("\t\t\t<th><font color=\"white\"> Minutes </font></th>\t\t\n");
      out.write("\t\t</tr>\n");
      out.write("\t\t<tr>\n");
      out.write("\t\t\n");
      out.write("\t\t");

		rs1 = con1.createStatement().executeQuery(detailQuery);
		int i = 0, hits = 0, minutes = 0 ;
		String operator = "";
		String srvowner = "";
		String shortcode = "";
	
		while(rs1.next()){
			operator = rs1.getString(1);
			srvowner = rs1.getString(2);
			shortcode = rs1.getString(3);
			hits = rs1.getInt(4);
			minutes = rs1.getInt(5);
			
      out.write("\n");
      out.write("\t\t\t<tr height=20 bgcolor=#ffffff>\n");
      out.write("\t\t\t\t<td>");
      out.print(operator );
      out.write("</td>\n");
      out.write("\t\t\t\t<td>");
      out.print(srvowner );
      out.write("</td>\n");
      out.write("\t\t\t\t<!--<td>");
      out.print(shortcode );
      out.write("</td>-->\n");
      out.write("\t\t\t\t<td>");
      out.print(hits );
      out.write("</td>\n");
      out.write("\t\t\t\t<td>");
      out.print(minutes );
      out.write("</td>\n");
      out.write("\t\t\t</tr>\n");
      out.write("\t\t\t");

		}
		
		rs1 = null;
		
		rs1 = con1.createStatement().executeQuery(totalsquery);
		int totalCalls = 0, totalMinutes = 0;
		
		while(rs1.next()){
			
			totalCalls = rs1.getInt(1);
			totalMinutes = rs1.getInt(2);
			
		}
		
		
      out.write("\n");
      out.write("\t\t<tr bgcolor=#4FC4F6 >\n");
      out.write("\t\t\t<td colspan=\"2\" ><font size='5' color=#FFFFFF>Total</font></td><td><font size='4' color=#0000FF>");
      out.print(totalCalls );
      out.write("</font></td><td><font size='4' color=#0000FF>");
      out.print(totalMinutes );
      out.write("</font></td>\n");
      out.write("\t\t</tr>\n");
      out.write("\t</table>\n");
      out.write("\n");
      out.write("</div>\n");
      out.write("<!-- ///////////////////////////  DASHBOARD START ////////////////////////////// -->\n");
      out.write("\n");
      out.write("<div class=\"chart\" style=\"width:40%; margin-left:0%; padding-left: 0%;float:left;\"  id=\"div-1b\">\n");
      out.write("\t\t               <h3>Operators Status</h3>\n");
      out.write("\t\t                <div class=\"diagram\">\n");
      out.write("\t\t                  <canvas id=\"canvas\" height=\"220\" width=\"220\"> </canvas>\n");
      out.write("\t\t                  <h4 align=\"center\"><span>");
      out.print(month );
      out.write("</span><br />");
      out.print(year );
      out.write("</h4>   \n");
      out.write("\t\t                 </div>\n");
      out.write("\t\t                     \n");
      out.write("\t\t               \t<!--                \n");
      out.write("\t\t\t\t\t\t<span><img src=\"images/chart.png\" alt=\"\" /></span>\n");
      out.write("\t\t\t\t\t\t-->\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t<div class=\"chart_list\">\n");
      out.write("\t\t\t           \t  <ul>\n");
      out.write("\t\t\t           \t  \t<li><a href=\"#\" class=\"red\">Zain<p class=\"percentage\">");
      out.print(zain );
      out.write("<em>%</em></p></a></li>\n");
      out.write("\t\t\t           \t  \t<li><a href=\"#\" class=\"yellow\">MTN<p class=\"percentage\">");
      out.print(mtn );
      out.write("<em>%</em></p></a></li>\n");
      out.write("\t\t\t           \t  \t<li><a href=\"#\" class=\"blue\">Sudatel<p class=\"percentage\">");
      out.print(sudatel );
      out.write("<em>%</em></p></a></li>\n");
      out.write("\t\t\t           \t  \t<div class=\"clear\"></div>\t\n");
      out.write("\t\t\t           \t  </ul>\n");
      out.write("\t\t\t           </div>\n");
      out.write("\t\t\t           <script>\n");
      out.write("\t\t\t\t\t\tvar doughnutData = [\n");
      out.write("\t\t\t\t\t\t\t\t{\n");
      out.write("\t\t\t\t\t\t\t\t\tvalue: ");
      out.print(zain);
      out.write(",\n");
      out.write("\t\t\t\t\t\t\t\t\tcolor:\"#E64C65\"\n");
      out.write("\t\t\t\t\t\t\t\t},\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\t\t{\n");
      out.write("\t\t\t\t\t\t\t\t\tvalue : ");
      out.print(sudatel );
      out.write(",\n");
      out.write("\t\t\t\t\t\t\t\t\tcolor : \"#4FC4F6\"\n");
      out.write("\t\t\t\t\t\t\t\t},\t\n");
      out.write("\t\t\t\t\t\t\t\t{\n");
      out.write("\t\t\t\t\t\t\t\t\tvalue : ");
      out.print(mtn );
      out.write(",\n");
      out.write("\t\t\t\t\t\t\t\t\tcolor : \"#FCB150\"\n");
      out.write("\t\t\t\t\t\t\t\t},\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\t];\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\tvar myDoughnut = new Chart(document.getElementById(\"canvas\").getContext(\"2d\")).Doughnut(doughnutData);\t\t\t\t\t\n");
      out.write("\t\t\t\t\t</script>\n");
      out.write("\t\t          </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!-- ///////////////////////////  DASHBOARD END   ////////////////////////////// -->\t\n");
      out.write("    \t\t</div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("    \t\t\n");
      out.write("    \t</div>\t\t\n");
      out.write("\n");
      out.write("      </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("      \n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\t\t\t\n");
      out.write("\t\t\t\n");
      out.write("\t\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\t  \n");
      out.write(" ");

con.close();
con1.close();

      out.write("\n");
      out.write("  \t\t    \n");
      out.write("</body>\n");
      out.write("</html>\n");
      out.write("\n");
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
