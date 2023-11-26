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
        <a href="http://localhost:8080/SOT/index.jsp"><H1>Home</H1></a>
        
        <h3>Create Team</h3>
        <form action="settings.jsp" method="post">
            <label for="teamName"><b>Team Name</b></label>
            <input type="text" placeholder="Enter Team Name" name="teamName" id="teamName" required>
    
            <button type="submit" class="createTeamBtn">Create Team</button>
        </form>
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
            HttpSession sso = request.getSession(false);
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?autoReconnect=true&useSSL=false", user, password);
           
            String username = (String) sso.getAttribute("username");
            String orgName = request.getParameter("orgname");

            Statement stmt = con.createStatement();

            String query = "SELECT * FROM studentorg WHERE orgname = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, orgName);

            ResultSet rs = ps.executeQuery();
            //Check for valid website and print the contents.
            if (rs.next()){  
                String schoolName = rs.getString(2);
                out.println(orgName + "<br>");
                out.println(schoolName + "<br>");
                out.println("Members List: <br>");
                query = "SELECT username FROM memberofstudent WHERE orgname = ?";
                PreparedStatement ps2 = con.prepareStatement(query);
                ps2.setString(1, orgName);
                rs = ps2.executeQuery();
                while (rs.next()){
                    out.println(rs.getString(1) + "<br>");
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
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
