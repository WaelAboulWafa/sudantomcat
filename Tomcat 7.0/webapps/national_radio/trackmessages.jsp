<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*,java.util.regex.*" %>





<%


String pgmid;try{ pgmid =  session.getAttribute("pgmid").toString();}catch(Exception e){pgmid=null;}
String username;try{ username =  session.getAttribute("username").toString();}catch(Exception e){username=null;}
String password;try{password =  session.getAttribute("password").toString();}catch(Exception e){password=null;}



if( pgmid==null) //user not logged in
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

  

String resultorder = "desc";try{resultorder =  request.getParameter("resultorder").trim();    }catch(Exception e){resultorder = "desc";}






int offset=0;

if(request.getParameter("offset")!=null) 
{
 offset= Integer.parseInt(request.getParameter("offset").toString());
}

int pagesize = 50;
int count= 0;
int pages = 0;
int lowerbound = 0;
int upperbound = 0;






















  int reccount = 0;
     String[] id = null;
     String[] sentdate =  null;
     String[] shortcode = null;      
     String[] tel = null;
     String[] bodyformat = null;       
     String[] msg = null;     


      
     int visiblecount = 0 ;

    






String query1 = "SELECT count(*) from sms.nradio_cdrs where pgmid='" + pgmid + "' and status=0 ";
String query2 = "SELECT ID from sms.nradio_cdrs where pgmid='" + pgmid + "' and status=0 order by ID " + resultorder ;
String query3 = "Select ID, datein, shortcode, msisdn, lang, readable from sms.nradio_cdrs where pgmid='" + pgmid + "' and status=0 order by ID " + resultorder;

String filtershortcode = "ALL";

      rs = con.createStatement().executeQuery(query1);            
      if(rs.next())
      {
     	 reccount = rs.getInt(1);
      }
        rs.close(); rs = null;
   
  
    count =  reccount;
  
       
       rs = con.createStatement().executeQuery(query2);            
       while(rs.next())
       {
     	 String tmp = rs.getString(1);
     	 visiblecount = visiblecount + 1 ;
       }
        rs.close(); rs = null;
        
   
   rs = null;
   rs = con.createStatement().executeQuery(query3);

   
     id = new String[visiblecount];
     tel = new String[visiblecount];
     shortcode = new String[visiblecount];
     msg = new String[visiblecount];
     bodyformat = new String[visiblecount];
     sentdate =  new String[visiblecount];
     
   
     int theCounter = 0;
   while(rs.next())
    {
     id[theCounter] = rs.getString(1).trim();
     sentdate[theCounter] =  rs.getString(2).trim();     
     shortcode[theCounter] = rs.getString(3).trim();          
     tel[theCounter] = rs.getString(4).trim();     
     bodyformat[theCounter] = rs.getString(5).trim(); 
     msg[theCounter] = rs.getString(6).trim(); 

    theCounter = theCounter + 1 ;
   }
   rs.close(); 
   rs = null;
   
   
   
   

   
   

           String pgm_name = "„‰«”»«  ÿÊ«—∆";
		   rs = con.createStatement().executeQuery("SELECT pgm_name from sms.nradio_pgms where id= '" + pgmid + "'");
		   while(rs.next()){pgm_name = rs.getString(1); }rs.close(); rs = null;
	
	
		   

         














   if(count != 0 ) 
   {
     if(count%pagesize ==0)
      {
        pages = (count/pagesize);
      }
      else
      {  
        pages = (count/pagesize) + 1  ;
     }
   }
 
if(count != 0 )
{
if(pages == 1)
{
lowerbound = 0;
upperbound = count;
}
else
{

if( ( (offset) * pagesize) <= count)
{
 lowerbound = (offset * pagesize) ;

 if(   ((offset+1) * pagesize) > count )
  {
   upperbound = count;
  }
  else
  {
   upperbound = ( (offset+1) * pagesize);
  }
}
else
{
lowerbound = 0;
upperbound = 0;

}  
}  
  
 
}






   
   
    


   

   

             
%>



































<html dir='rtl'>
<HEAD>


