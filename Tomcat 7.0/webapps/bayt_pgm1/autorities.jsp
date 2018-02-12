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
 
 

 public boolean ispageallowed(String[] thepage,String[] theright,String pagerequired)
 {

  for(int k=0;k<thepage.length;k++)
  {
    if(thepage[k].equalsIgnoreCase(pagerequired))
    {
     if(theright[k].equalsIgnoreCase("1")){return true;}  
    }
  }

  return false;
 } 
 
 
 
 
public String getuid(String the_uname,Connection thecon)throws Exception
{

 int thisid= 0;
 ResultSet thers;
 
 thers = thecon.createStatement().executeQuery("select userid from fitservice.bayt_pgm_Users where username=N'"+ the_uname + "'");            
 while(thers.next()){thisid=thers.getInt(1);}thers.close();thers = null;
 
 return Integer.toString(thisid);
 
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

  try
  {
   rs = con.createStatement().executeQuery("SELECT userID from fitservice.bayt_pgm_Users where username=N'" + username.replaceAll("'", "''") + "' and password=N'" + password.replaceAll("'", "''") + "'");             
   userid = 0;
   while(rs.next()){userid = rs.getInt(1);}
   rs.close();rs = null;
  }catch(Exception e){}
  
  



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
   rs = con.createStatement().executeQuery("SELECT  CONVERT(char(10), lastlogintime, 101), convert(varchar,lastlogintime, 8)  from fitservice.bayt_pgm_Users where userID=" + userid);             
   while(rs.next()){indate=rs.getString(1);intime=rs.getString(2);}
   rs.close();rs = null;
  }catch(Exception e){}







  
  boolean allowedaccess = false;
  for(int k =0;k< thepage.length ; k++)
  {
//   if(thepage[k].equalsIgnoreCase("filteration.jsp")){if(allowed[k] == 1){allowedaccess =true;}}
//   if(thepage[k].equalsIgnoreCase("send.jsp")){if(allowed[k] == 1){allowedaccess =true;}}
//   if(thepage[k].equalsIgnoreCase("nicknames.jsp")){if(allowed[k] == 1){allowedaccess =true;}}
//   if(thepage[k].equalsIgnoreCase("smsonair.jsp")){if(allowed[k] == 1){allowedaccess =true;}}         
//   if(thepage[k].equalsIgnoreCase("search.jsp")){if(allowed[k] == 1){allowedaccess =true;}}
//   if(thepage[k].equalsIgnoreCase("badwords.jsp")){if(allowed[k] == 1){allowedaccess =true;}}
//   if(thepage[k].equalsIgnoreCase("operatorsproviders.jsp")){if(allowed[k] == 1){allowedaccess =true;}}
//   if(thepage[k].equalsIgnoreCase("upperinfo.jsp")){if(allowed[k] == 1){allowedaccess =true;}}
//   if(thepage[k].equalsIgnoreCase("lowerinfo.jsp")){if(allowed[k] == 1){allowedaccess =true;}}
//   if(thepage[k].equalsIgnoreCase("instructions.jsp")){if(allowed[k] == 1){allowedaccess =true;}}
//   if(thepage[k].equalsIgnoreCase("smscount.jsp")){if(allowed[k] == 1){allowedaccess =true;}}
//   if(thepage[k].equalsIgnoreCase("smsdistribution.jsp")){if(allowed[k] == 1){allowedaccess =true;}}
   if(thepage[k].equalsIgnoreCase("autorities.jsp")){if(allowed[k] == 1){allowedaccess =true;}}                           
  }
  
  


// out.println(allowedaccess);

if(allowedaccess ==false)
{
response.sendRedirect("login_logout.jsp");
return;
}

