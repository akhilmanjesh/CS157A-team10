<%@ page import="java.sql.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  

<html>
    <head>
        <title>Projects Page</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="style.css">
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

            // Delete post logic
            String deletePostId = request.getParameter("deletePostId");
            if (deletePostId != null && !deletePostId.isEmpty()) {
                String deleteQuery = "DELETE FROM posts WHERE postid = ?";
                PreparedStatement deleteStmt = con.prepareStatement(deleteQuery);
                deleteStmt.setString(1, deletePostId);
                deleteStmt.executeUpdate();
                deleteStmt.close();
            }

            HttpSession sso = request.getSession(false);
            String username = (String) sso.getAttribute("username");
            if (username == null){
                out.println("Login to view posts.");
            } else {
                String query = "SELECT * FROM posts WHERE orgName IN (SELECT orgName FROM memberofStudent WHERE username = ?)";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();
                while(rs.next()) {
                    String postId = rs.getString(1); // Assuming the first column is the post ID
                    %>
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title"><%=rs.getString(3)%></h5>
                            <p class="card-text"><%=rs.getString(2)%></p>
                            <form method="post">
                                <input type="hidden" name="deletePostId" value="<%=postId%>"/>
                                <button type="submit">Delete Post</button>
                            </form>
                        </div>
                    </div>
                    <%
                }
                out.println("No more posts.");

                rs.close();
                ps.close();
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
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
