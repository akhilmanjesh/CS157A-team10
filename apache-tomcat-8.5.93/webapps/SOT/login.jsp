<%@ page import="java.sql.*"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="java.util.UUID" %>
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

            if (rs.next()){
                String storedHashedPassword = rs.getString("password");
                if (BCrypt.checkpw(enteredPassword, storedHashedPassword)) {
                    String sessionToken = UUID.randomUUID().toString();

                    PreparedStatement tokenStmt = con.prepareStatement("UPDATE users SET session_token = ? WHERE username = ?");
                    tokenStmt.setString(1, sessionToken);
                    tokenStmt.setString(2, username);
                    tokenStmt.executeUpdate();
                    tokenStmt.close();

                    response.addCookie(new javax.servlet.http.Cookie("session_token", sessionToken));

                    out.println("Login Successful");
                } else {
                    out.println("Invalid Username or Password.");
                }
            }

          } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
  </body>
</html>
