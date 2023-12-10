<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  
<html>
<head>
    <title>Friends</title>
</head>
<body>
    <%@include file = "navbar.jsp"%>
    <div class="row justify-content-center">
    <div class = "col-8 p-3 mb-2 bg-light text-dark">
    <%
        sso = request.getSession(false);
        String loggedInUser = (sso != null && sso.getAttribute("username") != null) ? (String) sso.getAttribute("username") : "test"; 

        String action = request.getParameter("action");
        String friendUsername = request.getParameter("friendUsername");

        String dbURL = "jdbc:mysql://localhost:3306/sot?autoReconnect=true&useSSL=false";
        Properties props = new Properties();
        InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties");
        props.load(input);
        input.close();
        String user = props.getProperty("db.username");
        String password = props.getProperty("db.password");
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(dbURL, user, password);
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
                if (friendUsername.equals(loggedInUser)){
                    throw new SQLException("Cannot add yourself as a friend."); 
                } else {
                    String sql = "SELECT username FROM users WHERE username = ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, friendUsername);
                    rs = pstmt.executeQuery();
                    if (rs.next()){
                        sql = "(SELECT user1 from friends WHERE user1 = ? AND user2 = ?) UNION (SELECT user1 from friends WHERE user1 = ? AND user2 = ?)";
                        pstmt = con.prepareStatement(sql);
                        pstmt.setString(1, loggedInUser);
                        pstmt.setString(2, friendUsername);
                        pstmt.setString(3, friendUsername);
                        pstmt.setString(4, loggedInUser);
                        rs = pstmt.executeQuery();
                        if (!rs.next()){
                        sql = "INSERT INTO friends (user1, user2) VALUES (?, ?)";
                        pstmt = con.prepareStatement(sql);
                        pstmt.setString(1, loggedInUser);
                        pstmt.setString(2, friendUsername);
                        pstmt.executeUpdate();
                        %>
                            <div class="alert alert-success" role="alert">
                                <p>Friend Request Sent</p>
                            </div>
                        <%             
                        } else {
                            throw new SQLException("Users are already friends or pending.");
                        }
                    } else {
                        throw new SQLException("User does not exist.");
                    }
 
                    
                }
            }
    
            if ("removeFriend".equals(action) && friendUsername != null) {
                String sql = "DELETE FROM friends WHERE user1 = ? AND user2 = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, loggedInUser);
                pstmt.setString(2, friendUsername);
                pstmt.executeUpdate();
            }
    
        } catch (Exception e) {
                %>
                <div class="alert alert-danger" role="alert">
                    <%=e.getMessage()%>
                </div>
                <%
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
    </form>

    <div id="pendingFriends">
        <h4>Pending Friends</h4>
        <%
            try {
                con = DriverManager.getConnection(dbURL, user, password);
                String sql = "(SELECT user1 FROM friends WHERE user2 = ? AND pending = 1)";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, loggedInUser);
                rs = pstmt.executeQuery();
                out.println("<ul>");
                while (rs.next()) {
                    if (rs.getString(1) != null){
                        %>
                        <div class ="card">
                            <div class="card-body">
                                <h5 class="card-title"><%=rs.getString(1)%></h5>
                                <a href="accept_friend.jsp?friendusername=<%=rs.getString(1)%>"><button class="btn btn-primary">Accept</button></a>
                            </div>
                        </div> 
                        <%
                    }
                    
                }
                out.println("</ul>");
            } catch (Exception e) {
                %>
                <div class="alert alert-danger" role="alert">
                    <%=e.getMessage()%>
                </div>
                <%
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                if (con != null) try { con.close(); } catch (SQLException e) { }
            }
        %>
    </div>

    
    <div id="currentFriends">
        <h4>Current Friends</h4>
        <%
            try {
                con = DriverManager.getConnection(dbURL, user, password);
                String sql = "(SELECT * from friends WHERE user1 = ? AND pending = 0 OR user2 = ? AND pending = 0)";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, loggedInUser);
                pstmt.setString(2, loggedInUser);
                rs = pstmt.executeQuery();
                out.println("<ul>");
                while (rs.next()) {
                    if (!rs.getString(1).equals(loggedInUser)){
                        %>
                        <div class ="card">
                            <div class="card-body">
                                <h5 class="card-title"><%=rs.getString(1)%></h5>
                                <a href="remove_friend.jsp?friendID=<%=rs.getString(4)%>"><button class="btn btn-danger">Remove</button></a>
                            </div>
                        </div> 
                        <%

                    } else {
                        %>
                        <div class ="card">
                            <div class="card-body">
                                <h5 class="card-title"><%=rs.getString(2)%></h5>
                                <a href="remove_friend.jsp?friendID=<%=rs.getString(4)%>"><button class="btn btn-danger">Remove</button></a>
                            </div>
                        </div> 
                        <%
                    }
                }
                out.println("</ul>");
            } catch (Exception e) {
                %>
                <div class="alert alert-danger" role="alert">
                    <%=e.getMessage()%>
                </div>
                <%
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                if (con != null) try { con.close(); } catch (SQLException e) { }
            }
        %>
    </div>
    </div>
    </div>
