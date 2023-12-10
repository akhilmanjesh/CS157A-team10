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
        <div class="row justify-content-center">
        <div class="col-8 p-3 mb-2 bg-light text-dark">

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
            String orgName = request.getParameter("orgname");
            String teamName = request.getParameter("teamname");
            %>
            <a href = "view_student_organization.jsp?orgname=<%=orgName%>">         <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-left" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M14.5 1.5a.5.5 0 0 1 .5.5v4.8a2.5 2.5 0 0 1-2.5 2.5H2.707l3.347 3.346a.5.5 0 0 1-.708.708l-4.2-4.2a.5.5 0 0 1 0-.708l4-4a.5.5 0 1 1 .708.708L2.707 8.3H12.5A1.5 1.5 0 0 0 14 6.8V2a.5.5 0 0 1 .5-.5"/>
            </svg></a>
            <br>
            <h3><%=teamName%></h3><br>
            <h3>Team Members</h3><br>
            <%
            String query = "SELECT username FROM assignedTo WHERE teamname = ? AND orgname = ?";
            PreparedStatement ps = con.prepareStatement(query);   
            ps.setString(1, teamName);                  
            ps.setString(2, orgName);
            ResultSet rsTeams = ps.executeQuery();

            //Verify Owner
            query = "SELECT username FROM studentLeads WHERE username = ? AND orgname = ?";
            ps = con.prepareStatement(query);   
            ps.setString(1, username);
            ps.setString(2, orgName);
            ResultSet rs = ps.executeQuery();

            //Owner View
            if (rs.next()){
                while (rsTeams.next()){
                    %>
                        <div class ="card">
                            <div class="card-body">
                                <h5 class="card-title"><%=rsTeams.getString(1)%></h5>
                                <p class="card-text"><a href= "http://localhost:8080/SOT/remove_team_member.jsp?orgname=<%=orgName%>&teamname=<%=teamName%>&target=<%=rsTeams.getString(1)%>"><button>Remove User</button></a></p>
                            </div>
                        </div>
                        
                    <%
                }

                %>
                <%@include file="edit_team.jsp"%>
                <%
            } else {
                //Member List
                while (rsTeams.next()){
                    %>
                        <div class ="card">
                            <div class="card-body">
                                <h5 class="card-title"><%=rsTeams.getString(1)%></h5>
                            </div>
                        </div>
                        
                    <%
                }
            }




        } catch(SQLException e) {
            out.println(e.getMessage()); 
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
