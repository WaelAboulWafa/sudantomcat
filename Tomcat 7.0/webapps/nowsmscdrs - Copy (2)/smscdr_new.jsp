<%@ page language="java" contentType="text/html; charset=windows-1256" pageEncoding="windows-1256"%><%@page import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*,java.util.regex.*"  %><%!




public String getReadable(String theUnicode,String thelang)
 {
   if( thelang.equalsIgnoreCase("E") ){return theUnicode;}
   
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




public boolean insertcdr(String theprovider,String theshortcode,String themsisdn,String thelang,String thecontents,Connection con ) throws Exception

{

String thereadable = "";
String themodifiedcontents  = thecontents.replaceAll("'", "''");
if( thelang.equalsIgnoreCase("A") ){thereadable =  getReadable(thecontents,thelang).replaceAll("'", "''");}
else{thereadable =  thecontents.replaceAll("'", "''");}

try{
	

	String thequery ="insert into sms.mo_cdrs(Contents,Readable,provider,msisdn,shortcode,lang) values('" + thecontents + "','" + thereadable + "','" + theprovider + "','" +  themsisdn + "','" + theshortcode + "','" + thelang + "')" ;
//	String thequery ="insert into sms.mo_cdrs(Contents,Readable,provider,msisdn,shortcode,lang) values('" + thecontents + "','','" + theprovider + "','" +  themsisdn + "','" + theshortcode + "','" + thelang + "')" ;



con.createStatement().execute(thequery);
	

}catch(Exception e){ return false; }

return true;              
}





            
%><%

        String provider=null;
        String msisdn=null ;
        String shortcode=null;
        String lang=null;
        String contents = null;

         if(request.getParameter("provider") != null)   {provider = request.getParameter("provider");provider = provider.trim();} 
         if(request.getParameter("msisdn") != null)     {msisdn = request.getParameter("msisdn");msisdn = msisdn.trim();} 
         if(request.getParameter("shortcode") != null)  {shortcode = request.getParameter("shortcode");shortcode = shortcode.trim();} 
         if(request.getParameter("lang") != null)       {lang = request.getParameter("lang");lang = lang.trim();}           
         if(request.getParameter("contents") != null)   {contents = request.getParameter("contents");contents = contents.trim();}                    
           
        if ( (provider == null)    ||
             (msisdn == null)      ||
             (shortcode == null)   ||
             (lang == null)        ||
             (contents == null)    

           )
        {
          out.print("Rejected. parameter(s) missing.");
          out.close();
          return;    
       	}       	
       	
       	


        Connection con=null;
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
        con  = ds.getConnection();
        
        

        
  
       	
        if(! (lang.equalsIgnoreCase("A") || lang.equalsIgnoreCase("E") ))
        {
              out.print("Rejected. unknown language");
              out.close();
              return;         	   	
        }

       	
        if( lang.equalsIgnoreCase("A") )
        {
        
        try{
             StringBuffer stb = new StringBuffer();
             for(int i=0;i< contents.length();i=i+4)
             {
              if(contents.substring(i,i+3).equalsIgnoreCase("066")){stb.append("003");stb.append( contents.substring(i+3,i+4) );}
              else{stb.append(contents.substring(i,i+4));}
             }
             contents = stb.toString();
           }catch(Exception e){contents = contents;}
        
        }


         boolean dbstatus =  false;
         try{dbstatus = insertcdr(provider,shortcode,msisdn,lang,contents,con);}catch(Exception e){out.print(e.toString());}
         
         
         if (dbstatus){out.print("OK");out.close();return;}
         else{out.print("ERROR");out.close();return;}   

       
          
     
  
            
            %>