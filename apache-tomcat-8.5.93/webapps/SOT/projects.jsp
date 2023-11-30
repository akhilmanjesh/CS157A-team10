<%@ page import="java.sql.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  

<html>
    <head>
        <title>Projects Page</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="style.css">
        <style>
            .card-title {
                color: #007bff;
                text-decoration: underline;
                cursor: pointer;
                font-weight: bold;
            }
    
            .card-title:hover {
                color: #0056b3;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp"%>
        <hr class="featurette-divider">
        <div class="container-fluid">
            <div class="row">
                <div class="col-6">
                    <h3> Projects</h3>
                </div>
                <div class="col-6">
                    <form class="form-inline" method="post" action="">
                        <div class="input-group">
                            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="searchTerm">
                            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%
            sso = request.getSession(false);
            if(sso.getAttribute("username") != null && sso.getAttribute("type") == "companystaff") {
                %> <a href="create_project.jsp"><button>Create Project</button></a> <%
            }
        %>
        

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

            String searchTerm = request.getParameter("searchTerm");

            String query = "SELECT * FROM project";

            if (searchTerm != null && !searchTerm.isEmpty()) {
                query += " WHERE ProjectName LIKE '%" + searchTerm + "%'";
            }

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while(rs.next()) {
                int projectId = rs.getInt(1);
                String projectName = rs.getString(2);
                String projectDescription = rs.getString(3);
                String projectOrgName = rs.getString(4);
                String projectModalID = projectName.replace(" ", "_") + "Modal" + projectId; 

                String username = (String) sso.getAttribute("username");

                boolean isInProjectOrg = false;
                String isInProjectOrgQuery = "SELECT * FROM membersofcompany WHERE username = ? AND orgname = ?";
                PreparedStatement inProjectPs = con.prepareStatement(isInProjectOrgQuery);
                inProjectPs.setString(1, username);
                inProjectPs.setString(2, projectOrgName);
                ResultSet inProjectRS = inProjectPs.executeQuery();
                isInProjectOrg = inProjectRS.next();

                boolean isCompanyLead = false;
                
                String companyLeadsQuery = "SELECT * FROM companyleads WHERE username = ? AND orgname = ?";
                PreparedStatement companyLeadsPs = con.prepareStatement(companyLeadsQuery);
                companyLeadsPs.setString(1, username);
                companyLeadsPs.setString(2, projectOrgName);
                ResultSet companyLeadsRS = companyLeadsPs.executeQuery();
                
                isCompanyLead = companyLeadsRS.next();

                companyLeadsRS.close();
                companyLeadsPs.close();
                String reviewsQuery = "SELECT Author, review FROM reviews WHERE projectid = ?";
                PreparedStatement reviewsPs = con.prepareStatement(reviewsQuery);
                reviewsPs.setInt(1, projectId);
                ResultSet reviewsRs = reviewsPs.executeQuery();
                %>
                <div class ="card">
                    <div class="card-body">
                        <h5 class="card-title" data-bs-toggle="modal" data-bs-target="#<%= projectModalID %>"><%= projectName %></h5>
                        <p class="card-text"><%= projectDescription %></p>
                        <% if(sso.getAttribute("username") != null && sso.getAttribute("type") == "companystaff" && isInProjectOrg) { %>
                            <a href="editProject.jsp?projectId=<%= projectId %>" class="btn btn-warning">Edit</a>
                        <% } %>
                        <% if (isCompanyLead) { %> 
                            <a href="deleteProject.jsp?projectId=<%= projectId %>" class="btn btn-danger">Delete</a>
                        <%  } %>
                    </div>
                </div>

                <div class="modal fade" id="<%= projectModalID %>" tabindex="-1" aria-labelledby="<%= projectModalID %>Label" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="<%= projectModalID %>Label"><%= projectName %> Details</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p><%= projectDescription %></p>
                            </div>
                            <div class = "modal-header">
                                <h5 class="modal-title" id="teamsID"><strong>Teams: </strong></h5>
                            </div>
                            <div class="modal-body">
                                <ul class="list-group">
                                    <%
                                    String checkJoinedQuery = "SELECT * FROM workson WHERE projectid = ?";
                                    PreparedStatement checkJoinPs = con.prepareStatement(checkJoinedQuery);
                                    checkJoinPs.setInt(1, projectId);
                                    ResultSet joinedRs = checkJoinPs.executeQuery();
                                    while(joinedRs.next()) {
                                        String joinedOrgName = joinedRs.getString(1);
                                        String joinedTeamName = joinedRs.getString(2);
                                        %>
                                        <li class="list-group-item"><strong><%= joinedOrgName %></strong> - <%= joinedTeamName %></li>
                                        <%
                                    }

                                    joinedRs.close();
                                    checkJoinPs.close();
                                    %>
                                </ul>
                            
                                <%
                                if(username != null && sso.getAttribute("type") == "student") {
                                    String leaderQuery = "SELECT * FROM studentleads WHERE username = ?";
                                    PreparedStatement ps = con.prepareStatement(leaderQuery);
                                    ps.setString(1, username);

                                    ResultSet leaderRS = ps.executeQuery();

                                    while(leaderRS.next()) {
                                        String leaderOrgName = leaderRS.getString("orgname");

                                        String teamsQuery = "SELECT * FROM teams WHERE orgname = ? AND teamname NOT IN (SELECT teamname FROM workson WHERE projectid = ?)";
                                        PreparedStatement teamsPs = con.prepareStatement(teamsQuery);
                                        teamsPs.setString(1, leaderOrgName);
                                        teamsPs.setInt(2, projectId);
                                        ResultSet teamsRS = teamsPs.executeQuery();
                                        if(teamsRS.isBeforeFirst()) {
                                        %>
                                            <div>
                                                <p><strong>Student Organization: </strong><%= leaderOrgName %></p>
                                                <form action="joinProject.jsp" method="post">
                                                    <input type="hidden" name="orgname" value="<%= leaderOrgName %>">
                                                    <input type="hidden" name="projectid" value="<%= projectId %>">
                                                    <label for="teamDropdown">Select Team:</label>
                                                    <select name="teamDropdown" id="teamDropdown">
                                                        <%
                                                            while(teamsRS.next()) {
                                                                String teamName = teamsRS.getString("teamName");
                                                                %>
                                                                <option value="<%= teamName %>"><%= teamName %></option> 
                                                                <%
                                                            }
                                                        %>
                                                        
                                                    </select>
                                                    <button type="submit" class="btn btn-primary">Join</button>
                                                </form>
                                            </div>
                                        <%
                                        }
                                        teamsRS.close();
                                        teamsPs.close();
                                    }

                                    leaderRS.close();
                                    ps.close();
                                }
                                %>
                                <div class="modal-body">
                                    <h5>Reviews:</h5>
                                    <% while(reviewsRs.next()) { %>
                                        <div class="review">
                                            <strong><%= reviewsRs.getString("Author") %>:</strong>
                                            <p><%= reviewsRs.getString("review") %></p>
                                        </div>
                                    <% } %>
                                </div>
                                <%
                                    reviewsRs.close();
                                    reviewsPs.close();
                                %>
                                
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <%
            }

            rs.close();
            stmt.close();
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
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
