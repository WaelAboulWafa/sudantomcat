<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*" %>


 

<%!
   
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

            
%>










<%
String username;try{ username =  session.getAttribute("username").toString();}catch(Exception e){username=null;}
String password;try{password =  session.getAttribute("password").toString();}catch(Exception e){password=null;}
if(username==null || password==null) //user not logged in
{
session.invalidate();
response.sendRedirect("login.jsp");
}



  /////get user authorities/////////////
  Connection con=null;
  InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();
  ResultSet rs = null;
  int userid= 0;
  try
  {
   rs = con.createStatement().executeQuery("SELECT userID from fitservice.nationaltv_pgm_Users where username=N'" + username.replaceAll("'", "''") + "' and password=N'" + password.replaceAll("'", "''") + "'");             
   userid = 0;
   while(rs.next()){userid = rs.getInt(1);}
   rs.close();rs = null;
  }catch(Exception e){}
  
  



  int reccount = 0 ;
  rs = null;
  try
  {
   rs = con.createStatement().executeQuery("SELECT count(*) from fitservice.nationaltv_pgm_UsersAuthorities where userID=" + userid);             
   while(rs.next()){reccount = rs.getInt(1);} 
   rs.close();rs = null;
  }catch(Exception e){}
  
  
  String[] thepage = new String[reccount];
  int[] allowed = new int[reccount];
  
  rs = null;
  int z =0;
  try
  {
   rs = con.createStatement().executeQuery("SELECT page, allowed from fitservice.nationaltv_pgm_UsersAuthorities where userID=" + userid);             
   while(rs.next()){thepage[z]=rs.getString(1);allowed[z]=rs.getInt(2);z=z+1;}
   rs.close();rs = null;
  }catch(Exception e){}
    


  /*
  boolean allowedaccess = false;
  for(int k =0;k< thepage.length ; k++)
  {
   if(thepage[k].equalsIgnoreCase("filteration.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k].equalsIgnoreCase("send.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k].equalsIgnoreCase("nicknames.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k].equalsIgnoreCase("smsonair.jsp"){if(theflag[k] == 1){allowedaccess true;}}         
   if(thepage[k].equalsIgnoreCase("search.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k].equalsIgnoreCase("badwords.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k].equalsIgnoreCase("operatorsproviders.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k].equalsIgnoreCase("upperinfo.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k].equalsIgnoreCase("lowerinfo.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k].equalsIgnoreCase("instructions.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k].equalsIgnoreCase("smscount.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k].equalsIgnoreCase("smsdistribution.jsp"){if(theflag[k] == 1){allowedaccess true;}}
   if(thepage[k].equalsIgnoreCase("autorities.jsp"){if(theflag[k] == 1){allowedaccess true;}}                           
  }
  */
  
%>





<html dir='rtl'>

<head>
<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt Arabic Transparent, geneva, lucida, "lucida grande", Arabic Transparent, helvetica, sans-serif; COLOR: #000000 }</style>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<title>«·ﬁ«∆„… «·—∆Ì”Ì… ... National TV</title>

        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
        <link href="vendors/easypiechart/jquery.easy-pie-chart.css" rel="stylesheet" media="screen">
        <link href="assets/styles.css" rel="stylesheet" media="screen">
        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <script src="vendors/modernizr-2.6.2-respond-1.1.0.min.js"></script>
</head>
<body>

 <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span>
                     <span class="icon-bar"></span>
                     <span class="icon-bar"></span>
                    </a>
                    
                    <div class="nav-collapse collapse">
                        <ul class="nav pull-left">
                            <li class="dropdown">
                                <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-user"></i> <font size='5' Color=green><b> <%= (new String(username.getBytes("Cp1252"),"Cp1256")) %> </b></font> <i class="caret"></i>

                                </a>

                                <ul class="dropdown-menu">
                                    <li>
                                        <a tabindex="-1" href="#">Profile</a>
                                    </li>
                                    <li class="divider"></li>
                                    <li>
                                        <a tabindex="-1" href="login_logout.jsp">Logout</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                        <ul class="nav pull-right">
                            <li class="active">
                                <a href="#" >Dashboard</a>
                            </li>
                            <li class="">
                                    <li>
                                        <a href="#">SEO Settings</a>
                                    </li>
                                    <li>
                                        <a href="#">Other Link</a>
                                    </li>
                            </li>
                            <li class="dropdown">
                                <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">Content <i class="caret"></i>

                                </a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a tabindex="-1" href="#">Blog</a>
                                    </li>
                                    <li>
                                        <a tabindex="-1" href="#">News</a>
                                    </li>
                                    <li>
                                        <a tabindex="-1" href="#">Custom Pages</a>
                                    </li>
                                    <li>
                                        <a tabindex="-1" href="#">Calendar</a>
                                    </li>
                                    <li class="divider"></li>
                                    <li>
                                        <a tabindex="-1" href="#">FAQ</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">Users <i class="caret"></i>

                                </a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a tabindex="-1" href="#">User List</a>
                                    </li>
                                    <li>
                                        <a tabindex="-1" href="#">Search</a>
                                    </li>
                                    <li>
                                        <a tabindex="-1" href="#">Permissions</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <!--/.nav-collapse -->
                </div>
            </div>
		    
		    
