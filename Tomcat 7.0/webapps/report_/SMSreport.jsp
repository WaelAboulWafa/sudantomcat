<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SMS Reports</title>
	<link rel="shortcut icon" href="images/ico/favicon.ico">
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/fit144.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/fit114.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/fit72.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/fit57.png">!--Bootstrap Core CSS-->
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">

<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/mycss.css" media="screen" type="text/css" />
<link rel="stylesheet" type="text/css" href="datepicker.css"/>
<script type="text/javascript" src="datepicker.js"></script>
<script src="js/Chart.js"></script>

<!--  
<style>
	table, td, tr{
		border: 2px solid #3385FF;
		background-color: lightgray
	}
	th {
		border: 2px solid #3385FF;
		background-color: #F1FAFF;
		font-style: 
	}

</style>
-->
</head>
<body style="width:100%;">
<!-- ////////// START OF MENU /////////// -->

<div class="pagina" style="margin-left: 25%;">
    <div class="linha">          
        <div class="tile tileLargo amarelo" align="center">
        	<span class="titulo">IVR Report</span><br/>
        	<a href="report.jsp">
        	<img alt="SMS Reports" src="images/phone-28-48.png"></a>
        </div>
        <div class="tile tileLargo vermelho" align="center">
        	<span class="titulo">SMS Report</span><br/>
  			<a href="#">
        	<img alt="SMS Reports" src="images/message-outline-48.png"></a>
        </div>          
        <div class="tile tileLargo verde" align="center">
        	<span class="titulo">Logout</span><br/>
        	<a href="login.jsp">
        	<img alt="logout" src="images/logout-48.png" /></a>
        </div>
    </div>
</div>


<!-- ////////// END OF MENU ////////// -->

<%

////////////// Session Attributes //////////////////

String username = session.getAttribute("username").toString().trim();
String service_id = session.getAttribute("service_id").toString().trim();



/////////////////////////// Dates //////////////////////////////////

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
	Calendar tday = Calendar.getInstance();
	String today = new SimpleDateFormat("YYYY-MM-dd").format(tday.getTime());
	
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
	// the shortcodes
	
		ArrayList<String> shortcodes = new ArrayList<String>();
		String servicesc = "select shortcode from rep_service where servid = '"+service_id+"' ";
			   
			   
		rs = con.createStatement().executeQuery(servicesc);

		while(rs.next()){
			shortcodes.add(rs.getString(1));
		}
		
		rs = null;
		  ///////////// Formatting shortcodes list /////////////////////////////////
		  String listOfShortCodes = "";
		  for(int i = 0; i< shortcodes.size(); i++){
			  if(i != shortcodes.size()-1){
				  listOfShortCodes = listOfShortCodes + "'"+shortcodes.get(i)+"',";
			  }
			  else{
				  listOfShortCodes = listOfShortCodes + "'"+shortcodes.get(i)+"'";
			  }
		  }
		 ////////////////////////////////////////////////////////////////////////////
		 

		 ////////////////////////////////////////////////////////////////////////////
		

	String queryservdetails = "SELECT dst, operator ";
	queryservdetails = queryservdetails + "FROM ucp_user.cdr ";
	queryservdetails = queryservdetails + "WHERE app_name='"+ theService +"' and operator !='Unknown'";
	queryservdetails = queryservdetails + "group by operator ";
	
	String detailQuery = "SELECT operator, app_name,dst,count(*) as thecnt , sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as Minutes"; 
		   detailQuery = detailQuery + " FROM ucp_user.cdr ";
		   detailQuery = detailQuery + " where call_start_date between '"+sdate_formated+"' and '"+edate_formated+"'"; 
		   detailQuery = detailQuery + " and operator in ('SudaTel' , 'MTN' ) and dst in ('"+listOfShortCodes+"') and app_name = '"+theService+"'";
		   detailQuery = detailQuery + " group by app_name,dst, operator order by app_name" ;
	
	
	String[] theShortcodes = new String[srvcount] ;
	String[] theOperators = new String[srvcount] ;
	


    String query1 = "SELECT  sms.providers.name , sms.mo_cdrs.shortcode, sum(mo_cdrs.length) as thecount ";
	query1 = query1 +" FROM sms.mo_cdrs  JOIN sms.providers on mo_cdrs.Provider = providers.gateway";
	query1 = query1 +" where DateIn between '"+sdate_formated+"' and '"+edate_formated+"'";
	query1 = query1 +" and sms.mo_cdrs.shortcode in ('"+listOfShortCodes+"') and sms.providers.name in ('SudaTel' , 'MTN' )";	
	query1 = query1 +"group by sms.providers.name , sms.mo_cdrs.shortcode order by sms.providers.name , sms.mo_cdrs.shortcode   ";


 

    // Totals
    
    String totalsquery = "SELECT count(*) ,sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) )";
    	   totalsquery = totalsquery + "bayt ucp_user.cdr where call_start_date between '"+sdate_formated+"' and '"+edate_formated+"'";
    	   totalsquery = totalsquery + "and operator in ('SudaTel' , 'MTN' ) and dst in ('"+listOfShortCodes+"')";//app_name = '"+theService+"'";
	
  //////////// getting Dashboard stuff ////////////////

  rs = null;
  int MTN = 1;
  rs = con.createStatement().executeQuery("SELECT  sum(mo_cdrs.length) as total  FROM sms.mo_cdrs JOIN sms.providers on mo_cdrs.Provider = providers.gateway  WHERE DateIn between '"+sdate_formated+"' and '"+edate_formated+"'  and mo_cdrs.shortcode in ('1421','+2491421','+2491653','1653','+2491653') and sms.providers.name = 'MTN' ;");
  while(rs.next()){
	  MTN = rs.getInt(1); 
  }
  rs = null;
  
  int SudaTel = 1;
  rs = con.createStatement().executeQuery("select  sum(mo_cdrs.length) as total  FROM sms.mo_cdrs JOIN sms.providers on mo_cdrs.Provider = providers.gateway  where DateIn between '"+sdate_formated+"' and '"+edate_formated+"' and  mo_cdrs.shortcode in ('1421','+2491421','+2491653','1653','+2491653') and sms.providers.name = 'SudaTel';");
  while(rs.next()){
	  SudaTel = rs.getInt(1); 
  }
  rs = null;
 
  int Total = 1;
  rs = con.createStatement().executeQuery("select  sum(mo_cdrs.length) as total  FROM sms.mo_cdrs JOIN sms.providers on mo_cdrs.Provider = providers.gateway  where DateIn between '"+sdate_formated+"' and '"+edate_formated+"' and  mo_cdrs.shortcode in ('1421','+2491421','+2491653','1653','+2491653') ;");
   while(rs.next()){
	  Total = rs.getInt(1); 
  }
  rs = null;
  
  //int zain = (int) Math.floor((float) (Zain*100)/Total);
  int sudatel = (int) Math.floor((float) (SudaTel*100)/Total);
  int mtn = (int) Math.floor((float) (MTN*100)/Total);
