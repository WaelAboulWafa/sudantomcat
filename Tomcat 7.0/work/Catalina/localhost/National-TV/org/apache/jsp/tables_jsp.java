/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.54
 * Generated at: 2015-09-21 13:02:34 UTC
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

public final class tables_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write(" \n");
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

String username;try{ username =  session.getAttribute("username").toString();}catch(Exception e){username=null;}
String password;try{password =  session.getAttribute("password").toString();}catch(Exception e){password=null;}
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
   rs = con.createStatement().executeQuery("SELECT userID,phone from fitservice.bayt_pgm_Users where username=N'" + username.replaceAll("'", "''") + "' and password=N'" + password.replaceAll("'", "''") + "'");             
   userid = 0;
   while(rs.next()){userid = rs.getInt(1);phoneallowed=rs.getInt(2);}
   rs.close();rs = null;
  }catch(Exception e){out.println(e.toString());}
  
  

//out.println(userid);


  int reccount1 = 0 ;
  rs = null;
  try
  {
   rs = con.createStatement().executeQuery("SELECT count(*) from fitservice.bayt_pgm_UsersAuthorities where userID=" + userid);             
   while(rs.next()){reccount1 = rs.getInt(1);} 
   rs.close();rs = null;
  }catch(Exception e){}
  
  
  String[] thepage = new String[reccount1];
  int[] allowed = new int[reccount1];
  
  rs = null;
  int z =0;
  try
  {
   rs = con.createStatement().executeQuery("SELECT page, allowed from fitservice.bayt_pgm_UsersAuthorities where userID=" + userid);             
   while(rs.next()){thepage[z]=rs.getString(1);allowed[z]=rs.getInt(2);z=z+1;}
   rs.close();rs = null;
  }catch(Exception e){}
    










  rs = null;
  String indate=""; 
  String intime="";
  try
  {
//   rs = con.createStatement().executeQuery("SELECT  CONVERT(char(10), lastlogintime, 101), convert(varchar,lastlogintime, 8)  from fitservice.bayt_pgm_Users where userID=" + userid);             
   rs = con.createStatement().executeQuery("SELECT  lastlogintime,  lastlogintime  from fitservice.bayt_pgm_Users where userID=" + userid);                
   while(rs.next()){indate=rs.getString(1);intime=rs.getString(2);}
   rs.close();rs = null;
  }catch(Exception e){out.println(e.toString());}




//out.println(username);out.println(password);

  
  boolean allowedaccess = false;
  for(int k =0;k< thepage.length ; k++)
  {
   if(thepage[k].equalsIgnoreCase("filteration.jsp")){if(allowed[k] == 1){allowedaccess =true;}}
  }
  
  


// out.println(allowedaccess); if(1==1)return;

if(allowedaccess ==false)
{
response.sendRedirect("login_logout.jsp");
return;
}

