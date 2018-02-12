<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*,java.util.regex.*" %>

 






<%
String username;try{ username =  session.getAttribute("username").toString();}catch(Exception e){username=null;}
String password;try{password =  session.getAttribute("password").toString();}catch(Exception e){password=null;}
if(username==null) //user not logged in
{
session.invalidate();
response.sendRedirect("login.jsp");
}

else
{


		   
  
  

  Connection con=null;
  InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();
  ResultSet rs = null;



  String generalpass="";
  rs = con.createStatement().executeQuery("SELECT thepassword from sms.nradio_superusers where theuser='general'");             
  while(rs.next()){generalpass = rs.getString(1); }rs.close(); rs = null;

		   
  String adminpass="";
  rs = con.createStatement().executeQuery("SELECT thepassword from sms.nradio_superusers where theuser='admin'");             
  while(rs.next()){adminpass = rs.getString(1); }rs.close(); rs = null;







  rs = null;
  String indate=""; 
  String intime="";








 
 
 
 
 
 
  rs = null;







String pgmstatus= "0"; 
//try{pgmstatus = request.getParameter("pgmstatus").trim();}catch(Exception e){pgmstatus = "0";}
 rs = con.createStatement().executeQuery("SELECT status FROM sms.nradio_operations");            
 while(rs.next()){pgmstatus = rs.getString(1);}
 rs.close(); rs = null;


   
 

 int count=0;
 rs = con.createStatement().executeQuery("select count(*) from sms.nradio_pgms ");            
 while(rs.next()){count = rs.getInt(1);}
 rs.close(); rs = null;

   

   

             
%>



































<html dir='rtl'>
<HEAD>


<script LANGUAGE="JavaScript" type="text/javascript">

function correctinvoke(target)
{
if(target == 0) {document.thisfrm.action="addprogram.jsp";document.thisfrm.submit();}

if(target == 1) {document.thisfrm.action="modifyprov.jsp";document.thisfrm.submit();}
if(target == 2) {document.thisfrm.action="deleteprov.jsp";document.thisfrm.submit();}

if(target == 3) {document.accountingfrm.action="addprovaccountingfrm.jsp";document.accountingfrm.submit();}
if(target == 4) {document.accountingfrm.action="modifyprovaccountingfrm.jsp";document.accountingfrm.submit();}
if(target == 5) {document.accountingfrm.action="deleteprovaccountingfrm.jsp";document.accountingfrm.submit();}


}


function viewarabicurl(theID,theapp)
{
var thecountry = document.getElementById('thecountry' + theID).value;
var thecoperator = document.getElementById('thecoperator' + theID).value;
var theprovidername = document.getElementById('theprovidername' + theID).value;
var theshortcode = document.getElementById('theshortcode' + theID).value;
prompt('\u0645\u062B\u0627\u0644\u0020\u0644\u0631\u0627\u0628\u0637\u0020\u0627\u0644\u0631\u0633\u0627\u0626\u0644\u0020\u0627\u0644\u0639\u0631\u0628\u064A', theapp + '?provider=' + theprovidername + '&country=' + thecountry +'&operator='+ thecoperator + '&shortcode=' +theshortcode +'&msisdn=20121234567&lang=A&contents=062A062C0631064A0628');

  
}


function viewURLEnglish(theID,theapp)
{
var thecountry = document.getElementById('thecountry' + theID).value;
var thecoperator = document.getElementById('thecoperator' + theID).value;
var theprovidername = document.getElementById('theprovidername' + theID).value;
var theshortcode = document.getElementById('theshortcode' + theID).value;
prompt('\u0645\u062B\u0627\u0644\u0020\u0644\u0631\u0627\u0628\u0637\u0020\u0627\u0644\u0631\u0633\u0627\u0626\u0644\u0020\u0627\u0644\u0627\u0646\u062C\u0644\u064A\u0632\u064A', theapp + '?provider=' + theprovidername + '&country=' + thecountry +'&operator='+ thecoperator + '&shortcode=' +theshortcode +'&msisdn=20121234567&lang=E&contents=test');
}





function thecorrectinvoke(whattocall)
{

if(whattocall == 0) {document.thethisfrm.action="thebatchprogramsmodify.jsp";document.thethisfrm.submit();}
if(whattocall == 1) 
				   {
				   
							var r = confirm("Are you sure you want to delete ?");
							if (r == true) 
							{

							  document.thethisfrm.action="thebatchprogramsdelete.jsp";document.thethisfrm.submit();
							} 
							else 
							{

							}
				   

				   }

}


function selectall(k)
{
	for( i=0; i< k; i++ )
	{ 
	 if( document.getElementById('ischeck' + i) != null )  
     { 
	   document.getElementById('ischeck' + i).checked = true; 
	 }
	}
}






function startTime() 
{
    var today=new Date();
 
 	var x1=  today.getYear() + "-" + today.getMonth() + "-" + today.getDate() ; 
    
    var h=today.getHours();
    var m=today.getMinutes();
    var s=today.getSeconds();
    m = checkTime(m);
    s = checkTime(s);
    document.getElementById('txt').innerHTML = x1+" "+ h+":"+m+":"+s;
    var t = setTimeout(function(){startTime()},500);
}

function checkTime(i) {
    if (i<10) {i = "0" + i};  // add zero in front of numbers < 10
    return i;
}


</script>














<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt arial, geneva, lucida, "lucida grande", arial, helvetica, sans-serif; COLOR: #000000;background-color: #FFFFFF; }</style>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<title>National radio ... Programs%></title>

</head>


<BODY onload="startTime()">




<%
String applicationAt = "http://" + request.getHeader("Host") +request.getContextPath() + "/" +"submit.jsp";
%>



<table border='1' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%' height='80'>
  <tr>
    <td width='21%' align='center'><b><i><font color='#A36103' size='6'>«·»—«„Ã</font></i></b></td>
    
 
    
    
    
    
    <td width='35%' align='center'>
		    <table dir='ltr' border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='75%'>
		    
		      <tr>
		      		<td colspan=3 width='25%' align='center'><font color='#000000' face='Arial' size='2'><b>Super Users</b></font></td>
		      </tr>
		      
		       <tr>
		      		<td  width='25%' align='center'><font color='#000000' face='Arial' size='2'>username</font></td>
		      		<td  width='25%' align='center'><font color='#000000' face='Arial' size='2'>password</font></td>
		      		<td  width='25%' align='center'><font color='#000000' face='Arial' size='2'>&nbsp;</font></td>
		      </tr>
		      
		      				    
		    <form action='changeadminpass.jsp' method='get'> 
		      <tr >
		      		<td width='25%' align='center'><font color='#000000' face='Arial' size='2'><b>admin</b></font></td>
                    <td width='50%' align='center'><INPUT type='text' dir='ltr' style='font-size:12pt;color:#000000;font-weight:bold;width:12em;height:1.5em' NAME=adminpass value='<%=adminpass%>' ></td>
                    <td width='25%' align='center'><input type='submit' value='change password' STYLE='font-weight:bold ; width:10em ; height:2.0em'></td>
		      		
		      </tr>
		     </form> 
		      
		    <form action='changegeneralpass.jsp' method='get'> 
		      <tr >
		      		<td width='25%' align='center'><font color='#000000' face='Arial' size='2'><b>general</b></font></td>
                    <td width='50%' align='center'><INPUT type='text' dir='ltr' style='font-size:12pt;color:#000000;font-weight:bold;width:12em;height:1.5em' NAME=generalpass value='<%=generalpass%>' ></td>
                    <td width='25%' align='center'><input type='submit' value='change password' STYLE='font-weight:bold ; width:10em ; height:2.0em'></td>
		      		
		      </tr>
		     </form> 




		    </table>
    </td>
    
    
    <td width='19%' align='center'>
    	<table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%'>
 		<form action='AdminMainPage.jsp' method='post'>                
     		 <tr><td align='center'><input type='submit' name='subMain' value='«·ﬁ«∆„… «·—∆Ì”Ì…' STYLE='font-weight:bold;font-family:arial;font-size:18;color:#00f;width:12em;height:2.5em'></td></tr>
                </form>
 		<form name='theform' action='programs.jsp' method='post'>
     		<tr><td align='center'><input type='submit' name='subRefresh' value='«⁄«œ…  Õ„Ì·' STYLE='font-weight:bold;font-family:arial;font-size:18;color:#00f;width:12em;height:2.5em'></td></tr>
               </form>
    	</table>
    </td>
<td bgcolor='#ffffff' width='15%' align='center'><IMG src='logo.png'></td>
  </tr>
</table>




<br>










 
  <table align='center' border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='90%'>


	<tr>
	
		<td width='50%' align='center'>



 
      <table align='center' border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='75%'>

   		<form name=thisfrm  method=post action="">
 	    
      	      <tr height='25' bgcolor=#DCDCDC>
  	        	<td colspan=2 align='center'><b>»—‰«„Ã ÃœÌœ</b></td>
      	      </tr>
      	       	    

       	    
      	      <tr height='25' bgcolor=#DCDCDC>
  	        	<td width='30%' align='center'><b>«”„ «·»—‰«„Ã</b></td>
      	        <td width='70%' align='right'>
      	        	<INPUT type='text' style='font-size:12pt;color:#000000;font-weight:bold;width:15em;height:1.5em' dir='rtl' name='pgmname' >
      	       	</td>
      	      </tr>
      	      


      	   
       	    
      	      <tr height='25' bgcolor=#DCDCDC>
  	        	<td width='30%' align='center'><b>ÌÊ„ «·»À</b></td>
      	        <td width='70%' align='right'>
                       <select name='pgmairingday'  style='font-size:12pt;color:#000000;font-weight:bold;width:8em;height:1.7em'  >
								<option selected value='ALL'>ÌÊ„Ì«</option>
								<option  value='SUNDAY'>«·«Õœ</option>
								<option  value='MONDAY'>«·«À‰Ì‰</option>
								<option  value='TUESDAY'>«·À·«À«¡</option>
								<option  value='WEDNESDAY'>«·«—»⁄«¡</option>
								<option  value='THURSDAY'>«·Œ„Ì”</option>
								<option  value='FRIDAY'>«·Ã„⁄Â</option>
								<option  value='SATURDAY'>«·”» </option>
						 </select>
    	        	
      	       	</td>
      	      </tr>
      	      
      	      
      	      <tr height='25' bgcolor=#DCDCDC>
  	        	<td width='30%' align='center'><b>»œ«Ì… «·»À</b></td>
      	        <td width='70%' align='right'>
      	        	<INPUT type='text' style='font-size:12pt;color:#000000;font-weight:bold;width:7em;height:1.5em' dir='ltr' name='pgmairingstart' value='00:00:01' >
      	       	</td>
      	      </tr>
      	            	      
      	      
  
      	      <tr height='25' bgcolor=#DCDCDC>
  	        	<td width='30%' align='center'><b>‰Â«Ì… «·»À</b></td>
      	        <td width='70%' align='right'>
      	        	<INPUT type='text' style='font-size:12pt;color:#000000;font-weight:bold;width:7em;height:1.5em' dir='ltr' name='pgmairingend' value='00:01:00' >
      	       	</td>
      	      </tr>
      	            	            	      
      	      













      	      <tr height='25' bgcolor=#DCDCDC>
  	        	<td width='30%' align='center'><b>ÌÊ„ «·«⁄«œÂ</b></td>
      	        <td width='70%' align='right'>
                       <select name='pgmreplayday'  style='font-size:12pt;color:#000000;font-weight:bold;width:8em;height:1.7em'  >
                       			<option  value='NOREPLAY'>·« «⁄«œÂ</option>
								<option  value='ALL'>ÌÊ„Ì«</option>
								<option  value='SUNDAY'>«·«Õœ</option>
								<option  value='MONDAY'>«·«À‰Ì‰</option>
								<option  value='TUESDAY'>«·À·«À«¡</option>
								<option  value='WEDNESDAY'>«·«—»⁄«¡</option>
								<option  value='THURSDAY'>«·Œ„Ì”</option>
								<option  value='FRIDAY'>«·Ã„⁄Â</option>
								<option  value='SATURDAY'>«·”» </option>
						 </select>
    	        	
      	       	</td>
      	      </tr>
      	      
      	      
      	      <tr height='25' bgcolor=#DCDCDC>
  	        	<td width='30%' align='center'><b>»œ«Ì… «·»À</b></td>
      	        <td width='70%' align='right'>
      	        	<INPUT type='text' style='font-size:12pt;color:#000000;font-weight:bold;width:7em;height:1.5em' dir='ltr' name='pgmreplaystart' value='13:00:01' >
      	       	</td>
      	      </tr>
      	            	      
      	      
  
      	      <tr height='25' bgcolor=#DCDCDC>
  	        	<td width='30%' align='center'><b>‰Â«Ì… «·»À</b></td>
      	        <td width='70%' align='right'>
      	        	<INPUT type='text' style='font-size:12pt;color:#000000;font-weight:bold;width:7em;height:1.5em' dir='ltr' name='pgmreplayend' value='13:01:00' >
      	       	</td>
      	      </tr>
      	            	            	      
      	      





      	      <tr height='25' bgcolor=#DCDCDC>
  	        	<td width='30%' align='center'><b>«”„ «·„” Œœ„</b></td>
      	        <td width='70%' align='right'>
      	        	<INPUT type='text' style='font-size:12pt;color:#000000;font-weight:bold;width:10em;height:1.5em' dir='ltr' name='usrname' >
      	       	</td>
      	      </tr>
      	      
      	      
      	      
      	      
      	      <tr height='25' bgcolor=#DCDCDC>
  	        	<td width='30%' align='center'><b>ﬂ·„… «·„—Ê—</b></td>
      	        <td width='70%' align='right'>
      	        	<INPUT type='text' style='font-size:12pt;color:#000000;font-weight:bold;width:10em;height:1.5em' dir='ltr' name='password' >
      	       	</td>
      	      </tr>
      	      
      	      






      	      
      	      
      	       <tr height='25' bgcolor=#DCDCDC>
      	        <td colspan=2  align='center'><input type='button' name='subAdd' value='«÷«›…' style='font-weight:bold ; width:9em ; height:2.5em' onClick="correctinvoke(0)"></td>
      	      </tr>
      	      

</form>


      	    </table>




	</td>
	
	
	
	
			<td width='75%' align='center'>
	
	
            <table border='1' bgcolor=#FFFFFF align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='75%' >
	     <form action='pgmstatus.jsp' method='post'> 

									<%
									if(pgmstatus.equalsIgnoreCase("0"))
									{
									%>
									 <tr bgcolor=#AA7777 >
									<%
									}
                                    else
									{
									%>
									 <tr bgcolor=#7777AA >
									<%
									}
									%>
										     
              
              
              
                <td colspan=2 height='40' align='center'><b><font color='FFFFFF' size='3'> ÊÃÌÂ «·—”«∆·</font></b></td>
              </tr>
              
              <tr> 
                
                <td width='50%' align='center'>
                

					<table > 
						<tr >
						
						
									
									<td width='10%' align='center'>
									<%
									if(pgmstatus.equalsIgnoreCase("0"))
									{
									%>
									 <input type='radio' checked  name='pgmstatus' value='0'><font  size='4'>ÿÊ«—∆</font>
									<%
									}
									else
									{
									%>
									 <input type='radio'name='pgmstatus' value='0'><font  size='4'>ÿÊ«—∆</font>
									<%
									}
									%>
									
									</td>
															

									<td width='10%' align='center'>
									<%
									if(pgmstatus.equalsIgnoreCase("1"))
									{
									%>
									 <input type='radio' checked  name='pgmstatus' value='1'><font  size='4'>»—«„Ã</font>
									<%
									}
									else
									{
									%>
									 <input type='radio'name='pgmstatus' value='1'><font  size='4'>»—«„Ã</font>
									<%
									}
									%>
									
									</td>
									
									

								
									
					        </tr>
					        </table>        
                
                </td>
                
                
                <td width='25%' align='center'><input type='submit' name='subAdd' value=' ÿ»Ìﬁ' STYLE='font-size:16; color:#000000; width:5em; height:2em'></td>
              </tr>
	     </form>
            </table>
        	
	
	
	</td>	
	






</tr>


</table>











<br>






<table align='center' border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#AAAAAA' width='98%'>


      	      <tr height='25' bgcolor=#DCDCDC>
  	        	<td colspan=6 align='center'><b>«·»—«„Ã</b></td>
      	      </tr>
      	      

<tr height='25' bgcolor=#DCDCDC>
 <td width='10%' align='center'><input type='submit' name='subApproveSMSSel' value='«·ﬂ·' style='font-weight:bold ; width:6em ; height:2.0em' onClick='selectall(<%= count %>)'></td>
 <td width='10%' align='center'><input type='submit' name='subApproveSMSSel' value=' ⁄œÌ·' style='font-weight:bold ; width:6em ; height:2.0em' onClick="thecorrectinvoke(0)"></td>
 <td width='10%' align='center'><input type='submit' name='subApproveSMSSel' value='Õ–›' style='font-weight:bold ; width:6em ; height:2.0em' onClick="thecorrectinvoke(1)"></td> 
 
 
 
 <td colspan=2 width='65%' align='center'></td>
 
 
  


                                          <td width='10%' align='center'>
                                                <table border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
                                                      <tr>
                                                            <td align='center'><b>⁄œœ</b></td>
                                                            <td align='center'><font color=#000099><b><%= count %></b></font></td>
                                                      </tr>
                                                </table>
                                          </td>
                                          


 
 </tr>

</table>






     <table border='1' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#cccccc' width='98%'>





           	  <tr bgcolor=#DCDCDC height='25'>
         	    <td width='5%' colspan=3 align='center'><b>&nbsp;</b></td>
      	        
                <td width='10%' colspan=3 align='center'><font color=#000099><b>«·»À</b></font></td>


				<td width='10%' colspan=3 align='center'><font color=#990000><b>«·«⁄«œÂ</b></font></td>

      	        <td width='10%' colspan=2 align='center'><b>&nbsp;</b></td>

              </tr>







           	  <tr bgcolor=#DCDCDC height='25'>
         	    <td width='5%' align='center'><b>&nbsp;</b></td>
      	        <td width='5%' align='center'><b>„”·”·</b></td>
      	        <td width='1%' align='center'><b>«”„ «·»—‰«„Ã</b></td>
                <td width='10%' align='center'><font color=#000099><b>ÌÊ„</b></font></td>
                <td width='10%' align='center'><font color=#000099><b>»œ«Ì…</b></font></td>
      	        <td width='10%' align='center'><font color=#000099><b>‰Â«Ì…</b></font></td>
                <td width='10%' align='center'><font color=#990000><b>ÌÊ„</b></font></td>
                <td width='10%' align='center'><font color=#990000><b>»œ«Ì…</b></font></td>
      	        <td width='10%' align='center'><font color=#990000><b>‰Â«Ì…</b></font></td>
      	        <td width='10%' align='center'><b>«”„ «·„” Œœ„</b></td>
      	        <td width='10%' align='center'><b>ﬂ·„… «·„—Ê—</b></td>
              </tr>


<form name=thethisfrm method=post action="">
<INPUT type='hidden' NAME=count SIZE=6  READONLY value="<%= count %>" > 

<% 

   rs = null;
   

   rs = con.createStatement().executeQuery("SELECT id,pgm_name,airing_weekday,airing_from,airing_to,replay_weekday,replay_from,replay_to,username,password FROM sms.nradio_pgms order by id");  
 

 int therownnum =0;  
while(rs.next())
{

 

String pgmid = rs.getString(1);
String pgmname = rs.getString(2);
String pgmairingday = rs.getString(3);
String pgmairingstart = rs.getString(4);
String pgmairingend = rs.getString(5);
String pgmreplayday = rs.getString(6);
String pgmreplaystart = rs.getString(7);
String pgmreplayend = rs.getString(8);
String theusr=rs.getString(9);
String thepass=rs.getString(10);



%>



<tr>
     
       			<td width='1%' align='center'>  <INPUT id="ischeck<%= therownnum %>" NAME=ischeck<%= therownnum %> TYPE=CHECKBOX >  </td>
       
                   <td width='1%' align='center'><b><%=pgmid%></b></td>
                   <INPUT type='hidden' NAME=id<%= therownnum %> value="<%= pgmid %>" > 


                   
                   
                   <td width='10%' align='center'><INPUT dir='rtl' style='font-size:12pt;color:#000000;font-weight:bold;width:8em;height:1.7em' id="pgmname<%= therownnum %>" NAME=pgmname<%= therownnum %> value='<%=pgmname%>' ></td>


                   
                   <td width='10%' align='center'>
                   
                   
                        <select name='pgmairingday<%= therownnum %>'  style='font-size:12pt;color:#000000;font-weight:bold;width:8em;height:1.7em'  >
							
							 
							<%
							if(pgmairingday.equalsIgnoreCase("ALL"))
							{
							%>
								<option selected value='ALL'>ÌÊ„Ì«</option>
							<%
							}
							else
							{
							%>
								<option  value='ALL'>ÌÊ„Ì«</option>
							<%
							}
							%>
							


							<%
							if(pgmairingday.equalsIgnoreCase("SUNDAY"))
							{
							%>
								<option selected value='SUNDAY'>«·«Õœ</option>
							<%
							}
							else
							{
							%>
								<option  value='SUNDAY'>«·«Õœ</option>
							<%
							}
							%>




							<%
							if(pgmairingday.equalsIgnoreCase("MONDAY"))
							{
							%>
								<option selected value='MONDAY'>«·«À‰Ì‰</option>
							<%
							}
							else
							{
							%>
								<option  value='MONDAY'>«·«À‰Ì‰</option>
							<%
							}
							%>




							<%
							if(pgmairingday.equalsIgnoreCase("TUESDAY"))
							{
							%>
								<option selected value='TUESDAY'>«·À·«À«¡</option>
							<%
							}
							else
							{
							%>
								<option  value='TUESDAY'>«·À·«À«¡</option>
							<%
							}
							%>




							<%
							if(pgmairingday.equalsIgnoreCase("WEDNESDAY"))
							{
							%>
								<option selected value='WEDNESDAY'>«·«—»⁄«¡</option>
							<%
							}
							else
							{
							%>
								<option  value='WEDNESDAY'>«·«—»⁄«¡</option>
							<%
							}
							%>



							<%
							if(pgmairingday.equalsIgnoreCase("THURSDAY"))
							{
							%>
								<option selected value='THURSDAY'>«·Œ„Ì”</option>
							<%
							}
							else
							{
							%>
								<option  value='THURSDAY'>«·Œ„Ì”</option>
							<%
							}
							%>




							<%
							if(pgmairingday.equalsIgnoreCase("FRIDAY"))
							{
							%>
								<option selected value='FRIDAY'>«·Ã„⁄Â</option>
							<%
							}
							else
							{
							%>
								<option  value='FRIDAY'>«·Ã„⁄Â</option>
							<%
							}
							%>




							<%
							if(pgmairingday.equalsIgnoreCase("SATURDAY"))
							{
							%>
								<option selected value='SATURDAY'>«·”» </option>
							<%
							}
							else
							{
							%>
								<option  value='SATURDAY'>«·”» </option>
							<%
							}
							%>





							
							
							
						</select>
							

                   
                   

                   				
                   				
                   				
                   </td>
                   
                   
                   <td width='10%' align='center'><INPUT dir='ltr' style='font-size:12pt;color:#000000;font-weight:bold;width:8em;height:1.7em' id="pgmairingstart<%= therownnum %>" NAME=pgmairingstart<%= therownnum %> value='<%=pgmairingstart%>' ></td>
                   <td width='10%' align='center'><INPUT dir='ltr' style='font-size:12pt;color:#000000;font-weight:bold;width:8em;height:1.7em' id="pgmairingend<%= therownnum %>" NAME=pgmairingend<%= therownnum %> value='<%=pgmairingend%>' ></td>
                   
                   
                   
                   <td width='10%' align='center'>
                   
                   
                        <select name='pgmreplayday<%= therownnum %>'  style='font-size:12pt;color:#000000;font-weight:bold;width:8em;height:1.7em'  >
							

							<%
							if(pgmreplayday.equalsIgnoreCase("NOREPLAY"))
							{
							%>
								<option selected value='NOREPLAY'>·« «⁄«œÂ</option>
							<%
							}
							else
							{
							%>
								<option  value='NOREPLAY'>·« «⁄«œÂ</option>
							<%
							}
							%>
							

							 
							<%
							if(pgmreplayday.equalsIgnoreCase("ALL"))
							{
							%>
								<option selected value='ALL'>ÌÊ„Ì«</option>
							<%
							}
							else
							{
							%>
								<option  value='ALL'>ÌÊ„Ì«</option>
							<%
							}
							%>
							


							<%
							if(pgmreplayday.equalsIgnoreCase("SUNDAY"))
							{
							%>
								<option selected value='SUNDAY'>«·«Õœ</option>
							<%
							}
							else
							{
							%>
								<option  value='SUNDAY'>«·«Õœ</option>
							<%
							}
							%>




							<%
							if(pgmreplayday.equalsIgnoreCase("MONDAY"))
							{
							%>
								<option selected value='MONDAY'>«·«À‰Ì‰</option>
							<%
							}
							else
							{
							%>
								<option  value='MONDAY'>«·«À‰Ì‰</option>
							<%
							}
							%>




							<%
							if(pgmreplayday.equalsIgnoreCase("TUESDAY"))
							{
							%>
								<option selected value='TUESDAY'>«·À·«À«¡</option>
							<%
							}
							else
							{
							%>
								<option  value='TUESDAY'>«·À·«À«¡</option>
							<%
							}
							%>




							<%
							if(pgmreplayday.equalsIgnoreCase("WEDNESDAY"))
							{
							%>
								<option selected value='WEDNESDAY'>«·«—»⁄«¡</option>
							<%
							}
							else
							{
							%>
								<option  value='WEDNESDAY'>«·«—»⁄«¡</option>
							<%
							}
							%>



							<%
							if(pgmreplayday.equalsIgnoreCase("THURSDAY"))
							{
							%>
								<option selected value='THURSDAY'>«·Œ„Ì”</option>
							<%
							}
							else
							{
							%>
								<option  value='THURSDAY'>«·Œ„Ì”</option>
							<%
							}
							%>




							<%
							if(pgmreplayday.equalsIgnoreCase("FRIDAY"))
							{
							%>
								<option selected value='FRIDAY'>«·Ã„⁄Â</option>
							<%
							}
							else
							{
							%>
								<option  value='FRIDAY'>«·Ã„⁄Â</option>
							<%
							}
							%>




							<%
							if(pgmreplayday.equalsIgnoreCase("SATURDAY"))
							{
							%>
								<option selected value='SATURDAY'>«·”» </option>
							<%
							}
							else
							{
							%>
								<option  value='SATURDAY'>«·”» </option>
							<%
							}
							%>





							
							
							
						</select>
							

                   
                   

                   				
                   				
                   				
                   </td>
                   



                   
                   
                   
                   <td width='10%' align='center'><INPUT dir='ltr' style='font-size:12pt;color:#000000;font-weight:bold;width:8em;height:1.7em' id="pgmreplaystart<%= therownnum %>" NAME=pgmreplaystart<%= therownnum %> value=<%=pgmreplaystart%> ></td>                          
                   <td width='10%' align='center'><INPUT dir='ltr' style='font-size:12pt;color:#000000;font-weight:bold;width:8em;height:1.7em' id="pgmreplayend<%= therownnum %>" NAME=pgmreplayend<%= therownnum %> value=<%=pgmreplayend%> ></td>                          
                   <td width='10%' align='center'><INPUT dir='ltr' style='font-size:12pt;color:#000000;font-weight:bold;width:8em;height:1.7em' id="theusr<%= therownnum %>" NAME=theusr<%= therownnum %> value=<%=theusr%> ></td>                          
                   <td width='10%' align='center'><INPUT dir='ltr' style='font-size:12pt;color:#000000;font-weight:bold;width:8em;height:1.7em' id="thepass<%= therownnum %>" NAME=thepass<%= therownnum %> value=<%=thepass%> ></td>                          
                                      
                                      
                                      
 
           
                                                
                    
 </tr>
 



<%
therownnum = therownnum + 1;

}

rs.close();rs=null;



%>

  


</form>  
 </table>






























































<br>






</BODY>
</HTML>
























<%
con.close();  
}
%>
