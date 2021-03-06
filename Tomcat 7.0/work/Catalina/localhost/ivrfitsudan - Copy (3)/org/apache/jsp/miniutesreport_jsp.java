/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2015-05-18 08:33:54 UTC
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

public final class miniutesreport_jsp extends org.apache.jasper.runtime.HttpJspBase
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



  Connection con=null;
  InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();
  ResultSet rs = null;


/*
  int count = 0 ;
  rs = null;
  try
  {
   rs = con.createStatement().executeQuery("SELECT count(*) from cdr");             
   while(rs.next()){count = rs.getInt(1);} 
   rs.close();rs = null;
  }catch(Exception e){}
  
*/







String theSdate =(new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date((new java.util.Date()).getTime())).trim();
String theEdate =(new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date( (new java.util.Date()).getTime())).trim();
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
Calendar c = Calendar.getInstance();
c.setTime(sdf.parse(theEdate));
c.add(Calendar.DATE, 1);  // number of days to add
theEdate = sdf.format(c.getTime());



String fdate = "";try{fdate = request.getParameter("fdate").trim();}catch(Exception e){fdate = theSdate;}
String tdate = "";try{tdate = request.getParameter("tdate").trim();}catch(Exception e){tdate = theEdate;}

   
String sdate_formated = fdate.substring(0,4) + "-" + fdate.substring(4,6) + "-" + fdate.substring(6,8);
String edate_formated = tdate.substring(0,4) + "-" + tdate.substring(4,6) + "-" + tdate.substring(6,8);



String query1 = "";
query1 = query1 + " SELECT app_name,dst,count(*) as thecnt , " ;
query1 = query1 + " sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as Minutes FROM ucp_user.cdr  ";
query1 = query1 + " where DATE_FORMAT(call_start_date,'%Y-%m-%d') between '"+sdate_formated+"' and '"+edate_formated+"' and operator in ('SudaTel' , 'MTN' , 'Zain') ";

 
String query2 = "";
query2 = query2 + " SELECT count(*) as thecnt , " ;
query2 = query2 + " sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as Minutes FROM ucp_user.cdr  " ;
query2 = query2 + " where DATE_FORMAT(call_start_date,'%Y-%m-%d') between '"+sdate_formated+"' and '"+edate_formated+"' and operator in ('SudaTel' , 'MTN' , 'Zain') ";


String query3 = "";
query3 = query3 + " SELECT DATE_FORMAT(call_start_date,'%Y-%m-%d') as theday , ";
query3 = query3 + " count(*) as Total_Calls , " ; 
query3 = query3 + " sum(case when operator='SudaTel' then 1 else 0 end) as SudaTel_Calls , " ;
query3 = query3 + " sum(case when operator='MTN' then 1 else 0 end) as MTN_Calls , " ;
query3 = query3 + " sum(case when operator='Zain' then 1 else 0 end) as Zain_Calls , " ;
query3 = query3 + " sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as Total_Minutes , " ;
query3 = query3 + " sum(case when operator='SudaTel' then CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) else 0 end) as SudaTel_Minutes , " ;
query3 = query3 + " sum(case when operator='MTN' then CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) else 0 end) as MTN_Minutes , " ;
query3 = query3 + " sum(case when operator='Zain' then CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) else 0 end) as Zain_Minutes " ;
query3 = query3 + " FROM ucp_user.cdr  " ;
query3 = query3 + " where DATE_FORMAT(call_start_date,'%Y-%m-%d') between '"+sdate_formated+"' and '"+edate_formated+"' and operator in ('SudaTel' , 'MTN' , 'Zain') ";



