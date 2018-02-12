<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*" %>




<!DOCTYPE HTML>
<html lang="en">
<head>
<title>Rittal Call Center</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link href="css/style.css" rel="stylesheet" type="text/css" media="all"/>
<link href="css/nav.css" rel="stylesheet" type="text/css" media="all"/>
<link href='css/font.css' rel='stylesheet' type='text/css'>

<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
	

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/login.js"></script>
<script type="text/javascript" src="js/Chart.js"></script>
 <script type="text/javascript" src="js/jquery.easing.js"></script>
 <script type="text/javascript" src="js/jquery.ulslide.js"></script>
 <!----Calender -------->
  <link rel="stylesheet" href="css/clndr.css" type="text/css" />
  <script src="js/underscore-min.js"></script>
  <script src= "js/moment-2.2.1.js"></script>
  <script src="js/clndr.js"></script>
  <script src="js/site.js"></script>
  <!----End Calender -------->


  <style>
  body {
      position: relative; 
  }
 
  #section1 {padding-top:30px;height:500px;}
  #section2 {padding-top:30px;height:500px;}
  </style>
</head>
<body>
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

	String queryservdetails = "SELECT dst, operator ";
	queryservdetails = queryservdetails + "FROM ucp_user.cdr ";
	queryservdetails = queryservdetails + "WHERE app_name='"+ theService +"' and operator !='Unknown'";
	queryservdetails = queryservdetails + "group by operator ";
	
	String detailQuery = "SELECT operator, app_name,dst,count(*) as thecnt , sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as Minutes"; 
		   detailQuery = detailQuery + " FROM ucp_user.cdr ";
		   detailQuery = detailQuery + " where call_start_date between '"+sdate_formated+"' and '"+edate_formated+"'"; 
		   detailQuery = detailQuery + " and operator in ('SudaTel' , 'MTN' , 'Zain') and app_name='"+theService+"'";
		   detailQuery = detailQuery + " group by app_name,dst, operator order by app_name" ;
	
	
	String[] theShortcodes = new String[srvcount] ;
	String[] theOperators = new String[srvcount] ;

    // Totals
    
    String totalsquery = "SELECT count(*) ,sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) )";
    	   totalsquery = totalsquery + "FROM ucp_user.cdr where call_start_date between '"+sdate_formated+"' and '"+edate_formated+"'";
    	   totalsquery = totalsquery + "and operator in ('SudaTel' , 'MTN' , 'Zain') and app_name='"+theService+"'";
	
 ////////////// getting Dashboard stuff ////////////////

  
  //Connection con1=null;
  //InitialContext ic1 = new InitialContext();
  //DataSource ds1 = (DataSource) ic1.lookup("java:comp/env/jdbc/TheDB2");
  //con1  = ds1.getConnection();
  rs1 = null;
  int Zain = 1;
  rs1 = con1.createStatement().executeQuery("select sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as minutes from cdr  where dst  in ('1653','87015002', '6631') and operator = 'Zain' and call_start_date between '"+month_start+"' and '"+today+"';");
  while(rs1.next()){
	  Zain = rs1.getInt(1); 
  }
  rs1 = null;
 
  int MTN = 1;
  rs1 = con1.createStatement().executeQuery("select sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as minutes from cdr  where dst  in ('1653','87015002', '6631') and operator = 'MTN' and call_start_date between '"+month_start+"' and '"+today+"';");
  while(rs1.next()){
	  MTN = rs1.getInt(1); 
  }
  rs1 = null;
  
  int SudaTel = 1;
  rs1 = con1.createStatement().executeQuery("select sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as minutes from cdr  where dst  in ('1653','87015002', '6631') and operator = 'SudaTel' and call_start_date between '"+month_start+"' and '"+today+"';");
  while(rs1.next()){
	  SudaTel = rs1.getInt(1); 
  }
  rs1 = null;
 
  int Total = 1;
  rs1 = con1.createStatement().executeQuery("select sum(CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) ) as minutes from cdr  where dst  in ('1653','87015002', '6631') and call_start_date between '"+month_start+"' and '"+today+"';");
  while(rs1.next()){
	  Total = rs1.getInt(1); 
  }
  rs1 = null;
  
  int zain = (int) Math.floor((float) (Zain*100)/Total);
  int sudatel = (int) Math.floor((float) (SudaTel*100)/Total);
  int mtn = (int) Math.floor((float) (MTN*100)/Total);
////////////////////// End of Dashboard stuff /////////////////////////////

%>




<header>
		<div class="navbar navbar-default navbar-fixed-top navbar-inverse">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#example">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#">Admin Panel</a>
					<a href="" class="navbar-brand">Settings</a>
				</div>
				<div class="collpase navbar-collapse" id="example">
					<ul class="nav navbar-nav">
						<li class="active"><a href="#section1">IVR Report</a></li>
						<li ><a href="#section2">Agent Report</a></li>
					</ul>

					

					
             	  <div class="profile_details">
				    		   <div id="loginContainer">
				                  <a id="loginButton" class=""><span>Me</span></a>   
				                    <div id="loginBox">                
				                      <form id="loginForm">
				                        <fieldset id="body">
				                            <div class="user-info">
							        			<h4>Hello,<a href="#"> Username</a></h4>
							        			<ul>
							        				<li class="profile active"><a href="#">Profile </a></li>
							        				<li class="logout"><a href="#"> Logout</a></li>
							        				<div class="clear"></div>		
							        			</ul>
							        		</div>			                            
				                        </fieldset>
				                    </form>
				                </div>
				            </div>
				             <div class="profile_img">	
				             	<a href="#"><img src="images/profile_img40x40.jpg" alt="" />	</a>
				             </div>		
				             <div class="clear"></div>		  	
					    </div>




				</div>

			</div>
		</div>
			<div class="jumbotron">
				<div class="container">
				<div align="center" id="div-1c">
