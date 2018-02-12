
<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*,java.util.regex.*" %>



 
<%!


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

            
%>










<%
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






   
   
    


   

   

             
%>










<html>
    
    <head>
        <title>Tables</title>
        <!-- Bootstrap -->
        <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" media="screen">
        <link href="assets/styles.css" rel="stylesheet" media="screen">
        <link href="assets/DT_bootstrap.css" rel="stylesheet" media="screen">
        <!--[if lte IE 8]><script language="javascript" type="text/javascript" src="vendors/flot/excanvas.min.js"></script><![endif]-->
        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
        <script src="vendors/modernizr-2.6.2-respond-1.1.0.min.js"></script>


      


function selectall(k)
{
  for( i=0; i< k; i++ )
  { 
   if( document.getElementById('ischeck' + i) != null )  
     { 
     document.getElementById('ischeck' + i).checked = true; 
   }
  }
}



function correctinvoke(target)
{
if(target == 0) {document.mainform.action="BATCHApprove.jsp";document.mainform.submit();}
if(target == 1) {document.mainform.action="BATCHReject.jsp";document.mainform.submit();}
if(target == 2) {document.mainform.action="BATCHWaiting.jsp";document.mainform.submit();}
if(target == 3) {document.mainform.action="BATCHApproveBoxANDBAR.jsp";document.mainform.submit();}




}
 



</script>

    </head>
    
    <body>
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container-fluid">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span>
                     <span class="icon-bar"></span>
                     <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="#">Admin Panel</a>
                    <div class="nav-collapse collapse">
                        <ul class="nav pull-right">
                            <li class="dropdown">
                                <a href="#" role="button" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-user"></i> Vincent Gabriel <i class="caret"></i>

                                </a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a tabindex="-1" href="#">Profile</a>
                                    </li>
                                    <li class="divider"></li>
                                    <li>
                                        <a tabindex="-1" href="login.jsp">Logout</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                        <ul class="nav">
                            <li class="active">
                                <a href="#">Dashboard</a>
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
                                        <a tabindex="-1" href="">Permissions</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <!--/.nav-collapse -->
                </div>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span3" id="sidebar">
                    <ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">
                        <li>
                            <a href="MainPage.jsp"><i class="icon-chevron-right"></i> Dashboard</a>
                        </li>
                        <li>
                            <a href="tables.jsp"><i class="icon-chevron-right"></i> Tables</a>
                        </li>
                        <li>
                            <a href="stats.html"><i class="icon-chevron-right"></i> Statistics (Charts)</a>
                        </li>
                        <li class="active">
                            <a href="tables.jsp"><i class="icon-chevron-right"></i> Tables</a>
                        </li>
                        <li>
                            <a href="form.html"><i class="icon-chevron-right"></i> Users</a>
                        </li>
                       
                       
                        
                    </ul>
                </div>
                <!--/span-->
                <div class="span9" id="content">

                    
                    

                    


                     <div class="row-fluid">
                        <!-- block -->
                        <div class="block">
                            <div class="navbar navbar-inner block-header">
                                <div class="muted pull-left">Bootstrap dataTables</div>
                            </div>
                            <div class="block-content collapse in">
                                <div class="span12">
                                    
  									<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered" id="example">
										<thead>
											<tr>
												<th>Oprators</th>
												<th>phone no</th>
												<th>Date of send</th>
												<th>SMS Text</th>
												<th>Select</th>
											</tr>
										</thead>

										<tbody>
                      <form name=mainform method=post action="" >

                      <INPUT style="display: none;" NAME=theoffset SIZE=10  value="<%= lowerbound %>" > 
                      <INPUT style="display: none;" NAME=countrysc SIZE=10  value="<%= filtershortcode %>" > 
                      <INPUT style="display: none;" NAME=thebase SIZE=10  value="<%= offset %>" > 

                      <INPUT style="display: none;" NAME=count SIZE=10  value="<%= reccount %>" > 

                    <% for (int l =lowerbound ; l < upperbound ; l ++)
                                {

                        %>

											<tr class="odd gradeX">
												
                       
                        <td><%= shortcode[l] %></td>
                        <INPUT type='hidden' NAME=id<%= l %> SIZE=6  READONLY value="<%= id[l] %>" >
												<td><b><font color=#000000 size=4>  <%= sentdate[l] %> </td></font></b></td>
												<td > <b><font color=#000099 size=5><%=  getReadable(replaceWord(msg[l]," ",""),bodyformat[l]) %></font></b></td>
                        
												<td><INPUT id="ischeck<%= l %>" NAME=ischeck<%= l %> TYPE=CHECKBOX ></td>
                        <INPUT type='hidden' NAME=id<%= l %> SIZE=6  READONLY value="<%= id[l] %>" >

                         <INPUT type='hidden' NAME=tel<%= l %> SIZE=17  READONLY value="<%= tel[l] %>" >
                        <%          
                      if(phoneallowed == 1)
                      {
                      %>
                                <td align='center'><b><font color=#000000 size=4 dir='ltr'><%= tel[l] %></font></b></td>
                      <%
                      }
                      else
                      {
                                   if(tel[l].length() >= 4)
                                   {
                      %>
                                   <td align='center'><b><font color=#000000 size=4 dir='ltr'><%= tel[l].substring(tel[l].length()-4,tel[l].length()) %></font></b></td>
                      <%
                                   }
                                   else
                                   {
                      %>
                                   <td align='center'><b><font color=#000000 size=4 dir='ltr'><%= tel[l] %></font></b></td>
                      <%             
                                   }
                      }
                      %>






											</tr>
											
											
										<%
                    }
                    %>
                    </form>
										</tbody>
									</table>
                                </div>
                            </div>
                        </div>
                        <!-- /block -->
                    </div>

                     
                </div>
            </div>
            <hr>
            <footer>
                <p>&copy; Vincent Gabriel 2013</p>
            </footer>
        </div>
        <!--/.fluid-container-->

        <script src="vendors/jquery-1.9.1.js"></script>
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <script src="vendors/datatables/js/jquery.dataTables.min.js"></script>


        <script src="assets/scripts.js"></script>
        <script src="assets/DT_bootstrap.js"></script>
        <script>
        $(function() {
            
        });
        </script>
    </body>

</html>

<%
con.close();   
}
}
%>