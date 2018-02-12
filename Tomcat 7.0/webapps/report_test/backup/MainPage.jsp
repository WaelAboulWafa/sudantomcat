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
   rs = con.createStatement().executeQuery("SELECT userID from fitservice.nradio_pgm_Users where username=N'" + username.replaceAll("'", "''") + "' and password=N'" + password.replaceAll("'", "''") + "'");             
   userid = 0;
   while(rs.next()){userid = rs.getInt(1);}
   rs.close();rs = null;
  }catch(Exception e){}
  
  



  int reccount = 0 ;
  rs = null;
  try
  {
   rs = con.createStatement().executeQuery("SELECT count(*) from fitservice.nradio_pgm_UsersAuthorities where userID=" + userid);             
   while(rs.next()){reccount = rs.getInt(1);} 
   rs.close();rs = null;
  }catch(Exception e){}
  
  
  String[] thepage = new String[reccount];
  int[] allowed = new int[reccount];
  
  rs = null;
  int z =0;
  try
  {
   rs = con.createStatement().executeQuery("SELECT page, allowed from fitservice.nradio_pgm_UsersAuthorities where userID=" + userid);             
   while(rs.next()){thepage[z]=rs.getString(1);allowed[z]=rs.getInt(2);z=z+1;}
   rs.close();rs = null;
  }catch(Exception e){}
  
 //////////////////// Getting Date ///////////////////////
 
String theSdate =(new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date((new java.util.Date()).getTime())).trim();
String theEdate =(new SimpleDateFormat("yyyyMMdd")).format(new java.util.Date( (new java.util.Date()).getTime())).trim();
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
Calendar c = Calendar.getInstance();
c.setTime(sdf.parse(theEdate));
c.add(Calendar.DATE, 1);  // number of days to add
theEdate = sdf.format(c.getTime());

Calendar cal = Calendar.getInstance();
String month = new SimpleDateFormat("MMM").format(cal.getTime());
Calendar ye = Calendar.getInstance();
String year = new SimpleDateFormat("YYYY").format(ye.getTime());


String fdate = "";try{fdate = request.getParameter("fdate").trim();}catch(Exception e){fdate = theSdate;}
String tdate = "";try{tdate = request.getParameter("tdate").trim();}catch(Exception e){tdate = theEdate;}

//fdate.substring(0,4)   
// + fdate.substring(6,8)
String sdate_formated = fdate.substring(0,4) + "-" + fdate.substring(4,6) + "-01";
String edate_formated = tdate.substring(0,4) + "-" + tdate.substring(4,6) + "-" + tdate.substring(6,8);

 
 ////////////////////////////////////////////////////////
    
 ////////////// getting reports from IVR CDR ////////////////

  
  Connection con1=null;
  InitialContext ic1 = new InitialContext();
  DataSource ds1 = (DataSource) ic1.lookup("java:comp/env/jdbc/TheDB2");
  con1  = ds1.getConnection();
  ResultSet rs1 = null;
  int Zain = 1;
  rs1 = con1.createStatement().executeQuery("select sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as minutes from cdr  where dst  in ('1653','87015002', '6631') and operator = 'Zain' and call_start_date between '"+sdate_formated+"' and '"+edate_formated+"';");
  while(rs1.next()){
	  Zain = rs1.getInt(1); 
  }
  rs1 = null;
 
  int MTN = 1;
  rs1 = con1.createStatement().executeQuery("select sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as minutes from cdr  where dst  in ('1653','87015002', '6631') and operator = 'MTN' and call_start_date between '"+sdate_formated+"' and '"+edate_formated+"';");
  while(rs1.next()){
	  MTN = rs1.getInt(1); 
  }
  rs1 = null;
  
  int SudaTel = 1;
  rs1 = con1.createStatement().executeQuery("select sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as minutes from cdr  where dst  in ('1653','87015002', '6631') and operator = 'SudaTel' and call_start_date between '"+sdate_formated+"' and '"+edate_formated+"';");
  while(rs1.next()){
	  SudaTel = rs1.getInt(1); 
  }
  rs1 = null;
 
  int Total = 1;
  rs1 = con1.createStatement().executeQuery("select sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as minutes from cdr  where dst  in ('1653','87015002', '6631') and call_start_date between '"+sdate_formated+"' and '"+edate_formated+"';");
  while(rs1.next()){
	  Total = rs1.getInt(1); 
  }
  rs1 = null;
  
  int zain = (int) Math.floor((float) (Zain*100)/Total);
  int sudatel = (int) Math.floor((float) (SudaTel*100)/Total);
  int mtn = (int) Math.floor((float) (MTN*100)/Total);
 ////////////// The Filter //////////////////////////////////////
 
String query1 = "";
query1 = query1 + " SELECT app_name,dst,count(*) as thecnt , " ;
query1 = query1 + " sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as Minutes FROM ucp_user.cdr  ";
query1 = query1 + " where call_start_date between '"+sdate_formated+"' and '"+edate_formated+"' and operator in ('SudaTel' , 'MTN' , 'Zain') ";