<table border='1' align='center' bgcolor=#1975FF cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='50%' >
                 <form action='test.jsp' method='post'>
                  <tr>
                        <td>
                              <table border='0' align='center' bgcolor=#4FC4F6 cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
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

				</div> 
			</div> 
	</header>





<!-- vd -->

<div class="container-fluid">
            <div class="row-fluid">
                <div class="span3" id="sidebar">
                    <ul class="nav nav-list bs-docs-sidenav nav-collapse collapse">
                        <li class="active">
                            <a href="index.html"><i class="icon-chevron-right"></i> Dashboard iiiiii</a>
                        </li>
                        <li>
                            <a href="calendar.html"><i class="icon-chevron-right"></i> Calendar</a>
                        </li>
                        <li>
                            <a href="stats.html"><i class="icon-chevron-right"></i> Statistics (Charts)</a>
                        </li>
                        <li>
                            <a href="form.html"><i class="icon-chevron-right"></i> Forms</a>
                        </li>
                        <li>
                            <a href="tables.html"><i class="icon-chevron-right"></i> Tables</a>
                        </li>
                        <li>
                            <a href="buttons.html"><i class="icon-chevron-right"></i> Buttons & Icons</a>
                        </li>
                        <li>
                            <a href="editors.html"><i class="icon-chevron-right"></i> WYSIWYG Editors</a>
                        </li>
                        <li>
                            <a href="interface.html"><i class="icon-chevron-right"></i> UI & Interface</a>
                        </li>
                        <li>
                            <a href="#"><span class="badge badge-success pull-right">731</span> Orders</a>
                        </li>
                        <li>
                            <a href="#"><span class="badge badge-success pull-right">812</span> Invoices</a>
                        </li>
                        <li>
                            <a href="#"><span class="badge badge-info pull-right">27</span> Clients</a>
                        </li>
                        <li>
                            <a href="#"><span class="badge badge-info pull-right">1,234</span> Users</a>
                        </li>
                        <li>
                            <a href="#"><span class="badge badge-info pull-right">2,221</span> Messages</a>
                        </li>
                        <li>
                            <a href="#"><span class="badge badge-info pull-right">11</span> Reports</a>
                        </li>
                        <li>
                            <a href="#"><span class="badge badge-important pull-right">83</span> Errors</a>
                        </li>
                        <li>
                            <a href="#"><span class="badge badge-warning pull-right">4,231</span> Logs</a>
                        </li>
                    </ul>
                </div>


<!-- dcd-->
	    
            
             




    <div  id= "section1" class="container">

    	<div class="row">
    		<div class="col-ms-12">
				
<!-- End of Date Picker -->

<div align='center' style="width:30%; float:right;"  id="div-1a">

	<table class="pure-table" border='1'  bgcolor=#f4f4f4 cellpadding='0' cellspacing='0' style='border-collapse: collapse;float:right;' bordercolor='#111111' width='100%'>
		<tr height=20 bgcolor=#1975FF>
                        <td colspan=4 align='center'><font size='2' color="white"><b>Per Shortcode/Operator</b></font></td>
        </tr>
		<tr bgcolor=#4791FF>
			<th><font color="white"> Operator</font> </th>
			<th><font color="white"> Service owner</font> </th>
			<!--<th><font color="white"> ShortCode </font></th>-->
			<th><font color="white"> Hits </font></th>
			<th><font color="white"> Minutes </font></th>		
		</tr>
		<tr>
		
		<%
		rs1 = con1.createStatement().executeQuery(detailQuery);
		int i = 0, hits = 0, minutes = 0 ;
		String operator = "";
		String srvowner = "";
		String shortcode = "";
	
		while(rs1.next()){
			operator = rs1.getString(1);
			srvowner = rs1.getString(2);
			shortcode = rs1.getString(3);
			hits = rs1.getInt(4);
			minutes = rs1.getInt(5);
			%>
			<tr height=20 bgcolor=#ffffff>
				<td><%=operator %></td>
				<td><%=srvowner %></td>
				<!--<td><%=shortcode %></td>-->
				<td><%=hits %></td>
				<td><%=minutes %></td>
			</tr>
			<%
		}
		
		rs1 = null;
		
		rs1 = con1.createStatement().executeQuery(totalsquery);
		int totalCalls = 0, totalMinutes = 0;
		
		while(rs1.next()){
			
			totalCalls = rs1.getInt(1);
			totalMinutes = rs1.getInt(2);
			
		}
		
		%>
		<tr bgcolor=#4FC4F6 >
			<td colspan="2" ><font size='5' color=#FFFFFF>Total</font></td><td><font size='4' color=#0000FF><%=totalCalls %></font></td><td><font size='4' color=#0000FF><%=totalMinutes %></font></td>
		</tr>
	</table>

</div>
<!-- ///////////////////////////  DASHBOARD START ////////////////////////////// -->

<div class="chart" style="width:40%; margin-left:0%; padding-left: 0%;float:left;"  id="div-1b">
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



<!-- ///////////////////////////  DASHBOARD END   ////////////////////////////// -->	
    		</div>



    		
    	</div>		

      </div>







      




			
			
	























	  
 <%
con.close();
con1.close();
%>
  		    
</body>
</html>

