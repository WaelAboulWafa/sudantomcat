<%@ page contentType="text/html;charset=windows-1256"%>
<%@ page language="java" import="java.util.*,java.text.*,java.sql.*,javax.naming.*,javax.sql.*,java.net.*" %>



<html dir='rtl'>
<head>
<STYLE type=text/css>BODY {MARGIN: 0px; FONT: 14pt arial, geneva, lucida, "lucida grande", arial, helvetica, sans-serif; COLOR: #000000 }</style>
<meta http-equiv="Content-Language" content="en-ar">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
<title>دخــول ... National Radio</title>
</head>

<body >
<table border='2' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#BBBBBB' width='100%'>
	<tr height=60>
    <td bgcolor='#E6E6E6' width='15%' align='center'><IMG src='logo.png'></td>
		<td bgcolor='#E6E6E6' width='85%' align='center'>&nbsp;<font size='5'><b><i> من فضلك ادخل اسم المستخدم و كلمة المرور</i></b></font>&nbsp;</td>
	</tr>
</table>	
<br><br><br>
<table border='1' bgcolor='#E6E6E6' align='center' cellpadding='0' cellspacing='0' style='border-collapse: collapse' bordercolor='#BBBBBB' width='30%' height='100'>
<form action="Authenticate.jsp" method="post">
	<tr height=80 align="center">
		<td width='80%'><font color=#000000><b>اسـم المسـتخدم&nbsp;&nbsp;</b></font><input dir='ltr' type="text" name="username"><font color=#000000></font></td>
		<td width='20%'><IMG src='user.gif'></TD>
	</tr>
	<tr height=80 align="center">
		<td><font color=#000000><b>كلمـة المــرور&nbsp;&nbsp;</b></font><input dir='ltr' type="password" name="password"><font color=#000000></font></td>
		<td><IMG src='pass.gif'></TD>
	</tr>
	<tr height='40'>
		<td colspan='3' align='center'><input type="submit" value="دخـول" style="font-weight:bold;font-size:14pt;width:12em;height:3em"></td>
	</tr>
</form>
</table>


<br>

 




</body>
</html>
