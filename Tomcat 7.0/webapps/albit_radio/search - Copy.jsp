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
%>



<%

 

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
%>



<html dir=rtl>

<head>
<link rel="stylesheet" type="text/css" href="datepicker.css"/>
<script type="text/javascript" src="datepicker.js"></script>
<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt arial, geneva, lucida, "lucida grande", arial, helvetica, sans-serif; COLOR: #000000 } Table {font:12pt } </style>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<title>«·»ÕÀ ... National Radio</title>
</head>

<body>

 

 

            <form action='MainPage.jsp' method='post'>
            <input type='hidden' name='uid' value='41'>
            
            <table border='1' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%' height='80'>
              <tr>
                <td width='21%' align='center'><b><i><font color='#A36103' size='6'> «·«—‘Ì›</font></i></b></td>
                <td width='10%' height='100' align='center'>
                  <table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%' height='100%'>
            	<tr bgcolor=#CCFFC8><td align='center' width='100%'><font size='4'>„ﬁ—ƒÂ</font></td></tr>
            	<tr bgcolor=#FFC8C8><td align='center' width='100%'><font size='4'>€Ì— „ﬁ—ƒÂ</font></td></tr>
     
                  </table>
                </td>
                <td width='30%' align='center'>
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
            		<form action='search.jsp' method='post'>
            		<input type='hidden' name='uid' value='41'>
              		<tr><td align='center'><input type='submit' name='subRefresh' value='«⁄«œ…  Õ„Ì·' STYLE='font-weight:bold;font-family:arial;font-size:18;color:#00f;width:12em;height:2.5em'></td></tr>
                        </form> 
                	</table>
                </td>
<td bgcolor='#ffffff' width='15%' align='center'><IMG src='logo.png'></td>
              </tr>
            </table>

<br>
			<br>
			<table border='1' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#DCDCDC' width='80%'>
			  <tr height='30'>








<form method="post">












			    
			    
			    
			  </tr>
			</table>
			<table border='1' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#DCDCDC' width='50%'>
			 <tr>
			 <td>
			 <table border='1' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#DCDCDC' width='100%'>
			  <tr height=30>
			  








			    <td width='14%' align='center'>
<input type=button value=" «—ÌŒ „‰" onclick="displayDatePicker('fdate', this);">

<input  type="text" readonly name="fdate" id="idate" value='<%=fdate%>' >
                            </td>

			    <td width='2%' align='center'>&nbsp;</td>

<td width='14%' align='center'>
<input type=button value=" «—ÌŒ ≈·Ì" onclick="displayDatePicker('tdate', this);">
<input  type="text"  readonly name="tdate" id="idate" value='<%=tdate%>'>
</td>











<td width='25%' align='center'>
<select name='messagetatus' style='font-weight:bold ; color:#909090'>

<option value=''>ﬂ· «·—”«∆·</option>


<%
if(messagetatus.equalsIgnoreCase("1"))
{
%>
<option selected value='1'>—”«∆· „ﬁ—Ê¡Â</option>
<%
}
else
{
%>
<option value='1'>—”«∆· „ﬁ—Ê¡Â</option>
<%
}
%>



<%
if(messagetatus.equalsIgnoreCase("-1"))
{
%>
<option selected value='-1'>—”«∆· €Ì— „ﬁ—Ê¡Â</option>
<%
}
else
{
%>
<option value='-1'>—”«∆· €Ì— „ﬁ—Ê¡Â</option>
<%
}
%>


</select>
</td>



			    <td width='15%' align='center'><input type='submit' name='Searchbutton' value='»ÕÀ' style='font-weight:bold;width:8em;height:3em'></td>


			  </tr>
			 </table>
			 </td>
			 </tr>
			</table>
			<br>	

			 <br>	
			 
			 <table border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#cccccc' width='98%'>
                  <tr height=30 bgcolor=#DCDCDC>
                    <td align='center'><b>«·⁄œœ</b>&nbsp;&nbsp;&nbsp;<font color=#000099><b><%= THECOUNT %></b></font></td>
 			        <td width='75%' align='center'><b>&nbsp;</b></td>                    
                  </tr>
             </table>
			 
			 
			 
      					<table border='1' align='center' cellpadding='0' cellspacing='1' style='border-collapse: collapse' bordercolor='#cccccc' width='98%'>
      					  <tr bgcolor=#DCDCDC>
      					    <td width='30%' rowspan=2 align='center'><b>‰’ «·—”«·Â</b></td>
      					    <td width='10%' rowspan=2 align='center'><b>—ﬁ„  ·Ì›Ê‰</b></td>
      					    <td width='10%' rowspan=2 align='center'><b>«·„’œ—</b></td>
      					    <td width='10%' rowspan=2 align='center'><b>Êﬁ  «·œŒÊ·</b></td>
      					    <td width='10%' rowspan=2 align='center'><b>Êﬁ  «·ﬁ—«¡Â</b></td>      					    
  					    
      					  </tr>

      					  <tr bgcolor=#DCDCDC>
   					          					          					          					    
      					  </tr>






<%

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

if(txt.contains(progid)){            
 
if(the_msg_readtime != null)
{
%>
<tr height=25 bgcolor=#CCFFC8>
<%
}
else
{
%>
<tr height=25 bgcolor=#FFC8C8>
<%
 }

%>

  <td width='30%' align='center'><b><%=txt   %></b></td>
      					    
      					   
      					    
      					    
<%    	    
if(phoneallowed == 1)
{
%>
    	    <td align='center'><b><font color=#000000 size=4 dir='ltr'><%= the_msg_msisdn %></font></b></td>
<%
}
else
{
%>
    	    <td align='center'><b><font color=#000000 size=4 dir='ltr'> ·«  ÊÃœ ’·«ÕÌÂ</font></b></td>
<%
}
%>     	    
       

      					    
      				
      					    
      					    
      					    
      					    <td width='10%' align='center'><b><font color=#000000 size=3 dir='ltr' dir='ltr'><%= the_msg_Recipient %></font></b></td>
      					    <td width='10%' align='center'><b><font color=#000000 size=3 dir='ltr' dir='ltr'><%= the_msg_intime %></font></b></td>
      					    <td width='10%' align='center'><b><font color=#000000 size=3 dir='ltr' dir='ltr'><%= the_msg_readtime %></font></b></td>      					    

      					    









      					    

</tr>
<%
}
%>
<%
}
rs.close();rs=null;
%>





















</table>








</form>



<br>





</html>





<%
con.close();
%>


<%
}
}
%>
