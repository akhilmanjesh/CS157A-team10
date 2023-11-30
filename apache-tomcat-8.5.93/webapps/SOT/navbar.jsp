<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>SOT - Home</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg custom-navbar">
        <a class="navbar-brand" href="index.jsp" style="margin-left:10px">SOT</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <% HttpSession sso = request.getSession(false); %>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav"style="margin-right:10px">
            <ul class="navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="projects.jsp">Projects</a>
                </li>
                <%
                if (sso.getAttribute("username") != null){
                        %>           
                       <li class="nav-item">
                        <a class="nav-link" href="posts.jsp">Posts</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="events.jsp">Events</a>
                        </li>
                        <%
                    } 
                %>
                <li class="nav-item">
                    <a class="nav-link" href="organizations.jsp">Organizations</a>
                </li>
                <%
                    if (sso.getAttribute("username") != null){
                        %>     
                        <li class="nav-item">
                            <a class="nav-link" href="settings.jsp">Settings</a>
                        </li>           
                        <li class="nav-item">
                            <a class="nav-link" href="logout.jsp">Logout</a>
                        </li>
                        <%
                    } else {
                        %>
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="signup.jsp">Sign Up</a>
                        </li>
                        <%
                    }
                %>
            </ul>
        </div>
    </nav>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</body>
</html>
