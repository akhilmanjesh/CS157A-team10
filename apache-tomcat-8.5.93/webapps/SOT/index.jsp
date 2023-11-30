<%@ page import="java.sql.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  

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
            String username = (String) sso.getAttribute("username");       
            String type = (String) sso.getAttribute("type");
        %>
            <div class="jumbotron" style="background-color:#b1b7c1;">
                <div class="text-center">
                    <h1 class="display-4" style="padding-top:75px">Hello, <%=sso.getAttribute("username")%>!</h1>
                    <p class="lead" style="padding-bottom:75px">Welcome to Student Organized Tracker.</p>
                    <hr class="my-4">
                </div>
            </div>
        <style>
        </style>
        <div class="row justify-content-center">
          <div class="col-md-3">
            <div class="text-center">
            <h2>Your Friends</h2>
            <%
                String sql = "(SELECT * from friends WHERE user1 = ? AND pending = 0 OR user2 = ? AND pending = 0)";
                PreparedStatement pstmt = con.prepareStatement(sql);
                pstmt.setString(1, username);
                pstmt.setString(2, username);
                ResultSet rs = pstmt.executeQuery();
                while(rs.next()){
                    if (!rs.getString(1).equals(username)){
                        %>
                        <div class ="card">
                            <div class="card-body">
                                <h5 class="card-title"><%=rs.getString(1)%></h5>
                            </div>
                        </div> 
                        <%

                    } else {
                        %>
                        <div class ="card">
                            <div class="card-body">
                                <h5 class="card-title"><%=rs.getString(2)%></h5>
                            </div>
                        </div> 
                        <%
                    }
                }
            %>
            </div>
          </div>
          <div class="col-md-3">
            <div class="text-center">
            <h2>Your Organizations</h2>
                <%
                if (type == "student") {
                    sql = "SELECT orgname FROM memberofstudent WHERE username = ?";
                } else {
                    sql = "SELECT orgname FROM membersofcompany WHERE username = ?";
                }     
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, username);
                rs = pstmt.executeQuery();
                while (rs.next()){
                    if (type == "student"){
                        %>
                            <div class ="card">
                                <div class="card-body">
                                    <h5 class="card-title"><a href="view_student_organization.jsp?orgname=<%=rs.getString(1)%>"><%=rs.getString(1)%></a></h5>
                                </div>
                            </div>          
                        <%
                    } else {
                        %>
                            <div class ="card">
                                <div class="card-body">
                                    <h5 class="card-title"><a href="view_company_organization.jsp?orgname=<%=rs.getString(1)%>"><%=rs.getString(1)%></a></h5>
                                </div>
                            </div>     
                        <%
                    }                 
                }
                %>
            </div>
          </div>
        </div>
        <%
        } catch(SQLException e) {
                out.println(e.getMessage()); 
            } finally {
                if (con != null) {
                    try {
                        con.close();
                    } catch (SQLException e) {
                        out.println("SQLException caught: " + e.getMessage());
                    }
                }
        }
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
                    <div class="text-center">
                        <img class="featurette-image img-fluid mx-auto" data-src="holder.js/500x500/auto" style="width: 400px; height: 400px;" src="./headline.png">
                    </div>
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
    <br>

    <%}%>

</body>
</html>
