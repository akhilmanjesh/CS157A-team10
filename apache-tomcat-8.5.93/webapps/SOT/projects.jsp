<%@ page import="java.sql.*"%>
<html>
    <head>
        <title>Projects Page</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <a href="http://localhost:8080/SOT/index.jsp"><H1>Home</H1></a>

        <%
        String db = "sot";
            String user;
                user = "root";
            String password = "1723";
            try {
                java.sql.Connection con;
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sot?autoReconnect=true&useSSL=false",user, password);

                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT ProjectName, ProjectDescription FROM project");

                while(rs.next()) {
                    String projectName = rs.getString(1);
                    String projectDescription = rs.getString(2);
                    %>
                    <div class ="card">
                        <div class="card-body">
                            <h5 class="card-title"><%= projectName %></h5>
                            <p class="card-text"><%= projectDescription %></p>
                        </div>
                    </div>
                    <%
                }


                rs.close();
                stmt.close();
                con.close();
            } catch(SQLException e) {
                out.println("SQLException caught: " + e.getMessage()); 
            }

        %>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>