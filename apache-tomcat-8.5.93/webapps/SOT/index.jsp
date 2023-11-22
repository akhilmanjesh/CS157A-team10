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
        <a class="navbar-brand" href="#">SOT</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="projects.jsp">Projects</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="posts.jsp">Posts</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="events.jsp">Events</a>
                </li>
   
                <li class="nav-item">
                    <a class="nav-link" href="settings.jsp">Settings</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="organizations.jsp">Organizations</a>
                </li>
                <%
                    HttpSession sso = request.getSession(false);
                    if (sso.getAttribute("username") != null){
                        %>                
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

    <h1>Welcome to SOT: Student Organization Tasker</h1>
    <% 
        sso = request.getSession(false);
        if (sso.getAttribute("username") != null){
            out.println("Greetings " + sso.getAttribute("username") + "!");
            out.println("Account type " + sso.getAttribute("type") + "!");
        }
    %>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