String query4 = "";
query4 = query4 + " SELECT count(*) as Total_Calls ,  ";
query4 = query4 + " sum(case when operator='SudaTel' then 1 else 0 end) as SudaTel_Calls , ";
query4 = query4 + " sum(case when operator='MTN' then 1 else 0 end) as MTN_Calls , ";
query4 = query4 + " sum(case when operator='Zain' then 1 else 0 end) as Zain_Calls , ";
query4 = query4 + " sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as Total_Minutes , ";
query4 = query4 + " sum(case when operator='SudaTel' then CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) else 0 end) as SudaTel_Minutes , ";
query4 = query4 + " sum(case when operator='MTN' then CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) else 0 end) as MTN_Minutes , ";
query4 = query4 + " sum(case when operator='Zain' then CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) else 0 end) as Zain_Minutes  ";
query4 = query4 + " FROM ucp_user.cdr  " ;
query4 = query4 + " where DATE_FORMAT(call_start_date,'%Y-%m-%d') between '"+sdate_formated+"' and '"+edate_formated+"' and operator in ('SudaTel' , 'MTN' , 'Zain') ";








String filterservice = "ALL";
if( request.getParameter("filterservice")!=null) 
{
 if( !(request.getParameter("filterservice").trim().equalsIgnoreCase("ALL")) ) 
 { 
  filterservice= request.getParameter("filterservice");
  query1 = query1 + " and app_name='" + filterservice + "' ";
  query2 = query2 + " and app_name='" + filterservice + "' ";
  
  query3 = query3 + " and app_name='" + filterservice + "' ";
  
  query4 = query4 + " and app_name='" + filterservice + "' ";
   
 }
} 
   


///////////////THE services
int theservicescount = 0;
String[] theservices = null;

   try{
      rs = con.createStatement().executeQuery("SELECT appname,count(*) as thecnt FROM ucp_user.router where log =1 group by appname asc");            
      while(rs.next())
      {
     	 theservicescount = theservicescount + 1;
      }
       rs.close(); rs = null;

   rs = null;
   rs = con.createStatement().executeQuery("SELECT appname,count(*) as thecnt FROM ucp_user.router where log =1 group by appname asc");

 theservices = new String[theservicescount];
   
   
   int theCounterrr1 = 0;
   while(rs.next())
    {
     try{
         theservices[theCounterrr1] = rs.getString(1).trim();
        }catch(Exception ex){theservices[theCounterrr1]="";}
        

     theCounterrr1 = theCounterrr1 + 1 ;
   }
   rs.close(); 
   rs = null;
   
      }catch(Exception e){out.println(e);return;}

/// ------------------





















String filtershortcode = "ALL";
if( request.getParameter("filtershortcode")!=null) 
{
 if( !(request.getParameter("filtershortcode").trim().equalsIgnoreCase("ALL")) ) 
 { 
  filtershortcode= request.getParameter("filtershortcode");
  query1 = query1 + " and dst='" + filtershortcode + "' ";
  query2 = query2 + " and app_name='" + filterservice + "' ";
  
  query3 = query3 + " and dst='" + filtershortcode + "' ";
  
  query4 = query4 + " and dst='" + filtershortcode + "' ";  
  
    
 }
} 
   


///////////////THE shortcodes
int theshortcodescount = 0;
String[] theshortcodes = null;

   try{
      rs = con.createStatement().executeQuery("SELECT shortcode,count(*) as thecnt FROM router where log =1 group by shortcode asc");            
      while(rs.next())
      {
     	 theshortcodescount = theshortcodescount + 1;
      }
       rs.close(); rs = null;

   rs = null;
   rs = con.createStatement().executeQuery("SELECT shortcode,count(*) as thecnt FROM router where log =1 group by shortcode asc");

 theshortcodes = new String[theshortcodescount];
   
   
   int theCounterrr1 = 0;
   while(rs.next())
    {
     try{
         theshortcodes[theCounterrr1] = rs.getString(1).trim();
        }catch(Exception ex){theshortcodes[theCounterrr1]="";}
        

     theCounterrr1 = theCounterrr1 + 1 ;
   }
   rs.close(); 
   rs = null;
   
      }catch(Exception e){out.println(e);return;}

/// ------------------







query1 = query1 + " group by app_name,dst order by app_name ";

query2 = query2 + " order by app_name" ;


query3 = query3 + " group by theday order by theday";



