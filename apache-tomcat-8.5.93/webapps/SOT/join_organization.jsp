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
            String orgName = request.getParameter("orgname");

            if (sso.getAttribute("username") != null && sso.getAttribute("type") == "student"){
                String query = "SELECT * FROM memberofstudent WHERE username = ? AND orgName = ?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, username);
                ps.setString(2, orgName);
                ResultSet rs1 = ps.executeQuery();
                if (!rs1.next()){
                    PreparedStatement pstmt = con.prepareStatement("INSERT INTO memberofstudent (username, orgname, joindate) VALUES (?, ?, ?)");
                    pstmt.setString(1, username);
                    pstmt.setString(2, orgName);
    
                    LocalDateTime utcDateTime = LocalDateTime.now(ZoneOffset.UTC);
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy:MM:dd");
                    String formattedDate = utcDateTime.format(formatter);
    
                    pstmt.setString(3, formattedDate);
                    pstmt.executeUpdate();
                    pstmt.close();
                }
                rs1.close();

            } else if (sso.getAttribute("username") != null && sso.getAttribute("type") == "companystaff"){
                String query = "SELECT * FROM membersofcompany WHERE username = ? AND orgName = ?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, username);
                ps.setString(2, orgName);
                ResultSet rs1 = ps.executeQuery();
                if (!rs1.next()){
                    PreparedStatement pstmt = con.prepareStatement("INSERT INTO membersofcompany (username, orgname) VALUES (?, ?)");
                    pstmt.setString(1, username);
                    pstmt.setString(2, orgName);
                    pstmt.executeUpdate();
                    pstmt.close();
                }
                rs1.close();
            } else {
                out.println("please log in");
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
