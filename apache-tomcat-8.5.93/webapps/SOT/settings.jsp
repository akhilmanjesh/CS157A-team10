<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<html>
<head>
    <title>Settings Page</title>
</head>
<body>
    <a href="http://localhost:8080/SOT/index.jsp"><H1>Home</H1></a>
    <h3>Create Organization</h3>
    <form action="settings.jsp" method="post"> 
        <p>Please fill in this form to create an organization.</p>

        <label for="orgName"><b>Organization Name</b></label>
        <input type="text" placeholder="Enter Organization Name" name="orgName" id="orgName" required>

        <label for="orgType"><b>Organization Type</b></label>
        <select name="orgType" id="orgType" required>
            <option value="company">Company</option>
            <option value="student">Student</option>
        </select>

        <div id="schoolNameContainer" style="display:none;">
            <label for="schoolName"><b>School Name</b></label>
            <input type="text" placeholder="Enter School Name" name="schoolName" id="schoolName">
        </div>

        <button type="submit" class="createOrgBtn">Create Organization</button>
    </form>
    <h3>Create Team</h3>
    <form action="settings.jsp" method="post">
        <label for="teamName"><b>Team Name</b></label>
        <input type="text" placeholder="Enter Team Name" name="teamName" id="teamName" required>

        <button type="submit" class="createTeamBtn">Create Team</button>
    </form>
    <h3>Create Post</h3>
    <form action="settings.jsp" method="post">
        <label for="postContent"><b>Post Content</b></label>
        <textarea name="postContent" id="postContent" required></textarea>

        <button type="submit" class="createPostBtn">Create Post</button>
    </form>
    <h3>Create Event</h3>
    <form action="settings.jsp" method="post">
        <label for="eventName"><b>Event Name</b></label>
        <input type="text" placeholder="Enter Event Name" name="eventName" id="eventName" required>

        <label for="eventDate"><b>Event Date</b></label>
        <input type="date" name="eventDate" id="eventDate" required>

        <button type="submit" class="createEventBtn">Create Event</button>
    </form>




    <%
        String orgType = request.getParameter("orgType");
        String schoolName = request.getParameter("schoolName");
        String teamName = request.getParameter("teamName");
        String postContent = request.getParameter("postContent");
        String eventName = request.getParameter("eventName");
        String eventDate = request.getParameter("eventDate");
        String orgName = request.getParameter("orgName");

        if (orgName == null || orgName.isEmpty()) {
          orgName = "SJSUACM"; 
        }

        String dbURL = "jdbc:mysql://localhost:3306/sot?autoReconnect=true&useSSL=false";
        String user = "root";
        String password = "1723";
        Connection con = null;
        PreparedStatement pstmt = null;
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
                } else if("company".equals(orgType)) {
                    sql = "INSERT INTO companyorg (OrgName) VALUES (?)";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, orgName);
                }
                int rowsAffected = pstmt.executeUpdate();
                if(rowsAffected > 0) {
                    out.println("<p>Organization created successfully</p>");
                } else {
                    out.println("<p>An error occurred</p>");
                }
            }

            if(teamName != null && !teamName.isEmpty()) {
                String sql = "INSERT INTO teams (TeamName, Orgname) VALUES (?, ?)";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, teamName);
                pstmt.setString(2, orgName);
                int rowsAffected = pstmt.executeUpdate();
                if(rowsAffected > 0) {
                    out.println("<p>Team created successfully</p>");
                } else {
                    out.println("<p>An error occurred while creating the team</p>");
                }
            }

            if(postContent != null && !postContent.trim().isEmpty()) {
            
                String sql = "INSERT INTO posts (body) VALUES (?)";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, postContent);
            
                int rowsAffected = pstmt.executeUpdate();
                if(rowsAffected > 0) {
                    out.println("<p>Post created successfully</p>");
                } else {
                    out.println("<p>An error occurred while creating the post</p>");
                }
            }

            if(eventName != null && eventDate != null && !eventName.trim().isEmpty() && !eventDate.trim().isEmpty()) {
                boolean isAdmin = true; // FIXME: check actual admin 
                boolean isStudentOrgAdmin = true; // FIXME: check if admin is of student org
            
                if(isAdmin && isStudentOrgAdmin) {
                    String sql = "INSERT INTO events (eventname, eventdate, orgname) VALUES (?, ?, ?)";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, eventName);
                    pstmt.setDate(2, java.sql.Date.valueOf(eventDate));
                    pstmt.setString(3, orgName); 
            
                    int rowsAffected = pstmt.executeUpdate();
                    if(rowsAffected > 0) {
                        out.println("<p>Event created successfully</p>");
                    } else {
                        out.println("<p>Error occurred while creating the event</p>");
                    }
                } else {
                    out.println("<p>Only administrators of student organizations can create events.</p>");
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