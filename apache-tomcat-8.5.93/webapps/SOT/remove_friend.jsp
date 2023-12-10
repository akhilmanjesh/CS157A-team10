<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  
<html>
<head>
    <title>Friends</title>
</head>
<body>
    <%@include file = "navbar.jsp"%>

    <%
        sso = request.getSession(false);
        String loggedInUser = (sso != null && sso.getAttribute("username") != null) ? (String) sso.getAttribute("username") : "test"; 

        String action = request.getParameter("action");
        String friendID = request.getParameter("friendID");

        String dbURL = "jdbc:mysql://localhost:3306/sot?autoReconnect=true&useSSL=false";
        Properties props = new Properties();
        InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties");
        props.load(input);
        input.close();
        String user = props.getProperty("db.username");
        String password = props.getProperty("db.password");
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(dbURL, user, password);

                try {
                out.println(loggedInUser);
                String sql = "DELETE FROM friends WHERE (friendID = ? AND pending = 0)";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, friendID);
                
                out.println(pstmt.toString());
                int rowsAffected = pstmt.executeUpdate();
                String redirectURL = "friends.jsp";
                response.sendRedirect(redirectURL);
                if (rowsAffected > 0) {
                    out.println("<p>Friend removed successfully.</p>");
                } else {
                    out.println("<p>Error occurred while removing the friend.</p>");
                }
            } catch(SQLException e) {
                out.println("<p>SQLException caught: " + e.getMessage() + "</p>");
            }
            %>
</body>
</html>