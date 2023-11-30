<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>SOT - Home</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="style.css">
</head>
<body>
        <%@include file="navbar.jsp" %>
        <%
        sso = request.getSession(false);
        if (sso.getAttribute("username") != null){
            out.println("Greetings " + sso.getAttribute("username") + "!");
            out.println("Account type " + sso.getAttribute("type") + "!");
        } else {
        %>
        <style>
            .carousel-item{
                height:25rem;
                background:gray;
                color:white;
                position: relative;
            }   
            .container {
                position: absolute;
                bottom: 0;
                right: 0;
                left: 0;
                padding-bottom:50px;
            }
            .overlay-image{
                position: absolute;
                bottom: 0;
                right: 0;
                left: 0;
                top: 0;
                background-position: center;
                background-size: cover;
                opacity: 0.5;
            }
            .container text-center{
                top: -200px;
                bottom: -200px;;
            }
        </style>
        <div id="carouselExampleIndicators" class="carousel slide">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class ="overlay-image" style="background-image:url(./slide-2.jpg);"></div>
                    <div class = "container">   
                        <h1>Welcome to Student Organized Tracker.</h1>
                        <p>SOT makes finding work eaiser for students.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class ="overlay-image" style="background-image:url(./slide-3.jpg);"></div>
                    <div class = "container">
                        <h1>Student Organized Tracker is a free for all students.</h1>
                        <a href = "signup.jsp"><button type="button" class="btn btn-primary">Sign up today!</button></a>
                    </div> 
                </div>
                <div class="carousel-item">
                    <div class ="overlay-image" style="background-image:url(./slide-1.jpg);"></div>
                    <div class = "container">
                        <h1>Developed by students from San Jose State University.</h1>
                        <p>A CS157A project.</p>
                    </div> 
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>

        <br>
        <div class ="container-fluid">
            <div class="row justify-content-center">
                <div class="col-sm-5">
                    <h2 class="featurette-heading">What is Student Organized Tracker? <span class="text-muted">(SOT)</span></h2>
                    <p class="lead">SOT is a web application designed to help students reach out and find meaningful work to help build their carrers. 
                    We offer a platform for companies to put projects out for student organizations to view and sign up for. These projects would be assigned
                    to repsective teams within student organizations and project managers from companies would help facilitate the progression of projects.</p>
                </div>
            </div>
            <hr class="featurette-divider">
            <div class="row justify-content-center">
                <div class="col-sm-3 order-sm-1">
                    <img class="featurette-image img-fluid mx-auto" data-src="holder.js/500x500/auto" alt="500x500" style="width: 500px; height: 500px;" src="data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22500%22%20height%3D%22500%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20500%20500%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_18c1d6cc5e1%20text%20%7B%20fill%3A%23AAAAAA%3Bfont-weight%3Abold%3Bfont-family%3AArial%2C%20Helvetica%2C%20Open%20Sans%2C%20sans-serif%2C%20monospace%3Bfont-size%3A25pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_18c1d6cc5e1%22%3E%3Crect%20width%3D%22500%22%20height%3D%22500%22%20fill%3D%22%23EEEEEE%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%22185.13333129882812%22%20y%3D%22261.1%22%3E500x500%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E" data-holder-rendered="true">
                </div>
                    <div class="col-sm-3 order-sm-2">
                        <h2 class="featurette-heading">How do I get started? 
                        <br><span class="text-muted">Students</span></h2>
                        <p class="lead">If you are student, sign up and become a student user. This will allow you access to join organizations within our platform.</p>
                        <h2><span class="text-muted">Companies</span></h2>
                        <p class="lead">If you are are part of a company, sign up to become a company staff user that will allow you to join your respecitve company organization and assign
                        work for student organizations.</p>
                    </div>
                </div>
        </div>
    <%}%>
    <br>

    <!--Footer-->
    <div class="d-flex justify-content-center" style = "background-color: rgba(0, 0, 0, 0.2);">
    <h5>CS157A Team #10</h5>
    </div>

</body>
</html>
