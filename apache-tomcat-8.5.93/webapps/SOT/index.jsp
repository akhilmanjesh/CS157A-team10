<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>SOT - Home</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
                    <a class="nav-link" href="login.jsp">Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="signup.jsp">Sign Up</a>
                </li>
            </ul>
        </div>
    </nav>

    <h1>Welcome to SOT: Student Organization Tasker</h1>
    <% 
        HttpSession sso = request.getSession(false);
        if (sso != null){
            out.println("Greetings " + sso.getAttribute("username") + "!");
        }
    %>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>