<script LANGUAGE="JavaScript" type="text/javascript">


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
if(target == 0) {document.mainform.action="BATCHApprove.jsp";document.mainform.submit();}
if(target == 1) {document.mainform.action="BATCHReject.jsp";document.mainform.submit();}
if(target == 2) {document.mainform.action="BATCHWaiting.jsp";document.mainform.submit();}
if(target == 3) {document.mainform.action="BATCHApproveBoxANDBAR.jsp";document.mainform.submit();}




}
 


 




</script>





























<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt arial, geneva, lucida, "lucida grande", arial, helvetica, sans-serif; COLOR: #000000 } Table {font:12pt } </style>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<title>«·—”«∆· ... National Radio</title>

</head>


<BODY>





<table border='1' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%' height='80'>
  <tr>
    <td width='21%' align='center'><b><i><font color='#A36103' size='6'>«·—”«∆·</font></i></b></td>
    

                
                
    
    <td width='30%' align='center'>
    <table border='1' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%'>
    
      <tr height='50'>
          <td width='100%' align='center'><font size='5' Color=black><a href="ftp://<%=username %>:<%=password %>@196.29.186.246"><b> ’›Õ «· ”ÃÌ·« </b></a></font></td>
      </tr> 
      
          
      <tr height='50'>
      		<td width='100%' align='center'><font color='#BB0000' face='Arial' size='6'><b><%=pgm_name%></b></font></td>
      </tr>
      
   

    </table>
    </td>
    <td width='24%' align='center'>
    	<table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%'>
 		<form action='login_logout.jsp' method='post'>                
     		 <tr><td align='center'><input type='submit' name='subMain' value='Œ—ÊÃ' STYLE='font-weight:bold;font-family:arial;font-size:18;color:#00f;width:12em;height:2.5em'></td></tr>
                </form>
 		<form name='theform' action='trackmessages.jsp' method='post'>
     		<tr><td align='center'><input type='submit' name='subRefresh' value='«⁄«œ…  Õ„Ì·' STYLE='font-weight:bold;font-family:arial;font-size:18;color:#00f;width:12em;height:2.5em'></td></tr>
               </form>
               
    	</table>
    </td>
<td bgcolor='#ffffff' width='15%' align='center'><IMG src='logo.png'></td>
  </tr>
</table>




<br>







  









               


            <br>







            <table border='1' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='96%'>
                  <tr height='30'>
                    <td align='center' width='4%'>
<%
if(pages>0)
{
  for(int i=0;i<pages;i++)
  {
   if(i==offset)
    {
%>
                     <b><%= (offset +1)%></b>
<%
    }
    else
   {
%>
                  <b><a href=trackmessages.jsp?resultorder=<%=resultorder%>&offset=<%= i %>&filtertheshortcode=<%= URLEncoder.encode(filtershortcode)%> ><%= Integer.toString(i+1) %> </a>&nbsp;</b>
<%
   }
   
  }
}
%>
                    </td>
                  </tr>
            </table>

            <br>









            <table border='1' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='98%'>
                  <tr>
                        <td>
                              <table border='0' align='center' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
                                    <tr>
                                          <td width='5%' align='center'>
                                                <table border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
                                                      <input type='hidden' name='uid' value='41'>
                                                      <input type='hidden' name='cur_page' value='1'>
                                                      <input type='hidden' name='selc' value=''>
                                                      <tr><td align='center'><input type='submit' name='subSelectAll' value='«·ﬂ·' style='font-weight:bold ; width:8em ; height:2em' onClick="selectall(<%= reccount %>)"></td></tr>
                                                </table>
                                          </td>
                                          <td width='5%' align='center'>&nbsp;</td>
                                          <td width='10%' align='right'><input type='submit' name='subApproveSMSSel' value='ﬁ—«¡Â' style='font-weight:bold ; color:#0000FF; width:8em ; height:2em' onClick="correctinvoke(0)"></td>

                                          <td width='25%' align='center'>
                                          
                                          
                                                <table border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
                                                      <tr align="center" >
                                                       <td align='center' >




			
                                                       </td>
                                                      </tr>
                                                </table>
                                                
                                                
                                          </td>
                                          <td width='15%' align='center'>
                                                <table border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
                                                      <tr>
                                                            <td align='center'><b>⁄œœ</b></td>
                                                            <td align='left'><font color=#000099><b><%= reccount %></b></font></td>
                                                      </tr>
                                                </table>
                                          </td>
                                          <td width='10%' align='center'>
                                          	<table border='0' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#111111' width='100%'>
                                                      <tr>
                                                            <td align='center'><b>’›Õ…</b></td>
                                                            <td align='left'><font color=#000099><b><%= (offset +1)%>&nbsp/&nbsp;<%= pages %></b></font></td>
                                                      </tr>
                                          	</table>
                                          </td>
                                    </tr>
                              </table>
                        </td>
                  </tr>
            </table>

   
















            
            
            
            
            
            <br>


















