/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.93
 * Generated at: 2023-11-26 06:15:37 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;

public final class companysignup_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(1);
    _jspx_dependants.put("/index.jsp", Long.valueOf(1700964358801L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("java.sql");
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("org.mindrot.jbcrypt.BCrypt");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    final java.lang.String _jspx_method = request.getMethod();
    if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
      return;
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("    <title>SOT - Home</title>\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"css/bootstrap.min.css\">\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"style.css\">\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("    <nav class=\"navbar navbar-expand-lg custom-navbar\">\r\n");
      out.write("        <a class=\"navbar-brand\" href=\"#\">SOT</a>\r\n");
      out.write("        <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarNav\" aria-controls=\"navbarNav\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\r\n");
      out.write("            <span class=\"navbar-toggler-icon\"></span>\r\n");
      out.write("        </button>\r\n");
      out.write("        <div class=\"collapse navbar-collapse\" id=\"navbarNav\">\r\n");
      out.write("            <ul class=\"navbar-nav\">\r\n");
      out.write("                <li class=\"nav-item active\">\r\n");
      out.write("                    <a class=\"nav-link\" href=\"index.jsp\">Home <span class=\"sr-only\">(current)</span></a>\r\n");
      out.write("                </li>\r\n");
      out.write("                <li class=\"nav-item\">\r\n");
      out.write("                    <a class=\"nav-link\" href=\"projects.jsp\">Projects</a>\r\n");
      out.write("                </li>\r\n");
      out.write("                <li class=\"nav-item\">\r\n");
      out.write("                    <a class=\"nav-link\" href=\"posts.jsp\">Posts</a>\r\n");
      out.write("                </li>\r\n");
      out.write("                <li class=\"nav-item\">\r\n");
      out.write("                    <a class=\"nav-link\" href=\"events.jsp\">Events</a>\r\n");
      out.write("                </li>\r\n");
      out.write("   \r\n");
      out.write("                <li class=\"nav-item\">\r\n");
      out.write("                    <a class=\"nav-link\" href=\"settings.jsp\">Settings</a>\r\n");
      out.write("                </li>\r\n");
      out.write("                <li class=\"nav-item\">\r\n");
      out.write("                    <a class=\"nav-link\" href=\"organizations.jsp\">Organizations</a>\r\n");
      out.write("                </li>\r\n");
      out.write("                ");

                    HttpSession sso = request.getSession(false);
                    if (sso.getAttribute("username") != null){
                        
      out.write("                \r\n");
      out.write("                        <li class=\"nav-item\">\r\n");
      out.write("                            <a class=\"nav-link\" href=\"logout.jsp\">Logout</a>\r\n");
      out.write("                        </li>\r\n");
      out.write("                        ");

                    } else {
                        
      out.write("\r\n");
      out.write("                        <li class=\"nav-item\">\r\n");
      out.write("                            <a class=\"nav-link\" href=\"login.jsp\">Login</a>\r\n");
      out.write("                        </li>\r\n");
      out.write("                        <li class=\"nav-item\">\r\n");
      out.write("                            <a class=\"nav-link\" href=\"signup.jsp\">Sign Up</a>\r\n");
      out.write("                        </li>\r\n");
      out.write("                        ");

                    }
                
      out.write("\r\n");
      out.write("            </ul>\r\n");
      out.write("        </div>\r\n");
      out.write("    </nav>\r\n");
      out.write("\r\n");
      out.write("    <h1>Welcome to SOT: Student Organization Tasker</h1>\r\n");
      out.write("    ");
 
        sso = request.getSession(false);
        if (sso.getAttribute("username") != null){
            out.println("Greetings " + sso.getAttribute("username") + "!");
            out.println("Account type " + sso.getAttribute("type") + "!");
        }
    
      out.write("\r\n");
      out.write("    <script src=\"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js\"></script>\r\n");
      out.write("    <script src=\"js/bootstrap.min.js\"></script>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("    <title>Signup Page</title>\r\n");
      out.write("  </head>\r\n");
      out.write("  <body>\r\n");
      out.write("\r\n");
      out.write("    <form method = \"post\">\r\n");
      out.write("      <p>Please fill in this form to create an account.</p>\r\n");
      out.write("  \r\n");
      out.write("        \r\n");
      out.write("      <label for=\"username\"><b>Username</b></label>\r\n");
      out.write("      <input type=\"text\" placeholder=\"Enter Username\" name=\"username\" id=\"username\" required>\r\n");
      out.write("\r\n");
      out.write("      <label for=\"email\"><b>Email</b></label>\r\n");
      out.write("      <input type=\"text\" placeholder=\"Enter Email\" name=\"email\" id=\"email\" required> <br>\r\n");
      out.write("  \r\n");
      out.write("      <label for=\"pass\"><b>Password</b></label>\r\n");
      out.write("      <input type=\"password\" placeholder=\"Enter Password\" name=\"pass\" id=\"pass\" required>\r\n");
      out.write("  \r\n");
      out.write("      <label for=\"pass-repeat\"><b>Repeat Password</b></label>\r\n");
      out.write("      <input type=\"password\" placeholder=\"Repeat Password\" name=\"pass-repeat\" id=\"pass-repeat\" required> <br>\r\n");
      out.write("\r\n");
      out.write("      <label for=\"CompName\"><b>Company Name</b></label>\r\n");
      out.write("      <input type=\"text\" placeholder=\"Company Name\" name=\"CompName\" id=\"CompName\" required>\r\n");
      out.write("\r\n");
      out.write("      <label for=\"department\"><b>Department</b></label>\r\n");
      out.write("      <input type=\"text\" placeholder=\"Department\" name=\"Department\" id=\"Department\" required>\r\n");
      out.write("  \r\n");
      out.write("      <label for=\"Job\"><b>Job</b></label>\r\n");
      out.write("      <input type=\"text\" placeholder=\"Job\" name=\"Job\" id=\"Job\" required>\r\n");
      out.write("\r\n");
      out.write("      <button type=\"submit\" class=\"registerbtn\">Register</button>\r\n");
      out.write("\r\n");
      out.write("    </form>\r\n");
      out.write("  </body>\r\n");
      out.write("  ");

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
                  
                  PreparedStatement pstmt2 = con.prepareStatement("INSERT INTO companystaff (compName, department, job, username) VALUES (?, ?, ?, ?)");
                  pstmt2.setString(1, compName);
                  pstmt2.setString(2, department);
                  pstmt2.setString(3, job);
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
  
      out.write("\r\n");
      out.write("</html>\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
