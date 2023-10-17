<%@ page import="java.sql.*"%>
<html>
  <head>
    <title>Login Page</title>
  </head>
  <body>
    <a href="http://localhost:8080/SOT/index.jsp"><H1>Home</H1></a>
    <h3>Login</h1>
    <form action= "<%= request.getContextPath()%>/login.jsp" method = "post">
      <p>Please Login.</p>
  
        
      <label for="username"><b>Username</b></label>
      <input type="text" placeholder="Enter Username" name="username" id="username" required>

  
      <label for="pass"><b>Password</b></label>
      <input type="password" placeholder="Enter Password" name="pass" id="pass" required>

      <button type="submit" class="loginbtn">Login</button>
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
            String pass = request.getParameter("pass");

            if (username != null && password != null){
                PreparedStatement pstmt = con.prepareStatement("SELECT * FROM users WHERE (username = ? AND password = ?)");
                pstmt.setString(1, username);
                pstmt.setString(2, pass);
                ResultSet rs = pstmt.executeQuery();
                
                if (!rs.next()){
                    out.println("Invalid Username or Password.");
                } else{
                    out.println("Login Sucessful");
                }
                rs.close();
            }

          } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
  </body>
</html>
