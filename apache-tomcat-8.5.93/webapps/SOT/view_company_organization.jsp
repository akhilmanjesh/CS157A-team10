<%@ page import="java.sql.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  

<html>
    <head>
        <title>Organization</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <%@include file = "navbar.jsp"%>
        <div class = "row justify-content-center">
        <div class = "col-8 p-3 mb-2 bg-light text-dark">
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
            String orgName = request.getParameter("orgname");

            Statement stmt = con.createStatement();

            String query = "SELECT * FROM companyorg WHERE orgname = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, orgName);

            ResultSet rs = ps.executeQuery();
            //Check for valid website and print the contents.
            if (rs.next()){  
                %>
                <h2><%=orgName%></h2>
                <%

                query = "SELECT username FROM membersofcompany WHERE orgname = ?";
                PreparedStatement ps2 = con.prepareStatement(query);
                ps2.setString(1, orgName);
                rs = ps2.executeQuery();
                %>
                <h5>Members List</h5>
                <%
                while (rs.next()){
                    %>
                    <div class ="card">
                        <div class="card-body">
                            <h5 class="card-title"><%=rs.getString(1)%></h5>
                            <p class="card-text"></p>
                        </div>
                    </div>
                    <%
                }

            } else {
                out.println("Invalid org name!");
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
        </div>
    </div>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
