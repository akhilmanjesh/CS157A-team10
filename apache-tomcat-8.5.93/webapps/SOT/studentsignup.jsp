<%@ page import="java.sql.*"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@include file="index.jsp" %>
<html>
  <head>
    <title>Signup Page</title>
  </head>
  <body>
    <form method = "post">
      <p>Please fill in this form to create an account.</p>
  
        
      <label for="username"><b>Username</b></label>
      <input type="text" placeholder="Enter Username" name="username" id="username" required>

      <label for="email"><b>Email</b></label>
      <input type="text" placeholder="Enter Email" name="email" id="email" required> <br>
  
      <label for="pass"><b>Password</b></label>
      <input type="password" placeholder="Enter Password" name="pass" id="pass" required>
  
      <label for="pass-repeat"><b>Repeat Password</b></label>
      <input type="password" placeholder="Repeat Password" name="pass-repeat" id="pass-repeat" required> <br>

      <label for="GradYear"><b>Grad Year</b></label>
      <input type="text" placeholder="Grad Year" name="GradYear" id="GradYear" required>

      <label for="email"><b>School Name</b></label>
      <input type="text" placeholder="School Name" name="SchoolName" id="SchoolName" required>
  
      <label for="email"><b>Major</b></label>
      <input type="text" placeholder="Major" name="Major" id="Major" required>

      <button type="submit" class="registerbtn">Register</button>

    </form>
  </body>
  <%
  String db = "sot";
     String user; // assumes database name is the same as username
       user = "root";
     String password = "1723";
     try {
         java.sql.Connection con; 
         Class.forName("com.mysql.jdbc.Driver");
         con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sot?autoReconnect=true&useSSL=false",user, password);

         String username = request.getParameter("username");
         String email = request.getParameter("email");
         String pass = request.getParameter("pass");
         String passRepeat = request.getParameter("pass-repeat");
         String gradYear = request.getParameter("GradYear");
         String schoolName = request.getParameter("SchoolName");
         String major = request.getParameter("Major");
         
        //Check for username condition
        PreparedStatement usernameStatement = con.prepareStatement("SELECT * FROM users WHERE username = ?");
        usernameStatement.setString(1, username);
        ResultSet usernameCheck = usernameStatement.executeQuery();
        

        //Check Email Condition
        PreparedStatement emailStatement = con.prepareStatement("SELECT * FROM users WHERE email = ?");
        emailStatement.setString(1, email);
        ResultSet emailCheck = emailStatement.executeQuery();
        

        
          if ( username != null & email != null && pass != null & passRepeat != null){
            if (usernameCheck.next() != false){
              out.println("Username already taken.");
            } else{
              if (emailCheck.next() != false){
                out.println("Email already in use.");
              } else {
                if (pass.equals(passRepeat)){
                  String hashedPassword = BCrypt.hashpw(pass, BCrypt.gensalt());
     
                  PreparedStatement pstmt = con.prepareStatement("INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
                  pstmt.setString(1, username);
                  pstmt.setString(2, email);
                  pstmt.setString(3, hashedPassword);
                  pstmt.executeUpdate();
                  pstmt.close();
                  
                  PreparedStatement pstmt2 = con.prepareStatement("INSERT INTO student (gradYear, major, schoolName, username) VALUES (?, ?, ?, ?)");
                  pstmt2.setString(1, gradYear);
                  pstmt2.setString(2, major);
                  pstmt2.setString(3, schoolName);
                  pstmt2.setString(4, username);
                  pstmt2.executeUpdate();
                  pstmt2.close();

                  usernameStatement.close();
                  emailStatement.close();
                  out.println("Account created.");
 
                } else {
                  out.print("Passwords do not match!");
                }
              } 
            }
            } 
            con.close();




       } catch(SQLException e) { 
         out.println("SQLException caught: " + e.getMessage()); 
     }
  %>
</html>
