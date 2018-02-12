<%@ page language="java" pageEncoding="Cp1252" contentType="text/html; charset=Cp1252" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*,java.util.regex.*"  %><%!


       public String codedetector(String msg) 
       {
       String retval = "";
       Matcher matcher = Pattern.compile("[0-9]{1,20}").matcher(msg);
       if (matcher.find()){retval = matcher.group();}
       return retval;
       }
           
           
               
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
//     return (new String(theReadable.getBytes("Cp1256"),"Cp1252"));
     return (theReadable);
    }catch(Exception e){return "";}

 }

 
 
public int insertcdr(String themsisdn,String theshortcode,String thecountry,String theoperator,String theprovider,String thelang,
                     String thecontents,Connection thecon) throws Exception
{

String thereadable = "";
String themodifiedcontents  = thecontents.replaceAll("'", "''");

thereadable =  getReadable(thecontents,thelang).replaceAll("'", "''");

ResultSet rs = thecon.prepareStatement("insert into INCDRs( msisdn, shortcode, country, operator, provider, contents, Readable, language,code) values ('" + themsisdn + "','" + theshortcode + "', '" + thecountry  + "', '" + theoperator + "', '" + theprovider  + "','" + themodifiedcontents  + "',N'"+ thereadable + "','" + thelang + "','" + codedetector(thereadable) + "')  select @@IDENTITY" ).executeQuery();  
int theID = 0;            
while(rs.next()){ theID = rs.getInt(1);}rs.close();rs = null;

return theID;              
}





 
public void insertpush(int theid,String themsisdn,String theshortcode,String thecountry,String theoperator,String theprovider,String thelang,
                     String thecontents,String secretcode,Connection thecon) throws Exception
{
thecon.createStatement().execute("insert into push(id,msisdn, shortcode, country, operator, provider, code, scode) values (" + theid +",'" + themsisdn  + "','" +  theshortcode + "','" + thecountry + "','" + theoperator+"','" + theprovider+"',N'" +codedetector(getReadable(thecontents,thelang)).replaceAll("'", "''") + "','" + secretcode  + "' )  " );
}




public boolean iscombo(String shortcode,String thekeyword,Connection thecon) throws Exception
{
int count=0;
 ResultSet rs = thecon.createStatement().executeQuery("SELECT count(*) as thecnt from ComboConfig where shortcode=N'" + shortcode+ "'  and keyword=N'" + thekeyword + "'");
 while (rs.next()){count = rs.getInt(1);}rs.close();rs=null;

if (count > 0){return true;}
return false;
}


public void insertcombo(String themsisdn,String theshortcode,String thecountry,String theoperator,String theprovider,String thelang,
                     String thecontents,String thecontentcode,String secretcode,Connection thecon) throws Exception
{
 int count=0;
 ResultSet rs = thecon.createStatement().executeQuery("SELECT count(*) as thecnt from ComboConfig where shortcode=N'" + theshortcode+ "'  and keyword=N'" + thecontentcode + "'");
 while (rs.next()){count = rs.getInt(1);}rs.close();rs=null;
 

 
 if (count > 0)
 {
  int tmpcnt=0;
  String[] combocodes= new String[count];
  rs = thecon.createStatement().executeQuery("SELECT code from ComboConfig where shortcode=N'" + theshortcode+ "'  and keyword=N'" + thecontentcode + "' order by code");
  while (rs.next()){combocodes[tmpcnt] = rs.getString(1); tmpcnt=tmpcnt+1;}rs.close();rs=null;
 
   for(int zz=0;zz<count;zz++)
   {
    thecon.createStatement().execute("insert into ComboPush(msisdn, shortcode, country, operator, provider, code, scode) values ('" + themsisdn  + "','" +  theshortcode + "','" + thecountry + "','" + theoperator+"','" + theprovider+"',N'" +combocodes[zz] + "','" + secretcode  + "' )  " );
   }
 }
}

 
            
%><%


 Random rand;
 rand = new Random();                              
 String scode =	Integer.toString(rand.nextInt(9)) + Integer.toString(rand.nextInt(9)) + Integer.toString(rand.nextInt(9)) + 
                Integer.toString(rand.nextInt(9)) + Integer.toString(rand.nextInt(9)) + Integer.toString(rand.nextInt(9)) + 
                Integer.toString(rand.nextInt(9)) + Integer.toString(rand.nextInt(9)) + Integer.toString(rand.nextInt(9)) + 
                Integer.toString(rand.nextInt(9)) ;
               
               
        String shortcode=null ;
        String msisdn=null;
        String operator=null;
        String provider=null;
        String contents=null;
        String lang=null;
        String country=null ;

        if(request.getParameter("shortcode") != null){shortcode= request.getParameter("shortcode");shortcode= shortcode.trim();}
        if(request.getParameter("provider") != null){provider= request.getParameter("provider");provider= provider.trim();}
        if(request.getParameter("lang") != null){lang = request.getParameter("lang");lang = lang.trim();}
        if(request.getParameter("contents") != null){contents = request.getParameter("contents");contents = contents.trim();}
        if(request.getParameter("msisdn") != null){msisdn = request.getParameter("msisdn");msisdn = msisdn.trim();}
        if(request.getParameter("operator") != null){operator = request.getParameter("operator");operator = operator.trim();}
        if(request.getParameter("country") != null){country = request.getParameter("country");operator = operator.trim();}
         
        if ((country == null) || (provider == null) || (lang == null)  || (shortcode == null)  || (msisdn == null)     || (contents== null) || (operator== null) ||  ((!lang.equalsIgnoreCase("A")) && (!lang.equalsIgnoreCase("E"))))

        {
          out.print("rejected, parameter(s) missing.");
          return;
       	}
       	
       	
       	Connection con=null;
        InitialContext ic = new InitialContext();
        DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TheDB");
        con  = ds.getConnection();
        
        
       	
        int ActiveProvider = 0;
        ResultSet rs = con.createStatement().executeQuery("SELECT     count(*) as thecnt FROM  Providers  where providername='" + provider + "' and active=1");            
        while(rs.next()){  ActiveProvider = rs.getInt(1);}rs.close(); rs = null;
        
  	    
        if(ActiveProvider == 0){out.print("<b>Rejected</b>.&nbsp;provider&nbsp;&nbsp;: <u>" + provider + "</u>&nbsp;&nbsp;<b>unknown</b>");out.close();return;}       	
  
  
       	
       	
       	
       	
       	
       	
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
        
        

        
        int thereturnedid =  -1;
        try{
             thereturnedid = insertcdr(msisdn,shortcode,country,operator,provider,lang,contents,con);
              
             String thecontentcode = codedetector(getReadable(contents,lang)).replaceAll("'", "''");
             if(iscombo(shortcode,thecontentcode,con))
             {
//              out.print("combo");out.close();return;
              insertcombo(msisdn,shortcode,country,operator,provider,lang,contents,thecontentcode,scode,con);
             }
             else
             {
              insertpush(thereturnedid,msisdn,shortcode,country,operator,provider,lang,contents,scode,con); 
             }
             
           }catch(Exception e){thereturnedid =  -1;}  
           
           if(thereturnedid>0) {out.print("OK");out.close();return;}
           else{out.print("ERROR");out.close();return;}
         
       
     %>