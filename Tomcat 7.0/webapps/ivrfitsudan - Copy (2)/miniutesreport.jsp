<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*" %>




<%


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
query1 = query1 + " where call_start_date between '"+sdate_formated+"' and '"+edate_formated+"' ";

 
String query2 = "";
query2 = query2 + " SELECT count(*) as thecnt , " ;
query2 = query2 + " sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as Minutes FROM ucp_user.cdr  " ;
query2 = query2 + " where call_start_date between '"+sdate_formated+"' and '"+edate_formated+"' ";


String query3 = "";
query3 = query3 + " SELECT DATE_FORMAT(call_start_date,'%Y-%m-%d') as theday , count(*) as thecnt , ";
query3 = query3 + " sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as Minutes FROM ucp_user.cdr ";
query3 = query3 + " where call_start_date between '"+sdate_formated+"' and '"+edate_formated+"' ";






String filterservice = "ALL";
if( request.getParameter("filterservice")!=null) 
{
 if( !(request.getParameter("filterservice").trim().equalsIgnoreCase("ALL")) ) 
 { 
  filterservice= request.getParameter("filterservice");
  query1 = query1 + " and app_name='" + filterservice + "' ";
  query2 = query2 + " and app_name='" + filterservice + "' ";
  
  query3 = query3 + " and app_name='" + filterservice + "' ";
   
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












             
%>

























































<html dir=ltr>

<head>
<link rel="stylesheet" type="text/css" href="datepicker.css"/>
<script type="text/javascript" src="datepicker.js"></script>
<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt arial, geneva, lucida, "lucida grande", arial, helvetica, sans-serif; COLOR: #000000;background-color: #FFFFFF; }</style>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<title>Minutes Report</title>
</head>

<body>

 

 

<form action='miniutesreport.jsp' method='post'>
<input type='hidden' name='uid' value='41'>
<table border='0' bgcolor=#FFFFFF cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%' height='80'>
  <tr>
    <td width='21%' align='center'></td>
    <td width='35%' align='center'>

    </td>
    <td width='19%' align='center'>

    </td>
    <td bgcolor='#FFFFFF' width='15%' align='center'><IMG src='logo.png'></td>
  </tr>
</table>

<br>


<table border='0' align='center' bgcolor=#FFFFFF cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='90%' height='40' >
  <tr>
   <td align='center'><font color=#000000 size='4'>General IVR Minutes Report for Sudan</td>
  </tr>
 </table>



            <table border='1' align='center' bgcolor=#F9DEA9 cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='80%'>
                 <form action='smscount.jsp' method='post'>
                  <tr>
                        <td>
                              <table border='0' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
                                          <td width='5%' align='center'><b><input type=button value="From" onclick="displayDatePicker('fdate', this);"></td>
                                          <td width='20%' align='center'><input  style='font-size:12pt;color:#000000;font-weight:bold;width:8em;height:1.7em' type="text" readonly name="fdate" id="idate" value='<%=fdate%>' ></td>
                                          <td width='10%' align='center'>&nbsp;</td>
                                          <td width='5%' align='center'><b><input type=button value="To" onclick="displayDatePicker('tdate', this);"></b></td>
                                          <td width='20%' align='center'><input style='font-size:12pt;color:#000000;font-weight:bold;width:8em;height:1.7em' type="text"  readonly name="tdate" id="idate" value='<%=tdate%>'></td>
                                          <td width='10%' align='center'>&nbsp;</td>
                                          
                                          
                                          <td width='5%' align='center'>Service</td>
                                          
                                          
                                          <td width='20%' align='center'>
                                          
											<select name='filterservice' style='font-size:12pt;color:#000099;font-weight:bold;width:8em;height:1.7em' >
											 <option>ALL</option>
											<% 
											for (int l =0  ; l < theservices.length ; l ++)
											{
											  if (theservices[l].equalsIgnoreCase(filterservice)) 
											  {
											  
											%>       	        
											    	        <option selected><%= theservices[l] %></option>
											<%
											  }
											  else
											  {
											%>       	        
											    	        <option><%= theservices[l] %></option>
											<%
											  }    	        
											}
											%> 
											</select>                                          	
                                          	
                                          	
                                          	</td>
                                          




                                          <td width='10%' align='center'>&nbsp;</td>
                                          
                                          
                                          <td width='5%' align='center'>ShortCode</td>
                                          
                                          
                                          <td width='20%' align='center'>
                                          
											<select name='filtershortcode' style='font-size:12pt;color:#000099;font-weight:bold;width:8em;height:1.7em' >
											 <option>ALL</option>
											<% 
											for (int l =0  ; l < theshortcodes.length ; l ++)
											{
											  if (theshortcodes[l].equalsIgnoreCase(filtershortcode)) 
											  {
											  
											%>       	        
											    	        <option selected><%= theshortcodes[l] %></option>
											<%
											  }
											  else
											  {
											%>       	        
											    	        <option><%= theshortcodes[l] %></option>
											<%
											  }    	        
											}
											%> 
											</select>                                          	
                                          	
                                          	
                                          	</td>

                                          
                                          
                                          <td width='20%' align='center'>&nbsp;</td>
                                          
                                          
                                          <td width='10%' align='right'><input type='submit' name='subReport' value='Get Report' STYLE='font-weight:bold ; color:#000000; width:8em; height:2.2em'></td>
                              </table>
                        </td>
                  </tr>
                </form>
            </table>




 


<br>



















<table width='80%' align='center'>
	
	<tr >
	
	<td width=45% valign=top>



 
            <table border='1' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>


                  <tr height=20>
                        <td colspan=4 align='center'><font size='2'><b>Per Shortcode/Service</b></font></td>
                  </tr>
                              
                  <tr height=20>
                        <td  align='center'><font size='2'><b>Service</b></font></td>
                        <td  align='center'><font size='2'><b>ShortCode</b></font></td>
                        <td  align='center'><font size='2'><b>Calls Count</b></font></td>
                        <td  align='center'><font size='2'><b>Minutes Count</b></font></td>

                  </tr>
                  
                  

<%

   rs = null;
   rs = con.createStatement().executeQuery(query1);  
while(rs.next())
{
String service =rs.getString(1);
String sc =rs.getString(2);
String callcount = rs.getString(3);
String minutescount =rs.getString(4);

%>
			  <tr height=20 bgcolor=#ffffff>
				<td  align='center'><font size='2'><%=service%></font></td>
				<td  align='center'><font size='2'><%=sc%></font></td>
				<td  align='center'><font size='2'><%=callcount%></font></td>
				<td  align='center'><font size='2'><%=minutescount%></font></td>
			  </tr>
<%
}
rs.close();rs = null;

%>





			<%
	
			   rs = null;
			   rs = con.createStatement().executeQuery(query2);  
			while(rs.next())
			{
				String thecallstotal =rs.getString(1);
				String theminutestotal =rs.getString(2);
	
			%>
						  <tr height=20 bgcolor=#DCDCDC>
							<td colspan=2 align='center'><font size='2'><b>Total</b></font></td>
							<td  align='center'><font size='2'><b><%=thecallstotal%></b></font></td>
							<td  align='center'><font size='2'><b><%=theminutestotal%></b></font></td>

						  </tr>
			<%
			}
			rs.close();rs = null;
			
			%>








	</table>






</td>


	<td width=10% valign=top>&nbsp;</td>
	
	
	
<td width=45% valign=top>
	
	

 <table border='1' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
	
                  <tr height=20>
                        <td colspan=4 align='center'><font size='2'><b>Per Day</b></font></td>
                  </tr>

	
                  <tr height=20 bgcolor=#DCDCDC>
                        <td  align='center'><font size='2'><b>The Day</b></font></td>
                        <td  align='center'><font size='2'><b>Calls Count</b></font></td>
                        <td  align='center'><font size='2'><b>Minutes Count</b></font></td>

                  </tr>
                  	
	
		<%
	
			   rs = null;
			   rs = con.createStatement().executeQuery(query3);  
			while(rs.next())
			{
				String thed =rs.getString(1);
				String thec =rs.getString(2);
				String them =rs.getString(3);
	
			%>
						  <tr height=20 bgcolor=#ffffff>
							<td align='center'><font size='2'><%=thed%></font></td>
							<td  align='center'><font size='2'><%=thec%></font></td>
							<td  align='center'><font size='2'><%=them%></font></td>

						  </tr>
			<%
			}
			rs.close();rs = null;
			
			%>




			<%
	
			   rs = null;
			   rs = con.createStatement().executeQuery(query2);  
			while(rs.next())
			{
				String thecallstotal =rs.getString(1);
				String theminutestotal =rs.getString(2);
	
			%>
						  <tr height=20 bgcolor=#DCDCDC>
							<td  align='center'><font size='2'><b>Total</b></font></td>
							<td  align='center'><font size='2'><b><%=thecallstotal%></b></font></td>
							<td  align='center'><font size='2'><b><%=theminutestotal%></b></font></td>

						  </tr>
			<%
			}
			rs.close();rs = null;
			
			%>




	  </table>
	
	
	
		
	</td>	
	
	
   </tr>
   
</table>   
	
	
	
	
	
</body>

</html>



















<%


con.close();

%>