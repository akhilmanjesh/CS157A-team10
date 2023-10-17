<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>Signup Page</title>
  </head>
  <body>
    <a href="http://localhost:8080/SOT/index.jsp"><H1>Home</H1></a>
    <h3>Register</h1>
    <form action= "<%= request.getContextPath()%>/signup.jsp" method = "post">
      <p>Please fill in this form to create an account.</p>
  
        
      <label for="username"><b>Username</b></label>
      <input type="text" placeholder="Enter Username" name="username" id="username" required>

      <label for="email"><b>Email</b></label>
      <input type="text" placeholder="Enter Email" name="email" id="email" required>
  
      <label for="pass"><b>Password</b></label>
      <input type="password" placeholder="Enter Password" name="pass" id="pass" required>
  
      <label for="pass-repeat"><b>Repeat Password</b></label>
      <input type="password" placeholder="Repeat Password" name="pass-repeat" id="pass-repeat" required>

      <button type="submit" class="registerbtn">Register</button>
    </form>

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
            
            if ( username != null & email != null && pass != null & passRepeat != null){
              if (pass.equals(passRepeat)){
                PreparedStatement pstmt = con.prepareStatement("INSERT INTO users VALUES (?, ?, '123', 'fmkro')");
                pstmt.setString(1, username);
                pstmt.setString(2, email);
                pstmt.executeUpdate();
                pstmt.close();
                con.close();
                out.println("account created");
              } else {
                out.print("Passwords do not match!");
              }
            }
            

          } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
  </body>
</html>
