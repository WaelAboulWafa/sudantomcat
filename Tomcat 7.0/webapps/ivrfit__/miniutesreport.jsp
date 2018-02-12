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


////////////// Session Attributes //////////////////


/////////////////////////// Dates //////////////////////////////////


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

////////////////////////// End Of Dates ///////////////////////////

String query1 = "";
query1 = query1 + " SELECT app_name,dst,count(*) as thecnt , " ;
query1 = query1 + " sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as Minutes FROM ucp_user.cdr  ";
query1 = query1 + " where DATE_FORMAT(call_start_date,'%Y-%m-%d') between '"+sdate_formated+"' and '"+edate_formated+"' and operator in ('SudaTel' , 'MTN' , 'Zain') ";
//query1 = query1 + " and not  (dst in ('87015104','87015024','87015023','87015022','87015021','87015020' ,'87015005','87015002'))";
 
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







 //--  <td width='10%' align='right'><a href="/smsfitsudan/smsreport.jsp" class="btn btn-info btn-md " role="button">SMS Report</a></td>













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
      rs = con.createStatement().executeQuery("SELECT shortcode,count(*) as thecnt FROM router where log =1  group by shortcode asc");            
      while(rs.next())
      {
     	 theshortcodescount = theshortcodescount + 1;
      }
       rs.close(); rs = null;

   rs = null;
   rs = con.createStatement().executeQuery("SELECT shortcode,count(*) as thecnt FROM router where log =1  group by shortcode asc");

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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>IVR Reports</title>
<link rel="shortcut icon" href="images/ico/favicon.ico">

<link rel="stylesheet" hrebayt="css/reset.css">
<link rel="stylesheet" hrebayt="css/mycss.css" media="screen" type="text/css" />
<link rel="stylesheet" type="text/css" href="datepicker.css"/>
<script type="text/javascript" src="datepicker.js"></script>



  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>


<script>
function getcdr(day,shortcode)
{
//alert(day + ' ' + shortcode);
var myWindow = window.open("getcdr.jsp?theday=" + day + "&theoperator=" + shortcode , 'null' , "MsgWindow,toolbar=no,scrollbars=yes,location=no,resizable=yes", "width=200, height=100");
}
</script>


