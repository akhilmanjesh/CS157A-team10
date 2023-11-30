<%@ page import="java.sql.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Review Page</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container mt-5">
        <a href="http://localhost:8080/SOT/index.jsp" class="text-decoration-none"><h1>Home</h1></a>
        <h3>Create Review</h3>

        <form action="createReview.jsp" method="post">
            <p>Please fill in this form to create a review.</p>

            <div class="mb-3">
                <label for="reviewText" class="form-label"><b>Review</b></label>
                <textarea class="form-control" placeholder="Enter your review" name="reviewText" id="reviewText" required></textarea>
            </div>

            <input type="hidden" name="projectId" value="<%= request.getParameter("projectId") %>">

            <div class="mb-3">
                <label for="projectName" class="form-label"><b>Project</b></label>
                <span class="form-control-plaintext"><%= request.getParameter("projectName") %></span>
            </div>

            <button type="submit" class="btn btn-primary">Submit Review</button>
        </form>

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

                HttpSession sso = request.getSession(false);
                String username = (String) sso.getAttribute("username");

                String reviewText = request.getParameter("reviewText");
                int projectId = Integer.parseInt(request.getParameter("projectId"));

                if (reviewText != null) {
                    PreparedStatement pstmt = con.prepareStatement("INSERT INTO reviews (Author, projectid, review) VALUES (?, ?, ?)");
                    pstmt.setString(1, username);
                    pstmt.setInt(2, projectId);
                    pstmt.setString(3, reviewText);
                    pstmt.executeUpdate();
                    pstmt.close();
                    con.close();
                    String redirectURL = "http://localhost:8080/SOT/projects.jsp";
                    response.sendRedirect(redirectURL);
                    out.println("Review created");
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