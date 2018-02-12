<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- charset=ISO-8859-1 -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Login</title>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style.css" media="screen" type="text/css" />
</head>
<body>
<br><br><br><br>
  <div class="column_right_grid sign-in" style="width:40%; margin-left:30%" align="center">
				 	<div class="sign_in">
				       <h3>Sign in to your account</h3>
					    <form action="Authenticate.jsp">
					    	<span>
					 	    <i><img src="images/mail.png" alt="" /></i><input type="text" value="Username" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = 'Username';}" name="username">
					 	    </span>
					 	    <span>
					 	     <i><img src="images/lock.png" alt="" /></i>
					 	     <input type="password" placeholder="password" name="password">
					 	    </span>
					 		<input type="submit" class="my-button" value="Login">
					 	</form>
					       <h4><a href="#">Forget Password?</a></h4>				   
          		       </div>
				   </div>

  <script src="js/index.js"></script>

</body>
</html>