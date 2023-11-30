<%@ page import="java.sql.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  

<html>
    <head>
        <title>Organization</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="style.css">
    </head>
    <body>
        <%@include file="navbar.jsp" %>  

        <%
        String db = "sot";
        Properties props = new Properties();
        InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties");
        props.load(input);
        input.close();
        String user = props.getProperty("db.username");
        String password = props.getProperty("db.password");
        Connection con = null;

        %>
        <div class = "row justify-content-center">
            <div class = "col-6 p-3 mb-2 bg-light text-dark"><h3>Organizations</h3></div>
            <div class = "col-2 p-3 mb-2 bg-light text-dark">
                <div class = "text-end">
            <%
            sso = request.getSession(false);
            if (sso.getAttribute("username") != null){
            %>
                <div class="modal" id="createOrgModal" tabindex="-1" aria-labelledby="createOrgModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="createOrgModalLabel">Create Organization</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <%@include file="create_org.jsp" %>
                    </div>
                    </div>
                </div>
                </div>
                <a href="#" data-bs-toggle="modal" data-bs-target="#createOrgModal"><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createOrgModalCenter">
                    +
                </button>  </a>
            <%
            }
            %>
            </div>
        </div>
        </div>
            <div class = "row justify-content-center">
            <div class = "col-8 p-3 mb-2 bg-light text-dark">
        <%
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?autoReconnect=true&useSSL=false", user, password);
           
            String username = (String) sso.getAttribute("username");

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM studentorg");

            //Display Records    
                while(rs.next()) {
                    String studentOrgName = rs.getString(1);
                    String schoolName = rs.getString(2);
                    %>
                    <div class ="card">
                        <div class="card-body">
                            <h5 class="card-title"><a href="view_student_organization.jsp?orgname=<%=studentOrgName%>"><%= studentOrgName %></a></h5>
                            <p class="card-text"><%= schoolName %></p>
                            <%       
                            if (sso.getAttribute("username") != null && sso.getAttribute("type") == "student"){
                                String query = "SELECT orgName FROM memberofstudent WHERE username = ? AND orgName = ?";
                                PreparedStatement ps = con.prepareStatement(query);
                                ps.setString(1, username);
                                ps.setString(2, studentOrgName);
                                ResultSet rs1 = ps.executeQuery();
                                if (!rs1.next()){
                                    %>
                                    <a href="join_organization.jsp?orgname=<%=studentOrgName%>"><button class = "btn btn-success">Join Org</button></a>
                                    <%
                                } else {
                                    query = "SELECT * FROM studentleads WHERE username = ? AND orgname = ?";
                                    ps = con.prepareStatement(query);
                                    ps.setString(1, username);
                                    ps.setString(2, studentOrgName);
                                    rs1 = ps.executeQuery();
                                    if (!rs1.next()){
                                    %>
                                        <a href="leave_organization.jsp?orgname=<%=studentOrgName%>"><button class = "btn btn-outline-danger">Leave Org</button></a>
                                    <%
                                    } else {
                                    %>
                                        <a href="delete_organization.jsp?orgname=<%=studentOrgName%>"><button class = "btn btn-danger">Delete Org</button></a>
                                    <%  
                                    }
                                }
                                ps.close();
                                rs1.close();
                            }
                            %>
                        </div>
                    </div>
                    <%
                }     

                rs.close();
                stmt.close();

                Statement stmt2 = con.createStatement();
                ResultSet rs2 = stmt2.executeQuery("SELECT * FROM companyorg");
                
                while(rs2.next()) {
                    String compOrgName = rs2.getString(1);
                    %>
                    <div class ="card">
                        <div class="card-body">
                            <h5 class="card-title"><a href="view_company_organization.jsp?orgname=<%=compOrgName%>"><%= compOrgName %></a></h5>
                            <%       
                            if (sso.getAttribute("username") != null && sso.getAttribute("type") == "companystaff"){
                                String query = "SELECT orgName FROM membersofcompany WHERE username = ? AND orgName = ?";
                                PreparedStatement ps = con.prepareStatement(query);
                                ps.setString(1, username);
                                ps.setString(2, compOrgName);
                                ResultSet rs1 = ps.executeQuery();
                                if (!rs1.next()){
                                    %>
                                    <a href="join_organization.jsp?orgname=<%=compOrgName%>"><button>Join Org</button></a>                           
                                    <%
                                } else {
                                    query = "SELECT * FROM companyleads WHERE username = ? AND orgname = ?";
                                    ps = con.prepareStatement(query);
                                    ps.setString(1, username);
                                    ps.setString(2, compOrgName);
                                    rs1 = ps.executeQuery();
                                    if (!rs1.next()){
                                    %>
                                        <a href="leave_organization.jsp?orgname=<%=compOrgName%>"><button>Leave Org</button></a>
                                    <%
                                    } else {
                                    %>
                                        <a href="delete_organization.jsp?orgname=<%=compOrgName%>"><button>Delete Org</button></a>
                                    <%  
                                    }
                                }
                                rs1.close();
                            }
                            %>
                        </div>
                    </div>
                    <%
                }     

                rs2.close();
                stmt2.close();


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

        %>
            </div>
        </div>
    </body>
</html>
