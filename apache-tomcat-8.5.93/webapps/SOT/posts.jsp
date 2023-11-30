<%@ page import="java.sql.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  

<html>
    <head>
        <title>Projects Page</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <%
        String db = "sot";
        Properties props = new Properties();
        InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties");
        props.load(input);
        input.close();
        String user = props.getProperty("db.username");
        String password = props.getProperty("db.password");
        Connection con = null;
        try {
            sso = request.getSession(false);
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?autoReconnect=true&useSSL=false", user, password);
            String username = (String) sso.getAttribute("username");
            if (username == null){
                out.println("Login to view posts.");
            } else {
                String query = "SELECT * FROM posts WHERE orgName IN (SELECT orgName FROM memberofStudent WHERE username = ?)";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();
                while(rs.next()) {
                    %>
                    <div class ="card">
                        <div class="card-body">
                            <h5 class="card-title"><%=rs.getString(3)%></h5>
                            <p class="card-text"><%=rs.getString(2)%></p>
                        </div>
                    </div>
                    <%
                }
                out.println("No more posts.");

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
        %>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
