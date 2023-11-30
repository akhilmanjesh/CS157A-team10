<%@ page import="java.sql.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  

<html>
    <head>
        <title>Events Page</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <%@include file="navbar.jsp"%>
        <hr class="featurette-divider">
        <h3> Events </h3>

        <%
        String db = "sot";
        Properties props = new Properties();
        InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties");

        if (input != null) {
            props.load(input);
            input.close();

            String user = props.getProperty("db.username");
            String password = props.getProperty("db.password");
            String username = (String) sso.getAttribute("username");
            
            Connection con = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?autoReconnect=true&useSSL=false", user, password);
                String sql = "SELECT EventName, orgName, eventDate FROM events WHERE orgName IN (SELECT orgName FROM memberofstudent WHERE username = ?)";
                PreparedStatement pstmt = con.prepareStatement(sql);
                pstmt.setString(1, username);
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    String eventName = rs.getString("EventName");
                    String orgName = rs.getString("orgName"); 
                    String eventDate = rs.getString("EventDate");
                    %>
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title"><%= eventName %></h5>
                            <p class="card-text">Organized by: <%= orgName %></p> <!-- Corrected line -->
                            <p class="card-text">Date: <%= eventDate %></p>
                        </div>
                    </div>
                    <%
                }
                %>
                <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">No more events.</h5>
                        </div>
                   </div>
                <%
                rs.close();
                pstmt.close();
            } catch (SQLException e) {
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
        } else {
            out.println("Error: Unable to find config.properties file.");
        }
        %>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
