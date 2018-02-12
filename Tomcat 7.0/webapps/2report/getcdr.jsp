<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*" %>




<%


/////////////////////////// Dates //////////////////////////////////


String leday="" ;try{leday = request.getParameter("theday").trim();}catch(Exception e){leday="";}

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

String month_start = fdate.substring(0,4) + "-" + fdate.substring(4,6) + "-01";

////////////////////////// End Of Dates ///////////////////////////


  Connection con=null;
  InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();
  ResultSet rs = null;

////////////////////////////////IVR DATABASE CONNECTION//

Connection con1=null;
	InitialContext ic1 = new InitialContext();
	DataSource ds1 = (DataSource) ic1.lookup("java:comp/env/jdbc/TheDB2");
	con1  = ds1.getConnection();
	ResultSet rs1 = null;



String theService = "";
	String queryService = "";
	queryService = "SELECT service_name FROM reporting.rep_user WHERE username ='"+username+"' ";
	rs = con.createStatement().executeQuery(queryService);
	
	while(rs.next()){
		theService = rs.getString(1);
	}
	rs = null;
	int srvcount = 0;
	rs = con.createStatement().executeQuery("SELECT count(*) from reporting.rep_service where appname ='"+theService+"' ");
	while(rs.next()){
		srvcount = rs.getInt(1);
	}
	
	rs = null;

String query3 = "";
query3 = query3 + " SELECT ID, DATE_FORMAT(call_start_date,' %l:%i:%S') as callstart, DATE_FORMAT(call_end_date,' %l:%i:%S')  as callend, operator , dst ,src, TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) as Seconds , case 	when  ( TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) < 1 ) then 0 	else CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) end as BilledMinutes ";
query3 = query3 + " FROM cdr " ; 
query3 = query3 + " where DATE_FORMAT(call_start_date,'%Y-%m-%d') between '"+sdate_formated+"' and '"+sdate_formated+"'  ";

String query4 = "";
query4 = query4 + " SELECT distinct DATE_FORMAT(call_start_date,' %l') as callstart, DATE_FORMAT(call_end_date,' %l')  as callend, operator , dst ,src, TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) as Seconds , case 	when  ( TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) < 1 ) then 0 	else CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) end as BilledMinutes ";
query4 = query4 + " FROM cdr " ; 
query4 = query4 + " where DATE_FORMAT(call_start_date,'%Y-%m-%d') between '"+sdate_formated+"' and '"+sdate_formated+"' and operator in ('SudaTel' , 'MTN' , 'Zain') ";


String query5 = "";
query5 = query5 + "SELECT   ID ,DATE_FORMAT(call_start_date,' %r:%i:%S') as callstart ,  DATE_FORMAT(call_end_date,' %r:%i:%S')  as callend ";
query5 = query5 +", operator , dst ,src,";
query5 = query5 +"TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) as Seconds , ";
query5 = query5 +"case when  ( TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) < 1 ) then 0 	else CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) end as BilledMinutes ";
query5 = query5 +"FROM cdr  where DATE_FORMAT(call_start_date,'%Y-%m-%d')  ='"+sdate_formated+"' ";
query5 = query5 +"and operator in ('SudaTel' , 'MTN' , 'Zain') and app_name='"+theService+"'";
query5 = query5 +" group by app_name,dst, operator order by app_name" ;
	



//query5 = query5 + " where DATE_FORMAT(call_end_date,'%Y-%m-%d')  = '"+leday+"' ";

String theoperator = "ALL";

if( request.getParameter("theoperator")!=null) 
{
 if( !(request.getParameter("theoperator").trim().equalsIgnoreCase("all")) ) 
 { 
  theoperator= request.getParameter("theoperator");
  
query5 = query5 + " and operator='" + theoperator + "' ";
   
 }
} 

