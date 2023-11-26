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
        <a href="http://localhost:8080/SOT/index.jsp"><H1>Home</H1></a>

        <%
        String db = "sot";
        Properties props = new Properties();
        InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties");

        if (input != null) {
            props.load(input);
            input.close();

            String user = props.getProperty("db.username");
            String password = props.getProperty("db.password");
            
            Connection con = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?autoReconnect=true&useSSL=false", user, password);

                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT EventName, orgName, EventDate FROM events");

                while (rs.next()) {
                    String eventName = rs.getString("EventName");
                    String studentOrgName = rs.getString("StudentOrgName");
                    String eventDate = rs.getString("EventDate");
                    %>
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title"><%= eventName %></h5>
                            <p class="card-text">Organized by: <%= studentOrgName %></p>
                            <p class="card-text">Date: <%= eventDate %></p>
                        </div>
                    </div>
                    <%
                }

                rs.close();
                stmt.close();
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
