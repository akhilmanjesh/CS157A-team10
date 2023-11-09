<%@ page import="java.sql.*"%>
<%@ page import="java.util.Random" %>
<html>
  <head>
    <title>Create Project Page</title>
  </head>
  <body>
    <a href="http://localhost:8080/SOT/index.jsp"><H1>Home</H1></a>
    <h3>Project Creation</h1>
    <form action= "create_project.jsp" method = "post">
      <p>Please fill in this form to create a project.</p>
        
      <label for="username"><b>ProjectName</b></label>
      <input type="text" placeholder="Enter Project Name" name="projectName" id="projectName" required>

      <label for="Desscription"><b>Description</b></label>
      <input type="text" placeholder="Enter Description" name="description" id="description" required>
  
      <button type="submit" class="submitButton">Submit</button>
    </form>

    <% 
     String db = "sot";
        String user; // assumes database name is the same as username
          user = "root";
        String password = "1723";
        try {
            java.sql.Connection con; 
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sot?autoReconnect=true&useSSL=false",user, password);
            
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
            
            if ( projectName != null & projectDescription != null){
                

                PreparedStatement pstmt = con.prepareStatement("INSERT INTO project (projectid, projectname, projectdescription) VALUES (?, ?, ?)");
                pstmt.setInt(1, last_id + 1);
                pstmt.setString(2, projectName);
                pstmt.setString(3, projectDescription);
                pstmt.executeUpdate();
                pstmt.close();
                con.close();
                out.println("project created");
            }
            

          } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
  </body>
</html>