String query2 = "";
query2 = query2 + " SELECT count(*) as thecnt , " ;
query2 = query2 + " sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as Minutes FROM ucp_user.cdr  " ;
query2 = query2 + " where call_start_date between '"+sdate_formated+"' and '"+edate_formated+"' and operator in ('SudaTel' , 'MTN' , 'Zain') ";

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
query3 = query3 + " where call_start_date between '"+sdate_formated+"' and '"+edate_formated+"' and operator in ('SudaTel' , 'MTN' , 'Zain') ";

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
query4 = query4 + " where call_start_date between '"+sdate_formated+"' and '"+edate_formated+"' and operator in ('SudaTel' , 'MTN' , 'Zain') ";

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
 //////////////////////////////////////////////////////////////
///////////////THE services /////////////////////////////////////
int theservicescount = 0;
String[] theservices = null;
String servid = session.getAttribute("serviceid").toString().trim();
try{
rs = con.createStatement().executeQuery("SELECT appname,count(*) as thecnt FROM reporting.rep_service where servid = '"+servid+"' group by appname asc");            
while(rs.next())
{
theservicescount = theservicescount + 1;
}
rs.close(); rs = null;

rs = null;
rs = con.createStatement().executeQuery("SELECT appname,count(*) as thecnt FROM reporting.rep_service where  servid = '"+servid+"' group by appname asc");

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
///////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////


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
      rs = con.createStatement().executeQuery("SELECT shortcode,count(*) as thecnt FROM reporting.rep_service where servid='"+servid+"' group by shortcode asc");            
      while(rs.next())
      {
     	 theshortcodescount = theshortcodescount + 1;
      }
       rs.close(); rs = null;

   rs = null;
   rs = con.createStatement().executeQuery("SELECT shortcode,count(*) as thecnt FROM reporting.rep_service where servid='"+servid+"' group by shortcode asc");

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

/////////////////////////////////////////////////////////
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





<html >

<head>
<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt Arabic Transparent, geneva, lucida, "lucida grande", Arabic Transparent, helvetica, sans-serif; COLOR: #000000 }</style>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<title>Reporting System</title>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="datepicker.css">
<link rel="stylesheet" href="css/style.css" media="screen" type="text/css" />
<script src="js/Chart.js"></script>
<script src="datepicker.js"></script>
</head>
<body>
<p><%=sdate_formated %></p>
<p><%=edate_formated %></p>
<p><%=month %></p>
<p><%=year %></p>
<p><%=Total %></p>
<br>		    

<!-- 
//////////////////////////////////////////////// minutes Table ////////////////////////////////////////////////////////

 -->
<form action='MainPage.jsp' method='post'>
<input type='hidden' name='uid' value='41'>



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
		
		String servicelist = "";
		for(int i = 0; i < theshortcodes.length; i++ ){
			servicelist = servicelist + "'"+theshortcodes[i]+"',";
		}
		
		if (servicelist.endsWith(",")) {
			servicelist = servicelist.substring(0, servicelist.length() - 1);
			}
		String query31 = "";
		query31 = query31 + " SELECT DATE_FORMAT(call_start_date,'%Y-%m-%d') as theday , ";
		query31 = query31 + " count(*) as Total_Calls , " ; 
		query31 = query31 + " sum(case when operator='SudaTel' then 1 else 0 end) as SudaTel_Calls , " ;
		query31 = query31 + " sum(case when operator='MTN' then 1 else 0 end) as MTN_Calls , " ;
		query31 = query31 + " sum(case when operator='Zain' then 1 else 0 end) as Zain_Calls , " ;
		query31 = query31 + " sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as Total_Minutes , " ;
		query31 = query31 + " sum(case when operator='SudaTel' then CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) else 0 end) as SudaTel_Minutes , " ;
		query31 = query31 + " sum(case when operator='MTN' then CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) else 0 end) as MTN_Minutes , " ;
		query31 = query31 + " sum(case when operator='Zain' then CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) else 0 end) as Zain_Minutes " ;
		query31 = query31 + " FROM ucp_user.cdr  " ;
		query31 = query31 + " where call_start_date between '"+sdate_formated+"' and '"+edate_formated+"' and operator in ('SudaTel' , 'MTN' , 'Zain') ";
		query31 = query31 + " and dst in ("+servicelist+")";
		query31 = query31 + " group by theday order by theday";
			   rs1 = null;
			   rs1 = con1.createStatement().executeQuery(query3);  
			while(rs1.next())
			{
				String theday =rs1.getString(1);
				String Total_Calls =rs1.getString(2);
				String SudaTel_Calls =rs1.getString(3);
				String MTN_Calls =rs1.getString(4);
				String Zain_Calls =rs1.getString(5);
				String Total_Minutes =rs1.getString(6);
				String SudaTel_Minutes =rs1.getString(7);
				String MTN_Minutes =rs1.getString(8);
				String Zain_Minutes =rs1.getString(9);
				
	
			%>
						  <tr height=20 bgcolor=#ffffff>
							<td align='center'><font size='2'><%=theday%></font></td>
							<td  align='center'><font size='2'  color='000099' ><b><%=Total_Calls%></b></font></td>
							<td  align='center'><font size='2'><%=SudaTel_Calls%></font></td>
							<td align='center'><font size='2'><%=MTN_Calls%></font></td>
							<td  align='center'><font size='2'><%=Zain_Calls%></font></td>
							<td  align='center'><font size='2'  color='000099' ><b><%=Total_Minutes%></b></font></td>
							<td align='center'><font size='2'><%=SudaTel_Minutes%></font></td>
							<td  align='center'><font size='2'><%=MTN_Minutes%></font></td>
							<td  align='center'><font size='2'><%=Zain_Minutes%></font></td>

						  </tr>
			<%
			}
			rs1.close();rs1 = null;
			
			%>


			<%
	
			   rs1 = null;
			   rs1 = con1.createStatement().executeQuery(query4);  
			while(rs1.next())
			{

				String Total_Calls =rs1.getString(1);
				String SudaTel_Calls =rs1.getString(2);
				String MTN_Calls =rs1.getString(3);
				String Zain_Calls =rs1.getString(4);
				String Total_Minutes =rs1.getString(5);
				String SudaTel_Minutes =rs1.getString(6);
				String MTN_Minutes =rs1.getString(7);
				String Zain_Minutes =rs1.getString(8);
				
	
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
			rs1.close();rs1 = null;
			
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
String query11 = "";
query11 = query11 + " SELECT app_name,dst,count(*) as thecnt , " ;
query11 = query11 + " sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as Minutes FROM ucp_user.cdr  ";
query11 = query11 + " where call_start_date between '"+sdate_formated+"' and '"+edate_formated+"' and operator in ('SudaTel' , 'MTN' , 'Zain') ";
query11 = query11 + " and dst in ("+servicelist+")";
query11 = query11 + " group by app_name,dst order by app_name ";
String query12 = "";
query12 = "select sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) from ucp_user.cdr where dst in ("+servicelist+")";
   rs1 = null;
   rs1 = con1.createStatement().executeQuery(query1);  
while(rs1.next())
{
String service =rs1.getString(1);
String sc =rs1.getString(2);
String callcount = rs1.getString(3);
String minutescount =rs1.getString(4);

%>


			  <tr height=20 bgcolor=#ffffff>
				<td  align='center'><font size='2'><%=service%></font></td>
				<td  align='center'><font size='2'><%=sc%></font></td>
				<td  align='center'><font size='2'><%=callcount%></font></td>
				<td  align='center'><font size='2'><%=minutescount%></font></td>
			  </tr>
<%
}
rs1.close();rs1 = null;

%>
<%=query11 %>
			<%
	
			   rs1 = null;
			   rs1 = con1.createStatement().executeQuery(query2);  
			while(rs1.next())
			{
				String thecallstotal =rs1.getString(1);
				String theminutestotal =rs1.getString(2);
	
			%>
						  <tr height=20 bgcolor=#f4f4f4>
							<td colspan=2 align='center'><font size='2'><b>Total</b></font></td>
							<td  align='center'><font size='2'><b><%=thecallstotal%></b></font></td>
							<td  align='center'><font size='2'><b><%=theminutestotal%></b></font></td>

						  </tr>
			<%
			}
			rs1.close();rs1 = null;
			
			%>



	</table>


</td>

	
	
	</tr>
   
</table>  

<br>
	
<!-- 
//////////////////////////////////////////////end Of minutes Table/////////////////////////////////////////////////////
 -->




 <div class="chart" style="width:28%; margin-left:0%" align="center">
		               <h3>Operators Stats</h3>
		                <div class="diagram">
		                  <canvas id="canvas" height="220" width="220"> </canvas>
		                  <h4 align="center"><span><%=month %></span><br /><%=year %></h4>   
		                 </div>
		                     
		               	<!--                
						<span><img src="images/chart.png" alt="" /></span>
						-->					
						<div class="chart_list">
			           	  <ul>
			           	  	<li><a href="#" class="red">Zain<p class="percentage"><%=zain %><em>%</em></p></a></li>
			           	  	<li><a href="#" class="yellow">MTN<p class="percentage"><%=mtn %><em>%</em></p></a></li>
			           	  	<li><a href="#" class="blue">Sudatel<p class="percentage"><%=sudatel %><em>%</em></p></a></li>
			           	  	<div class="clear"></div>	
			           	  </ul>
			           </div>
			           <script>
						var doughnutData = [
								{
									value: <%=zain%>,
									color:"#E64C65"
								},						
								{
									value : <%=sudatel %>,
									color : "#4FC4F6"
								},	
								{
									value : <%=mtn %>,
									color : "#FCB150"
								},							
							
							];				
							var myDoughnut = new Chart(document.getElementById("canvas").getContext("2d")).Doughnut(doughnutData);					
					</script>
		          </div>
		          
<p>------------------------</p>
<p><%=query1%></p>
<p>------------------------</p>
<p>------------------------</p>
<p><%=query2%></p>
<p>------------------------</p>	
<p>------------------------</p>
<p><%=query3%></p>
<p>------------------------</p>	
<p>------------------------</p>
<p><%=query4%></p>
<p>------------------------</p>			
</body>

</html>


<%
con.close();
con1.close();
%>