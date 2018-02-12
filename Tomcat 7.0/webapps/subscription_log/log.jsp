<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*" %>




<%


  Connection con=null;
  InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();
  ResultSet rs = null;





String query1 = " select id,theservice,thedate,thesent from subscription_log order by id" ;







             
%>

























































<html dir=ltr>

<head>
<link rel="stylesheet" type="text/css" href="datepicker.css"/>
<script type="text/javascript" src="datepicker.js"></script>
<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt arial, geneva, lucida, "lucida grande", arial, helvetica, sans-serif; COLOR: #000000;background-color: #FFFFFF; }</style>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<title>Subscription Log</title>
</head>

<body>

 

 

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













<table width='50%' align='center'>
	
	<tr >





	
	
	
	
<td width=100% valign=top>
	
	

 <table border='1' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
	

                  	
                  <tr height=20 bgcolor=#f4f4f4>
                        <td  align='center'><font size='2'><b>ID</b></font></td>
                        <td  align='center'><font size='2'><b>Service</b></font></td>
                        <td  align='center'><font size='2'><b>Date<b></font></td>
                        <td  align='center'><font size='2'><b>Execution</b></font></td>


                  </tr>
                  


                                    
                  	
	
		<%
	
			   rs = null;
			   rs = con.createStatement().executeQuery(query1);  
			while(rs.next())
			{
				String id =rs.getString(1);
				String servicename =rs.getString(2);
				String thedate =rs.getString(3);
				String executiondate =rs.getString(4);
				
	
			%>
						  <tr height=20 bgcolor=#ffffff>
							<td align='center'><font size='2'><%=id%></font></td>
							<td  align='center'><font size='2'><%=servicename%></font></td>
							<td align='center'><font size='2'><%=thedate%></font></td>
							<td  align='center'><font size='2'><%=executiondate%></font></td>

						  </tr>
			<%
			}
			rs.close();rs = null;
			
			%>





	  </table>
	
	
	
		
	</td>	
	


	
<td width=2% valign=top>&nbsp;</td>	
	






	
	
	</tr>
   
</table>   
	
	
	
	
	
</body>

</html>



















<%


con.close();

%>