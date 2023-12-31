/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.5.93
 * Generated at: 2023-11-30 10:04:54 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import javax.servlet.http.*;
import javax.servlet.*;

public final class settings_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_imports_classes = null;
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
      out.write("<head>\r\n");
      out.write("    <title>Settings Page</title>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("    <a href=\"http://localhost:8080/SOT/index.jsp\"><H1>Home</H1></a>\r\n");
      out.write("\r\n");
      out.write("    ");

        HttpSession sso = request.getSession(false);
        String loggedInUser = (sso != null && sso.getAttribute("username") != null) ? (String) sso.getAttribute("username") : "test"; 
        String orgType = request.getParameter("orgType");
        String orgName = request.getParameter("orgName");

        if (orgName == null || orgName.isEmpty()) {
          orgName = "SJSUACM"; 
        }

        String action = request.getParameter("action");
        String friendUsername = request.getParameter("friendUsername");

        String dbURL = "jdbc:mysql://localhost:3306/sot?autoReconnect=true&useSSL=false";
        String user = "root";
        String password = "1723";
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(dbURL, user, password);
        try {
            String sql = "SELECT user2 FROM friends WHERE user1 = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, loggedInUser);
            rs = pstmt.executeQuery();
            out.println("<table>");
            while (rs.next()) {
                friendUsername = rs.getString("user2"); 
                
            }
            out.println("</table>");
        } catch(SQLException e) {
            out.println("<p>SQLException caught: " + e.getMessage() + "</p>");
        }
        if ("deleteFriend".equals(request.getParameter("action"))) {
            try {
                String sql = "DELETE FROM friends WHERE user1 = ? AND user2 = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, loggedInUser);
                pstmt.setString(2, friendUsername);
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<p>Friend deleted successfully.</p>");
                } else {
                    out.println("<p>Error occurred while deleting the friend.</p>");
                }
            } catch(SQLException e) {
                out.println("<p>SQLException caught: " + e.getMessage() + "</p>");
            }
        }
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(dbURL, user, password);
    
            if ("addFriend".equals(action) && friendUsername != null) {
                String sql = "INSERT INTO friends (user1, user2) VALUES (?, ?)";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, loggedInUser);
                pstmt.setString(2, friendUsername);
                pstmt.executeUpdate();
            }
    
            if ("removeFriend".equals(action) && friendUsername != null) {
                String sql = "DELETE FROM friends WHERE user1 = ? AND user2 = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, loggedInUser);
                pstmt.setString(2, friendUsername);
                pstmt.executeUpdate();
            }
    
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
            if (con != null) try { con.close(); } catch (SQLException e) { }
        }

    
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
      out.write("    <h3>Manage Friends</h3>\r\n");
      out.write("    <form method=\"post\">\r\n");
      out.write("        <label for=\"friendUsername\"><b>Friend's Username</b></label>\r\n");
      out.write("        <input type=\"text\" placeholder=\"Enter Friend Username\" name=\"friendUsername\" required>\r\n");
      out.write("        <button type=\"submit\" name=\"action\" value=\"addFriend\">Add Friend</button>\r\n");
      out.write("        <button type=\"submit\" name=\"action\" value=\"removeFriend\">Remove Friend</button>\r\n");
      out.write("    </form>\r\n");
      out.write("\r\n");
      out.write("    <div id=\"currentFriends\">\r\n");
      out.write("        <h4>Current Friends</h4>\r\n");
      out.write("        ");

            try {
                con = DriverManager.getConnection(dbURL, user, password);
                String sql = "SELECT user2 FROM friends WHERE user1 = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, loggedInUser);
                rs = pstmt.executeQuery();

                out.println("<ul>");
                while (rs.next()) {
                    out.println("<li>" + rs.getString("user2") + "</li>");
                }
                out.println("</ul>");
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                if (con != null) try { con.close(); } catch (SQLException e) { }
            }
        
      out.write("\r\n");
      out.write("    </div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("    <h3>Project Reviews</h3>\r\n");
      out.write("    <form method=\"post\">\r\n");
      out.write("        <label for=\"projectID\"><b>Project</b></label>\r\n");
      out.write("        <label for=\"projectID\"><b>Project ID</b></label>\r\n");
      out.write("        <input type=\"text\" name=\"projectID\" id=\"projectID\" placeholder=\"Enter Project ID\" required>\r\n");
      out.write("        <label for=\"review\"><b>Review</b></label>\r\n");
      out.write("        <textarea name=\"review\" id=\"review\" placeholder=\"Write your review here...\" required></textarea>\r\n");
      out.write("        <button type=\"submit\">Submit Review</button>\r\n");
      out.write("    </form>");
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
