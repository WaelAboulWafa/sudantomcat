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
response.sendRedirect("jbgcjk.jsp");
}

else
{

  /////get user authorities/////////////
  Connection con=null;
  InitialContext ic = new InitialContext();
  DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
  con  = ds.getConnection();
  ResultSet rs = null;
  int userid= 0;
  int phoneallowed = 0;
  try
  {
   rs = con.createStatement().executeQuery("SELECT userID,phone from fitservice.nationaltv_pgm_Users where username=N'" + username.replaceAll("'", "''") + "' and password=N'" + password.replaceAll("'", "''") + "'");             
   userid = 0;
   while(rs.next()){userid = rs.getInt(1);phoneallowed=rs.getInt(2);}
   rs.close();rs = null;
  }catch(Exception e){out.println(e.toString());}
  
  

//out.println(userid);


  int reccount1 = 0 ;
  rs = null;
  try
  {
   rs = con.createStatement().executeQuery("SELECT count(*) from fitservice.nationaltv_pgm_UsersAuthorities where userID=" + userid);             
   while(rs.next()){reccount1 = rs.getInt(1);} 
   rs.close();rs = null;
  }catch(Exception e){}
  
  
  String[] thepage = new String[reccount1];
  int[] allowed = new int[reccount1];
  
  rs = null;
  int z =0;
  try
  {
   rs = con.createStatement().executeQuery("SELECT page, allowed from fitservice.nationaltv_pgm_UsersAuthorities where userID=" + userid);             
   while(rs.next()){thepage[z]=rs.getString(1);allowed[z]=rs.getInt(2);z=z+1;}
   rs.close();rs = null;
  }catch(Exception e){}
    










  rs = null;
  String indate=""; 
  String intime="";
  try
  {
//   rs = con.createStatement().executeQuery("SELECT  CONVERT(char(10), lastlogintime, 101), convert(varchar,lastlogintime, 8)  from fitservice.nationaltv_pgm_Users where userID=" + userid);             
   rs = con.createStatement().executeQuery("SELECT  lastlogintime,  lastlogintime  from fitservice.nationaltv_pgm_Users where userID=" + userid);                
   while(rs.next()){indate=rs.getString(1);intime=rs.getString(2);}
   rs.close();rs = null;
  }catch(Exception e){out.println(e.toString());}




//out.println(username);out.println(password);

  
  boolean allowedaccess = false;
  for(int k =0;k< thepage.length ; k++)
  {
   if(thepage[k].equalsIgnoreCase("filteration.jsp")){if(allowed[k] == 1){allowedaccess =true;}}
  }
  
  


// out.println(allowedaccess); if(1==1)return;

if(allowedaccess ==false)
{
response.sendRedirect("login_logout.jsp");
return;
}

else
{

  rs = null;



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

int whenrejectcount = 0;    







//-----------------------------------
/*String query1 = "SELECT count(*) from fitservice.nationaltv_pgm_smss where flag=0";
String query2 = "SELECT ID from fitservice.nationaltv_pgm_smss where flag=0 order by ID";
String query3 = "select fitservice.nationaltv_pgm_smss.ID,fitservice.nationaltv_pgm_smss.intime, messages.messages.Recipient,messages.messages.Sender, messages.messages.bodyformat,messages.messages.body from  fitservice.nationaltv_pgm_smss INNER JOIN messages.messages  ON fitservice.nationaltv_pgm_smss.ID = messages.messages.id and fitservice.nationaltv_pgm_smss.flag=0 order by fitservice.nationaltv_pgm_smss.ID  asc";
*/
String query1 = "SELECT count(*) from cdrs where status=0 ";
String query2 = "SELECT ID from cdrs where status=0 order by ID desc";
String query3 = "Select ID, datein, shortcode, msisdn, lang, Contents from cdrs where status=0 order by ID desc";

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
     
   
   rs.next();
   //int theCounter = 0;
   //while(rs.next())
for (int theCounter=0;theCounter<visiblecount;theCounter++)
    {
     id[theCounter] = rs.getString(1).trim();
     sentdate[theCounter] =  rs.getString(2).trim();     
     shortcode[theCounter] = rs.getString(3).trim();          
     tel[theCounter] = rs.getString(4).trim();     
     bodyformat[theCounter] = rs.getString(5).trim(); 
     msg[theCounter] = rs.getString(6).trim(); 

    
     
     rs.next();
    // theCounter = theCounter + 1 ;
   }
   rs.close(); 
   rs = null;
   
   
   
   

   
   




















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
<title>„—«ﬁ»Â ... National Radio</title>

</head>


<BODY>





<table border='1' bgcolor=#DCDCDC cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%' height='80'>
  <tr>
    <td width='21%' align='center'><b><i><font color='#A36103' size='6'>„—«ﬁ»Â</font></i></b></td>
    

                
                
    
    <td width='30%' align='center'>
    <table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%'>
      <tr><td width='100%' align='center'><font color='#000000' face='Arial' size='4'><b> Êﬁ‹‹  «·œŒÊ·  <%= intime %> </b></font></td></tr>
      <tr><td width='100%' align='center'><font color='#000000' face='Arial' size='4'><b> &nbsp;</b></font></td></tr>

    </table>
    </td>
    <td width='24%' align='center'>
    	<table border='0' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#A36103' width='100%'>
 		<form action='MainPage.jsp' method='post'>                
     		 <tr><td align='center'><input type='submit' name='subMain' value='«·ﬁ«∆„… «·—∆Ì”Ì…' STYLE='font-weight:bold;font-family:arial;font-size:18;color:#00f;width:12em;height:2.5em'></td></tr>
                </form>
 		<form name='theform' action='filterationadmin.jsp' method='post'>
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
                  <b><a href=filterationadmin.jsp?offset=<%= i %>&filtertheshortcode=<%= URLEncoder.encode(filtershortcode)%> ><%= Integer.toString(i+1) %> </a>&nbsp;</b>
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





















     <table  border='1' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#cccccc' width='98%'>
             <tr bgcolor=#DCDCDC>
                  <td width='5%' align='center'><b>«Œ Ì«—</b></td>

             
                  <td width='60%' align='center'><b>‰’ «·—”«·Â</b></td>
                  <td width='11%' align='center'><b> «—ÌŒ «·«—”«·</b></td>
                  <td width='10%' align='center'><b> ·Ì›Ê‰</b></td>
                  <td width='9%'  align='center'><b>„’œ— «·Œœ„…</b></td>
                  
              
            </tr>
     


<form name=mainform method=post action="" >

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
 
 <td align='center'><b><font color=#000099 size=5><%=  getReadable(replaceWord(msg[l]," ",""),bodyformat[l]) %></font></b></td>
 
    	    <td align='center'> <b><font color=#000000 size=4>  <%= sentdate[l] %> </td></font></b></td>

<INPUT type='hidden' NAME=msg<%= l %> SIZE=17  READONLY value="<%= msg[l] %>" >




    	    
 <INPUT type='hidden' NAME=tel<%= l %> SIZE=17  READONLY value="<%= tel[l] %>" >

<%    	    
if(phoneallowed == 1)
{
%>
    	    <td align='center'><b><font color=#000000 size=4 dir='ltr'><%= tel[l] %></font></b></td>
<%
}
else
{
             if(tel[l].length() >= 4)
             {
%>
    	       <td align='center'><b><font color=#000000 size=4 dir='ltr'><%= tel[l].substring(tel[l].length()-4,tel[l].length()) %></font></b></td>
<%
             }
             else
             {
%>
    	       <td align='center'><b><font color=#000000 size=4 dir='ltr'><%= tel[l] %></font></b></td>
<%             
             }
}
%>





    	    <td align='center'> <b><font color=#000000 size=4  dir='ltr'>  <%= shortcode[l] %> </font></b></td>    	       	    

    	           
    	    
    	    	    


   	        	    





           </tr>            
<%
}
%>
</form>

 </table>



















<br>


</BODY>
</HTML>
























<%
con.close();   
}
}
%>

