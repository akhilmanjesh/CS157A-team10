<%@ page import="java.sql.*"%>

<html>
  <head>
    <title></title>
  </head>
  <body>
    <h3>Create Team</h3>
    <form action="view_student_organization.jsp?orgname=<%=orgName%>" method="post">
        <label for="teamName"><b>Team Name</b></label>
        <input type="text" placeholder="Enter Team Name" name="teamName" id="teamName" required>

        <button type="submit" class="createTeamBtn">Create Team</button>
    </form>
   <%
        sso = request.getSession(false);
        String teamName = request.getParameter("teamName");

        String dbURL = "jdbc:mysql://localhost:3306/sot?autoReconnect=true&useSSL=false";
        PreparedStatement pstmt = null;     //Insert into Team Table
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(dbURL, user, password);
            if(teamName != null && !teamName.isEmpty()) {
                String sql = "SELECT * FROM teams WHERE teamname = ? and Orgname = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, teamName);
                pstmt.setString(2, orgName);
                rs = pstmt.executeQuery();

                if (!rs.next()){
                    sql = "INSERT INTO teams (TeamName, Orgname) VALUES (?, ?)";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, teamName);
                    pstmt.setString(2, orgName);
                    int rowsAffected = pstmt.executeUpdate();
                    if(rowsAffected > 0) {
                        out.println("<p>Team created successfully</p>");
                    String redirectURL = "http://localhost:8080/SOT/view_student_organization.jsp?orgname="+orgName;
                    response.sendRedirect(redirectURL);
                    } else {
                        out.println("<p>An error occurred while creating the team</p>");
                    }
                } else {
                    throw new SQLException("Team already exists.");
                }


            }
        } catch(SQLException e) {
            out.println("<p>" + e.getMessage() + "</p>");
        } catch(ClassNotFoundException e) {
            out.println("<p>ClassNotFoundException caught: " + e.getMessage() + "</p>");
        } finally {
            if(pstmt != null) {
                try {
                    pstmt.close();
                } catch(SQLException e) {
                    out.println("<p>Error closing PreparedStatement: " + e.getMessage() + "</p>");
                }
            }
            if(con != null) {
                try {
                    con.close();
                } catch(SQLException e) {
                    out.println("<p>Error closing Connection: " + e.getMessage() + "</p>");
                }
            }
        }
    %>
  </body>
</html>
