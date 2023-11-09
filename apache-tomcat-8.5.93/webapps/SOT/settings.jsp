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

    <script>
        document.getElementById('orgType').addEventListener('change', function() {
            var orgType = this.value;
            var schoolNameContainer = document.getElementById('schoolNameContainer');
            if(orgType === 'student') {
                schoolNameContainer.style.display = 'block';
            } else {
                schoolNameContainer.style.display = 'none';
            }
        });
    </script>

    <%
        String orgName = request.getParameter("orgName");
        String orgType = request.getParameter("orgType");
        String schoolName = request.getParameter("schoolName");

        if(orgName != null && orgType != null) {
            String dbURL = "jdbc:mysql://localhost:3306/sot?autoReconnect=true&useSSL=false";
            String user = "root";
            String password = "1723";

            Connection con = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                con = DriverManager.getConnection(dbURL, user, password);

                String sql = "";

                if("student".equals(orgType)) {
                    sql = "INSERT INTO studentorg (OrgName, SchoolName) VALUES (?, ?)";
                } else if("company".equals(orgType)) {
                    sql = "INSERT INTO companyorg (OrgName) VALUES (?)";
                }

                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, orgName);

                if("student".equals(orgType)) {
                    pstmt.setString(2, schoolName);
                }

                int rowsAffected = pstmt.executeUpdate();

                if(rowsAffected > 0) {
                    out.println("<p>Organization created successfully</p>");
                } else {
                    out.println("<p>An error occurred</p>");
                }
            } catch(SQLException e) {
                out.println("<p>SQLException caught: " + e.getMessage() + "</p>");
            } catch(ClassNotFoundException e) {
                out.println("<p>ClassNotFoundException caught: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if(pstmt != null) pstmt.close();
                    if(con != null) con.close();
                } catch(SQLException se) {
                    out.println("<p>SQLException on close: " + se.getMessage() + "</p>");
                }
            }
        }
    %>
</body>
</html>
