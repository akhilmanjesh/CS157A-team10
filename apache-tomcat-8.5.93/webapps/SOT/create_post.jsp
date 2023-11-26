<%@ page import="java.sql.*"%>

<html>
  <head>
    <title></title>
  </head>
  <body>
    <h3>Create Post</h3>
    <form action="view_student_organization.jsp?orgname=<%=orgName%>" method="post">
        <label for="postContent"><b>Post Content</b></label>
        <textarea name="postContent" id="postContent" required></textarea>

        <button type="submit" class="createPostBtn">Create Post</button>
    </form>
   <%
        sso = request.getSession(false);
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(dbURL, user, password);
            String postContent = request.getParameter("postContent");
            if(postContent != null && !postContent.trim().isEmpty()) {
            
                String sql = "INSERT INTO posts (body, orgname) VALUES (?, ?)";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, postContent);
                pstmt.setString(2, orgName);
            
                int rowsAffected = pstmt.executeUpdate();
                if(rowsAffected > 0) {
                    out.println("<p>Post created successfully</p>");
                } else {
                    out.println("<p>An error occurred while creating the post</p>");
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