else
{















//user pressed modify
if( request.getParameter("subUpdate")!=null) 
{
String curr_uid="0";
String curr_uname= request.getParameter("uname");
curr_uid = getuid(curr_uname,con);


rs=null;
if( request.getParameter("filteration")!=null) {con.createStatement().execute("update fitservice.bayt_pgm_UsersAuthorities set allowed=1 where page='filteration.jsp' and userid="+ curr_uid );  }
else{con.createStatement().execute("update fitservice.bayt_pgm_UsersAuthorities set allowed=0 where page='filteration.jsp' and userid="+ curr_uid );  }

if( request.getParameter("search")!=null) {con.createStatement().execute("update fitservice.bayt_pgm_UsersAuthorities set allowed=1 where page='search.jsp' and userid="+ curr_uid );  }
else {con.createStatement().execute("update fitservice.bayt_pgm_UsersAuthorities set allowed=0 where page='search.jsp' and userid="+ curr_uid );  }


if( request.getParameter("autorities")!=null) {con.createStatement().execute("update fitservice.bayt_pgm_UsersAuthorities set allowed=1 where page='autorities.jsp' and userid="+ curr_uid );  }
else  {con.createStatement().execute("update fitservice.bayt_pgm_UsersAuthorities set allowed=0 where page='autorities.jsp' and userid="+ curr_uid );  }


//phone numbers
if( request.getParameter("phone")!=null) {con.createStatement().execute("update fitservice.bayt_pgm_Users set phone=1 where userid="+ curr_uid );  }
else  {con.createStatement().execute("update fitservice.bayt_pgm_Users set phone=0 where userid="+ curr_uid );  }




}










///user pressed add
if( request.getParameter("subAdd")!=null) 
{
    
   int userFnd = 0;
   rs = con.createStatement().executeQuery("SELECT  count(*) as thecnt from fitservice.bayt_pgm_Users where username=N'" + request.getParameter("uname").trim() +"'");             
   while(rs.next()){userFnd=rs.getInt(1);}rs.close();rs = null;
   


if(userFnd == 0)
{
 String the__query ="insert into  fitservice.bayt_pgm_Users( username, password, description) values(N'"+ request.getParameter("uname") + "',N'"+ request.getParameter("pword") +"',N'" + request.getParameter("oname") + "')";
 con.createStatement().execute(the__query);  
 rs=null;
 rs = con.createStatement().executeQuery("select max(userid) from fitservice.bayt_pgm_Users;");
 int theID = 0;  
 while(rs.next()){ theID = rs.getInt(1);}rs.close();rs = null;
 
// out.println(theID);
 
 if(theID != 0)
 {
  con.createStatement().execute("insert into  fitservice.bayt_pgm_UsersAuthorities(userid, page, allowed) values("+ theID  + ",'filteration.jsp',0)");

  con.createStatement().execute("insert into  fitservice.bayt_pgm_UsersAuthorities(userid, page, allowed) values("+ theID  + ",'search.jsp',0)"); 
    
  con.createStatement().execute("insert into  fitservice.bayt_pgm_UsersAuthorities(userid, page, allowed) values("+ theID  + ",'autorities.jsp',0)"); 

 
 }
} 
 


}



///user pressed delete
if( request.getParameter("subDelete")!=null) 
{
//oname
//uname
//pword

String curr_uid="0";
String curr_uname= request.getParameter("uname");
curr_uid = getuid(curr_uname,con);


con.createStatement().execute("delete from fitservice.bayt_pgm_Users where username =N'"+ request.getParameter("uname") + "'"); 
con.createStatement().execute("delete from fitservice.bayt_pgm_UsersAuthorities where userid='" + curr_uid + "'"); 

}






///user pressed update password
if( request.getParameter("subpasswordupdate")!=null) 
{
//oname
//uname
//pword
con.createStatement().execute("update fitservice.bayt_pgm_Users set password=N'" + request.getParameter("pword") + "' where username =N'"+ request.getParameter("uname") + "'"); 

}






///////////////THE fitservice.bayt_pgm_Users

/// -------------------
int the_pgm_Userscount = 0;
String[] theuserid = null;
String[] theusername = null;
String[] thepassword = null;
String[] thedescrption = null;
String[] phoneallowed = null;

rs = con.createStatement().executeQuery("SELECT count(*) from fitservice.bayt_pgm_Users");            
if(rs.next()){the_pgm_Userscount = rs.getInt(1);}rs.close(); rs = null;
rs = con.createStatement().executeQuery("SELECT     userID, username, password, description,phone FROM         fitservice.bayt_pgm_Users ORDER BY userID");

theuserid = new String[the_pgm_Userscount];
theusername = new String[the_pgm_Userscount];
thepassword = new String[the_pgm_Userscount];
thedescrption = new String[the_pgm_Userscount];
phoneallowed = new String[the_pgm_Userscount];
   
int theCounterrr1 = 0;
   while(rs.next())
    {
         theuserid[theCounterrr1] = rs.getString(1);
         theusername[theCounterrr1] = rs.getString(2);
         thepassword[theCounterrr1] = rs.getString(3);
         thedescrption[theCounterrr1] = rs.getString(4);
         phoneallowed[theCounterrr1] = rs.getString(5);         
         
        theCounterrr1 = theCounterrr1 + 1 ;
   }
   rs.close(); 
   rs = null;
/// ------------------




String filteusername = "";
if( request.getParameter("filteusername")!=null) 
{
  filteusername = request.getParameter("filteusername");
}
///-----------------------------------


             



















%>







<html dir='rtl'>

<head>
<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt arial, geneva, lucida, "lucida grande", arial, helvetica, sans-serif; COLOR: #000000 }</style>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<title>«·’·«ÕÌ«  ... Hawa AlSudan</title>
</head>

<body>

 

 

<form action='MainPage.jsp' method='post'>
<input type='hidden' name='uid' value='41'>
<input type='hidden' name='cur_page' value=''>
<table border='1' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%' height='80'>
  <tr>
    <td width='21%' align='center'><b><i><font color='#A36103' size='6'>«·’·«ÕÌ« </font></i></b></td>
    <td width='35%' align='center'>
    <table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%'>
      <tr><td width='100%' align='center'><font color='#000000' face='Arial' size='4'><b> Êﬁ‹‹  «·œŒÊ·  <%= intime %> </b></font></td></tr>
      <tr><td width='100%' align='center'><font color='#000000' face='Arial' size='4'><b> &nbsp;</b></font></td></tr>
      <tr><td width='100%' align='center'><font color='#000000' face='Arial' size='4'><b>  «—Ì‹‹Œ «·œŒÊ·  <%= indate %> </b></font></td></tr>
    </table>
    </td>
    <td width='19%' align='center'>
    	<table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%'>
    		<tr><td align='center'><input type='submit' name='subMain' value='«·ﬁ«∆„… «·—∆Ì”Ì…' STYLE='font-weight:bold;font-family:arial;font-size:18;color:#00f;width:12em;height:2.5em'></td></tr>

    		</form>
			<form action='autorities.jsp' method='post'>
			<input type='hidden' name='uid' value='41'>
    		<tr><td align='center'><input type='submit' name='subRefresh' value='«⁄«œ…  Õ„Ì·' STYLE='font-weight:bold;font-family:arial;font-size:18;color:#00f;width:12em;height:2.5em'></td></tr>
    	</table>
    </td>
<td bgcolor='#ffffff' width='15%' align='center'><IMG src='logo.png'></td>
  </tr>
</table><br>
		<table border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='60%'>
		  <tr>
		    <td width='30%' height='170' align='center' valign='top'>


<select name='filteusername' size='8' style='font-family:arial black; font-style:bold; font-size:16; color:#000 ;background:#DCDCDC;width:12em' onChange='javascript:this.form.submit();'>


<% 
for (int l =0  ; l < theuserid.length ; l ++)
{
  if (theusername[l].equalsIgnoreCase(filteusername)) 
  {
  
%>
    	        <option selected><%= (new String(theusername[l].getBytes("Cp1252"),"Cp1256")) %></option>       	        
<%
  }
  else
  {
%>       	        
    	        <option ><%= (new String(theusername[l].getBytes("Cp1252"),"Cp1256")) %></option>
<%
  }    	        
}
%> 


</select>








		    </td>
		    <td width='55%' height='200' rowspan='2'>
		    <table border='1' bgcolor=#DCDCDC align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='90%'>

<%

   String accountowner="";
   String accusername="";
   String accpassword="";
   String accphone="";   
   

   rs = null;
   rs = con.createStatement().executeQuery("SELECT    username, password, description,phone  FROM fitservice.bayt_pgm_Users  where username=N'"+filteusername+"' order by userID limit 1");  
   while(rs.next()){accusername=rs.getString(1);accpassword=rs.getString(2);accountowner=rs.getString(3);accphone=rs.getString(4);}rs.close();rs=null;
%>

		      <tr>
		        <td width='50%' align='center' height='30'><b>«”„ ’«Õ» «·Õ”«»</b></td>
<td width='50%' align='center' height='30'><input type='text' name='oname' value='<%=(new String(accountowner.getBytes("Cp1252"),"Cp1256"))%>' style='width:14em' size='20'></td>
		      </tr>
		      <tr>
		        <td width='50%' align='center' height='30'><b>«”„ «·„” Œœ„</b></td>
<td width='50%' align='center' height='30'><input type='text' name='uname' value='<%=(new String(accusername.getBytes("Cp1252"),"Cp1256"))%>' style='width:14em' size='20'></td>
		      </tr>
		      <tr>
		        <td width='50%' align='center' height='30'><b>ﬂ·„… «·„—Ê—</b></td>
<td width='50%' align='center' height='30'><input type='password' name='pword' value='<%=(new String(accpassword.getBytes("Cp1252"),"Cp1256"))%>' style='width:14em' size='20'></td>
		      </tr>

		      <tr>
		        <td width='50%' align='center' height='30'><b>«—ﬁ«„ «·ÂÊ« ›</b></td>
		        



<% 
if(accphone.equalsIgnoreCase("1"))
{
%>
             <td width='50%' align='center' height='30'>
             <input type='checkbox' name='phone' value='1' CHECKED>
             </td>
<%
}
else
{
%>
             <td width='50%' align='center' height='30'>
             <input type='checkbox' name='phone' value='0'>
             </td>
<%
}
%>




		      </tr>


		    </table>
		    <br>
		    <table border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='60%' height='17'>
		      <tr>
		        <td width='33%' height='30'><input type='submit' name='subAdd' value='«÷«›… „” Œœ„' style='font-weight:bold ; width:8em ; height:3em'></td>


<%
if(accusername.equalsIgnoreCase("admin") )
{
%>		        
		        <td width='33%' height='30'><input disabled type='submit' name='subUpdate' value=' ⁄œÌ· ’·«ÕÌ«  „” Œœ„' style='font-weight:bold ; width:12em ; height:3em'></td>
		        <td width='34%' height='30'><input disabled type='submit' name='subDelete' value='Õ–› „” Œœ„' style='font-weight:bold ; width:8em ; height:3em'></td>
<%
}
else
{
%>
		        <td width='33%' height='30'><input type='submit' name='subUpdate' value=' ⁄œÌ· ’·«ÕÌ«  „” Œœ„' style='font-weight:bold ; width:12em ; height:3em'></td>
		        <td width='34%' height='30'><input type='submit' name='subDelete' value='Õ–› „” Œœ„' style='font-weight:bold ; width:8em ; height:3em'></td>
		        
<%
}
%>		        

		        <td width='34%' height='30'><input type='submit' name='subpasswordupdate' value=' ⁄œÌ· ﬂ·„… «·„—Ê—' style='font-weight:bold ; width:10em ; height:3em'></td>		        		        		        
		        		        
		      </tr>
		    </table>
		    <br>
		    </td>
		  </tr>
		</table>

<br>














<%
   int autoritiescount = 0;
   rs = con.createStatement().executeQuery("select count(*) from fitservice.bayt_pgm_UsersAuthorities where userid=(select userid from fitservice.bayt_pgm_Users where username=N'"+filteusername+"')");  
   while(rs.next()){autoritiescount = rs.getInt(1);}rs.close();rs=null;
   
   String[] thepages = new String[autoritiescount];
   String[] isallowed = new String[autoritiescount];
   
   int ttt =0;
   rs = con.createStatement().executeQuery("select page, allowed from fitservice.bayt_pgm_UsersAuthorities where userid=(select userid from fitservice.bayt_pgm_Users where username=N'"+filteusername+"')");  
   while(rs.next()){thepages[ttt]=rs.getString(1);isallowed[ttt]=rs.getString(2);ttt=ttt+1;}rs.close();rs=null;
%>



		<table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
			<tr>
				<td width='3%'>&nbsp;</td>
				<td width='22%' valign='top'>
				    <!-- ........................ SMS Table .................... -->
				    <table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
				      <tr bgcolor=#646464><td width='100%' colspan='2' align='center' height='30'><b><font size='5' color=white>«·—”«∆· «·ﬁ’Ì—Â</font></b></td></tr>
















<% 
if(ispageallowed(thepages,isallowed,"filteration.jsp") )
{
%>
<tr><td width='25%' height='30' bgcolor=#DCDCDC>&nbsp;<input type='checkbox' name='filteration' value='1' CHECKED>&nbsp;<b><font size='3'>„—«ﬁ»Â</font></b></td></tr>
<%
}
else
{
%>
<tr><td width='25%' height='30' bgcolor=#DCDCDC>&nbsp;<input type='checkbox' name='filteration' value='0' >&nbsp;<b><font size='3'>„—«ﬁ»Â</font></b></td></tr>
<%
}
%>





















































<% 
if(ispageallowed(thepages,isallowed,"search.jsp") )
{
%>
                      <tr><td width='25%' height='30' bgcolor=#DCDCDC>&nbsp;<input type='checkbox' name='search' value='1' CHECKED>&nbsp;<b><font size='3'>&nbsp;«—‘Ì›</font></b></td></tr>
<%
}
else
{
%>
                      <tr><td width='25%' height='30' bgcolor=#DCDCDC>&nbsp;<input type='checkbox' name='search' value='0' >&nbsp;<b><font size='3'>&nbsp;«—‘Ì›</font></b></td></tr>
<%
}
%>











                    </table>
				    <!-- ........................ End SMS Table .................... -->
				</td>
				<td width='2%'>&nbsp;</td>
				<td width='22%' valign='top'>
				    <!-- ........................ Entry Table .................... -->

				    <!-- ........................ End Programs Table .................... -->
				</td>

				</td>
				<td width='2%'>&nbsp;</td>
				<td width='22%' valign='top'>

				<td width='2%'>&nbsp;</td>
				<td width='22%' valign='top'>
				    <!-- ........................ Admin Table .................... -->
				    <table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
				      <tr bgcolor=#646464><td width='100%' colspan='2' align='center' height='30'><b><font size='5' color=white>«·«œ«—Â</font></b></td></tr>





<% 
if(ispageallowed(thepages,isallowed,"autorities.jsp") )
{
%>
                              <tr><td width='25%' height='30' bgcolor=#DCDCDC>&nbsp;<input type='checkbox' name='autorities' value='1' CHECKED>&nbsp;<b><font size='3'>&nbsp;«·’·«ÕÌ« </font></b></td></tr>
<%
}
else
{
%>
                              <tr><td width='25%' height='30' bgcolor=#DCDCDC>&nbsp;<input type='checkbox' name='autorities' value='0' >&nbsp;<b><font size='3'>&nbsp;«·’·«ÕÌ« </font></b></td></tr>
<%
}
%>









				    </table>
				    <!-- ........................ End Admin Table .................... -->
				</td>
				<td width='3%'>&nbsp;</td>
			</tr>
		</table>
		</form>
		
</body>

</html>























<%
}
con.close();
}
%>




