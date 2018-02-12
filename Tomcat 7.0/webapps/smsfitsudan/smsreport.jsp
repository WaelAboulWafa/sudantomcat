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
   rs = con.createStatement().executeQuery("SELECT count(*) from mo_cdrs");             
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
query1 = query1 + " SELECT providers.name as operatorname, mo_cdrs.shortcode  , sum(mo_cdrs.length) as thecount  " ;
query1 = query1 + " FROM mo_cdrs,providers where mo_cdrs.Provider = providers.gateway   ";
query1 = query1 + " and  shortcode in ('1421','+2491421','+2491653','1653','+2495006') ";
query1 = query1 + " and datein between '"+sdate_formated+"' and '"+edate_formated+"' ";

 
String query2 = "";
query2 = query2 + " SELECT sum(mo_cdrs.length) as thecount  " ;
query2 = query2 + " FROM mo_cdrs,providers where mo_cdrs.Provider = providers.gateway  " ;
query2 = query2 + " and  shortcode in ('1421','+2491421','+2491653','1653','+2495006') ";
query2 = query2 + " and datein between '"+sdate_formated+"' and '"+edate_formated+"' ";






String filteroperator = "ALL";
if( request.getParameter("filteroperator")!=null) 
{
 if( !(request.getParameter("filteroperator").trim().equalsIgnoreCase("ALL")) ) 
 { 
  filteroperator= request.getParameter("filteroperator");
  query1 = query1 + " and providers.name='" + filteroperator + "' ";
  query2 = query2 + " and providers.name='" + filteroperator + "' ";
 }
} 
   


///////////////THE operators
int theoperatorscount = 0;
String[] theoperators = null;

   try{
      rs = con.createStatement().executeQuery("select distinct name from providers order by name asc");            
      while(rs.next())
      {
     	 theoperatorscount = theoperatorscount + 1;
      }
       rs.close(); rs = null;

   rs = null;
   rs = con.createStatement().executeQuery("select distinct name from providers order by name asc");

 theoperators = new String[theoperatorscount];
   
   
   int theCounterrr1 = 0;
   while(rs.next())
    {
     try{
         theoperators[theCounterrr1] = rs.getString(1).trim();
        }catch(Exception ex){theoperators[theCounterrr1]="";}
        

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
  query1 = query1 + " and shortcode='" + filtershortcode + "' ";
  query2 = query2 + " and shortcode='" + filtershortcode + "' ";
 }
} 
   


///////////////THE shortcodes
int theshortcodescount = 0;
String[] theshortcodes = null;

   try{
      rs = con.createStatement().executeQuery("SELECT shortcode,count(*) as thecnt FROM sms.mo_cdrs where shortcode in ('1421','+2491421','+2491653','1653')   group by shortcode  order by shortcode asc");            
      while(rs.next())
      {
     	 theshortcodescount = theshortcodescount + 1;
      }
       rs.close(); rs = null;

   rs = null;
   rs = con.createStatement().executeQuery("SELECT shortcode,count(*) as thecnt FROM sms.mo_cdrs where shortcode in ('1421','+2491421','+2491653','1653')   group by shortcode  order by shortcode asc");

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







query1 = query1 + " group by providers.name, mo_cdrs.shortcode order by providers.name asc, mo_cdrs.shortcode asc  ";
















             
%>

























































<html dir=ltr>

<head>
<link rel="shortcut icon" href="ico/favicon.ico">
<link rel="stylesheet" type="text/css" href="datepicker.css"/>
<script type="text/javascript" src="datepicker.js"></script>

<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  
<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt arial, geneva, lucida, "lucida grande", arial, helvetica, sans-serif; COLOR: #000000;background-color: #FFFFFF; }</style>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<title>SMS Report</title>
</head>

<body>

 

 

<form action='smsreport.jsp' method='post'>
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
   <td align='center'><font color=#000000 size='5'0>General SMS Report for Sudan</td>
  </tr>
 </table>

<br>

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
                                          
                                          
                                          <td width='5%' align='center'>Operator</td>
                                          
                                          
                                          <td width='20%' align='center'>
                                          
											<select name='filteroperator' style='font-size:12pt;color:#000099;font-weight:bold;width:8em;height:1.7em' >
											 <option>ALL</option>
											<% 
											for (int l =0  ; l < theoperators.length ; l ++)
											{
											  if (theoperators[l].equalsIgnoreCase(filteroperator)) 
											  {
											  
											%>       	        
											    	        <option selected><%= theoperators[l] %></option>
											<%
											  }
											  else
											  {
											%>       	        
											    	        <option><%= theoperators[l] %></option>
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
                                  <td width='10%' align='right'><a href="/ivrfit/miniutesreport.jsp" class="btn btn-info btn-md" role="button">IVR Report</a></td>
                                  <td width='10%' align='right'><a href="/ivrfit/login.jsp" class="btn btn-danger" role="button">Sign Out</a></td>
                        </td>
                  </tr>
                </form>
            </table>




 





 
            <table border='1' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='75%'>
                  <tr height=30>
                        <td width='15%' align='center'><font size='4'>Operator</font></td>
                        <td width='15%' align='center'><font size='4'>ShortCode</font></td>
                        <td width='15%' align='center'><font size='4'>SMS Count</font></td>
         

                  </tr>
                  
                  

<%

   rs = null;
   rs = con.createStatement().executeQuery(query1);  
while(rs.next())
{
String operator =rs.getString(1);
String sc =rs.getString(2);
String smscount = rs.getString(3);


%>
			  <tr height=30 bgcolor=#ffffff>
				<td width='15%' align='center'><font size='3'><%=operator%></font></td>
				<td width='15%' align='center'><font size='3'><%=sc%></font></td>
				<td width='15%' align='center'><font size='3'><%=smscount%></font></td>
	
			  </tr>
<%
}
rs.close();rs = null;

%>


	</table>



	<table border='1' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='75%'>
	
	
<%
	
			   rs = null;
			   rs = con.createStatement().executeQuery(query2);  
			while(rs.next())
			{
				String thecallstotal =rs.getString(1);
				String theminutestotal ="";
	
			%>
						  <tr height=30 bgcolor=#DCDCDC>
							<td width='30%' align='center'><font size='4'>&nbsp;</font></td>
							<td width='15%' align='center'><font size='4'><%=thecallstotal%></font></td>


						  </tr>
			<%
			}
			rs.close();rs = null;
			
			%>



	  
	  
	  
	  
	  
	</table>
</body>

</html>



















<%


con.close();

%>