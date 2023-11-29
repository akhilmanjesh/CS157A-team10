<%@ page import="java.sql.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>

<html>
  <head>
    <title>Edit Project Page</title>
  </head>
  <body>
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

        int projectId = Integer.parseInt(request.getParameter("projectId"));

        String projectQuery = "SELECT * FROM project WHERE projectid = ?";
        PreparedStatement ps = con.prepareStatement(projectQuery);
        ps.setInt(1, projectId);
        ResultSet rs = ps.executeQuery();

        if(rs.next()) {
            String projectName = rs.getString(2);
            String projectDescription = rs.getString(3);
    %>
    <form action="editProject.jsp" method="post">
        <input type="hidden" name="projectId" value="<%= projectId %>">
        
        <label for="projectName"><b>Project Name</b></label>
        <input type="text" name="projectName" value="<%= projectName %>" required>

        <label for="projectDescription"><b>Description</b></label>
        <input type="text" name="projectDescription" value="<%= projectDescription %>" required>

        <button type="submit" class="btn btn-primary">Update Project</button>
    </form>

    <%
            String newProjectName = request.getParameter("projectName");
            String newProjectDescription = request.getParameter("projectDescription");
            if(newProjectName != null && newProjectDescription != null) {
                String updateQuery = "UPDATE project SET projectname = ?, projectdescription = ? WHERE projectid = ?";
                PreparedStatement updatedPs = con.prepareStatement(updateQuery);
                updatedPs.setString(1, newProjectName);
                updatedPs.setString(2, newProjectDescription);
                updatedPs.setInt(3, projectId);
                updatedPs.executeUpdate();
                updatedPs.close();
                out.println("project updated");
            }
        } else {
            out.println("Project not found");
        }
        rs.close();
        ps.close();
    } catch(SQLException | ClassNotFoundException e) {
        out.println("Exception caught: " + e.getMessage());
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