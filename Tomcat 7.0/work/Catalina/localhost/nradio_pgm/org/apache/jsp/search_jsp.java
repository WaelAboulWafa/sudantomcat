/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2014-08-29 15:24:03 UTC
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

public final class search_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {



public String replaceWord(String inputStr,String patternStr,String replacementStr) throws Exception{return Pattern.compile(patternStr).matcher(inputStr).replaceAll(replacementStr);}
public String getReadable(String theUnicode,String thelang)
 {
   if( thelang.equalsIgnoreCase("0") ){return theUnicode;}
   
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







   
 public boolean isallowed(String requestedpage,String[] thepagesallowed,int[] theflag)
 {
  for(int k =0;k< thepagesallowed.length ; k++)
  {
    
    if(requestedpage.equalsIgnoreCase(thepagesallowed[k]))
    {
      if(theflag[k] == 1){return true;}
    } 
  }
  
  return false;
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
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

	String username;try{ username =  session.getAttribute("username").toString();}catch(Exception e){username=null;}
String password;try{password =  session.getAttribute("password").toString();}catch(Exception e){password=null;}
String progid = "";
if(username==null || password==null) //user not logged in
{
session.invalidate();
response.sendRedirect("login.jsp");    
}
else
{






  /////get user authorities/////////////
  Connection con=null;
  InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();
  ResultSet rs = null;
  int userid= 0;
  int phoneallowed = 0;
  try
  {
   rs = con.createStatement().executeQuery("SELECT userID,phone,programid from fitservice.nradio_pgm_Users where username=N'" + username.replaceAll("'", "''") + "' and password=N'" + password.replaceAll("'", "''") + "'");             
   userid = 0;
	   			while (rs.next()) {
				userid = rs.getInt(1);
				phoneallowed = rs.getInt(2);
				progid = rs.getString(3);
			}
			rs.close();
			rs = null;
		} catch (Exception e) {
		}

		int reccount1 = 0;
		rs = null;
		try {
			rs = con.createStatement().executeQuery(
					"SELECT count(*) from fitservice.nradio_pgm_UsersAuthorities where userID="
							+ userid);
			while (rs.next()) {
				reccount1 = rs.getInt(1);
			}
			rs.close();
			rs = null;
		} catch (Exception e) {
		}

		String[] thepage = new String[reccount1];
		int[] allowed = new int[reccount1];

		rs = null;
		int z = 0;
		try {
			rs = con.createStatement()
					.executeQuery(
							"SELECT page, allowed from fitservice.nradio_pgm_UsersAuthorities where userID="
									+ userid);
			while (rs.next()) {
				thepage[z] = rs.getString(1);
				allowed[z] = rs.getInt(2);
				z = z + 1;
			}
			rs.close();
			rs = null;
		} catch (Exception e) {
		}

		rs = null;
		String indate = "";
		String intime = "";
		try {
			rs = con.createStatement()
					.executeQuery(
							"SELECT  lastlogintime , lastlogintime  from fitservice.nradio_pgm_Users where userID="
									+ userid);
			while (rs.next()) {
				indate = rs.getString(1);
				intime = rs.getString(2);
			}
			rs.close();
			rs = null;
		} catch (Exception e) {
		}

		boolean allowedaccess = false;
		for (int k = 0; k < thepage.length; k++) {
			if (thepage[k].equalsIgnoreCase("search.jsp")) {
				if (allowed[k] == 1) {
					allowedaccess = true;
				}
			}
		}

		// out.println(allowedaccess);

		if (allowedaccess == false) {
			response.sendRedirect("login_logout.jsp");
			return;
		}

		else {

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");


 

String theSdate =(new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date((new java.util.Date()).getTime())).trim();
String theEdate =(new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date( (new java.util.Date()).getTime())).trim();
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
Calendar c = Calendar.getInstance();
c.setTime(sdf.parse(theEdate));
c.add(Calendar.DATE, 1);  // number of days to add
theEdate = sdf.format(c.getTime());



String searchword = "";try{searchword = request.getParameter("searchword").trim();}catch(Exception e){searchword = "";}
String searchby= "2"; try{searchby = request.getParameter("searchby").trim();}catch(Exception e){searchby = "2";}
String countries = "";try{countries = request.getParameter("countries").trim();}catch(Exception e){countries = "";}
String fdate = "";try{fdate = request.getParameter("fdate").trim();}catch(Exception e){fdate = theSdate;}
String tdate = "";try{tdate = request.getParameter("tdate").trim();}catch(Exception e){tdate = theEdate;}
String theuser = "";try{theuser = request.getParameter("theuser").trim();}catch(Exception e){theuser = "";}
String messagetatus = "";try{messagetatus = request.getParameter("messagetatus").trim();}catch(Exception e){messagetatus = "";}
String thehour = "all";try{thehour = request.getParameter("thehour").trim();}catch(Exception e){thehour = "all";}




String thequery="";
/*thequery= thequery + " select fitservice.nradio_pgm_smss.ID,(fitservice.cdrs.ID)
						 fitservice.nradio_pgm_smss.intime, (fitservice.cdrs.datein) 
						 fitservice.nradio_pgm_smss.readtime, (fitservice.cdrs.readtime)  
						 messages.messages.Recipient,(fitservice.cdrs.shortcode)
						 messages.messages.Sender, (fitservice.cdrs.msisdn) 
						 messages.messages.bodyformat,(fitservice.cdrs.lang)
						 messages.messages.body (fitservice.cdrs.contents) 
						 from  fitservice.nradio_pgm_smss ( cdrs )   INNER JOIN fitservice.cdrs ON fitservice.nradio_pgm_smss.ID = fitservice.cdrs.id  ";
thequery= thequery + " where nradio_pgm_smss.intime between '"+ fdate + "' and '"+ tdate + "' ";
*/

thequery = thequery+"select ID, datein, readtime, shortcode, msisdn, lang, contents from cdrs where datein between'"+fdate+"'and'" + tdate+"'";

if(messagetatus.equalsIgnoreCase("1"))
{
//thequery= thequery + " and fitservice.nradio_pgm_smss.flag=1";
	thequery= thequery + " and status=1";
}

if(messagetatus.equalsIgnoreCase("-1"))
{
//thequery= thequery + " and fitservice.nradio_pgm_smss.flag=0";
	thequery= thequery + " and status=0";
}



//thequery= thequery + " order by fitservice.nradio_pgm_smss.ID  asc";
thequery= thequery + " order by ID  asc";






//out.println(thequery);







int THECOUNT = 0 ;
   rs = null;
   rs = con.createStatement().executeQuery(thequery); 
while(rs.next())
{
THECOUNT = THECOUNT + 1;
String messageupdatetime1 = rs.getString(1);
String smssource1 = rs.getString(2);
String readable1 = rs.getString(3);
String msisdn1 = rs.getString(4);
String nickname1 = rs.getString(5);
String shortcode1 = rs.getString(6);
String theintime1 = rs.getString(7);
//String filerationagent1 = rs.getString(8);
//String orgip1 = rs.getString(9);
//String waittime1 = rs.getString(10);
//String status1 = rs.getString(11);
}
rs.close();rs=null;   




//out.println(thequery);  

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<html dir=rtl>\r\n");
      out.write("\r\n");
      out.write("<head>\r\n");
      out.write("<link rel=\"stylesheet\" type=\"text/css\" href=\"datepicker.css\"/>\r\n");
      out.write("<script type=\"text/javascript\" src=\"datepicker.js\"></script>\r\n");
      out.write("<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt arial, geneva, lucida, \"lucida grande\", arial, helvetica, sans-serif; COLOR: #000000 } Table {font:12pt } </style>\r\n");
      out.write("<meta http-equiv=\"Content-Language\" content=\"en-us\">\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1256\">\r\n");
      out.write("<title>البحث ... National Radio</title>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write(" \r\n");
      out.write("\r\n");
      out.write(" \r\n");
      out.write("\r\n");
      out.write("            <form action='MainPage.jsp' method='post'>\r\n");
      out.write("            <input type='hidden' name='uid' value='41'>\r\n");
      out.write("            \r\n");
      out.write("            <table border='1' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%' height='80'>\r\n");
      out.write("              <tr>\r\n");
      out.write("                <td width='21%' align='center'><b><i><font color='#A36103' size='6'> الارشيف</font></i></b></td>\r\n");
      out.write("                <td width='10%' height='100' align='center'>\r\n");
      out.write("                  <table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%' height='100%'>\r\n");
      out.write("            \t<tr bgcolor=#CCFFC8><td align='center' width='100%'><font size='4'>مقرؤه</font></td></tr>\r\n");
      out.write("            \t<tr bgcolor=#FFC8C8><td align='center' width='100%'><font size='4'>غير مقرؤه</font></td></tr>\r\n");
      out.write("     \r\n");
      out.write("                  </table>\r\n");
      out.write("                </td>\r\n");
      out.write("                <td width='30%' align='center'>\r\n");
      out.write("                <table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%'>\r\n");
      out.write("                  <tr><td width='100%' align='center'><font color='#000000' face='Arial' size='4'><b> وقــت الدخول  ");
      out.print( intime );
      out.write(" </b></font></td></tr>\r\n");
      out.write("      <tr><td width='100%' align='center'><font color='#000000' face='Arial' size='4'><b> &nbsp;</b></font></td></tr>\r\n");
      out.write("      <tr><td width='100%' align='center'><font color='#000000' face='Arial' size='4'><b> تاريــخ الدخول  ");
      out.print( indate );
      out.write(" </b></font></td></tr>\r\n");
      out.write("                </table>\r\n");
      out.write("                </td>\r\n");
      out.write("                <td width='19%' align='center'>\r\n");
      out.write("                \t<table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%'>\r\n");
      out.write("                \t\t<tr><td align='center'><input type='submit' name='subMain' value='القائمة الرئيسية' STYLE='font-weight:bold;font-family:arial;font-size:18;color:#00f;width:12em;height:2.5em'></td></tr>\r\n");
      out.write("                \t\t</form>\r\n");
      out.write("            \t\t<form action='search.jsp' method='post'>\r\n");
      out.write("            \t\t<input type='hidden' name='uid' value='41'>\r\n");
      out.write("              \t\t<tr><td align='center'><input type='submit' name='subRefresh' value='اعادة تحميل' STYLE='font-weight:bold;font-family:arial;font-size:18;color:#00f;width:12em;height:2.5em'></td></tr>\r\n");
      out.write("                        </form> \r\n");
      out.write("                \t</table>\r\n");
      out.write("                </td>\r\n");
      out.write("<td bgcolor='#ffffff' width='15%' align='center'><IMG src='logo.png'></td>\r\n");
      out.write("              </tr>\r\n");
      out.write("            </table>\r\n");
      out.write("\r\n");
      out.write("<br>\r\n");
      out.write("\t\t\t<br>\r\n");
      out.write("\t\t\t<table border='1' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#DCDCDC' width='80%'>\r\n");
      out.write("\t\t\t  <tr height='30'>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<form method=\"post\">\r\n");
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
      out.write("\t\t\t    \r\n");
      out.write("\t\t\t    \r\n");
      out.write("\t\t\t    \r\n");
      out.write("\t\t\t  </tr>\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\t\t\t<table border='1' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#DCDCDC' width='50%'>\r\n");
      out.write("\t\t\t <tr>\r\n");
      out.write("\t\t\t <td>\r\n");
      out.write("\t\t\t <table border='1' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#DCDCDC' width='100%'>\r\n");
      out.write("\t\t\t  <tr height=30>\r\n");
      out.write("\t\t\t  \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t    <td width='14%' align='center'>\r\n");
      out.write("<input type=button value=\"تاريخ من\" onclick=\"displayDatePicker('fdate', this);\">\r\n");
      out.write("\r\n");
      out.write("<input  type=\"text\" readonly name=\"fdate\" id=\"idate\" value='");
      out.print(fdate);
      out.write("' >\r\n");
      out.write("                            </td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t    <td width='2%' align='center'>&nbsp;</td>\r\n");
      out.write("\r\n");
      out.write("<td width='14%' align='center'>\r\n");
      out.write("<input type=button value=\"تاريخ إلي\" onclick=\"displayDatePicker('tdate', this);\">\r\n");
      out.write("<input  type=\"text\"  readonly name=\"tdate\" id=\"idate\" value='");
      out.print(tdate);
      out.write("'>\r\n");
      out.write("</td>\r\n");
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
      out.write("<td width='25%' align='center'>\r\n");
      out.write("<select name='messagetatus' style='font-weight:bold ; color:#909090'>\r\n");
      out.write("\r\n");
      out.write("<option value=''>كل الرسائل</option>\r\n");
      out.write("\r\n");
      out.write("\r\n");

if(messagetatus.equalsIgnoreCase("1"))
{

      out.write("\r\n");
      out.write("<option selected value='1'>رسائل مقروءه</option>\r\n");

}
else
{

      out.write("\r\n");
      out.write("<option value='1'>رسائل مقروءه</option>\r\n");

}

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

if(messagetatus.equalsIgnoreCase("-1"))
{

      out.write("\r\n");
      out.write("<option selected value='-1'>رسائل غير مقروءه</option>\r\n");

}
else
{

      out.write("\r\n");
      out.write("<option value='-1'>رسائل غير مقروءه</option>\r\n");

}

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</select>\r\n");
      out.write("</td>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t    <td width='15%' align='center'><input type='submit' name='Searchbutton' value='بحث' style='font-weight:bold;width:8em;height:3em'></td>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t  </tr>\r\n");
      out.write("\t\t\t </table>\r\n");
      out.write("\t\t\t </td>\r\n");
      out.write("\t\t\t </tr>\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\t\t\t<br>\t\r\n");
      out.write("\r\n");
      out.write("\t\t\t <br>\t\r\n");
      out.write("\t\t\t \r\n");
      out.write("\t\t\t <table border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#cccccc' width='98%'>\r\n");
      out.write("                  <tr height=30 bgcolor=#DCDCDC>\r\n");
      out.write("                    <td align='center'><b>العدد</b>&nbsp;&nbsp;&nbsp;<font color=#000099><b>");
      out.print( THECOUNT );
      out.write("</b></font></td>\r\n");
      out.write(" \t\t\t        <td width='75%' align='center'><b>&nbsp;</b></td>                    \r\n");
      out.write("                  </tr>\r\n");
      out.write("             </table>\r\n");
      out.write("\t\t\t \r\n");
      out.write("\t\t\t \r\n");
      out.write("\t\t\t \r\n");
      out.write("      \t\t\t\t\t<table border='1' align='center' cellpadding='0' cellspacing='1' style='border-collapse: collapse' bordercolor='#cccccc' width='98%'>\r\n");
      out.write("      \t\t\t\t\t  <tr bgcolor=#DCDCDC>\r\n");
      out.write("      \t\t\t\t\t    <td width='30%' rowspan=2 align='center'><b>نص الرساله</b></td>\r\n");
      out.write("      \t\t\t\t\t    <td width='10%' rowspan=2 align='center'><b>رقم تليفون</b></td>\r\n");
      out.write("      \t\t\t\t\t    <td width='10%' rowspan=2 align='center'><b>المصدر</b></td>\r\n");
      out.write("      \t\t\t\t\t    <td width='10%' rowspan=2 align='center'><b>وقت الدخول</b></td>\r\n");
      out.write("      \t\t\t\t\t    <td width='10%' rowspan=2 align='center'><b>وقت القراءه</b></td>      \t\t\t\t\t    \r\n");
      out.write("  \t\t\t\t\t    \r\n");
      out.write("      \t\t\t\t\t  </tr>\r\n");
      out.write("\r\n");
      out.write("      \t\t\t\t\t  <tr bgcolor=#DCDCDC>\r\n");
      out.write("   \t\t\t\t\t          \t\t\t\t\t          \t\t\t\t\t          \t\t\t\t\t    \r\n");
      out.write("      \t\t\t\t\t  </tr>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");


   rs = null;
   rs = con.createStatement().executeQuery(thequery);  
while(rs.next())
{
String the_msg_id = rs.getString(1);
String the_msg_intime = rs.getString(2);
String the_msg_readtime = rs.getString(3);
String the_msg_Recipient = rs.getString(4);
String the_msg_msisdn = rs.getString(5);
String the_msg_bodyformat = rs.getString(6);
String the_msg_body = rs.getString(7);
String filerationagent = "";
String orgip = "";
String waittime = "";
String status = "";


      
   

String txt = getReadable(replaceWord(the_msg_body," ",""),the_msg_bodyformat);

if(txt.startsWith(progid)){            
 
if(the_msg_readtime != null)
{

      out.write("\r\n");
      out.write("<tr height=25 bgcolor=#CCFFC8>\r\n");

}
else
{

      out.write("\r\n");
      out.write("<tr height=25 bgcolor=#FFC8C8>\r\n");

 }


      out.write("\r\n");
      out.write("\r\n");
      out.write("  <td width='30%' align='center'><b>");
      out.print(txt   );
      out.write("</b></td>\r\n");
      out.write("      \t\t\t\t\t    \r\n");
      out.write("      \t\t\t\t\t   \r\n");
      out.write("      \t\t\t\t\t    \r\n");
      out.write("      \t\t\t\t\t    \r\n");
    	    
if(phoneallowed == 1)
{

      out.write("\r\n");
      out.write("    \t    <td align='center'><b><font color=#000000 size=4 dir='ltr'>");
      out.print( the_msg_msisdn );
      out.write("</font></b></td>\r\n");

}
else
{

      out.write("\r\n");
      out.write("    \t    <td align='center'><b><font color=#000000 size=4 dir='ltr'> لا توجد صلاحيه</font></b></td>\r\n");

}

      out.write("     \t    \r\n");
      out.write("       \r\n");
      out.write("\r\n");
      out.write("      \t\t\t\t\t    \r\n");
      out.write("      \t\t\t\t\r\n");
      out.write("      \t\t\t\t\t    \r\n");
      out.write("      \t\t\t\t\t    \r\n");
      out.write("      \t\t\t\t\t    \r\n");
      out.write("      \t\t\t\t\t    <td width='10%' align='center'><b><font color=#000000 size=3 dir='ltr' dir='ltr'>");
      out.print( the_msg_Recipient );
      out.write("</font></b></td>\r\n");
      out.write("      \t\t\t\t\t    <td width='10%' align='center'><b><font color=#000000 size=3 dir='ltr' dir='ltr'>");
      out.print( the_msg_intime );
      out.write("</font></b></td>\r\n");
      out.write("      \t\t\t\t\t    <td width='10%' align='center'><b><font color=#000000 size=3 dir='ltr' dir='ltr'>");
      out.print( the_msg_readtime );
      out.write("</font></b></td>      \t\t\t\t\t    \r\n");
      out.write("\r\n");
      out.write("      \t\t\t\t\t    \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("      \t\t\t\t\t    \r\n");
      out.write("\r\n");
      out.write("</tr>\r\n");

}

      out.write('\r');
      out.write('\n');

}
rs.close();rs=null;

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
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</form>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<br>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</html>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

con.close();

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

}
}

      out.write('\r');
      out.write('\n');
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
