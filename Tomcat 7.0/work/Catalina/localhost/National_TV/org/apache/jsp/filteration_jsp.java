/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2015-09-13 12:49:16 UTC
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

public final class filteration_jsp extends org.apache.jasper.runtime.HttpJspBase
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

	String username;
	try {
		username = session.getAttribute("username").toString();
	} catch (Exception e) {
		username = null;
	}
	String password;
	try {
		password = session.getAttribute("password").toString();
	} catch (Exception e) {
		password = null;
	}
	String progid = "";
	
	
	
	
	
	if (username == null || password == null) //user not logged in
	{
		session.invalidate();
		response.sendRedirect("login.jsp");
	}

	else {

		/////get user authorities/////////////
		Connection con = null;
		InitialContext ic = new InitialContext();
		DataSource ds = (DataSource) ic
				.lookup("java:comp/env/jdbc/TheDB");
		con = ds.getConnection();
		ResultSet rs = null;
		int userid = 0;
		int phoneallowed = 0;
		try {
			rs = con.createStatement().executeQuery("SELECT userID,phone,programid from fitservice.nationaltv_pgm_Users where username=N'"
							+ username.replaceAll("'", "''")
							+ "' and password=N'"
							+ password.replaceAll("'", "''") + "'");
			userid = 0;
			while (rs.next()) {
				userid = rs.getInt(1);
				phoneallowed = rs.getInt(2);
				progid = rs.getString(3);
			}
			rs.close();
			rs = null;
		} catch (Exception e) {
			out.println(e.toString());
		}

		//out.println(userid);

		int reccount1 = 0;
		rs = null;
		try {
			rs = con.createStatement().executeQuery(
					"SELECT count(*) from fitservice.nationaltv_pgm_UsersAuthorities where userID="
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
							"SELECT page, allowed from fitservice.nationaltv_pgm_UsersAuthorities where userID="
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
			//   rs = con.createStatement().executeQuery("SELECT  CONVERT(char(10), lastlogintime, 101), convert(varchar,lastlogintime, 8)  from fitservice.nationaltv_pgm_Users where userID=" + userid);             
			rs = con.createStatement()
					.executeQuery(
							"SELECT  lastlogintime,  lastlogintime  from fitservice.nationaltv_pgm_Users where userID="
									+ userid);
			while (rs.next()) {
				indate = rs.getString(1);
				intime = rs.getString(2);
			}
			rs.close();
			rs = null;
		} catch (Exception e) {
			out.println(e.toString());
		}

		//out.println(username);out.println(password);

		boolean allowedaccess = false;
		for (int k = 0; k < thepage.length; k++) {
			if (thepage[k].equalsIgnoreCase("filteration.jsp")) {
				if (allowed[k] == 1) {
					allowedaccess = true;
				}
			}
		}

		// out.println(allowedaccess); if(1==1)return;

		if (allowedaccess == false) {
			response.sendRedirect("login_logout.jsp");
			return;
		}

		else {

			rs = null;

			int offset = 0;

			if (request.getParameter("offset") != null) {
				offset = Integer.parseInt(request
						.getParameter("offset").toString());
			}

			int pagesize = 50;
			int count = 0;
			int pages = 0;
			int lowerbound = 0;
			int upperbound = 0;

			int reccount = 0;
			String[] id = null;
			String[] sentdate = null;
			String[] shortcode = null;
			String[] tel = null;
			String[] bodyformat = null;
			String[] msg = null;

			int visiblecount = 0;

			int whenrejectcount = 0;

			//-----------------------------------
			//String query1 = "SELECT count(*) from fitservice.nationaltv_pgm_smss where flag=0 ";
			//String query2 = "SELECT ID from fitservice.nationaltv_pgm_smss where flag=0 order by ID";
			/*String query3 = "select fitservice.nationaltv_pgm_smss.ID, (ID)
							   	fitservice.nationaltv_pgm_smss.intime, (datein)
								messages.messages.Recipient, (shortcode)
								messages.messages.Sender, (msisdn)
								messages.messages.bodyformat, (lang)
								messages.messages.body (Contents)
								from  
								fitservice.nationaltv_pgm_smss INNER JOIN messages.messages 
								ON fitservice.nationaltv_pgm_smss.ID = messages.messages.id 
								and fitservice.nationaltv_pgm_smss.flag=0  order by 
								fitservice.nationaltv_pgm_smss.ID  asc";*/
            String query1 = "SELECT count(*) from cdrs where status=0 ";
            String query2 = "SELECT ID from cdrs where status=0 order by ID";
            String query3 = "Select ID, datein, shortcode, msisdn, lang, Contents from cdrs where status=0 order by ID asc";
			String filtershortcode = "ALL";

			rs = con.createStatement().executeQuery(query1);
			if (rs.next()) {
				reccount = rs.getInt(1);
			}
			rs.close();
			rs = null;

			count = reccount;

			rs = con.createStatement().executeQuery(query2);
			while (rs.next()) {
				String tmp = rs.getString(1);
				visiblecount = visiblecount + 1;
			}
			rs.close();
			rs = null;

			rs = null;
			rs = con.createStatement().executeQuery(query3);

			id = new String[visiblecount];
			tel = new String[visiblecount];
			shortcode = new String[visiblecount];
			msg = new String[visiblecount];
			bodyformat = new String[visiblecount];
			sentdate = new String[visiblecount];

			rs.next();
			//int theCounter = 0;
			//while(rs.next())
			for (int theCounter = 0; theCounter < visiblecount; theCounter++) {
				id[theCounter] = rs.getString(1).trim();
				sentdate[theCounter] = rs.getString(2).trim();
				shortcode[theCounter] = rs.getString(3).trim();
				tel[theCounter] = rs.getString(4).trim();
				bodyformat[theCounter] = rs.getString(5).trim();
				msg[theCounter] = rs.getString(6).trim();
				//String tmpmsg = rs.getString(6);
				//if(tmpmsg.startsWith("1"))
				//msg[theCounter]

				rs.next();
				// theCounter = theCounter + 1 ;
			}
			rs.close();
			rs = null;

			if (count != 0) {
				if (count % pagesize == 0) {
					pages = (count / pagesize);
				} else {
					pages = (count / pagesize) + 1;
				}
			}

			if (count != 0) {
				if (pages == 1) {
					lowerbound = 0;
					upperbound = count;
				} else {

					if (((offset) * pagesize) <= count) {
						lowerbound = (offset * pagesize);

						if (((offset + 1) * pagesize) > count) {
							upperbound = count;
						} else {
							upperbound = ((offset + 1) * pagesize);
						}
					} else {
						lowerbound = 0;
						upperbound = 0;

					}
				}

			}

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
      out.write("<html dir='rtl'>\r\n");
      out.write("<HEAD>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script LANGUAGE=\"JavaScript\" type=\"text/javascript\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("function selectall(k)\r\n");
      out.write("{\r\n");
      out.write("\tfor( i=0; i< k; i++ )\r\n");
      out.write("\t{ \r\n");
      out.write("\t if( document.getElementById('ischeck' + i) != null )  \r\n");
      out.write("     { \r\n");
      out.write("\t   document.getElementById('ischeck' + i).checked = true; \r\n");
      out.write("\t }\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("function correctinvoke(target)\r\n");
      out.write("{\r\n");
      out.write("if(target == 0) {document.mainform.action=\"BATCHApprove.jsp\";document.mainform.submit();}\r\n");
      out.write("if(target == 1) {document.mainform.action=\"BATCHReject.jsp\";document.mainform.submit();}\r\n");
      out.write("if(target == 2) {document.mainform.action=\"BATCHWaiting.jsp\";document.mainform.submit();}\r\n");
      out.write("if(target == 3) {document.mainform.action=\"BATCHApproveBoxANDBAR.jsp\";document.mainform.submit();}\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("}\r\n");
      out.write(" \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write(" \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</script>\r\n");
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
      out.write("<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt arial, geneva, lucida, \"lucida grande\", arial, helvetica, sans-serif; COLOR: #000000 } Table {font:12pt } </style>\r\n");
      out.write("<meta http-equiv=\"Content-Language\" content=\"en-us\">\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1256\">\r\n");
      out.write("<title>مراقبه ... National Radio</title>\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<BODY>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<table border='1' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%' height='80'>\r\n");
      out.write("  <tr>\r\n");
      out.write("    <td width='21%' align='center'><b><i><font color='#A36103' size='6'>مراقبه</font></i></b></td>\r\n");
      out.write("    \r\n");
      out.write("\r\n");
      out.write("                \r\n");
      out.write("                \r\n");
      out.write("    \r\n");
      out.write("    <td width='30%' align='center'>\r\n");
      out.write("    <table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%'>\r\n");
      out.write("      <tr><td width='100%' align='center'><font color='#000000' face='Arial' size='4'><b> وقــت الدخول  ");
      out.print( intime );
      out.write(" </b></font></td></tr>\r\n");
      out.write("      <tr><td width='100%' align='center'><font color='#000000' face='Arial' size='4'><b> &nbsp;</b></font></td></tr>\r\n");
      out.write("\r\n");
      out.write("    </table>\r\n");
      out.write("    </td>\r\n");
      out.write("    <td width='24%' align='center'>\r\n");
      out.write("    \t<table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%'>\r\n");
      out.write(" \t\t<form action='MainPage.jsp' method='post'>                \r\n");
      out.write("     \t\t <tr><td align='center'><input type='submit' name='subMain' value='القائمة الرئيسية' STYLE='font-weight:bold;font-family:arial;font-size:18;color:#00f;width:12em;height:2.5em'></td></tr>\r\n");
      out.write("                </form>\r\n");
      out.write(" \t\t<form name='theform' action='filteration.jsp' method='post'>\r\n");
      out.write("     \t\t<tr><td align='center'><input type='submit' name='subRefresh' value='اعادة تحميل' STYLE='font-weight:bold;font-family:arial;font-size:18;color:#00f;width:12em;height:2.5em'></td></tr>\r\n");
      out.write("               </form>\r\n");
      out.write("    \t</table>\r\n");
      out.write("    </td>\r\n");
      out.write("<td bgcolor='#ffffff' width='15%' align='center'><IMG src='logo.png'></td>\r\n");
      out.write("  </tr>\r\n");
      out.write("</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
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
      out.write("  \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("               \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("            <br>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("            <table border='1' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='96%'>\r\n");
      out.write("                  <tr height='30'>\r\n");
      out.write("                    <td align='center' width='4%'>\r\n");

if(pages>0)
{
  for(int i=0;i<pages;i++)
  {
   if(i==offset)
    {

      out.write("\r\n");
      out.write("                     <b>");
      out.print( (offset +1));
      out.write("</b>\r\n");

    }
    else
   {

      out.write("\r\n");
      out.write("                  <b><a href=filteration.jsp?offset=");
      out.print( i );
      out.write("&filtertheshortcode=");
      out.print( URLEncoder.encode(filtershortcode));
      out.write(' ');
      out.write('>');
      out.print( Integer.toString(i+1) );
      out.write(" </a>&nbsp;</b>\r\n");

   }
   
  }
}

      out.write("\r\n");
      out.write("                    </td>\r\n");
      out.write("                  </tr>\r\n");
      out.write("            </table>\r\n");
      out.write("\r\n");
      out.write("            <br>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("            <table border='1' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='98%'>\r\n");
      out.write("                  <tr>\r\n");
      out.write("                        <td>\r\n");
      out.write("                              <table border='0' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>\r\n");
      out.write("                                    <tr>\r\n");
      out.write("                                          <td width='5%' align='center'>\r\n");
      out.write("                                                <table border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>\r\n");
      out.write("                                                      <input type='hidden' name='uid' value='41'>\r\n");
      out.write("                                                      <input type='hidden' name='cur_page' value='1'>\r\n");
      out.write("                                                      <input type='hidden' name='selc' value=''>\r\n");
      out.write("                                                      <tr><td align='center'><input type='submit' name='subSelectAll' value='الكل' style='font-weight:bold ; width:8em ; height:2em' onClick=\"selectall(");
      out.print( reccount );
      out.write(")\"></td></tr>\r\n");
      out.write("                                                </table>\r\n");
      out.write("                                          </td>\r\n");
      out.write("                                          <td width='5%' align='center'>&nbsp;</td>\r\n");
      out.write("                                          <td width='10%' align='right'><input type='submit' name='subApproveSMSSel' value='قراءه' style='font-weight:bold ; color:#0000FF; width:8em ; height:2em' onClick=\"correctinvoke(0)\"></td>\r\n");
      out.write("\r\n");
      out.write("                                          <td width='25%' align='center'>\r\n");
      out.write("                                                <table border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>\r\n");
      out.write("                                                      <tr align=\"center\" >\r\n");
      out.write("                                                       <td align='center' >\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("                                                       </td>\r\n");
      out.write("                                                      </tr>\r\n");
      out.write("                                                </table>\r\n");
      out.write("                                          </td>\r\n");
      out.write("                                          <td width='15%' align='center'>\r\n");
      out.write("                                                <table border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>\r\n");
      out.write("                                                      <tr>\r\n");
      out.write("                                                            <td align='center'><b>عدد</b></td>\r\n");
      out.write("                                                            <td align='left'><font color=#000099><b>");
      out.print( reccount );
      out.write("</b></font></td>\r\n");
      out.write("                                                      </tr>\r\n");
      out.write("                                                </table>\r\n");
      out.write("                                          </td>\r\n");
      out.write("                                          <td width='10%' align='center'>\r\n");
      out.write("                                          \t<table border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>\r\n");
      out.write("                                                      <tr>\r\n");
      out.write("                                                            <td align='center'><b>صفحة</b></td>\r\n");
      out.write("                                                            <td align='left'><font color=#000099><b>");
      out.print( (offset +1));
      out.write("&nbsp/&nbsp;");
      out.print( pages );
      out.write("</b></font></td>\r\n");
      out.write("                                                      </tr>\r\n");
      out.write("                                          \t</table>\r\n");
      out.write("                                          </td>\r\n");
      out.write("                                    </tr>\r\n");
      out.write("                              </table>\r\n");
      out.write("                        </td>\r\n");
      out.write("                  </tr>\r\n");
      out.write("            </table>\r\n");
      out.write("\r\n");
      out.write("   \r\n");
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
      out.write("            \r\n");
      out.write("            \r\n");
      out.write("            \r\n");
      out.write("            \r\n");
      out.write("            \r\n");
      out.write("            <br>\r\n");
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
      out.write("     <table  border='1' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#cccccc' width='98%'>\r\n");
      out.write("             <tr bgcolor=#DCDCDC>\r\n");
      out.write("                  <td width='5%' align='center'><b>اختيار</b></td>\r\n");
      out.write("\r\n");
      out.write("             \r\n");
      out.write("                  <td width='60%' align='center'><b>نص الرساله</b></td>\r\n");
      out.write("                  <td width='11%' align='center'><b>تاريخ الارسال</b></td>\r\n");
      out.write("                  <td width='10%' align='center'><b>تليفون</b></td>\r\n");
      out.write("                  <td width='9%'  align='center'><b>مصدر الخدمة</b></td>\r\n");
      out.write("                  \r\n");
      out.write("              \r\n");
      out.write("            </tr>\r\n");
      out.write("     \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<form name=mainform method=post action=\"\" >\r\n");
      out.write("\r\n");
      out.write("<INPUT style=\"display: none;\" NAME=theoffset SIZE=10  value=\"");
      out.print( lowerbound );
      out.write("\" > \r\n");
      out.write("<INPUT style=\"display: none;\" NAME=countrysc SIZE=10  value=\"");
      out.print( filtershortcode );
      out.write("\" > \r\n");
      out.write("<INPUT style=\"display: none;\" NAME=thebase SIZE=10  value=\"");
      out.print( offset );
      out.write("\" > \r\n");
      out.write("\r\n");
      out.write("<INPUT style=\"display: none;\" NAME=count SIZE=10  value=\"");
      out.print( reccount );
      out.write("\" > \r\n");
      out.write("\r\n");
 for (int l =lowerbound ; l < upperbound ; l ++)
{


      out.write("\r\n");
      out.write("\r\n");
      out.write("<tr bgcolor=#FFFFFF>\r\n");
      out.write("\r\n");
      out.write(" \r\n");
      out.write("          \r\n");

 
 String txt = getReadable(replaceWord(msg[l]," ",""),bodyformat[l]);
 if(txt.startsWith(progid)){
	 
 
      out.write("\r\n");
      out.write("         \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("  \r\n");
      out.write("            <td align='center'>  <INPUT id=\"ischeck");
      out.print( l );
      out.write("\" NAME=ischeck");
      out.print( l );
      out.write(" TYPE=CHECKBOX >  </td>\r\n");
      out.write("    \t     <INPUT type='hidden' NAME=id");
      out.print( l );
      out.write(" SIZE=6  READONLY value=\"");
      out.print( id[l] );
      out.write("\" >\r\n");
      out.write(" \r\n");
      out.write(" \r\n");
      out.write(" <td align='center'><b><font color=#000099 size=5>");
      out.print(txt   );
      out.write("</font></b></td>\r\n");
      out.write(" \r\n");
      out.write("    \t    <td align='center'> <b><font color=#000000 size=4>  ");
      out.print( sentdate[l] );
      out.write(" </td></font></b></td>\r\n");
      out.write("\r\n");
      out.write("<INPUT type='hidden' NAME=msg");
      out.print( l );
      out.write(" SIZE=17  READONLY value=\"");
      out.print( msg[l] );
      out.write("\" >\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    \t    \r\n");
      out.write(" <INPUT type='hidden' NAME=tel");
      out.print( l );
      out.write(" SIZE=17  READONLY value=\"");
      out.print( tel[l] );
      out.write("\" >\r\n");
      out.write("\r\n");
    	    
if(phoneallowed == 1)
{

      out.write("\r\n");
      out.write("    \t    <td align='center'><b><font color=#000000 size=4 dir='ltr'>");
      out.print( tel[l] );
      out.write("</font></b></td>\r\n");

}
else
{
             if(tel[l].length() >= 4)
             {

      out.write("\r\n");
      out.write("    \t       <td align='center'><b><font color=#000000 size=4 dir='ltr'>");
      out.print( tel[l].substring(tel[l].length()-4,tel[l].length()) );
      out.write("</font></b></td>\r\n");

             }
             else
             {

      out.write("\r\n");
      out.write("    \t       <td align='center'><b><font color=#000000 size=4 dir='ltr'>");
      out.print( tel[l] );
      out.write("</font></b></td>\r\n");
             
             }
}

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    \t    <td align='center'> <b><font color=#000000 size=4  dir='ltr'>  ");
      out.print( shortcode[l] );
      out.write(" </font></b></td>    \t       \t    \r\n");
      out.write("\r\n");
      out.write("    \t           \r\n");
      out.write("    \t    \r\n");
      out.write("    \t    \t    \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("   \t        \t    \r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("           </tr>            \r\n");
      out.write("\r\n");
      out.write("</form>\r\n");
      out.write("\r\n");
      out.write(" </table>\r\n");

}

      out.write('\r');
      out.write('\n');

 }

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
      out.write("<br>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</BODY>\r\n");
      out.write("</HTML>\r\n");
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

con.close();   
}
}

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