<table border='0' bgcolor=#ffffff cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%' height='85'>
  <tr>
	  <td width='21%' align='center'><font size='5' Color=darkred><b>„—Õ»« ,</b></font><font size='5' Color=green><b> <%= (new String(username.getBytes("Cp1252"),"Cp1256")) %> </b></font></td>
    <td width='35%' align='center'>&nbsp;
    </td>
    <td width='19%' align='center'>
    	<table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%'>
    	&nbsp;
    	</table>
    </td>
    <td bgcolor='#ffffff' width='12%' align='center'><IMG src='logo.png'></td>
  </tr>
</table>


<br>		    
		    
		    
		    <table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
                  <tr>
                    <td width='3%'>&nbsp;</td>
                    <td width='22%' valign='top'>
                    <!-- ..................... SMS Table .................... -->
                    <table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
                        <tr bgcolor=#646464>
                              <td width='100%' colspan='2' align='center' height='30'><b><font size='5' color=white>«·—”«∆· «·ﬁ’Ì—Â</font></b></td>
                        </tr>
                        
                        




                        
<%
if(isallowed("filteration.jsp",thepage,allowed))
{
%>
                        <tr bgcolor=#DCDCDC>
                        <%
                         if(username.equalsIgnoreCase("admin")){
                        %>
                              <form action='filterationadmin.jsp' method='post'>
                  	            <td width='20%' height='40' align='center'><IMG src='ok.gif'></td>
                                <td width='80%' height='40'><p align='center'><input type='submit' name='subApprove' value='—”«∆· €Ì— „ﬁ—Ê∆Â' STYLE='font-family:Arabic Transparent;font-weight:bold; font-size:14pt ; width:10em ; height:2.5em'></td>
                  		      </form>
                        </tr>
                        <%
                         }
                         else{
                            %>
                                  <form action='filteration.jsp' method='post'>
                      	            <td width='20%' height='40' align='center'><IMG src='ok.gif'></td>
                                    <td width='80%' height='40'><p align='center'><input type='submit' name='subApprove' value='—”«∆· €Ì— „ﬁ—Ê∆Â' STYLE='font-family:Arabic Transparent;font-weight:bold; font-size:14pt ; width:10em ; height:2.5em'></td>
                      		      </form>
                            </tr>
                            <%
                        }
                        %>
                        <tr bgcolor=#DCDCDC>
                        <% if (username.equalsIgnoreCase("admin")) { %>
                              <form action='ftp://Netia_IVR:Netia@123@196.29.186.246' method='post'>
                              <%} 
                              else {%>
                              <form action='ftp://<%=username %>:<%=password %>@196.29.186.246' method='post'>
                              <%} %>
                  	            <td width='20%' height='40' align='center'><IMG src='ok.gif'></td>
                                <td width='80%' height='40'><p align='center'><input type='submit' name='subApprove' value=' ’›Õ «· ”ÃÌ·« ' STYLE='font-family:Arabic Transparent;font-weight:bold; font-size:14pt ; width:10em ; height:2.5em'></td>
                  		      </form>
                        </tr>
<%

}
else
{
%>
<tr bgcolor=#DCDCDC>
 <td width='20%' height='40' align='center'></td>
 <td width='80%' height='40'><p align='center'><font face='Arabic Transparent' size='5'><b>—”«∆· €Ì— „ﬁ—Ê∆Â</b></font></td>
</tr>

<%
}
%>
       


