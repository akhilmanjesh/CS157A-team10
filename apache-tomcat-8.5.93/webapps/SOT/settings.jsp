<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<html>
<head>
    <title>Settings Page</title>
</head>
<body>
    <a href="http://localhost:8080/SOT/index.jsp"><H1>Home</H1></a>

    <%
        HttpSession sso = request.getSession(false);
        String loggedInUser = (sso != null && sso.getAttribute("username") != null) ? (String) sso.getAttribute("username") : "test"; 
        String orgType = request.getParameter("orgType");
        String orgName = request.getParameter("orgName");

        if (orgName == null || orgName.isEmpty()) {
          orgName = "SJSUACM"; 
        }

        String action = request.getParameter("action");
        String friendUsername = request.getParameter("friendUsername");

        String dbURL = "jdbc:mysql://localhost:3306/sot?autoReconnect=true&useSSL=false";
        String user = "root";
        String password = "1723";
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(dbURL, user, password);
        try {
            String sql = "SELECT user2 FROM friends WHERE user1 = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, loggedInUser);
            rs = pstmt.executeQuery();
            out.println("<table>");
            while (rs.next()) {
                friendUsername = rs.getString("user2"); 
                
            }
            out.println("</table>");
        } catch(SQLException e) {
            out.println("<p>SQLException caught: " + e.getMessage() + "</p>");
        }
        if ("deleteFriend".equals(request.getParameter("action"))) {
            try {
                String sql = "DELETE FROM friends WHERE user1 = ? AND user2 = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, loggedInUser);
                pstmt.setString(2, friendUsername);
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<p>Friend deleted successfully.</p>");
                } else {
                    out.println("<p>Error occurred while deleting the friend.</p>");
                }
            } catch(SQLException e) {
                out.println("<p>SQLException caught: " + e.getMessage() + "</p>");
            }
        }
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(dbURL, user, password);
    
            if ("addFriend".equals(action) && friendUsername != null) {
                String sql = "INSERT INTO friends (user1, user2) VALUES (?, ?)";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, loggedInUser);
                pstmt.setString(2, friendUsername);
                pstmt.executeUpdate();
            }
    
            if ("removeFriend".equals(action) && friendUsername != null) {
                String sql = "DELETE FROM friends WHERE user1 = ? AND user2 = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, loggedInUser);
                pstmt.setString(2, friendUsername);
                pstmt.executeUpdate();
            }
    
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
            if (con != null) try { con.close(); } catch (SQLException e) { }
        }

    %>
</body>
</html>
    <h3>Manage Friends</h3>
    <form method="post">
        <label for="friendUsername"><b>Friend's Username</b></label>
        <input type="text" placeholder="Enter Friend Username" name="friendUsername" required>
        <button type="submit" name="action" value="addFriend">Add Friend</button>
        <button type="submit" name="action" value="removeFriend">Remove Friend</button>
    </form>

    <div id="currentFriends">
        <h4>Current Friends</h4>
        <%
            try {
                con = DriverManager.getConnection(dbURL, user, password);
                String sql = "SELECT user2 FROM friends WHERE user1 = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, loggedInUser);
                rs = pstmt.executeQuery();

                out.println("<ul>");
                while (rs.next()) {
                    out.println("<li>" + rs.getString("user2") + "</li>");
                }
                out.println("</ul>");
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                if (con != null) try { con.close(); } catch (SQLException e) { }
            }
        %>
    </div>


    <h3>Project Reviews</h3>
    <form method="post">
        <label for="projectID"><b>Project</b></label>
        <label for="projectID"><b>Project ID</b></label>
        <input type="text" name="projectID" id="projectID" placeholder="Enter Project ID" required>
        <label for="review"><b>Review</b></label>
        <textarea name="review" id="review" placeholder="Write your review here..." required></textarea>
        <button type="submit">Submit Review</button>
    </form>