<%@ page import="java.sql.*"%>
<%@ page import="java.util.Random" %>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Create Project Page</title>
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="style.css">
</head>
<body>
  <%@include file="navbar.jsp" %>  
  <div class="container mt-5">
    <h3>Project Creation</h3>
    <form action="create_project.jsp" method="post">
      <p>Please fill in this form to create a project.</p>

      <div class="form-group">
        <label for="projectName"><b>Project Name</b></label>
        <input type="text" class="form-control" placeholder="Enter Project Name" name="projectName" id="projectName" required>
      </div>

      <div class="form-group">
        <label for="description"><b>Description</b></label>
        <input type="text" class="form-control" placeholder="Enter Description" name="description" id="description" required>
      </div>

      <div class="form-group">
        <label for="organization"><b>Organization</b></label>
        <select class="form-control" name="organization" id="organization">
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

              HttpSession sso1 = request.getSession(false);
              String username = (String) sso1.getAttribute("username");

              String orgQuery = "SELECT orgname FROM membersofcompany WHERE username = ?";
              PreparedStatement orgPs = con.prepareStatement(orgQuery);
              orgPs.setString(1, username);
              ResultSet orgRs = orgPs.executeQuery();

              while(orgRs.next()) {
                String orgname = orgRs.getString("orgname");
              %>
                <option value="<%= orgname %>"><%= orgname %></option>
              <%
              }
              orgRs.close();
              orgPs.close();
            %>
          </select>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
      </form>
      <%
        String query = "SELECT MAX(projectid) AS last_id FROM project";
        PreparedStatement ps = con.prepareStatement(query);
        ResultSet rs1 = ps.executeQuery();
        int last_id = 0;

        if(rs1.next()) {
          last_id = rs1.getInt(1);
        } else {
          out.println("No records");
        }

        String projectName = request.getParameter("projectName");
        String projectDescription = request.getParameter("description");
        String projectOrgName = request.getParameter("organization");

        if (projectName != null & projectDescription != null){
          PreparedStatement pstmt = con.prepareStatement("INSERT INTO project (projectid, projectname, projectdescription, orgname) VALUES (?, ?, ?, ?)");
          pstmt.setInt(1, last_id + 1);
          pstmt.setString(2, projectName);
          pstmt.setString(3, projectDescription);
          pstmt.setString(4, projectOrgName);
          pstmt.executeUpdate();
          pstmt.close();
          con.close();
          out.println("project created");
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
    </div>

    <script src="js/bootstrap.min.js"></script>
  </body>
  </html>