<%@ page import="java.sql.*"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  
<%@include file="navbar.jsp" %>

<html>
  <head>
    <title>Login Page</title>
  </head>
  <body>

  <section class="vh-100" style="background-color: #eee;">
    <div class="container h-50">
      <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col-lg-12 col-xl-11">
          <div class="card text-black" style="border-radius: 25px;">
            <div class="card-body p-md-5">
                <div class= "row d-flex">
                  <div class="col-md-6 align-self-center offset-md-1">
                    <div class = "img-container">
                      <img src="./login_image.jpg" style="width=300px"
                      class="img-fluid" alt="Sample image">
                    </div>
                  </div>
                  <div class= "col-md-4 align-self-start">
                    <form action= "<%= request.getContextPath()%>/login.jsp" method = "post">
                      <p>Please Login.</p>

                  <div class = "row d-flex">
                    <div class = "col-md-4 align-self-start">
                      <label for="username"><b>Username</b></label>
                      <input type="text" placeholder="Enter Username" name="username" id="username" required>
                    </div>
                  </div>       
                  <div class = "row d-flex">
                    <div class = "col-md-4 align-self-start">
                      <label for="pass"><b>Password</b></label>
                      <input type="password" placeholder="Enter Password" name="pass" id="pass" required>
                    </div>
                  </div>
                  <div class = "row d-flex justify-content-end">
                    <div class = "col-md-2 allign-self-end">
                      <button type="submit" class="btn btn-primary">Login</button><br><p></p>
                    </div>
                  </div>              
                    </form>



  <style>
    .alert alert-danger{
      top:300px;
      left:0;
      right:0;
      bottom:0;
      margin-bottom:500px;
    }
  </style>

    <% 
        Properties props = new Properties();
        InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties");
        props.load(input);
        input.close();
        String user = props.getProperty("db.username");
        String password = props.getProperty("db.password");
        try {
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sot?autoReconnect=true&useSSL=false",user, password);

            String username = request.getParameter("username");
            String pass = request.getParameter("pass");

            PreparedStatement pstmt = con.prepareStatement("SELECT password FROM users WHERE username = ?");
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()){
                String storedHashedPassword = rs.getString("password");
                if (BCrypt.checkpw(pass, storedHashedPassword)) {
                    out.println("Test Login Successful");
                    String sessionToken = UUID.randomUUID().toString();

                    /*
                    PreparedStatement tokenStmt = con.prepareStatement("UPDATE users SET session_token = ? WHERE username = ?");
                    tokenStmt.setString(1, sessionToken);
                    tokenStmt.setString(2, username);
                    tokenStmt.executeUpdate();
                    tokenStmt.close();
                    */

                    sso = request.getSession(true);
                    sso.setAttribute("username", username);
                    PreparedStatement checkCompanyStaff = con.prepareStatement("SELECT username FROM companystaff WHERE username = ?");
                    checkCompanyStaff.setString(1, username);
                    ResultSet rs2 = checkCompanyStaff.executeQuery();
                    if (rs2.next()){
                      sso.setAttribute("type", "companystaff");
                    } else {
                      sso.setAttribute("type", "student");
                    }
                    String redirectURL = "http://localhost:8080/SOT/index.jsp";
                    response.sendRedirect(redirectURL);                   
                } else {
                  %>
                  <div class="alert alert-danger" role="alert">
                    Invalid Username or Password.
                  </div>
                  <%
                }
            } else if (!rs.next() && username != null){
                  %>
                  <div class="alert alert-danger" role="alert">
                    Invalid Username or Password.
                  </div>
                  <%
            }

          } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  </body>
</html>