else
{

  rs = null;



int offset=0;

if(request.getParameter("offset")!=null) 
{
 offset= Integer.parseInt(request.getParameter("offset").toString());
}

int pagesize = 50;
int count= 0;
int pages = 0;
int lowerbound = 0;
int upperbound = 0;






















  int reccount = 0;
     String[] id = null;
     String[] sentdate =  null;
     String[] shortcode = null;      
     String[] tel = null;
     String[] bodyformat = null;       
     String[] msg = null;     


      
     int visiblecount = 0 ;

int whenrejectcount = 0;    







//-----------------------------------
/*String query1 = "SELECT count(*) from fitservice.bayt_pgm_smss where flag=0";
String query2 = "SELECT ID from fitservice.bayt_pgm_smss where flag=0 order by ID";
String query3 = "select fitservice.bayt_pgm_smss.ID,fitservice.bayt_pgm_smss.intime, messages.messages.Recipient,messages.messages.Sender, messages.messages.bodyformat,messages.messages.body from  fitservice.bayt_pgm_smss INNER JOIN messages.messages  ON fitservice.bayt_pgm_smss.ID = messages.messages.id and fitservice.bayt_pgm_smss.flag=0 order by fitservice.bayt_pgm_smss.ID  asc";
*/

String query1 = "SELECT count(*) from fitservice.bayt_pgm_smss where status=0 ";
String query2 = "SELECT ID from fitservice.bayt_pgm_smss where status=0 order by ID";
String query3 = "Select ID, datein, shortcode, msisdn, lang, Contents from fitservice.bayt_pgm_smss where status=0 order by ID asc";

String filtershortcode = "ALL";




    

      rs = con.createStatement().executeQuery(query1);            
      if(rs.next())
      {
         reccount = rs.getInt(1);
      }
        rs.close(); rs = null;
   
  
    count =  reccount;
  
       
       rs = con.createStatement().executeQuery(query2);            
       while(rs.next())
       {
         String tmp = rs.getString(1);
         visiblecount = visiblecount + 1 ;
       }
        rs.close(); rs = null;
        
   
   rs = null;
   rs = con.createStatement().executeQuery(query3);

   
     id = new String[visiblecount];
     tel = new String[visiblecount];
     shortcode = new String[visiblecount];
     msg = new String[visiblecount];
     bodyformat = new String[visiblecount];
     sentdate =  new String[visiblecount];
     
   
   rs.next();
   //int theCounter = 0;
   //while(rs.next())
for (int theCounter=0;theCounter<visiblecount;theCounter++)
    {
     id[theCounter] = rs.getString(1).trim();
     sentdate[theCounter] =  rs.getString(2).trim();     
     shortcode[theCounter] = rs.getString(3).trim();          
     tel[theCounter] = rs.getString(4).trim();     
     bodyformat[theCounter] = rs.getString(5).trim(); 
     msg[theCounter] = rs.getString(6).trim(); 

    
     
     rs.next();
    // theCounter = theCounter + 1 ;
   }
   rs.close(); 
   rs = null;
   
   
   
   

   
   




















   if(count != 0 ) 
   {
     if(count%pagesize ==0)
      {
        pages = (count/pagesize);
      }
      else
      {  
        pages = (count/pagesize) + 1  ;
     }
   }
 
if(count != 0 )
{
if(pages == 1)
{
lowerbound = 0;
upperbound = count;
}
else
{

if( ( (offset) * pagesize) <= count)
{
 lowerbound = (offset * pagesize) ;

 if(   ((offset+1) * pagesize) > count )
  {
   upperbound = count;
  }
  else
  {
   upperbound = ( (offset+1) * pagesize);
  }
}
else
{
lowerbound = 0;
upperbound = 0;

}  
}  
  
 
}






   
   
    


   

   

             

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
      out.write("<html>\n");
      out.write("    \n");
      out.write("    <head>\n");
      out.write("        <title>Tables</title>\n");
      out.write("        <!-- Bootstrap -->\n");
      out.write("        <link href=\"bootstrap/css/bootstrap.min.css\" rel=\"stylesheet\" media=\"screen\">\n");
      out.write("        <link href=\"bootstrap/css/bootstrap-responsive.min.css\" rel=\"stylesheet\" media=\"screen\">\n");
      out.write("        <link href=\"assets/styles.css\" rel=\"stylesheet\" media=\"screen\">\n");
      out.write("        <link href=\"assets/DT_bootstrap.css\" rel=\"stylesheet\" media=\"screen\">\n");
      out.write("        <!--[if lte IE 8]><script language=\"javascript\" type=\"text/javascript\" src=\"vendors/flot/excanvas.min.js\"></script><![endif]-->\n");
      out.write("        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->\n");
      out.write("        <!--[if lt IE 9]>\n");
      out.write("            <script src=\"http://html5shim.googlecode.com/svn/trunk/html5.js\"></script>\n");
      out.write("        <![endif]-->\n");
      out.write("        <script src=\"vendors/modernizr-2.6.2-respond-1.1.0.min.js\"></script>\n");
      out.write("\n");
      out.write("\n");
      out.write("      \n");
      out.write("\n");
      out.write("\n");
      out.write("function selectall(k)\n");
      out.write("{\n");
      out.write("  for( i=0; i< k; i++ )\n");
      out.write("  { \n");
      out.write("   if( document.getElementById('ischeck' + i) != null )  \n");
      out.write("     { \n");
      out.write("     document.getElementById('ischeck' + i).checked = true; \n");
      out.write("   }\n");
      out.write("  }\n");
      out.write("}\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("function correctinvoke(target)\n");
      out.write("{\n");
      out.write("if(target == 0) {document.mainform.action=\"BATCHApprove.jsp\";document.mainform.submit();}\n");
      out.write("if(target == 1) {document.mainform.action=\"BATCHReject.jsp\";document.mainform.submit();}\n");
      out.write("if(target == 2) {document.mainform.action=\"BATCHWaiting.jsp\";document.mainform.submit();}\n");
      out.write("if(target == 3) {document.mainform.action=\"BATCHApproveBoxANDBAR.jsp\";document.mainform.submit();}\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("}\n");
      out.write(" \n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("</script>\n");
      out.write("\n");
      out.write("    </head>\n");
      out.write("    \n");
      out.write("    <body>\n");
      out.write("        <div class=\"navbar navbar-fixed-top\">\n");
      out.write("            <div class=\"navbar-inner\">\n");
      out.write("                <div class=\"container-fluid\">\n");
      out.write("                    <a class=\"btn btn-navbar\" data-toggle=\"collapse\" data-target=\".nav-collapse\"> <span class=\"icon-bar\"></span>\n");
      out.write("                     <span class=\"icon-bar\"></span>\n");
      out.write("                     <span class=\"icon-bar\"></span>\n");
      out.write("                    </a>\n");
      out.write("                    <a class=\"brand\" href=\"#\">Admin Panel</a>\n");
      out.write("                    <div class=\"nav-collapse collapse\">\n");
      out.write("                        <ul class=\"nav pull-right\">\n");
      out.write("                            <li class=\"dropdown\">\n");
      out.write("                                <a href=\"#\" role=\"button\" class=\"dropdown-toggle\" data-toggle=\"dropdown\"> <i class=\"icon-user\"></i> Vincent Gabriel <i class=\"caret\"></i>\n");
      out.write("\n");
      out.write("                                </a>\n");
      out.write("                                <ul class=\"dropdown-menu\">\n");
      out.write("                                    <li>\n");
      out.write("                                        <a tabindex=\"-1\" href=\"#\">Profile</a>\n");
      out.write("                                    </li>\n");
      out.write("                                    <li class=\"divider\"></li>\n");
      out.write("                                    <li>\n");
      out.write("                                        <a tabindex=\"-1\" href=\"login.jsp\">Logout</a>\n");
      out.write("                                    </li>\n");
      out.write("                                </ul>\n");
      out.write("                            </li>\n");
      out.write("                        </ul>\n");
      out.write("                        <ul class=\"nav\">\n");
      out.write("                            <li class=\"active\">\n");
      out.write("                                <a href=\"#\">Dashboard</a>\n");
      out.write("                            </li>\n");
      out.write("                           \n");
      out.write("                            \n");
      out.write("                            <li class=\"dropdown\">\n");
      out.write("                                <a href=\"#\" role=\"button\" class=\"dropdown-toggle\" data-toggle=\"dropdown\">Users <i class=\"caret\"></i>\n");
      out.write("\n");
      out.write("                                </a>\n");
      out.write("                                <ul class=\"dropdown-menu\">\n");
      out.write("                                    <li>\n");
      out.write("                                        <a tabindex=\"-1\" href=\"#\">User List</a>\n");
      out.write("                                    </li>\n");
      out.write("                                    <li>\n");
      out.write("                                        <a tabindex=\"-1\" href=\"#\">Search</a>\n");
      out.write("                                    </li>\n");
      out.write("                                    <li>\n");
      out.write("                                        <a tabindex=\"-1\" href=\"\">Permissions</a>\n");
      out.write("                                    </li>\n");
      out.write("                                </ul>\n");
      out.write("                            </li>\n");
      out.write("                        </ul>\n");
      out.write("                    </div>\n");
      out.write("                    <!--/.nav-collapse -->\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("        <div class=\"container-fluid\">\n");
      out.write("            <div class=\"row-fluid\">\n");
      out.write("                <div class=\"span3\" id=\"sidebar\">\n");
      out.write("                    <ul class=\"nav nav-list bs-docs-sidenav nav-collapse collapse\">\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"MainPage.jsp\"><i class=\"icon-chevron-right\"></i> Dashboard</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"tables.jsp\"><i class=\"icon-chevron-right\"></i> Tables</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"stats.html\"><i class=\"icon-chevron-right\"></i> Statistics (Charts)</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li class=\"active\">\n");
      out.write("                            <a href=\"tables.jsp\"><i class=\"icon-chevron-right\"></i> Tables</a>\n");
      out.write("                        </li>\n");
      out.write("                        <li>\n");
      out.write("                            <a href=\"form.html\"><i class=\"icon-chevron-right\"></i> Users</a>\n");
      out.write("                        </li>\n");
      out.write("                       \n");
      out.write("                       \n");
      out.write("                        \n");
      out.write("                    </ul>\n");
      out.write("                </div>\n");
      out.write("                <!--/span-->\n");
      out.write("                <div class=\"span9\" id=\"content\">\n");
      out.write("\n");
      out.write("                    \n");
      out.write("                    \n");
      out.write("\n");
      out.write("                    \n");
      out.write("\n");
      out.write("\n");
      out.write("                     <div class=\"row-fluid\">\n");
      out.write("                        <!-- block -->\n");
      out.write("                        <div class=\"block\">\n");
      out.write("                            <div class=\"navbar navbar-inner block-header\">\n");
      out.write("                                <div class=\"muted pull-left\">Bootstrap dataTables</div>\n");
      out.write("                            </div>\n");
      out.write("                            <div class=\"block-content collapse in\">\n");
      out.write("                                <div class=\"span12\">\n");
      out.write("                                    \n");
      out.write("  \t\t\t\t\t\t\t\t\t<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"table table-striped table-bordered\" id=\"example\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<thead>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<th>Oprators</th>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<th>phone no</th>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<th>Date of send</th>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<th>SMS Text</th>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<th>Select</th>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</thead>\n");
      out.write("\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<tbody>\n");
      out.write("                      <form name=mainform method=post action=\"\" >\n");
      out.write("\n");
      out.write("                      <INPUT style=\"display: none;\" NAME=theoffset SIZE=10  value=\"");
      out.print( lowerbound );
      out.write("\" > \n");
      out.write("                      <INPUT style=\"display: none;\" NAME=countrysc SIZE=10  value=\"");
      out.print( filtershortcode );
      out.write("\" > \n");
      out.write("                      <INPUT style=\"display: none;\" NAME=thebase SIZE=10  value=\"");
      out.print( offset );
      out.write("\" > \n");
      out.write("\n");
      out.write("                      <INPUT style=\"display: none;\" NAME=count SIZE=10  value=\"");
      out.print( reccount );
      out.write("\" > \n");
      out.write("\n");
      out.write("                    ");
 for (int l =lowerbound ; l < upperbound ; l ++)
                                {

                        
      out.write("\n");
      out.write("\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<tr class=\"odd gradeX\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t\n");
      out.write("                       \n");
      out.write("                        <td>");
      out.print( shortcode[l] );
      out.write("</td>\n");
      out.write("                        <INPUT type='hidden' NAME=id");
      out.print( l );
      out.write(" SIZE=6  READONLY value=\"");
      out.print( id[l] );
      out.write("\" >\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<td><b><font color=#000000 size=4>  ");
      out.print( sentdate[l] );
      out.write(" </td></font></b></td>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<td > <b><font color=#000099 size=5>");
      out.print(  getReadable(replaceWord(msg[l]," ",""),bodyformat[l]) );
      out.write("</font></b></td>\n");
      out.write("                        \n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<td><INPUT id=\"ischeck");
      out.print( l );
      out.write("\" NAME=ischeck");
      out.print( l );
      out.write(" TYPE=CHECKBOX ></td>\n");
      out.write("                        <INPUT type='hidden' NAME=id");
      out.print( l );
      out.write(" SIZE=6  READONLY value=\"");
      out.print( id[l] );
      out.write("\" >\n");
      out.write("\n");
      out.write("                         <INPUT type='hidden' NAME=tel");
      out.print( l );
      out.write(" SIZE=17  READONLY value=\"");
      out.print( tel[l] );
      out.write("\" >\n");
      out.write("                        ");
          
                      if(phoneallowed == 1)
                      {
                      
      out.write("\n");
      out.write("                                <td align='center'><b><font color=#000000 size=4 dir='ltr'>");
      out.print( tel[l] );
      out.write("</font></b></td>\n");
      out.write("                      ");

                      }
                      else
                      {
                                   if(tel[l].length() >= 4)
                                   {
                      
      out.write("\n");
      out.write("                                   <td align='center'><b><font color=#000000 size=4 dir='ltr'>");
      out.print( tel[l].substring(tel[l].length()-4,tel[l].length()) );
      out.write("</font></b></td>\n");
      out.write("                      ");

                                   }
                                   else
                                   {
                      
      out.write("\n");
      out.write("                                   <td align='center'><b><font color=#000000 size=4 dir='ltr'>");
      out.print( tel[l] );
      out.write("</font></b></td>\n");
      out.write("                      ");
             
                                   }
                      }
                      
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t</tr>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\t\t\t\t");

                    }
                    
      out.write("\n");
      out.write("                    </form>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</tbody>\n");
      out.write("\t\t\t\t\t\t\t\t\t</table>\n");
      out.write("                                </div>\n");
      out.write("                            </div>\n");
      out.write("                        </div>\n");
      out.write("                        <!-- /block -->\n");
      out.write("                    </div>\n");
      out.write("\n");
      out.write("                     \n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("            <hr>\n");
      out.write("            <footer>\n");
      out.write("                <p>&copy; Vincent Gabriel 2013</p>\n");
      out.write("            </footer>\n");
      out.write("        </div>\n");
      out.write("        <!--/.fluid-container-->\n");
      out.write("\n");
      out.write("        <script src=\"vendors/jquery-1.9.1.js\"></script>\n");
      out.write("        <script src=\"bootstrap/js/bootstrap.min.js\"></script>\n");
      out.write("        <script src=\"vendors/datatables/js/jquery.dataTables.min.js\"></script>\n");
      out.write("\n");
      out.write("\n");
      out.write("        <script src=\"assets/scripts.js\"></script>\n");
      out.write("        <script src=\"assets/DT_bootstrap.js\"></script>\n");
      out.write("        <script>\n");
      out.write("        $(function() {\n");
      out.write("            \n");
      out.write("        });\n");
      out.write("        </script>\n");
      out.write("    </body>\n");
      out.write("\n");
      out.write("</html>\n");
      out.write("\n");

con.close();   
}
}

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
