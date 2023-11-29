<%@ page import="java.sql.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.ZoneOffset"%>
<%@ page import="java.time.LocalDateTime"%>

<html>
    <head>
        <title>Organization</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <a href="http://localhost:8080/SOT/index.jsp"><H1>Home</H1></a>
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
            String type = (String) sso.getAttribute("type");
            String eventName = request.getParameter("eventname");
            String eventDate = request.getParameter("eventdate");   
            String orgName = (String) request.getParameter("orgname");

            if (username != null && type == "student"){
                String query = "SELECT username FROM studentleads WHERE username = ? AND orgname = ?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, username);
                ps.setString(2, orgName);
                ResultSet rs = ps.executeQuery();
                if (rs.next()){

                    query = "DELETE FROM events WHERE eventname= ? AND eventdate = ? AND orgname = ?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, eventName);
                    ps.setString(2, eventDate);
                    ps.setString(3, orgName);
                    int rowsAffected = ps.executeUpdate();
                    out.println(rowsAffected);      
                    if (rowsAffected == 0){
                        out.println("404");
                    } else {
                        String redirectURL = "http://localhost:8080/SOT/view_student_organization.jsp?orgname="+orgName;
                        response.sendRedirect(redirectURL);
                    }
                } else {
                    out.println("404");
                }

            } else {
                String redirectURL = "http://localhost:8080/SOT/index.jsp";
                response.sendRedirect(redirectURL);
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
