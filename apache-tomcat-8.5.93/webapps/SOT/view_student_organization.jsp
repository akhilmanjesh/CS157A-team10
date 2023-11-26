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
        HttpSession sso = request.getSession(false);
        String username = (String) sso.getAttribute("username");
        String orgName = request.getParameter("orgname");
    %>
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
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?autoReconnect=true&useSSL=false", user, password);
           

            Statement stmt = con.createStatement();

            String query = "SELECT * FROM studentorg WHERE orgname = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, orgName);

            ResultSet rs = ps.executeQuery();
            //Check for valid website and print the contents.
            if (rs.next()){  
                //Get Members
                String schoolName = rs.getString(2);
                out.println(orgName + "<br>");
                out.println(schoolName + "<br>");
                out.println("Members List: <br>");
                query = "SELECT username FROM memberofstudent WHERE orgname = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, orgName);
                rs = ps.executeQuery();
                while (rs.next()){
                    out.println(rs.getString(1) + "<br>");
                }
                //Get Teams
                out.println("Teams List: <br>");
                query = "SELECT * FROM teams WHERE orgname = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, orgName);
                rs = ps.executeQuery();
                while (rs.next()){
                    String tempTeamName = rs.getString(1);
                    %>
                    <a href = "view_team.jsp?orgname=<%=orgName%>&teamname=<%=tempTeamName%>"> <%=tempTeamName%> </a>
                    <%
                }

                //Check if owner
                query = "SELECT * FROM studentleads WHERE username = ? AND orgname = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, username);
                ps.setString(2, orgName);
                rs = ps.executeQuery();
                //Owner View
                if (rs.next()){
                %>
                    <%@include file="create_team.jsp" %>
                    <%@include file="create_post.jsp" %>
                <%
                }
            ps.close();
            rs.close();
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
