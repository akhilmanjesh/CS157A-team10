/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.93
 * Generated at: 2023-10-19 08:57:20 UTC
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

public final class signup_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

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
      out.write("<html>\r\n");
      out.write("  <head>\r\n");
      out.write("    <title>Signup Page</title>\r\n");
      out.write("  </head>\r\n");
      out.write("  <body>\r\n");
      out.write("    <a href=\"http://localhost:8080/SOT/index.jsp\"><H1>Home</H1></a>\r\n");
      out.write("    <h3>Register</h1>\r\n");
      out.write("    <form action= \"");
      out.print( request.getContextPath());
      out.write("/signup.jsp\" method = \"post\">\r\n");
      out.write("      <p>Please fill in this form to create an account.</p>\r\n");
      out.write("  \r\n");
      out.write("        \r\n");
      out.write("      <label for=\"username\"><b>Username</b></label>\r\n");
      out.write("      <input type=\"text\" placeholder=\"Enter Username\" name=\"username\" id=\"username\" required>\r\n");
      out.write("\r\n");
      out.write("      <label for=\"email\"><b>Email</b></label>\r\n");
      out.write("      <input type=\"text\" placeholder=\"Enter Email\" name=\"email\" id=\"email\" required>\r\n");
      out.write("  \r\n");
      out.write("      <label for=\"pass\"><b>Password</b></label>\r\n");
      out.write("      <input type=\"password\" placeholder=\"Enter Password\" name=\"pass\" id=\"pass\" required>\r\n");
      out.write("  \r\n");
      out.write("      <label for=\"pass-repeat\"><b>Repeat Password</b></label>\r\n");
      out.write("      <input type=\"password\" placeholder=\"Repeat Password\" name=\"pass-repeat\" id=\"pass-repeat\" required>\r\n");
      out.write("\r\n");
      out.write("      <button type=\"submit\" class=\"registerbtn\">Register</button>\r\n");
      out.write("    </form>\r\n");
      out.write("\r\n");
      out.write("    ");
 
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
                String hashedPassword = BCrypt.hashpw(pass, BCrypt.gensalt());

                PreparedStatement pstmt = con.prepareStatement("INSERT INTO users (username, email, password) VALUES (?, ?, ?)");
                pstmt.setString(1, username);
                pstmt.setString(2, email);
                pstmt.setString(3, hashedPassword);
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
    
      out.write("\r\n");
      out.write("  </body>\r\n");
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
