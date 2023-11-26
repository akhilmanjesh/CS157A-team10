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
            String teamName = request.getParameter("teamname");
            %>
            <a href = "view_student_organization.jsp?orgname=<%=orgName%>"> <%=orgName%> </a>
            <%
            out.println(teamName);
            //Owner View
            String query = "SELECT username FROM studentLeads WHERE username = ? AND orgname = ?";
            PreparedStatement ps = con.prepareStatement(query);   
            ps.setString(1, username);
            ps.setString(2, orgName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()){
                %>
                <%@include file="edit_team.jsp"%>
                <%
            }
            //Member List
            query = "SELECT * FROM assignedTo WHERE teamname = ? AND orgname = ?";
            ps = con.prepareStatement(query);   
            ps.setString(1, teamName);                  
            ps.setString(2, orgName);
            rs = ps.executeQuery();
            while (rs.next()){
                out.println(rs.getString(1));
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
