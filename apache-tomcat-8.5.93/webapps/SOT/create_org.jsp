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
<%
        String orgType = null;
        if (sso.getAttribute("type").equals("student")){
            orgType = "student";
        } else if (sso.getAttribute("type").equals("companystaff")){
            orgType = "companystaff";
        }
        out.println(orgType);
%>

    <div class ="text-start">
    <form action="organizations.jsp" method="post"> 
        <p>Please fill in this form to create an organization.</p>

        <div class=col-md-5>
        <label for="orgName"><b>Organization Name</b></label>
        <input type="text" placeholder="Enter Organization Name" name="orgName" id="orgName" required>

        <div id="schoolNameContainer" style="display:block;">
            <label for="schoolName"><b>School Name</b></label>
            <input type="text" placeholder="Enter School Name" name="schoolName" id="schoolName">
        </div>
        </div>
        <div class ="text-end" style="margin-top:20px">
        <button type="submit" class="btn btn-primary">Create Organization</button>
        </div>
    </form>

    <script>
            function hideSchool(){
                var orgType = "<%=orgType%>";
                console.log(orgType);
                if (orgType === 'student'){
                    schoolNameContainer.style.display = 'block';
                } else {
                    schoolNameContainer.style.display = 'none';
                }
            }
            hideSchool();
        </script>
    </div>
   <%


        String schoolName = request.getParameter("schoolName");
        String orgName = request.getParameter("orgName");
        String username = (String) sso.getAttribute("username");

        String dbURL = "jdbc:mysql://localhost:3306/sot?autoReconnect=true&useSSL=false";

        PreparedStatement pstmt = null;     //Insert into Org Table
        PreparedStatement pstmt2 = null;    //Insert into leader table
        PreparedStatement pstmt3 = null;    //Insert into members table
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
                    String redirectURL = "http://localhost:8080/SOT/organizations.jsp";
                    response.sendRedirect(redirectURL);
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