<form name=mainform method=post action="" >


     <table  border='1' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#cccccc' width='98%'>
     
     
     
     
     <tr bgcolor=#DCDCDC>
	<td colspan=5>
	

													<select name='resultorder' style='font-weight:bold;width:10em;height:2.0em; color:#000000'  onChange='javascript:document.mainform.submit();'>
													
													<% 
													  if (resultorder.equalsIgnoreCase("asc")) 
													  {
													  
													%>       	        
													    	        <option value ='asc' selected> — Ì»  ’«⁄œÌ</option>
													<%
													  }
													  else
													  {
													%>       	        
													    	        <option value ='asc' > — Ì»  ’«⁄œÌ</option>
													<%
													  }    	        
													%> 
													
													
													<% 
													  if (resultorder.equalsIgnoreCase("desc")) 
													  {
													  
													%>       	        
													    	        <option value ='desc' selected> — Ì»  ‰«“·Ì</option>
													<%
													  }
													  else
													  {
													%>       	        
													    	        <option value ='desc' > — Ì»  ‰«“·Ì</option>
													<%
													  }    	        
													%> 
													
													
													</select>	
	
	
	</td>
</tr>

     
     
     
     
     
             <tr bgcolor=#DCDCDC>
                  <td width='5%' align='center'><b>&nbsp;</b></td>

             
                  <td width='60%' align='center'><b>‰’ «·—”«·Â</b></td>
                  <td width='11%' align='center'><b> «—ÌŒ «·«—”«·</b></td>
                  <td width='10%' align='center'><b> ·Ì›Ê‰</b></td>
                  <td width='9%'  align='center'><b>„’œ— «·Œœ„…</b></td>
                  
              
            </tr>
     




	

<INPUT style="display: none;" NAME=theoffset SIZE=10  value="<%= lowerbound %>" > 
<INPUT style="display: none;" NAME=countrysc SIZE=10  value="<%= filtershortcode %>" > 
<INPUT style="display: none;" NAME=thebase SIZE=10  value="<%= offset %>" > 

<INPUT style="display: none;" NAME=count SIZE=10  value="<%= reccount %>" > 

<% for (int l =lowerbound ; l < upperbound ; l ++)
{

%>

<tr bgcolor=#FFFFFF>

 
          

         



  
            <td align='center'>  <INPUT id="ischeck<%= l %>" NAME=ischeck<%= l %> TYPE=CHECKBOX >  </td>
    	     <INPUT type='hidden' NAME=id<%= l %> SIZE=6  READONLY value="<%= id[l] %>" >
 
 <td align='center'><b><font color=#000099 size=5><%=  msg[l] %></font></b></td>
 
    	    <td align='center'> <b><font color=#000000 size=4>  <%= sentdate[l] %> </td></font></b></td>

<INPUT type='hidden' NAME=msg<%= l %> SIZE=17  READONLY value="<%= msg[l] %>" >




    	    
 <INPUT type='hidden' NAME=tel<%= l %> SIZE=17  READONLY value="<%= tel[l] %>" >


 	       <td align='center'><b><font color=#000000 size=4 dir='ltr'><%= tel[l] %></font></b></td>





    	    <td align='center'> <b><font color=#000000 size=4  dir='ltr'>  <%= shortcode[l] %> </font></b></td>    	       	    

    	           
    	    
    	    	    


   	        	    





           </tr>            
<%
}
%>


 </table>



</form>















<br>


</BODY>
</HTML>
























<%
con.close();   
}

%>

