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

thereadable =  getReadable(thecontents,thelang).