//out.println(query3);












             

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
      out.write("\r\n");
      out.write("<html dir=ltr>\r\n");
      out.write("\r\n");
      out.write("<head>\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"datepicker.css\"/>\r\n");
      out.write("<script type=\"text/javascript\" src=\"datepicker.js\"></script>\r\n");
      out.write("<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt arial, geneva, lucida, \"lucida grande\", arial, helvetica, sans-serif; COLOR: #000000;background-color: #FFFFFF; }</style>\r\n");
      out.write("<meta http-equiv=\"Content-Language\" content=\"en-us\">\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1256\">\r\n");
      out.write("<title>Minutes Report</title>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write(" \r\n");
      out.write("\r\n");
      out.write(" \r\n");
      out.write("\r\n");
      out.write("<form action='miniutesreport.jsp' method='post'>\r\n");
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
      out.write("  <tr>\r\n");
      out.write("   <td align='center'><font color=#000000 size='4'>General IVR Minutes Report for Sudan</td>\r\n");
      out.write("  </tr>\r\n");
      out.write(" </table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("            <table border='1' align='center' bgcolor=#F9DEA9 cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='80%'>\r\n");
      out.write("                 <form action='smscount.jsp' method='post'>\r\n");
      out.write("                  <tr>\r\n");
      out.write("                        <td>\r\n");
      out.write("                              <table border='0' align='center' bgcolor=#f4f4f4 cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>\r\n");
      out.write("                                          <td width='5%' align='center'><b><input type=button value=\"From\" onclick=\"displayDatePicker('fdate', this);\"></td>\r\n");
      out.write("                                          <td width='20%' align='center'><input  style='font-size:10pt;color:#000000;font-weight:bold;width:8em;height:1.7em' type=\"text\" readonly name=\"fdate\" id=\"idate\" value='");
      out.print(fdate);
      out.write("' ></td>\r\n");
      out.write("                                          <td width='10%' align='center'>&nbsp;</td>\r\n");
      out.write("                                          <td width='5%' align='center'><b><input type=button value=\"To\" onclick=\"displayDatePicker('tdate', this);\"></b></td>\r\n");
      out.write("                                          <td width='20%' align='center'><input style='font-size:10pt;color:#000000;font-weight:bold;width:8em;height:1.7em' type=\"text\"  readonly name=\"tdate\" id=\"idate\" value='");
      out.print(tdate);
      out.write("'></td>\r\n");
      out.write("                                          <td width='10%' align='center'>&nbsp;</td>\r\n");
      out.write("                                          \r\n");
      out.write("                                          \r\n");
      out.write("                                          <td width='5%' align='center'>Service</td>\r\n");
      out.write("                                          \r\n");
      out.write("                                          \r\n");
      out.write("                                          <td width='20%' align='center'>\r\n");
      out.write("                                          \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<select name='filterservice' style='font-size:10pt;color:#000099;font-weight:bold;width:10em;height:1.7em' >\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t <option>ALL</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");
 
											for (int l =0  ; l < theservices.length ; l ++)
											{
											  if (theservices[l].equalsIgnoreCase(filterservice)) 
											  {
											  
											
      out.write("       \t        \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t    \t        <option selected>");
      out.print( theservices[l] );
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");

											  }
											  else
											  {
											
      out.write("       \t        \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t    \t        <option>");
      out.print( theservices[l] );
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");

											  }    	        
											}
											
      out.write(" \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</select>                                          \t\r\n");
      out.write("                                          \t\r\n");
      out.write("                                          \t\r\n");
      out.write("                                          \t</td>\r\n");
      out.write("                                          \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("                                          <td width='10%' align='center'>&nbsp;</td>\r\n");
      out.write("                                          \r\n");
      out.write("                                          \r\n");
      out.write("                                          <td width='5%' align='center'>ShortCode</td>\r\n");
      out.write("                                          \r\n");
      out.write("                                          \r\n");
      out.write("                                          <td width='20%' align='center'>\r\n");
      out.write("                                          \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<select name='filtershortcode' style='font-size:10pt;color:#000099;font-weight:bold;width:10em;height:1.7em' >\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t <option>ALL</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");
 
											for (int l =0  ; l < theshortcodes.length ; l ++)
											{
											  if (theshortcodes[l].equalsIgnoreCase(filtershortcode)) 
											  {
											  
											
      out.write("       \t        \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t    \t        <option selected>");
      out.print( theshortcodes[l] );
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");

											  }
											  else
											  {
											
      out.write("       \t        \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t    \t        <option>");
      out.print( theshortcodes[l] );
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t");

											  }    	        
											}
											
      out.write(" \r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</select>                                          \t\r\n");
      out.write("                                          \t\r\n");
      out.write("                                          \t\r\n");
      out.write("                                          \t</td>\r\n");
      out.write("\r\n");
      out.write("                                          \r\n");
      out.write("                                          \r\n");
      out.write("                                          <td width='20%' align='center'>&nbsp;</td>\r\n");
      out.write("                                          \r\n");
      out.write("                                          \r\n");
      out.write("                                          <td width='10%' align='right'><input type='submit' name='subReport' value='Get Report' STYLE='font-weight:bold ; color:#000000; width:8em; height:2.2em'></td>\r\n");
      out.write("                              </table>\r\n");
      out.write("                        </td>\r\n");
      out.write("                  </tr>\r\n");
      out.write("                </form>\r\n");
      out.write("            </table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write(" \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<br>\r\n");
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
      out.write("<table width='90%' align='center'>\r\n");
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
      out.write("<td width=58% valign=top>\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\r\n");
      out.write(" <table border='1' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>\r\n");
      out.write("\t\r\n");
      out.write("                  <tr height=20 bgcolor=#f4f4f4>\r\n");
      out.write("                        <td colspan=9 align='center'><font size='2'><b>Per Day/Operator</b></font></td>\r\n");
      out.write("                  </tr>\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("                  <tr height=20 bgcolor=#f4f4f4>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>&nbsp;</b></font></td>\r\n");
      out.write("                        <td  colspan=4 align='center'><font size='2'><b>Calls</b></font></td>\r\n");
      out.write("                        <td  colspan=4 align='center'><font size='2'><b>Minutes</b></font></td>\r\n");
      out.write("                  </tr>\r\n");
      out.write("                  \t\r\n");
      out.write("                  <tr height=20 bgcolor=#f4f4f4>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>The Day</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>Total</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>SudaTel</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>MTN</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>Zain</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>Total</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>SudaTel</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>MTN</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>Zain</b></font></td>\r\n");
      out.write("\r\n");
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
				String theday =rs.getString(1);
				String Total_Calls =rs.getString(2);
				String SudaTel_Calls =rs.getString(3);
				String MTN_Calls =rs.getString(4);
				String Zain_Calls =rs.getString(5);
				String Total_Minutes =rs.getString(6);
				String SudaTel_Minutes =rs.getString(7);
				String MTN_Minutes =rs.getString(8);
				String Zain_Minutes =rs.getString(9);
				
	
			
      out.write("\r\n");
      out.write("\t\t\t\t\t\t  <tr height=20 bgcolor=#ffffff>\r\n");
      out.write("\t\t\t\t\t\t\t<td align='center'><font size='2'>");
      out.print(theday);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'><font size='2'  color='000099' ><b>");
      out.print(Total_Calls);
      out.write("</b></font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'><font size='2'>");
      out.print(SudaTel_Calls);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td align='center'><font size='2'>");
      out.print(MTN_Calls);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'><font size='2'>");
      out.print(Zain_Calls);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'><font size='2'  color='000099' ><b>");
      out.print(Total_Minutes);
      out.write("</b></font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td align='center'><font size='2'>");
      out.print(SudaTel_Minutes);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'><font size='2'>");
      out.print(MTN_Minutes);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'><font size='2'>");
      out.print(Zain_Minutes);
      out.write("</font></td>\r\n");
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
      out.write("\t\t\t");

	
			   rs = null;
			   rs = con.createStatement().executeQuery(query4);  
			while(rs.next())
			{

				String Total_Calls =rs.getString(1);
				String SudaTel_Calls =rs.getString(2);
				String MTN_Calls =rs.getString(3);
				String Zain_Calls =rs.getString(4);
				String Total_Minutes =rs.getString(5);
				String SudaTel_Minutes =rs.getString(6);
				String MTN_Minutes =rs.getString(7);
				String Zain_Minutes =rs.getString(8);
				
	
			
      out.write("\r\n");
      out.write("\t\t\t\t\t\t  <tr height=20 bgcolor=#f4f4f4>\r\n");
      out.write("\t\t\t\t\t\t\t<td align='center'><font size='2'><b>Total</b></font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'><font size='2'><b>");
      out.print(Total_Calls);
      out.write("</b></font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'><font size='2'><b>");
      out.print(SudaTel_Calls);
      out.write("</b></font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td align='center'><font size='2'><b>");
      out.print(MTN_Calls);
      out.write("</font></b></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'><font size='2'><b>");
      out.print(Zain_Calls);
      out.write("</font></b></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'><font size='2'><b>");
      out.print(Total_Minutes);
      out.write("</b></font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td align='center'><font size='2'><b>");
      out.print(SudaTel_Minutes);
      out.write("</b></font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'><font size='2'><b>");
      out.print(MTN_Minutes);
      out.write("</b></font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'><font size='2'><b>");
      out.print(Zain_Minutes);
      out.write("</b></font></td>\r\n");
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
      out.write("\t  </table>\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\r\n");
      out.write("\t\t\r\n");
      out.write("\t</td>\t\r\n");
      out.write("\t\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("<td width=2% valign=top>&nbsp;</td>\t\r\n");
      out.write("\t\r\n");
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
      out.write("\t\r\n");
      out.write("\t<td width=40% valign=top>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write(" \r\n");
      out.write("            <table border='1' align='center' bgcolor=#f4f4f4 cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("                  <tr height=20 bgcolor=#f4f4f4>\r\n");
      out.write("                        <td colspan=4 align='center'><font size='2'><b>Per Shortcode/Service</b></font></td>\r\n");
      out.write("                  </tr>\r\n");
      out.write("                              \r\n");
      out.write("                  <tr height=20 bgcolor=#f4f4f4>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>Service</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>ShortCode</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>Calls Count</b></font></td>\r\n");
      out.write("                        <td  align='center'><font size='2'><b>Minutes Count</b></font></td>\r\n");
      out.write("\r\n");
      out.write("                  </tr>\r\n");
      out.write("                  \r\n");
      out.write("                  \r\n");
      out.write("\r\n");


   rs = null;
   rs = con.createStatement().executeQuery(query1);  
while(rs.next())
{
String service =rs.getString(1);
String sc =rs.getString(2);
String callcount = rs.getString(3);
String minutescount =rs.getString(4);


      out.write("\r\n");
      out.write("\t\t\t  <tr height=20 bgcolor=#ffffff>\r\n");
      out.write("\t\t\t\t<td  align='center'><font size='2'>");
      out.print(service);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t<td  align='center'><font size='2'>");
      out.print(sc);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t<td  align='center'><font size='2'>");
      out.print(callcount);
      out.write("</font></td>\r\n");
      out.write("\t\t\t\t<td  align='center'><font size='2'>");
      out.print(minutescount);
      out.write("</font></td>\r\n");
      out.write("\t\t\t  </tr>\r\n");

}
rs.close();rs = null;


      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t");

	
			   rs = null;
			   rs = con.createStatement().executeQuery(query2);  
			while(rs.next())
			{
				String thecallstotal =rs.getString(1);
				String theminutestotal =rs.getString(2);
	
			
      out.write("\r\n");
      out.write("\t\t\t\t\t\t  <tr height=20 bgcolor=#f4f4f4>\r\n");
      out.write("\t\t\t\t\t\t\t<td colspan=2 align='center'><font size='2'><b>Total</b></font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'><font size='2'><b>");
      out.print(thecallstotal);
      out.write("</b></font></td>\r\n");
      out.write("\t\t\t\t\t\t\t<td  align='center'><font size='2'><b>");
      out.print(theminutestotal);
      out.write("</b></font></td>\r\n");
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
      out.write("\t</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</td>\r\n");
      out.write("\r\n");
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