////////////////////// End of Dashboard stuff /////////////////////////////

%>
<!-- Date Picker -->
<div class="clearfix"></div>
<div align="center" id="div-1c">
<table border='1' align='center' bgcolor=#1975FF cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='50%' >
                 <form action='SMSreport.jsp' method='post'>
                  <tr>
                        <td>
                              <table border='0' align='center' bgcolor=#1975FF cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
                                          <td width='5%' align='center'><b><input class="button-secondary pure-button" type=button value="From" onclick="displayDatePicker('fdate', this);"></td>
                                          <td width='20%' align='center'><input  style='font-size:10pt;color:#000000;font-weight:bold;width:8em;height:1.7em' type="text" readonly name="fdate" id="idate" value='<%=fdate%>' ></td>
                                          <td width='5%' align='center'><b><input class="button-secondary pure-button" type=button value="To" onclick="displayDatePicker('tdate', this);"></b></td>
                                          <td width='20%' align='center'><input style='font-size:10pt;color:#000000;font-weight:bold;width:8em;height:1.7em' type="text"  readonly name="tdate" id="idate" value='<%=tdate%>'></td>
                                         
                                          
                                          
                                          <td width='10%' align='right'><input class="button-success pure-button pure-button-primary" type='submit' name='subReport' value='Get Report' STYLE='font-weight:bold ; color:#ffffff; width:8em; height:2.2em'></td>
                              </table>
                        </td>
                  </tr>
                </form>
            </table>

</div>


 


<br>

<!-- End of Date Picker -->
<div class="clearfix"></div>
<div align='center' style="width:30%; margin-left:40%" align="center" id="div-1a">

	<table class="pure-table" border='1' align='center' bgcolor=#f4f4f4 cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
		<tr height=20 bgcolor=#1975FF>
                        <td colspan=4 align='center'><font size='2' color="white"><b>Per Shortcode/Operator</b></font></td>
        </tr>
		<tr bgcolor=#4791FF>
			<th><font color="white"> Operator</font> </th>
			<th><font color="white"> Service owner</font> </th>
			<th><font color="white"> ShortCode </font></th>
			<th><font color="white"> SMS Count </font></th>
					
		</tr>
		<tr>
		
			<%
			
		rs  = con.createStatement().executeQuery(query1);
		rs1 = con1.createStatement().executeQuery(detailQuery);
		
		String operator = "";
		String srvowner = "";
		String shortcode = "";
		String smscount="";
	 	double total =0;
	 
		while(rs1.next() && rs.next()){
			operator  = rs.getString(1);
			srvowner  = rs1.getString(2);
			shortcode = rs.getString(2);
			smscount  = rs.getString(3);
			 total+= Double.parseDouble(smscount);
			%>
			<tr height=20 bgcolor=#ffffff>
				<td><%=operator %></td>
				<td><%=srvowner %></td>
				<td><%=shortcode %></td>
				<td><%=smscount %></td>
				
			</tr>
			<%
		}
		
	rs1 = null;
    rs = null;
		%>
		<tr bgcolor=#5CE65C >
			<td colspan="3" ><font size='5' color=#FFFFFF>Total</font></td><td><font size='4' color=#0000FF><%=(int)total %></font></td>
		</tr>
	</table>

</div>
<!-- ///////////////////////////  DASHBOARD START ////////////////////////////// -->
<div class="clearfix"></div>
<div class="chart" style="width:28%; margin-left:0%; padding-left: 0%;" align="center" id="div-1b">
		               <h3>Operators Status</h3>
		                <div class="diagram">
		                  <canvas id="canvas" height="220" width="220"> </canvas>
		                  <h4 align="center"><span><%=month %></span><br /><%=year %></h4>   
		                 </div>
		                     
		               	<!--                
						<span><img src="images/chart.png" alt="" /></span>
						-->	
										
						<div class="chart_list">
			           	  <ul>
			           	  	
			           	  	<li><a href="#" class="yellow">MTN<p class="percentage"><%=mtn %><em>%</em></p></a></li>
			           	  	<li><a href="#" class="blue">Sudatel<p class="percentage"><%=sudatel %><em>%</em></p></a></li>
			           	  	<div class="clear"></div>	
			           	  </ul>
			           </div>
			           
			           <script>
						var doughnutData = [
														
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



<!-- ///////////////////////////  DASHBOARD END   ////////////////////////////// -->
<%
con.close();
con1.close();
%>

<!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
</body>
</html>