<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*" %>




<%





String leday = "2001-01-01";try{leday = request.getParameter("theday").trim();}catch(Exception e){leday = "2001-01-01";}




  Connection con=null;
  InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();
  ResultSet rs = null;


String query3 = "";
query3 = query3 + " SELECT ID, DATE_FORMAT(call_start_date,' %H:%i:%S') as callstart, DATE_FORMAT(call_end_date,' %H:%i:%S')  as callend, operator , dst ,src, TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) as Seconds , case 	when  ( TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) < 1 ) then 0 	else CEIL(TIMESTAMPDIFF(SECOND, call_start_date, call_end_date) / 60) end as BilledMinutes ";
query3 = query3 + " FROM cdr " ; 
query3 = query3 + " where DATE_FORMAT(call_start_date,'%Y-%m-%d') = '"+ leday +"'  ";





String theoperator = "ALL";

if( request.getParameter("theoperator")!=null) 
{
 if( !(request.getParameter("theoperator").trim().equalsIgnoreCase("ALL")) ) 
 { 
  theoperator= request.getParameter("theoperator");
  query3 = query3 + " and operator ='"+ theoperator +"' ";
  query3 = query3 + " and DATE_FORMAT(call_start_date,'%H:%i:%S') >= '"+(request.getParameter("filtercallstart").trim())+"'";
  query3 = query3 + " and ATE_FORMAT(call_end_date,'%H:%i:%S) <= '"+(request.getParameter("filtercallstart").trim())+"' ";
   
 }
} 




   


 



query3 = query3 + " order by id ";

   





             
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

 

 

<form action='getReport.jsp' method='post'>
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



            <table border='1' align='center' bgcolor=#F9DEA9 cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='40%'>
                  <tr>
                        <td>
                              <table border='0' align='center' bgcolor=#f4f4f4 cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
                                          
                                          <td width='20%' align='center'><b>CDRs</b> </td>
                                          
                                          <td width='20%' align='center'>Day : <b><%=leday%></b> </td>
                                          
                                          
                                          <td width='2%' align='center'>&nbsp;</td>
                                          
                                          
                                          <td width='20%' align='center'>Operator : <b><%=theoperator%></b> </td>                                          
                                          
                                         
                              </table>
                        </td>
                  </tr>

            </table>




 



















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
			   rs = con.createStatement().executeQuery(query3);  
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
	
	
	<textarea><%=query3%></textarea>

	
		
	</td>	
	


	

	
	
	</tr>
   
</table>   
	
	
	
	
	
</body>

</html>



















<%


con.close();


%>