//---
String filtershortcode = "ALL";
if( request.getParameter("filtershortcode")!=null) 
{
 if( !(request.getParameter("filtershortcode").trim().equalsIgnoreCase("ALL")) ) 
 { 
  filtershortcode= request.getParameter("filtershortcode");
  
  query3 = query3 + " and dst='" + filtershortcode + "' ";
  
  query5 = query5 + " and dst='" + filtershortcode + "' ";  
  
    
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

 
//------
String callstart = "All";
if(request.getParameter("callstart")!=null)
{
if( !(request.getParameter("callstart").trim().equalsIgnoreCase("all")))
	{
	callstart = request.getParameter("callstart");
	query5 = query5 + "and cast((DATE_FORMAT(call_start_date,' %l:%i:%S')) as UNSIGNED) >='"+ callstart+"' "; 
	
	}
}

String callEnd = "All";
if(request.getParameter("callEnd")!=null)
{
if( !(request.getParameter("callEnd").trim().equalsIgnoreCase("all")))
	{
	callEnd = request.getParameter("callEnd");
	query5 = query5 + "and cast((DATE_FORMAT(call_start_date,' %l:%i:%S')) as UNSIGNED) <='"+ callEnd+"' "; 
if( !(request.getParameter("theoperator").trim().equalsIgnoreCase("all")) ) {
    query5 = query5 + "and operator in ('" + theoperator + "')";}
	}
}


%>







<html dir=ltr>

<head>
<link rel="stylesheet" type="text/css" href="datepicker.css"/>
<script type="text/javascript" src="datepicker.js">
</script>


<script>


function getcdr(day,shortcode)
{
alert(day + ' ' + shortcode);
var myWindow = window.open("http://www.yahoo.com", 'null' , "MsgWindow,toolbar=no,scrollbars=yes,location=no,resizable=yes", "width=200, height=100");
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
<title>CDRs Report</title>
</head>

<body>

 

 

<form action='getcdr.jsp' method='GET'>
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


 </table>



            <table border='1' align='center' bgcolor=#F9DEA9 cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='60%'>
                  <tr>
                        <td>
                              <table border='0' align='center' bgcolor=#f4f4f4 cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
                                          
                                          <td width='20%' align='center'><b>CDRs</b> </td>
                                          
                                          <td width='5%' align='center'><b><input type=button value="From" onclick="displayDatePicker('fdate', this);"></td>
                                          <td width='20%' align='center'><input  style='font-size:10pt;color:#000000;font-weight:bold;width:8em;height:1.7em' type="text" readonly name="fdate" id="idate" value='<%=fdate%>' ></td>
                                          <td width='10%' align='center'>&nbsp;</td>
                                          <td width='5%' align='center'><b><input type=button value="To" onclick="displayDatePicker('tdate', this);"></b></td>
                                          <td width='20%' align='center'><input style='font-size:10pt;color:#000000;font-weight:bold;width:8em;height:1.7em' type="text"  readonly name="tdate" id="idate" value='<%=tdate%>'></td>
                                          <td width='2%' align='center'>&nbsp;</td>
                                          
                                          <td width='20%' align='center'><b> Operator :</b></td>
                                          <td width='20%' align='center'>
                                           <select name= 'theoperator' style='font-size:10pt;color:#000099;font-weight:bold;width:10em;height:1.7em'  >
											<option  value ="all">ALL</option>
											<option value="mtn">MTN</option>
											<option value="zain">ZAIN</option>
											<option value="Sudatel">Sudatel</option>

											</select>                                          	
                                          	 </td>                                          
                                          
                                         
                              </table>
                              
                              
                              
                              
                              
              <table  border='0' align='center' bgcolor=#f4f4f4 cellpadding='1' cellspacing='1' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
                             	<tr>
                             		        <td width='20%' align='center'><b>From</b></td>
                                          
                                          
                                            <td width='20%' align='center'>
                                          
											<select name= 'callstart' style='font-size:10pt;color:#000099;font-weight:bold;width:10em;height:1.7em'  >
											<option>ALL</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
											<option value="9">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											</select>                                          	
                                          	
                                          	
                                          	</td>
                                          




                                          <td width='10%' align='center'>&nbsp;</td>
                                          
                                          
                                          <td width='5%' align='center'>To</td>
                                          
                                          
                                          <td width='20%' align='center'>
                                          
											<select name='callEnd' style='font-size:10pt;color:#000099;font-weight:bold;width:10em;height:1.7em'  >
											 <option>ALL</option>
											<option value="1">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
											<option value="9">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
											</select>                                          	
                                          	
                                          	
                                          	</td>

                                          
                                          
                                          <td width='20%' align='center'>&nbsp;</td>
                                          
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
                                          <td width='10%' align='right'><input type='submit' name='submit' value='Get Report' STYLE='font-weight:bold ; color:#000000; width:8em; height:2.2em' ></td>
                              
                             		
                             	
                             	</tr>
                             </table> 
                              
                              
                        </td>
                  </tr>

            </table>

 

</form>




<table width='55%' align='center'>
	
	<tr >
	
	
	<td width=100% valign=top>
	

 	<table border='1' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
	
  	
                  <tr height=20 bgcolor=#f4f4f4>
                  <td  align='center'><font size='2'><b>ID</b></font></td>
                        <td  align='center'><font size='2'><b>Call Start</b></font></td>
                        <td  align='center'><font size='2'><b>Call End</b></font></td>
                        <td  align='center'><font size='2'><b>Operator</b></font></td>
                        <td  align='center'><font size='2'><b>Shortcode</b></font></td>
                        <td  align='center'><font size='2'><b>Caller</b></font></td>
                        <td  align='center'><font size='2'><b>Seconds</b></font></td>
                        <td  align='center'><font size='2'><b>Minutes</b></font></td>                        
                  </tr>
                      	
	
		<%
	
			   rs = null;
			   rs = con.createStatement().executeQuery(query5);  
			while(rs.next())
			{
				String id =rs.getString(1);
				String start =rs.getString(2);
				String end =rs.getString(3);
				String operator= rs.getString(4);
				String shortcode =rs.getString(5);
				String caller =rs.getString(6);
				String seconds =rs.getString(7);
				String minutes =rs.getString(8);								
				
			
	
			%>
						  <tr height=20 bgcolor=#ffffff   >
							<td  align='center'  ><font size='2'><%=id%></font></td>
							<td  align='center'  ><font size='2'><%=start%></font></td>
							<td  align='center'  ><font size='2'><%=end%></font></td>
							<td  align='center'  ><font size='2'><%=operator%></font></td>
							<td  align='center'  ><font size='2'><%=shortcode%></font></td>
							<td  align='center'  ><font size='2'><%=caller%></font></td>
							<td  align='center'  ><font size='2'><%=seconds%></font></td>
							<td  align='center'  ><font size='2'><%=minutes%></font></td>														
							

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