<%
if(isallowed("search.jsp",thepage,allowed))
{
%>			      <%
						if(username.equalsIgnoreCase("admin")){
					%>
			      <tr bgcolor=#DCDCDC><form action='searchadmin.jsp' method='post'>
						      <input type='hidden' name='uid' value='41'>
					          <td width='20%' height='40' align='center'><IMG src='ok.gif'></td>
				                <td width='80%' height='40'><p align='center'><input type='submit' name='subSrch' value='ﬂ· «·—”«∆·' STYLE='font-family:Arabic Transparent;font-weight:bold; font-size:14pt ; width:10em ; height:2.5em'></td>
						      </form>
			      </tr>
			      <%
						}
						else{
			      %>
			      <tr bgcolor=#DCDCDC><form action='search.jsp' method='post'>
						      <input type='hidden' name='uid' value='41'>
					          <td width='20%' height='40' align='center'><IMG src='ok.gif'></td>
				                <td width='80%' height='40'><p align='center'><input type='submit' name='subSrch' value='ﬂ· «·—”«∆·' STYLE='font-family:Arabic Transparent;font-weight:bold; font-size:14pt ; width:10em ; height:2.5em'></td>
						      </form>
			      </tr>
			      <%
			      	
						}

					%>
<%
}
else
{
%>
<tr bgcolor=#DCDCDC>
 <td width='20%' height='40' align='center'></td>
 <td width='80%' height='40'><p align='center'><font face='Arabic Transparent' size='5'><b>ﬂ· «·—”«∆·</b></font></td>
</tr>

<%
}
%>
			      



			      
			</table>
			
			
			
			
			
			
			
			
			
                  <!-- ........................ Reserved Table .................... -->
	    				</td>

	    				<td width='2%'>&nbsp;</td>
	    				<td width='22%' valign='top'>


					    
						<!-- ........................ End Of News Table .................... -->

	    				</td>
	    				<td width='2%'>&nbsp;</td>
	    				<td width='22%' valign='top'>




	    				</td>
	    				<td width='2%'>&nbsp;</td>







	    				<td width='22%' valign='top'>

					    <!-- ........................ Report Table .................... -->
					    <table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
					      <tr bgcolor=#646464>
					        <td width='100%' colspan='2' align='center' height='30'><b><font size='5' color=white>«·«œ«—Â</font></b></td>
					      </tr>
					      
					      
					      
					      
					      
					      
					      
					      
					      
<%
if(isallowed("autorities.jsp",thepage,allowed))
{
%>						      
						      
					      
					      <tr bgcolor=#DCDCDC> <form action='autorities.jsp' method='post'>
									  <input type='hidden' name='uid' value='41'>

							          <td width='20%' height='40' align='center'><IMG src='ok.gif'></td>
						              <td width='80%' height='40'><p align='center'><input type='submit' name='subAdmin' value='«·’·«ÕÌ« ' STYLE='font-family:Arabic Transparent ; font-weight:bold; font-size:14pt ; width:10em ; height:2.5em'></td>
								      </form>
								     
					      </tr>


					      
					      
<%
}
else
{
%>
<tr bgcolor=#DCDCDC>
 <td width='20%' height='40' align='center'></td>
 <td width='80%' height='40'><p align='center'><font face='Arabic Transparent' size='5'><b>«·’·«ÕÌ« </b></font></td>
</tr>

<%
}
%>
							      
	







	





					    </table>
						<!-- ........................ End Of Report Table .................... -->

	    				</td>
	    				<td width='3%'>&nbsp;</td>
	  				</tr>
				</table>

			    <!-- ........................ Log Off .................... -->
			    <br>
				<table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
	  				<tr>
	    				<td width='3%'>&nbsp;</td>
	    				<td width='22%' valign='top'>
					    	<table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
						      <tr bgcolor=#DCDCDC>
								<form action='login_logout.jsp' method='post'>
								<input type='hidden' name='uid' value='41'>
					                  <td width='80%' height='40'><p align='center'><input type='submit' name='subLogOff' value='Œ‹‹—ÊÃ' STYLE='font-family:Arabic Transparent ; font-weight:bold; font-size:14pt ; width:12em ; height:2.5em'></td>
							    </form>
						      </tr>
							</table>
	    				</td>
	    				<td width='2%'>&nbsp;</td>
	    				<td width='22%' valign='top'>
	    				&nbsp;
	    				</td>
	    				<td width='2%'>&nbsp;</td>
	    				<td width='22%' valign='top'>
	    				&nbsp;
	    				</td>
	    				<td width='2%'>&nbsp;</td>
	    				<td width='22%' valign='top'>
	    				&nbsp;
	    				</td>
	    				<td width='3%'>&nbsp;</td>
	  				</tr>
				</table>

				<!-- ........................ Log Off .................... -->



<br>
<br>


				
</body>

</html>




<%
con.close();
%>