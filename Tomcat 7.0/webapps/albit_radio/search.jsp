<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*,java.util.regex.*" %>






<%!

public String replaceWord(String inputStr,String patternStr,String replacementStr) throws Exception{return Pattern.compile(patternStr).matcher(inputStr).replaceAll(replacementStr);}
public String getReadable(String theUnicode,String thelang)
 {
   if( thelang.equalsIgnoreCase("0") ){return theUnicode;}
   
   if(theUnicode.length() < 4){return "";}
   try 
    {
     byte[] by = new byte[theUnicode.length()/2];
     for(int i=0;i<theUnicode.length()/2;i++)
     by[i] = (new Integer(Integer.parseInt(theUnicode.substring(i*2,i*2 + 2),16))).byteValue();
     String theReadable = new String(by,"UTF-16");
     return theReadable;
    }catch(Exception e){return "";}

 }







            
%>



<%

String pgmid;try{ pgmid =  session.getAttribute("pgmid").toString();}catch(Exception e){pgmid=null;}
String username;try{ username =  session.getAttribute("username").toString();}catch(Exception e){username=null;}
String password;try{password =  session.getAttribute("password").toString();}catch(Exception e){password=null;}

if( pgmid.equalsIgnoreCase("admin")  ) //admin login
{








  Connection con=null;
  InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();
  ResultSet rs = null;



String theSdate =(new SimpleDateFormat("yyyy-MM-dd")).format(new java.util.Date((new java.util.Date()).getTime())).trim();
String theEdate =(new SimpleDateFormat("yyyy-MM-dd")).format(new java.util.Date( (new java.util.Date()).getTime())).trim();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Calendar c = Calendar.getInstance();
c.setTime(sdf.parse(theEdate));
c.add(Calendar.DATE, 1);  // number of days to add
theEdate = sdf.format(c.getTime());




String stime = "00:00:01";try{stime = request.getParameter("stime").trim();}catch(Exception e){stime = "00:00:01";}
String etime = "00:00:01";try{etime = request.getParameter("etime").trim();}catch(Exception e){etime = "23:59:59";}



String fdate = "";try{fdate = request.getParameter("fdate").trim();}catch(Exception e){fdate = theSdate;}
String tdate = "";try{tdate = request.getParameter("tdate").trim();}catch(Exception e){tdate = theEdate;}




String messagetatus = "ALL";try{messagetatus = request.getParameter("messagetatus").trim();}catch(Exception e){messagetatus = "ALL";}

String searchword = "";try{searchword = request.getParameter("searchword").trim();}catch(Exception e){searchword = "";}
String searchby= "1"; try{searchby = request.getParameter("searchby").trim();}catch(Exception e){searchby = "1";}

String searchorder = "1"; try{searchorder = request.getParameter("searchorder").trim();}catch(Exception e){searchorder = "1";}



String pgms = "ALLPGMS";try{pgms =  request.getParameter("pgms").trim();    }catch(Exception e){pgms = "ALLPGMS";}



String pgmtomodify = "0";try{pgmtomodify =  request.getParameter("pgmtomodify").trim();    }catch(Exception e){pgmtomodify = "0";}





 

String operators = "ALL";try{operators = request.getParameter("operators").trim();}catch(Exception e){operators = "ALL";}



String thequery="";
thequery = " select albit_cdrs.ID,  DATE_FORMAT(datein, '%Y-%m-%d %H:%i:%S' ) as thedatein , readtime, shortcode, msisdn, readable ,  albit_pgms.id , albit_pgms.pgm_name , providers.name , albit_cdrs.Status" +
 		   " from sms.albit_cdrs LEFT JOIN sms.albit_pgms ON albit_pgms.id=albit_cdrs.pgmid LEFT JOIN sms.providers ON albit_cdrs.provider = providers.gateway " +
		   " where (datein between '" + fdate + " " + stime + "' and '" + tdate + " " + etime + "')" ;


if(searchby.equalsIgnoreCase("1")){thequery= thequery + " and albit_cdrs.readable like N'%" + (new String(searchword.getBytes("Cp1252"),"Cp1256")) + "%' ";}
if(searchby.equalsIgnoreCase("2")){thequery= thequery + " and albit_cdrs.msisdn like N'%" + (new String(searchword.getBytes("Cp1252"),"Cp1256")) + "%' ";}


if(!pgms.equalsIgnoreCase("ALLPGMS"))
{

	if(pgms.equalsIgnoreCase("NOPGM"))
	{
		thequery= thequery + " and albit_cdrs.pgmid ='0' ";
	}
	else
	{
		thequery= thequery + " and albit_pgms.pgm_name like N'%" + (new String(pgms.getBytes("Cp1252"),"Cp1256")) + "%' ";
	}
	
}






if(!operators.equalsIgnoreCase("ALL"))
{
		thequery= thequery + " and providers.name like N'%" + (new String(operators.getBytes("Cp1252"),"Cp1256")) + "%' ";
}



if(!messagetatus.equalsIgnoreCase("ALL"))
{
		if(messagetatus.equalsIgnoreCase("0")){	thequery= thequery + "  and albit_cdrs.Status = 0 "; }
		if(messagetatus.equalsIgnoreCase("1")){ thequery= thequery + "  and albit_cdrs.Status = 1 "; }
	
}







if(searchorder.equalsIgnoreCase("1")){thequery= thequery + " order by albit_cdrs.ID  asc";}
if(searchorder.equalsIgnoreCase("2")){thequery= thequery + " order by albit_cdrs.ID  desc";}

 






//out.println(thequery);







int THECOUNT = 0 ;
   rs = null;
   rs = con.createStatement().executeQuery(thequery); 
while(rs.next())
{
THECOUNT = THECOUNT + 1;

}
rs.close();rs=null;   




//out.println(thequery);  
%>



<html dir=rtl>

<head>


<STYLE type=text/css>

body{font-size:62.5%;}

</style>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">



<link rel="stylesheet" href="../jquery-ui-1.10.2/themes/base/jquery-ui.css">
<script src="../jquery-ui-1.10.2/jquery-1.9.1.js"></script>
<script src="../jquery-ui-1.10.2/ui/jquery-ui.js"></script>



  <script type="text/javascript" src="../jquery-ui-1.10.2/ui/jquery.timepicker.js"></script>
  <link rel="stylesheet" type="text/css" href="../jquery-ui-1.10.2/ui/jquery.timepicker.css" />



  <script type="text/javascript" src="../jquery-ui-1.10.2/ui/site.js"></script>
  <!-- <link rel="stylesheet" type="text/css" href="../jquery-ui-1.10.2/ui/site.css" /> -->
  
  
  
  
<script>
  $(function() 
  {
    $( "#fdate" ).datepicker({ dateFormat: 'yy-mm-dd' });
    $( "#tdate" ).datepicker({ dateFormat: 'yy-mm-dd' });
  });
  </script>
  
  

            <script>
                $(function() {
                    $('#stime').timepicker({ 'timeFormat': 'H:i:s'  , 'step': 1 });
                    $('#etime').timepicker({ 'timeFormat': 'H:i:s'  , 'step': 1 });
                });
            </script>
            


<script>


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



function correctinvoke(target)
{
	if(target == 0) {document.mainform.action="BATCHPgmModify.jsp";document.mainform.submit();}

}


</script>              



<%


   
    int pgm_CNT=0;
    rs = con.createStatement().executeQuery("SELECT count(*) FROM sms.albit_pgms");
    while(rs.next()){pgm_CNT=rs.getInt(1);}rs.close(); rs = null;
    
     String[] the_pgm_id = new String[pgm_CNT];
     String[] the_pgm_name = new String[pgm_CNT];
     
       int cc = 0;
       rs = con.createStatement().executeQuery("SELECT id,pgm_name FROM sms.albit_pgms");            
       while(rs.next())
       {
         the_pgm_id[cc] = rs.getString(1);
         the_pgm_name[cc] = rs.getString(2);
         
         

     	 cc = cc + 1 ;
       }
       rs.close(); rs = null;
        


%>


<title>«·»ÕÀ ... National Radio</title>


</head>

<body>



 

            
          
            
            <table border='1' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%' height='80'>
              <tr>
                <td width='21%' align='center'><b><i><font color='#A36103' size='6'>«·»ÕÀ</font></i></b></td>


                <td width='30%' align='center'>
                <table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%'>
                  <tr><td width='100%' align='center'><font color='#000000' face='Arial' size='4'><b>&nbsp;</b></font></td></tr>
     				 <tr><td width='100%' align='center'><font color='#000000' face='Arial' size='4'><b> &nbsp;</b></font></td></tr>
				      <tr><td width='100%' align='center'><font color='#000000' face='Arial' size='4'><b>&nbsp;</b></font></td></tr>
                </table>
                </td>
                <td width='19%' align='center'>
                	<table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%'>
                	
                	<form action='AdminMainPage.jsp' method='post'>
               		<tr>
                			<td align='center'><input type='submit' name='subMain' value='«·ﬁ«∆„… «·—∆Ì”Ì…' STYLE='font-weight:bold;font-family:arial;font-size:18;color:#00f;width:12em;height:2.5em'></td></tr>
                			</form>
            		
            		<form action='search.jsp' method='post'>
              		<tr>
              			<td align='center'><input type='submit' name='subRefresh' value='«⁄«œ…  Õ„Ì·' STYLE='font-weight:bold;font-family:arial;font-size:18;color:#00f;width:12em;height:2.5em'></td>
              		</tr>
                        </form> 
                	</table>
                	
                </td>
<td bgcolor='#ffffff' width='15%' align='center'><IMG src='logo.png'></td>
              </tr>
            </table>

<br>
			<br>
			
			
			
			
			
			
			<table border='1' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#DCDCDC' width='90%'>
			  <tr height='30'>





















			    
			    
			    
			  </tr>
			</table>
			
			
			

			
			
			
			<table border='1' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#DCDCDC' width='90%'>
			
	<form method="post">			
			
			 <tr>
			 
			 
			 <td width='30%' colspan=2 align='center' >
			 
			 
			 <table border='1' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#DCDCDC' width='100%'>
			  <tr height=30>
			  








			    <td  align='center'>

					 <table dir='ltr' border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#DCDCDC' width='100%'>
					 
					 
					  <tr>
				      		<td colspan=2 align='center'><font color='#000000' face='Arial' size='3'> «—ÌŒ „‰</font></td>
				      </tr>
				      
				      
					  <tr>
					  
					  
					   	<td>
							<input dir='ltr' type="text"  name="fdate" id="fdate" value='<%=fdate%>'   style='width:7em;height:1.5em' >
		                </td> 
		                
		                <td>
		                
		               	   <input dir='ltr' type="text"  name="stime" id="stime"   value='<%=stime%>' style='width:7em;height:1.5em' >
		                </td>
		                
					   </tr>
		
		              </table>
            
              </td>




		    <td align='center'>

					 <table dir='ltr' border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#DCDCDC' width='100%'>
					 
					 
					  <tr>
				      		<td colspan=2 align='center'><font color='#000000' face='Arial' size='3'> «—ÌŒ «·Ì</font></td>
				      </tr>
				      
				      
					  <tr>
					  
					  
					   	<td>
							<input dir='ltr' type="text"  name="tdate" id="tdate" value='<%=tdate%>'   style='width:7em;height:1.5em' >
		                </td> 
		                
		                <td>
		                
		               	   <input dir='ltr' type="text"  name="etime" id="etime"   value='<%=etime%>' style='width:7em;height:1.5em' >
		                </td>
		                
					   </tr>
		
		                </table>
            
              </td>
              
              
           </tr>
           </table>   
              
              










			    <td width='15%' align='center'>

					 <table  border='1' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#DCDCDC' width='100%'>
					 


					  <tr>
				      		
				      		
				      		
				      		
				      		

<td width='10%' align='center'>
<%
if(searchby.equalsIgnoreCase("1"))
{
%>
 <input type='radio' checked  name='searchby' value='1'><font size='3'>«·—”«·Â</font>
<%
}
else
{
%>
 <input type='radio'name='searchby' value='1'><font size='3'>«·—”«·Â</font>
<%
}
%>

</td>




<td width='10%' align='center'>

<%
if(searchby.equalsIgnoreCase("2"))
{
%>
 <input type='radio' checked  name='searchby' value='2'><font size='3'>«· ·Ì›Ê‰</font>
<%
}
else
{
%>
 <input type='radio'  name='searchby' value='2'><font size='3'>«· ·Ì›Ê‰</font>
<%
}
%>


</td>

				      		
				      		
				      </tr>

					 
					  <tr>



<td colspan=2 width='20%' align='center'>
 <input type='text' name='searchword' value='<%=(new String(searchword.getBytes("Cp1252"),"Cp1256"))%>' style='width:10em;height:1.6em'>
</td>



 </tr>


</table>







			      <td  width='15%' align='center'>

<select name='pgms' style='font-weight:bold;width:9em;height:1.6em'>

<%
  if(pgms.equalsIgnoreCase("ALLPGMS"))
{
%> 
	<option value='ALLPGMS' selected>«·ﬂ·</option>
<%
}
else
{
%>
	<option value='ALLPGMS' >«·ﬂ·</option>
<%
}  	        
%>



<%
  if(pgms.equalsIgnoreCase("NOPGM"))
{
%> 
	<option value='NOPGM' selected>·« »—‰«„Ã</option>
<%
}
else
{
%>
	<option value='NOPGM' >·« »—‰«„Ã</option>
<%
}  	        
%>








<% 
   rs = con.createStatement().executeQuery("select pgm_name from sms.albit_pgms order by id");             
while(rs.next())
  {
	String temppgm=  rs.getString(1);
	
	
  if((new String(pgms.getBytes("Cp1252"),"Cp1256")).equalsIgnoreCase(temppgm))
{
%> 
	<option selected><%= temppgm %></option>
<%
}
else
{
%>
	<option ><%= temppgm %></option>
<%
}  	        
}rs.close();rs=null;
%>

</select>

</td>



















			      <td  width='15%' align='center'>

<select name='operators' style='font-weight:bold;width:9em;height:1.6em'>

<%
  if(operators.equalsIgnoreCase("ALL"))
{
%> 
	<option value='ALL' selected>ﬂ· «·‘—ﬂ« </option>
<%
}
else
{
%>
	<option value='ALL' >ﬂ· «·‘—ﬂ« </option>
<%
}  	        
%>




<% 
   rs = con.createStatement().executeQuery("select name from sms.providers order by prov_id");             
while(rs.next())
  {
	String tempop=  rs.getString(1);
  if(operators.equalsIgnoreCase(tempop))
{
%> 
	<option selected><%= tempop %></option>
<%
}
else
{
%>
	<option ><%= tempop %></option>
<%
}  	        
}rs.close();rs=null;
%>

</select>

</td>











                         
                         
                         









<td width='15%' align='center'>

<select name='messagetatus' style='font-weight:bold;width:9em;height:1.6em'>

<option value='ALL'>ﬂ· «·—”«∆·</option>


<%
if(messagetatus.equalsIgnoreCase("0"))
{
%>
<option selected value='0'>—”«∆· „ﬁ—Ê¡Â</option>
<%
}
else
{
%>
<option value='0'>—”«∆· „ﬁ—Ê¡Â</option>
<%
}
%>



<%
if(messagetatus.equalsIgnoreCase("1"))
{
%>
<option selected value='1'>—”«∆· €Ì— „ﬁ—Ê¡Â</option>
<%
}
else
{
%>
<option value='1'>—”«∆· €Ì— „ﬁ—Ê¡Â</option>
<%
}
%>


</select>
</td>










			      <td  width='15%' align='center'>

<select name='searchorder' style='font-weight:bold;width:6em;height:1.6em'>

<%
  if(searchorder.equalsIgnoreCase("1"))
{
%> 
	<option value='1' selected> ’«⁄œÌ</option>
<%
}
else
{
%>
	<option value='1' > ’«⁄œÌ</option>
<%
}  	        
%>





<%
  if(searchorder.equalsIgnoreCase("2"))
{
%> 
	<option value='2' selected> ‰«“·Ì</option>
<%
}
else
{
%>
	<option value='2' > ‰«“·Ì</option>
<%
}  	        
%>







</select>

</td>














			    <td width='15%' align='center'>
			    		<input type='submit' name='Searchbutton' value='»ÕÀ' style='font-weight:bold;width:5em;height:2em'>
			    </td>


			  </tr>
			  
			 </table>

			 </td>
			 
			 </tr>
			 
</form>
			 
			</table>
			
			
			
			



			
			<br>	
			<br>
	
<form name=mainform method=post action="" >
			 
			 <table border='1' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#cccccc' width='98%'>
			 
			 
                  <tr height=30 bgcolor=#DCDCDC>
                    
                    <td width='45%' align='center'>
                    
                    	<table border='1' align='right' cellpadding='0' cellspacing='0' width='80%>
                    	
                    	   <tr width='100%'>
                    	   
                    	   		<td colspan=3 width='100%' align='center'>  ÕÊÌ· »—«„Ã </td> 
                    	   </tr>
                    	   
                    	   <tr width='100%'>
                    	   
                    	   		
                    	   		
	                    	   	<td width='25%' align='center'>
	                    	   		<input type='button' value='«·ﬂ·' style='font-weight:bold ; width:5em ; height:2em' onClick="selectall(<%= THECOUNT %>)"></td>		
                    	   	
                    	   		<td width='25%' align='center'>
                    	   			<select name='pgmtomodify' style='font-weight:bold;width:9em;height:1.8em' >
                    	   			
										 <option value=0 >·« »—‰«„Ã</option>


										<% 
										for (int l =0  ; l < the_pgm_id.length ; l ++)
										{
										  if (the_pgm_id[l].equalsIgnoreCase(pgmtomodify)) 
										  {
										  
										%>       	        
										    	        <option value='<%= the_pgm_id[l] %>' selected><%= the_pgm_name[l] %></option>
										<%
										  }
										  else
										  {
										%>       	        
										    	        <option value='<%= the_pgm_id[l] %>'><%= the_pgm_name[l] %></option>
										<%
										  }    	        
										}
										%> 
	



											
											
                                	</select> 
                                </td>
                                
                                
                                <td width='25%' align='center'>
                                		<input type='submit' value=' ÕÊÌ·' style='font-weight:bold ; color:#000000; width:7em ; height:2em' onClick="correctinvoke(0)">
                               	</td>
                                	
                    	   		    
                    	   
                    	   </tr>
                    	
                    	</table>
                    
                    
                    		
                    		
                    		
                    </td>    
                    
                    
                     
 			        <td width='45%' align='center'><b>&nbsp;</b></td>     
 			        <td width='10%' align='center'><b>«·⁄œœ</b>&nbsp;&nbsp;&nbsp;<font color=#000099><b><%= THECOUNT %></b></font></td>               
 			        
                  </tr>
             </table>
			 
			 

<%
int cntr =0 ;
%>




<INPUT style="display: none;" NAME=count value="<%= THECOUNT %>" > 

			 
      					<table border='1' align='center' cellpadding='0' cellspacing='1' style='border-collapse: collapse' bordercolor='#cccccc' width='100%'>
      					  <tr bgcolor=#DCDCDC>
      					  	<td width='1%' align='center'>&nbsp;</td> 
      					    <td width='40%' rowspan=2 align='center'><b>‰’ «·—”«·Â</b></td>
      					    <td width='10%' rowspan=2 align='center'><b>—ﬁ„  ·Ì›Ê‰</b></td>
      					    <td width='10%' rowspan=2 align='center'><b>«·—ﬁ„ «·„Œ ’—</b></td>
      					    <td width='10%' rowspan=2 align='center'><b>»—‰«„Ã</b></td>      					          					    
      					    <td width='10%' rowspan=2 align='center'><b>„’œ—</b></td>      					    
      					    <td width='10%' rowspan=2 align='center'><b>Êﬁ  «·œŒÊ·</b></td>
      					    <td width='10%' rowspan=2 align='center'><b>Êﬁ  «·ﬁ—«¡Â</b></td>      					    
  					    
      					  </tr>

      					  <tr bgcolor=#DCDCDC>
   					          					          					          					    
      					  </tr>






<%

   rs = null;
   rs = con.createStatement().executeQuery(thequery);  
while(rs.next())
{
int theid = rs.getInt(1);
String thedatein = rs.getString(2);
String thereadtime = rs.getString(3);
String theshortcode = rs.getString(4);
String themsisdn = rs.getString(5);
String themsg = rs.getString(6);
String theprogramid = rs.getString(7);
String theprogramname = rs.getString(8);
String theoperator = rs.getString(9);
String thestatus = rs.getString(10);

      
   




%>


<%
if(theid%2 ==0)
{
%>
          <tr bgcolor=#fDfDfD height='25'>
<%
}
else
{
%>
          <tr bgcolor=#f5f5f5 height='25'>
<%
}
%>


 			<INPUT style="display: none;" NAME=id<%= cntr %> value="<%= theid %>" > 

			<td width='1%'  align='center'>  <INPUT id="ischeck<%= cntr %>" NAME=ischeck<%= cntr %> TYPE=CHECKBOX >  </td>
			
			
			<td width='40%' align='center'><%=themsg%></td>
    	    <td width='10%' align='center'><font color=#000000 size=3 dir='ltr' ><%= themsisdn %></font></td>
	  	    <td width='10%' align='center'><font color=#000000 size=3 dir='ltr' ><%= theshortcode %></font></td>
	  	    
	  	    <td width='10%' align='center'><font color=#000000 size=3 dir='ltr' ><%= theprogramname %></font></td>
	  	    <td width='10%' align='center'><font color=#000000 size=3 dir='ltr' ><%= theoperator %></font></td>
	  	    
      	    <td width='10%' align='center'><font color=#000000 size=2 dir='ltr' ><%= thedatein %></font></td>
      	    <td width='10%' align='center'><font color=#000000 size=2 dir='ltr' ><%= thereadtime %></font></td>      					    

      					    

      					    

</tr>
<%
cntr = cntr +1 ;

}

rs.close();rs=null;
%>





















</table>





</form>






<br>





</html>











<%

con.close();

}

else
{

	session.invalidate();
	response.sendRedirect("login.jsp");

}


%>


