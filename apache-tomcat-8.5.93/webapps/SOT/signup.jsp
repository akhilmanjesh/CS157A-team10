<%@ page import="java.sql.*"%>
<%@ page import="org.mindrot.jbcrypt.BCrypt" %>
<html>
  <head>
    <title>Signup Page</title>
  </head>
  <body>
    <%@include file="navbar.jsp"%>


<style>
  .img-container{

  }
</style>
<section class="vh-100" style="background-color: #eee;">
  <div class="container h-50">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-lg-12 col-xl-11">
        <div class="card text-black" style="border-radius: 25px;">
          <div class="card-body p-md-5">
              <div class= "row d-flex justify-content-center">
                <div class=col-md-4 align-self-center>
                  <div class = "img-container">
                    <a href = "studentsignup.jsp">
                    <button type="button" class="btn btn-outline-primary">
                    <h3>Create a Student Account</h1>
                    <img src="./student_account.jpg" style="width:236px"
                    class="img-fluid" alt="Sample image">
                    </button>
                    </a>
                  </div>
                </div>
<div class=col-md-4 align-self-center>
                  <div class = "img-container">
                    <a href = "companysignup.jsp">
                    <button type="button" class="btn btn-outline-primary">
                    <h3>Create a Company Account</h1>
                    <img src="./company_account.jpg" style="width:400px"
                    class="img-fluid" alt="Sample image">
                    </button>
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
  </body>
</html>
