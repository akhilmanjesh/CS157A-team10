/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.93
 * Generated at: 2023-11-30 21:13:26 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.Properties;
import java.io.InputStream;
import java.sql.*;

public final class posts_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(1);
    _jspx_dependants.put("/navbar.jsp", Long.valueOf(1701350444935L));
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
    _jspx_imports_classes.add("java.util.Properties");
    _jspx_imports_classes.add("java.io.InputStream");
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
      out.write("  \r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("    <head>\r\n");
      out.write("        <title>Projects Page</title>\r\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/bootstrap.min.css\">\r\n");
      out.write("        <link rel=\"stylesheet\" href=\"style.css\">\r\n");
      out.write("    </head>\r\n");
      out.write("    <body>\r\n");
      out.write("        ");
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
      out.write("        <a class=\"navbar-brand\" href=\"index.jsp\" style=\"margin-left:10px\">SOT</a>\r\n");
      out.write("        <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarNav\" aria-controls=\"navbarNav\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\r\n");
      out.write("            <span class=\"navbar-toggler-icon\"></span>\r\n");
      out.write("        </button>\r\n");
      out.write("        ");
 HttpSession sso = request.getSession(false); 
      out.write("\r\n");
      out.write("        <div class=\"collapse navbar-collapse justify-content-end\" id=\"navbarNav\"style=\"margin-right:10px\">\r\n");
      out.write("            <ul class=\"navbar-nav\">\r\n");
      out.write("                <li class=\"nav-item active\">\r\n");
      out.write("                    <a class=\"nav-link\" href=\"index.jsp\">Home</a>\r\n");
      out.write("                </li>\r\n");
      out.write("                <li class=\"nav-item\">\r\n");
      out.write("                    <a class=\"nav-link\" href=\"projects.jsp\">Projects</a>\r\n");
      out.write("                </li>\r\n");
      out.write("                ");

                if (sso.getAttribute("username") != null){
                        
      out.write("           \r\n");
      out.write("                       <li class=\"nav-item\">\r\n");
      out.write("                        <a class=\"nav-link\" href=\"posts.jsp\">Posts</a>\r\n");
      out.write("                        </li>\r\n");
      out.write("                        <li class=\"nav-item\">\r\n");
      out.write("                            <a class=\"nav-link\" href=\"events.jsp\">Events</a>\r\n");
      out.write("                        </li>\r\n");
      out.write("                        ");

                    } 
                
      out.write("\r\n");
      out.write("                <li class=\"nav-item\">\r\n");
      out.write("                    <a class=\"nav-link\" href=\"organizations.jsp\">Organizations</a>\r\n");
      out.write("                </li>\r\n");
      out.write("                ");

                    if (sso.getAttribute("username") != null){
                        
      out.write("     \r\n");
      out.write("                        <li class=\"nav-item\">\r\n");
      out.write("                            <a class=\"nav-link\" href=\"friends.jsp\">Friends</a>\r\n");
      out.write("                        </li>           \r\n");
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
      out.write("<script src=\"https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js\" integrity=\"sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r\" crossorigin=\"anonymous\"></script>\r\n");
      out.write("<script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js\" integrity=\"sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+\" crossorigin=\"anonymous\"></script>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
      out.write("\r\n");
      out.write("        <hr class=\"featurette-divider\">\r\n");
      out.write("       \r\n");
      out.write("\r\n");
      out.write("        <div class=\"row justify-content-center\">\r\n");
      out.write("        <div class=\"col-8\">\r\n");
      out.write("        <h3> Posts </h3>\r\n");
      out.write("        ");

        String db = "sot";
        Properties props = new Properties();
        InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties");
        props.load(input);
        input.close();
        String user = props.getProperty("db.username");
        String password = props.getProperty("db.password");
        Connection con = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?autoReconnect=true&useSSL=false", user, password);

            /*
            // Delete post logic
            String deletePostId = request.getParameter("deletePostId");
            if (deletePostId != null && !deletePostId.isEmpty()) {
                String deleteQuery = "DELETE FROM posts WHERE postid = ?";
                PreparedStatement deleteStmt = con.prepareStatement(deleteQuery);
                deleteStmt.setString(1, deletePostId);
                deleteStmt.executeUpdate();
                deleteStmt.close();
            }
            */
            String username = (String) sso.getAttribute("username");
            if (username == null){
                out.println("Login to view posts.");
            } else {
                String query = "SELECT * FROM posts WHERE orgName IN (SELECT orgName FROM memberofStudent WHERE username = ?)";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();
                while(rs.next()) {
                    String postId = rs.getString(1); // Assuming the first column is the post ID
                    
      out.write("\r\n");
      out.write("                    <div class=\"card\">\r\n");
      out.write("                        <div class=\"card-body\">\r\n");
      out.write("                            <h5 class=\"card-title\">[");
      out.print(postId);
      out.write(']');
      out.write(' ');
      out.print(rs.getString(3));
      out.write("</h5>\r\n");
      out.write("                            <p class=\"card-text\">");
      out.print(rs.getString(2));
      out.write("</p>\r\n");
      out.write("                            <!--\r\n");
      out.write("                            <form method=\"post\">\r\n");
      out.write("                                <input type=\"hidden\" name=\"deletePostId\" value=\"");
      out.print(postId);
      out.write("\"/>\r\n");
      out.write("                                <button type=\"submit\">Delete Post</button>\r\n");
      out.write("                            </form>\r\n");
      out.write("                            -->\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                    ");

                }
                
      out.write("\r\n");
      out.write("                <b>No more posts.</b>\r\n");
      out.write("                ");


                rs.close();
                ps.close();
            }
        } catch(SQLException e) {
            out.println("SQLException caught: " + e.getMessage()); 
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    out.println("SQLException caught: " + e.getMessage());
                }
            }
        }
        
      out.write("\r\n");
      out.write("        </div>\r\n");
      out.write("        </div>\r\n");
      out.write("        <script src=\"js/bootstrap.min.js\"></script>\r\n");
      out.write("    </body>\r\n");
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
