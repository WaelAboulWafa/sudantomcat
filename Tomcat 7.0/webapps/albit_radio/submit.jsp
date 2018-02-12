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





        Connection con=null;
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
        con  = ds.getConnection();
        
        

         boolean erroroccured =  false;

         
         
		int match_pgm=0;


		try{
	


	

			 //get program rule
			 int pgmstatus = 0;
			 ResultSet rs = con.createStatement().executeQuery("SELECT status FROM sms.albit_operations");            
		     while(rs.next()){pgmstatus = rs.getInt(1);}
		     rs.close(); rs = null;
			
			
			  
		     
		     //normal program operation
		     if(pgmstatus != 0 )
		     {
		       
					 int pgmid=0;
					 String airing_weekday="";
					 String airing_from="";
					 String airing_to="";
					 String replay_weekday="";
					 String replay_from="";
					 String replay_to="";
					 
					 rs = con.createStatement().executeQuery("SELECT id,airing_weekday,CONCAT( DATE_FORMAT(NOW(),'%Y-%m-%d') ,' ',airing_from) as airing_from ,CONCAT( DATE_FORMAT(NOW(),'%Y-%m-%d') ,' ',airing_to) as airing_to,replay_weekday,CONCAT( DATE_FORMAT(NOW(),'%Y-%m-%d') ,' ',replay_from) as replay_from ,		CONCAT( DATE_FORMAT(NOW(),'%Y-%m-%d') ,' ',replay_to) as replay_to FROM sms.albit_pgms order by id");            
				     while(rs.next())
				     	{
				     	
							 pgmid=rs.getInt(1);
							 airing_weekday=rs.getString(2);
							 airing_from=rs.getString(3);
							 airing_to=rs.getString(4);
							 replay_weekday=rs.getString(5);
							 replay_from=rs.getString(6);
							 replay_to=rs.getString(7);
							 
							 
							 java.util.Date now_date =  new java.util.Date();
							 
							 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
							 
							 String now_Week = (new SimpleDateFormat("EEEE")).format(now_date); 
							
					        

							java.util.Date the_airingdate_from = sdf.parse(airing_from);
        					java.util.Date the_airingdate_to = sdf.parse(airing_to);
        					
							java.util.Date the_replaydate_from = sdf.parse(replay_from);
        					java.util.Date the_replaydate_to = sdf.parse(replay_to);
        					
        					
        					 
        					 if (( now_date.compareTo(the_airingdate_from) >= 0 )  && ( now_date.compareTo(the_airingdate_to) <= 0 ) )
        					 {
        					   
        					 }


                          if(  
                          	  (	( now_date.compareTo(the_airingdate_from) >= 0 )  && ( now_date.compareTo(the_airingdate_to) <= 0 ) )
                          	  ||
                          	  (	( now_date.compareTo(the_replaydate_from) >= 0 )  && ( now_date.compareTo(the_replaydate_to) <= 0 ) )
                          		
                          	) 
                          {

                          	if( 
                          		( airing_weekday.equalsIgnoreCase("ALL")     ||  airing_weekday.equalsIgnoreCase(now_Week)  )
                          								|| 
                          		
                          		( 
                          			( replay_weekday.equalsIgnoreCase("ALL")     ||  replay_weekday.equalsIgnoreCase(now_Week) ) 
                          								&& 
                          			(!replay_weekday.equalsIgnoreCase("NOREPLAY"))
                          		)
                          		
                          		
                          	  )
                          	  {
                          	  
                          	  		match_pgm = pgmid; break;
                          	  
                          	  
                          	  }
                          
                          
                          
                          }          					
        
					 				     	

				     	}
				     rs.close(); rs = null;
		     		       
		       
		       
		
		
		

		    
		    
		     		
		     }
 
     
     
     
     
    //insert the record
    
	String thereadable = "";
	String themodifiedcontents  = contents.replaceAll("'", "''");
	if( lang.equalsIgnoreCase("A") ){thereadable =  getReadable(contents,lang).replaceAll("'", "''");}
	else{thereadable =  contents.replaceAll("'", "''");}

    
	String thequery ="insert into sms.albit_cdrs(Contents,Readable,provider,msisdn,shortcode,lang,pgmid) values('" + contents + "','" + thereadable + "','" + provider + "','" +  msisdn + "','" + shortcode + "','" + lang + "','" + match_pgm + "')" ;
    con.createStatement().execute(thequery);


	
	
	erroroccured=false;

}catch(Exception e){ erroroccured=true;  }




         con.close();
         

         

       
         if (!erroroccured){out.print("OK");}
         else{out.print("ERROR");}   

       

            
            %>