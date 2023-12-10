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

        try {
            sso = request.getSession(false);
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
           
            username = (String) sso.getAttribute("username");
            orgName = request.getParameter("orgname");
            teamName = request.getParameter("teamname");
            
            //Display valid members to be added
            query = "SELECT username FROM memberofStudent WHERE orgname = ? AND username NOT IN (SELECT username FROM assignedTo WHERE teamname = ? AND orgname = ?)";
            ps = con.prepareStatement(query); 
            ps.setString(1, orgName);
            ps.setString(2, teamName);
            ps.setString(3, orgName);           
            ResultSet choice = ps.executeQuery();
            %>
            <form method="post">
                Assign User to Team: 
                <select name="userTarget">
                    <%while(choice.next()){%>
                        <option value="<%=choice.getString(1)%>"><%=choice.getString(1)%></option>
                    <%}%>
                </select>
                <br/><br/>
                <input type="submit" value="Add"/>
            </form>
            <%

            String userTarget = request.getParameter("userTarget");
            if (userTarget != null){
                query = "INSERT INTO assignedTo (username, teamname, orgname) VALUES (?, ?, ?)";
                ps = con.prepareStatement(query);
                ps.setString(1, userTarget);
                ps.setString(2, teamName);
                ps.setString(3, orgName);
                int rowsAffected = ps.executeUpdate();
                String redirectURL = "http://localhost:8080/SOT/view_team.jsp?orgname="+orgName+"&teamname="+teamName;
                response.sendRedirect(redirectURL);
            }
            
        } catch(SQLException e) {
            out.println("SQLException caught: " + e.getMessage()); 
        } 
        %>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
