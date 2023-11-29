<%@ page import="java.sql.*"%>
<%@ page import="java.util.Random" %>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  
<html>
  <head>
    <title>Create Project Page</title>
  </head>
  <body>
    <% 
        try {
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

            query = "SELECT orgname FROM companyleads WHERE username = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, username);
            rs1 = ps.executeQuery();

            

            %>
            <h3>Project Creation</h1>
            <form action= "projects.jsp" method = "post">
              <p>Please fill in this form to create a project.</p>
                
              <label for="username"><b>ProjectName</b></label>
              <input type="text" placeholder="Enter Project Name" name="projectName" id="projectName" required>

              <label for="Description"><b>Description</b></label>
              <input type="text" placeholder="Enter Description" name="description" id="description" required>

              <select name="orgNameTarget" reqiuired>
                <%while(rs1.next()){%>
                  <option value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>
                <%}%>
              </select>
          
              <button type="submit" class="submitButton">Submit</button>
            </form>
            <%
            String projectName = request.getParameter("projectName");
            String projectDescription = request.getParameter("description");
            String orgNameTarget = request.getParameter("orgNameTarget");
            if ( projectName != null & projectDescription != null){
                PreparedStatement pstmt = con.prepareStatement("INSERT INTO project (projectname, projectdescription, orgname) VALUES (?, ?, ?)");
                pstmt.setString(1, projectName);
                pstmt.setString(2, projectDescription);
                pstmt.setString(3, orgNameTarget);
                pstmt.executeUpdate();
                pstmt.close();
                con.close();
                out.println("project created");
                String redirectURL = "http://localhost:8080/SOT/projects.jsp";
                response.sendRedirect(redirectURL);

                
            }

            

          } catch(SQLException e) { 
            out.println("SQLException caught: " + e.getMessage()); 
        }
    %>
  </body>
</html>
