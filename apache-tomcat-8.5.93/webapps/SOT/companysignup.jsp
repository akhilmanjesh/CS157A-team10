<%@ page import="java.sql.*"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<%@include file="navbar.jsp" %>
<html>
  <head>
    <title>Signup Page</title>
  </head>
  <body>
<section class="h-100">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col">
        <div class="card card-registration my-4">
          <div class="row g-0 align-items-center" style="background-color:#DCDCDC">
            <div class="col-xl-7 d-none d-xl-block align-"  mx-auto>
              <div class="text-center">
                <img src="./generic_employee_logo.png" class="img-fluid" alt="Responsive image" style="width:300px">
              </div>
            </div>
            <div class="col-xl-5" style="background-color:white">
              <div class="card-body p-md-5 text-black">
                <form method = "post">
                  <h2>Company Account Registration</h2>
                  <p>Please fill in this form to create an account.</p>
                  <div class = row>
                    <div class = col-md-3 mx-auto>
      <label for="username"><b>Username</b></label>
      <input type="text" placeholder="Enter Username" name="username" id="username" required>
                    </div>
                  </div>
                  <div class = row>
                    <div class = col-md-3 mx-auto>
      <label for="email"><b>Email</b></label>
      <input type="text" placeholder="Enter Email" name="email" id="email" required> <br>
                    </div>
                  </div>
                  <div class = row>
                    <div class = col-md-4 al mx-auto>
      <label for="pass"><b>Password</b></label>
      <input type="password" placeholder="Enter Password" name="pass" id="pass" required>
                    </div>
                  </div>
                  <div class = row>
                    <div class = col-md-3 mx-auto>
      <label for="pass-repeat"><b>Repeat Password</b></label>
      <input type="password" placeholder="Repeat Password" name="pass-repeat" id="pass-repeat" required> <br>
                    </div>
                  </div>
                  <div class = row>
                    <div class = col-md-3 mx-auto>
      <label for="CompName"><b>Company Name</b></label>
      <input type="text" placeholder="Company Name" name="CompName" id="CompName" required>
                    </div>
                  </div>
                  <div class = row>
                    <div class = col-md-3 mx-auto>
      <label for="department"><b>Department</b></label>
      <input type="text" placeholder="Department" name="Department" id="Department" required>
                    </div>
                  </div>
                  <div class = row>
                    <div class = col-md-3 mx-auto>
      <label for="Job"><b>Job</b></label>
      <input type="text" placeholder="Job" name="Job" id="Job" required>
                    </div>
                  </div>
        
                  <div class = row justify-content-end>
                    <div class = col-lg-12>
                      <div class ="text-end">
                        <button type="submit" class="btn btn-primary">Register</button>
                      </div>
                     
                    </div>
                  </div>


                </form>              
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
  </body>
  <%
  String db = "sot";
     String user; // assumes database name is the same as username
       user = "root";
     String password = "1723";
     try {
         java.sql.Connection con; 
         Class.forName("com.mysql.jdbc.Driver");
Connection con = null;
Properties props = new Properties();
InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties");
props.load(input);
String user = props.getProperty("db.username");
String password = props.getProperty("db.password");
String url = props.getProperty("db.url");
con = DriverManager.getConnection(url, user, password);
input.close();

         String username = request.getParameter("username");
         String email = request.getParameter("email");
         String pass = request.getParameter("pass");
         String passRepeat = request.getParameter("pass-repeat");
         String compName = request.getParameter("CompName");
         String department = request.getParameter("Department");
         String job = request.getParameter("Job");
         
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
                  %>
                  <div class = "container-fluid">
                    <div class="row justify-content-center">
                      <div class="col-md-2">
                        <div class="alert alert-danger" role="alert">
                          <div class ="text-center">Username has already been taken!</div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <%
            } else{
              if (emailCheck.next() != false){
                  %>
                  <div class = "container-fluid">
                    <div class="row justify-content-center">
                      <div class="col-md-2">
                        <div class="alert alert-danger" role="alert">
                          <div class ="text-center">Email already in use!</div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <%
              } else {
                if (pass.equals(passRepeat)){
                  String hashedPassword = BCrypt.hashpw(pass, BCrypt.gensalt());
     
                  PreparedStatement pstmt = con.prepareStatement("INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
                  pstmt.setString(1, username);
                  pstmt.setString(2, email);
                  pstmt.setString(3, hashedPassword);
                  pstmt.executeUpdate();
                  pstmt.close();
                  
                  PreparedStatement pstmt2 = con.prepareStatement("INSERT INTO companystaff (compName, department, job, username) VALUES (?, ?, ?, ?)");
                  pstmt2.setString(1, compName);
                  pstmt2.setString(2, department);
                  pstmt2.setString(3, job);
                  pstmt2.setString(4, username);
                  pstmt2.executeUpdate();
                  pstmt2.close();

                  usernameStatement.close();
                  emailStatement.close();
                  %>
                  <div class = "container-fluid">
                    <div class="row justify-content-center">
                      <div class="col-md-2">
                        <div class="alert alert-primary" role="alert">
                          <div class ="text-center">Account Successfully Created</div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <%
 
                } else {
                  %>
                  <div class = "container-fluid">
                    <div class="row justify-content-center">
                      <div class="col-md-2">
                        <div class="alert alert-danger" role="alert">
                          <div class ="text-center">Passwords do not match!</div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <%
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
