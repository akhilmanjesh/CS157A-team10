<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
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
        String friendUsername = request.getParameter("friendusername");

        String dbURL = "jdbc:mysql://localhost:3306/sot?autoReconnect=true&useSSL=false";
        String user = "root";
        String password = "1723";
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
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

                try {
                out.println(loggedInUser);
                String sql = "UPDATE friends SET pending = 0 WHERE user1 = ? AND user2 = ? AND pending=1";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, friendUsername);
                pstmt.setString(2, loggedInUser);
                
                out.println(pstmt.toString());
                int rowsAffected = pstmt.executeUpdate();
                String redirectURL = "friends.jsp";
                response.sendRedirect(redirectURL);
                if (rowsAffected > 0) {
                    out.println("<p>Friend accepted successfully.</p>");
                } else {
                    out.println("<p>Error occurred while accepting the friend.</p>");
                }
            } catch(SQLException e) {
                %>
                <div class="alert alert-danger" role="alert">
                    <%=e.getMessage()%>
                </div>
                <%
            }
            %>
</body>
</html>