<STYLE type=text/css>
	BODY {MARGIN: 0px; FONT: 14pt arial, geneva, lucida, "lucida grande", arial, helvetica, sans-serif; COLOR: #000000;background-color: #FFFFFF; }

		.clickable:hover
		{
		    background:#ffa;
		    cursor: hand;
		}
	
</style>



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
                              <table border='0' align='center' bgcolor=#f4f4f4 cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
                                          <td width='5%' align='center'><b><input type=button value="From" onclick="displayDatePicker('fdate', this);"></td>
                                          <td width='20%' align='center'><input  style='font-size:10pt;color:#000000;font-weight:bold;width:8em;height:1.7em' type="text" readonly name="fdate" id="idate" value='<%=fdate%>' ></td>
                                          <td width='10%' align='center'>&nbsp;</td>
                                          <td width='5%' align='center'><b><input type=button value="To" onclick="displayDatePicker('tdate', this);"></b></td>
                                          <td width='20%' align='center'><input style='font-size:10pt;color:#000000;font-weight:bold;width:8em;height:1.7em' type="text"  readonly name="tdate" id="idate" value='<%=tdate%>'></td>
                                          <td width='10%' align='center'>&nbsp;</td>
                                          
                                          
                                          <td width='5%' align='center'>Service</td>
                                          
                                          
                                          <td width='20%' align='center'>
                                          
											<select name='filterservice' style='font-size:10pt;color:#000099;font-weight:bold;width:10em;height:1.7em' >
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
                                          
										
											<select name='filtershortcode' style='font-size:10pt;color:#000099;font-weight:bold;width:10em;height:1.7em' >
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
                                     
                                         <td width='10%' align='right'><a href="login.jsp" class="btn btn-danger" role="button">Sign Out</a></td>
                        </td>
                  </tr>
                </form>
            </table>



 
                              
 


<br>



















<table width='90%' align='center'>
	
	<tr >





	
	
	
	
<td width=58% valign=top>
	
	

 <table border='1' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
	
                  <tr height=20 bgcolor=#f4f4f4>
                        <td colspan=9 align='center'><font size='2'><b>Per Day/Operator</b></font></td>
                  </tr>

	
                  <tr height=20 bgcolor=#f4f4f4>
                        <td  align='center'><font size='2'><b>&nbsp;</b></font></td>
                        <td  colspan=4 align='center'><font size='2'><b>Calls</b></font></td>
                        <td  colspan=4 align='center'><font size='2'><b>Minutes</b></font></td>
                  </tr>
                  	
                  <tr height=20 bgcolor=#f4f4f4>
                        <td  align='center'><font size='2'><b>The Day</b></font></td>
                        <td  align='center'><font size='2'><b>Total</b></font></td>
                        <td  align='center'><font size='2'><b>SudaTel</b></font></td>
                        <td  align='center'><font size='2'><b>MTN</b></font></td>
                        <td  align='center'><font size='2'><b>Zain</b></font></td>
                        <td  align='center'><font size='2'><b>Total</b></font></td>
                        <td  align='center'><font size='2'><b>SudaTel</b></font></td>
                        <td  align='center'><font size='2'><b>MTN</b></font></td>
                        <td  align='center'><font size='2'><b>Zain</b></font></td>

                  </tr>
                  


                                    
                  	
	
		<%
	
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
				
	
			%>
						  <tr height=20 bgcolor=#ffffff>
							<td  align='center'><font size='2'><%=theday%></font></td>
							<td  class="clickable" title="click to get CDRs of day :<%=theday%>" align='center' onclick="getcdr('<%=theday%>','ALL');" ><font size='2'  color='000099' ><b><%=Total_Calls%></b></font></td>
							<td  class="clickable" title="click to get CDRs of day :<%=theday%> , operator: SudaTel" align='center' onclick="getcdr('<%=theday%>','SudaTel');" ><font size='2'><%=SudaTel_Calls%></font></td>
							<td  class="clickable" title="click to get CDRs of day :<%=theday%> , operator: MTN" align='center' onclick="getcdr('<%=theday%>','MTN'>');" ><font size='2'><%=MTN_Calls%></font></td>
							<td  class="clickable" title="click to get CDRs of day :<%=theday%> , operator: Zain" align='center' onclick="getcdr('<%=theday%>','Zain');" ><font size='2'><%=Zain_Calls%></font></td>
							<td  class="clickable" title="click to get CDRs of day :<%=theday%>" align='center' onclick="getcdr('<%=theday%>','ALL');" ><font size='2'  color='000099' ><b><%=Total_Minutes%></b></font></td>
							<td  class="clickable" title="click to get CDRs of day :<%=theday%> , operator: SudaTel" align='center' onclick="getcdr('<%=theday%>','SudaTel');" ><font size='2'><%=SudaTel_Minutes%></font></td>
							<td  class="clickable" title="click to get CDRs of day :<%=theday%> , operator: MTN" align='center' onclick="getcdr('<%=theday%>','MTN');" ><font size='2'><%=MTN_Minutes%></font></td>
							<td  class="clickable" title="click to get CDRs of day :<%=theday%> , operator: Zain" align='center' onclick="getcdr('<%=theday%>','Zain');" ><font size='2'><%=Zain_Minutes%></font></td>

						  </tr>
			<%
			}
			rs.close();rs = null;
			
			%>






			<%
	
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
				
	
			%>
						  <tr height=20 bgcolor=#f4f4f4>
							<td align='center'><font size='2'><b>Total</b></font></td>
							<td  align='center'><font size='2'><b><%=Total_Calls%></b></font></td>
							<td  align='center'><font size='2'><b><%=SudaTel_Calls%></b></font></td>
							<td align='center'><font size='2'><b><%=MTN_Calls%></font></b></td>
							<td  align='center'><font size='2'><b><%=Zain_Calls%></font></b></td>
							<td  align='center'><font size='2'><b><%=Total_Minutes%></b></font></td>
							<td align='center'><font size='2'><b><%=SudaTel_Minutes%></b></font></td>
							<td  align='center'><font size='2'><b><%=MTN_Minutes%></b></font></td>
							<td  align='center'><font size='2'><b><%=Zain_Minutes%></b></font></td>

						  </tr>
			<%
			}
			rs.close();rs = null;
			
			%>







	  </table>
	
	
	
		
	</td>	
	


	
<td width=2% valign=top>&nbsp;</td>	
	











	
	<td width=40% valign=top>



 
            <table border='1' align='center' bgcolor=#f4f4f4 cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>


                  <tr height=20 bgcolor=#f4f4f4>
                        <td colspan=4 align='center'><font size='2'><b>Per Shortcode/Service</b></font></td>
                  </tr>
                              
                  <tr height=20 bgcolor=#f4f4f4>
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
						  <tr height=20 bgcolor=#f4f4f4>
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


	
	
	</tr>
   
</table>   
	
	
	
	
	
</body>

</html>



















<%


con.close();

%>