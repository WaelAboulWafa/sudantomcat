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
	

//	String thequery ="insert into fitservice.zoheir_pgm_smss(Contents,Readable,provider,msisdn,shortcode,lang) values('" + thecontents + "','" + thereadable + "','" + theprovider + "','" +  themsisdn + "','" + theshortcode + "','" + thelang + "')" ;
	String th