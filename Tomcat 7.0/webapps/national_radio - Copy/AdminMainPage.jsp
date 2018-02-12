<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*" %>






<%

String pgmid;try{ pgmid =  session.getAttribute("pgmid").toString();}catch(Exception e){pgmid=null;}
String username;try{ username =  session.getAttribute("username").toString();}catch(Exception e){username=null;}
String password;try{password =  session.getAttribute("password").toString();}catch(Exception e){password=null;}

if( pgmid.equalsIgnoreCase("admin")  ) //admin login
{


  
%>





<html dir='rtl'>

<head>
<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt Arabic Transparent, geneva, lucida, "lucida grande", Arabic Transparent, helvetica, sans-serif; COLOR: #000000 }</style>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<title>القائمة الرئيسية ... National Radio</title>
</head>
<body>


		    
		    
<table border='0' bgcolor=#ffffff cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%' height='85'>
  <tr>
	<td width='25%' align='center'><font size='5' Color=darkred><b>مرحباً ,</b></font><font size='4' Color=green><b> <%= username %> </b></font></td>
    <td width='25%' align='center'>&nbsp;</td>
    <td width='25%' align='center'><font size='4' Color=black><a href="ftp://<%=username %>:<%=password %>@196.29.186.246"><b>تصفح التسجيلات</b></a></font></td>
    <td bgcolor='#ffffff' width='25%' align='left'><IMG src='logo.png'></td>
  </tr>
</table>


<br>		    
		    
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		    
		    <table border='0' alin='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='90%'>
                  <tr>
      
      
      	
      	
      	
      	
      
                    <td width='25%' align='center' >
                    
                    
                    <table align='center' border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='15%'>
                    
                        <tr bgcolor=#646464>
                              <td width='50%'  align='center' height='30'><b><font size='4' color=white>الاداره</font></b></td>
                        </tr>


			     		 <tr bgcolor=#DCDCDC>
			     		 	<form action='programs.jsp' method='post'>
				                <td width='50%' height='40'><p align='center'><input type='submit'  value='البرامج' STYLE='font-family:Arabic Transparent;font-weight:bold; font-size:12pt ; width:8em ; height:2.0em'></td>
						   </form>
			      		</tr>



			     		 <tr bgcolor=#DCDCDC>
			     		 	<form action='search.jsp' method='post'>
				                <td width='50%' height='40'><p align='center'><input type='submit'  value='البحث' STYLE='font-family:Arabic Transparent;font-weight:bold; font-size:12pt ; width:8em ; height:2.0em'></td>
						   </form>
			      		</tr>
			      		

	   

			      		
			      		
			      			      
					</table>
			
			
			
			
	    				</td>





				
	
		



	  				</tr>
				</table>








			    <br>




				<table border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='95%'>
	  				<tr align='center'>

	    				<td width='25%' valign='top'>&nbsp;</td>
	    				<td width='25%' valign='top'>&nbsp;</td>
	    				<td width='25%' valign='top'>&nbsp;</td>
	    				<td width='25%' valign='top'>
	    				
					    	<table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='60%'>
						      <tr bgcolor=#DCDCDC align='center'>
								<form action='login_logout.jsp' method='post'>
					                  <td width='80%' height='40'><p align='center'><input type='submit' value='خروج' STYLE='font-family:Arabic Transparent;font-weight:bold; color:#FF0000; font-size:12pt ; width:8em ;  height:2.0em'></td>
							    </form>
						      </tr>
							</table>
	    				</td>

	  				</tr>
				</table>






















<br>
<br>


				
</body>

</html>




<%

}

else
{

	session.invalidate();
	response.sendRedirect("login.jsp");

}


%>