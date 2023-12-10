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
Connection con = null;
Properties props = new Properties();
InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties");
props.load(input);
String user = props.getProperty("db.username");
String password = props.getProperty("db.password");
String url = props.getProperty("db.url");
con = DriverManager.getConnection(url, user, password);
input.close();

            String username = (String) sso.getAttribute("username");
            String accountType= (String) sso.getAttribute("type");
            String orgName = request.getParameter("orgname");
            if (accountType == "student"){
                String query = "SELECT * FROM studentleads WHERE username = ? AND orgname = ?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, username);
                ps.setString(2, orgName);
                ResultSet rs = ps.executeQuery();
                if (rs.next()){
                    query = "DELETE FROM studentorg WHERE orgname = ?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, orgName);
                    int rowsAffected = ps.executeUpdate();
                    if (rowsAffected > 0){
                        out.println("delete sucessful");
                    } else {
                        out.println("error");
                    }
                }      
            } else if (accountType == "companystaff"){
                String query = "SELECT * FROM companyleads WHERE username = ? AND orgname = ?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, username);
                ps.setString(2, orgName);
                ResultSet rs = ps.executeQuery();
                if (rs.next()){
                    query = "DELETE FROM companyorg WHERE orgname = ?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, orgName);
                    int rowsAffected = ps.executeUpdate();
                    if (rowsAffected > 0){
                        out.println("delete sucessful");
                    } else {
                        out.println("error");
                    }
                }   
            }
            

            String redirectURL = "http://localhost:8080/SOT/organizations.jsp";
            response.sendRedirect(redirectURL);


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
