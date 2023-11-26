<%@ page import="java.sql.*"%>
<%@ page import="java.util.Random" %>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.ZoneOffset"%>
<%@ page import="java.time.LocalDateTime"%>
<html>
  <head>
    <title>Create Project Page</title>
  </head>
  <body>
    <h3>Create Organization</h3>
    <form action="organizations.jsp" method="post"> 
        <p>Please fill in this form to create an organization.</p>

        <label for="orgName"><b>Organization Name</b></label>
        <input type="text" placeholder="Enter Organization Name" name="orgName" id="orgName" required>

        <div id="schoolNameContainer" style="display:none;">
            <label for="schoolName"><b>School Name</b></label>
            <input type="text" placeholder="Enter School Name" name="schoolName" id="schoolName">
        </div>

        <button type="submit" class="createOrgBtn">Create Organization</button>
    </form>

   <%
        sso = request.getSession(false);

        String orgType = null;
        if (sso.getAttribute("type").equals("student")){
            orgType = "student";
        } else if (sso.getAttribute("type").equals("companystaff")){
            orgType = "companystaff";
        }
        String schoolName = request.getParameter("schoolName");
        String orgName = request.getParameter("orgName");
        String username = (String) sso.getAttribute("username");

        String dbURL = "jdbc:mysql://localhost:3306/sot?autoReconnect=true&useSSL=false";
        String user = "root";
        String password = "1723";
        Connection con = null;
        PreparedStatement pstmt = null;     //Insert into Org Table
        PreparedStatement pstmt2 = null;    //Insert into leader table
        PreparedStatement pstmt3 = null;    //Insert into members table
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(dbURL, user, password);

            if(orgName != null && orgType != null) {
                String sql = "";
                if("student".equals(orgType)) {
                    sql = "INSERT INTO studentorg (OrgName, SchoolName) VALUES (?, ?)";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, orgName);
                    pstmt.setString(2, schoolName);
                    sql = "INSERT INTO studentleads (username, orgname) VALUES (?, ?)";
                    pstmt2 = con.prepareStatement(sql);
                    pstmt2.setString(1, username);
                    pstmt2.setString(2, orgName);
                    sql = "INSERT INTO memberofStudent (username, orgname, joindate) VALUES (?, ?, ?)";
                    pstmt3 = con.prepareStatement(sql);
                    pstmt3.setString(1, username);
                    pstmt3.setString(2, orgName);

                    LocalDateTime utcDateTime = LocalDateTime.now(ZoneOffset.UTC);
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy:MM:dd");
                    String formattedDate = utcDateTime.format(formatter);

                    pstmt3.setString(3, formattedDate);

                } else if("companystaff".equals(orgType)) {
                    sql = "INSERT INTO companyorg (OrgName) VALUES (?)";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, orgName);
                    sql = "INSERT INTO companyleads (username, orgname) VALUES (?, ?)";
                    pstmt2 = con.prepareStatement(sql);
                    pstmt2.setString(1, username);
                    pstmt2.setString(2, orgName);
                    sql = "INSERT INTO membersofcompany (username, orgname) VALUES (?, ?)";
                    pstmt3 = con.prepareStatement(sql);
                    pstmt3.setString(1, username);
                    pstmt3.setString(2, orgName);
                }
                int rowsAffected = pstmt.executeUpdate();
                int rowsAffected2 = pstmt2.executeUpdate();
                int rowsAffected3 = pstmt3.executeUpdate();
                if(rowsAffected > 0 && rowsAffected2 > 0 && rowsAffected3 > 0) {
                    out.println("<p>Organization created successfully</p>");
                } else {
                    out.println("<p>An error occurred</p>");
                }
            }
        } catch(SQLException e) {
            out.println("<p>SQLException caught: " + e.getMessage() + "</p>");
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
