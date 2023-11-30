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
        <%@include file = "navbar.jsp"%>
    <div class = "row justify-content-center">
    <%
        sso = request.getSession(false);
        String username = (String) sso.getAttribute("username");
        String orgName = request.getParameter("orgname");
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
           

            Statement stmt = con.createStatement();

            String query = "SELECT * FROM studentorg WHERE orgname = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, orgName);

            ResultSet rs = ps.executeQuery();
            //Check for valid website and print the contents.
            %>
                <div class = "col-8 p-3 mb-2 bg-light text-dark">
                <a href = "organizations.jsp">         <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-left" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M14.5 1.5a.5.5 0 0 1 .5.5v4.8a2.5 2.5 0 0 1-2.5 2.5H2.707l3.347 3.346a.5.5 0 0 1-.708.708l-4.2-4.2a.5.5 0 0 1 0-.708l4-4a.5.5 0 1 1 .708.708L2.707 8.3H12.5A1.5 1.5 0 0 0 14 6.8V2a.5.5 0 0 1 .5-.5"/>
                    </svg></a>
            <%
            if (rs.next()){  
                //Get Members
                String schoolName = rs.getString(2);
                %>
                <h3><%=orgName%></h3><br>
                <h5><%=schoolName%></h5><br>
                <%
                query = "SELECT username FROM memberofstudent WHERE orgname = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, orgName);
                ResultSet rsMembers = ps.executeQuery();

                //Get Teams
                query = "SELECT * FROM teams WHERE orgname = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, orgName);
                ResultSet rsTeams = ps.executeQuery();

                //Get Posts
                query = "SELECT * FROM posts WHERE orgname = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, orgName);
                ResultSet rsPosts = ps.executeQuery();

                //Get Events
                query = "SELECT * FROM events WHERE orgname = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, orgName);
                ResultSet rsEvents = ps.executeQuery();
                
                //Check if owner
                query = "SELECT * FROM studentleads WHERE username = ? AND orgname = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, username);
                ps.setString(2, orgName);
                rs = ps.executeQuery();
                boolean isOwner = false;
                if (rs.next()){
                    isOwner = true;
                }

                //Owner View
                if (isOwner){
                %>
                    <%@include file="create_team.jsp" %>
                    <%@include file="create_post.jsp" %>
                    <%@include file="create_events.jsp" %>

                <%
                //Display Results
                %>
                <h5>Members</h5>
                <%
                while (rsMembers.next()){
                %>
                <div class ="card">
                    <div class="card-body">
                        <h5 class="card-title"><%=rsMembers.getString(1)%></h5>
                        <p class="card-text"></p>
                    </div>
                </div>
                <%
                }
                %>
                <h5>Teams</h5>
                <%
                    while (rsTeams.next()){           
                        String tempTeamName = rsTeams.getString(1);
                        %>
                        <div class ="card">
                            <div class="card-body">
                                <h5 class="card-title"><a href = "view_team.jsp?orgname=<%=orgName%>&teamname=<%=tempTeamName%>"><%=tempTeamName%></a></h5>
                                <p class="card-text"><a href = "delete_team.jsp?orgname=<%=orgName%>&teamname=<%=tempTeamName%>"><button>Delete Team</button></a></p>
                            </div>
                        </div>
                        <%
                    }
                %>
                <h5>Posts</h5>
                <%
                    while (rsPosts.next()){
                        String postid = rsPosts.getString(1);
                        String postBody = rsPosts.getString(2);
                        String postOrgName = rsPosts.getString(3);
                        %>
                            <div class ="card">
                                <div class="card-body">
                                    <h5 class="card-title"><%=postid%> by: [<%=postOrgName%>]</h5>
                                    <p class="card-text"><%=postBody%></p>
                                    <a href = "http://localhost:8080/SOT/delete_post.jsp?postid=<%=postid%>&orgname=<%=orgName%>"><button>Delete Post</button></a><br>
                                </div>
                            </div>
                        <%
                    }  
                %>
                <h5>Events</h5>
                <%     
                    while (rsEvents.next()){
                        String eventName = rsEvents.getString(1);
                        String eventDate = rsEvents.getString(2);
                        String eventOrg = rsEvents.getString(3);

                        %>
                            <div class ="card">
                                <div class="card-body">
                                    <h5 class="card-title"><%=eventName%> by: [<%=eventOrg%>]</h5>
                                    <p class="card-text"><%=eventDate%></p>
                                    <a href = "http://localhost:8080/SOT/delete_event.jsp?eventname=<%=eventName%>&eventdate=<%=eventDate%>&orgname=<%=orgName%>"><button>Delete Event</button></a>
                                </div>
                            </div>
                        <%
                    }      
                } 
                //User View
                else {
                    %>
                        <div class="row justify-content-center">
                            <div class="col-md-2 mx-auto">
                                <div class="text-center"><h3>Members</h3>
                                <%
                                while (rsMembers.next()){
                                    %>
                                    <div class ="card">
                                        <div class="card-body">
                                            <h5 class="card-title"><%=rsMembers.getString(1)%></h5>
                                            <p class="card-text"></p>
                                        </div>
                                    </div>
                                    <%
                                }
                                %>
                                </div>
                            </div>
                            <div class="col-md-2 mx-auto">
                                <div class="text-center"><h3>Teams</h3>
                                <%
                                while (rsTeams.next()){           
                                    String tempTeamName = rsTeams.getString(1);
                                    %>
                                    <div class ="card">
                                        <div class="card-body">
                                            <h5 class="card-title"><a href = "view_team.jsp?orgname=<%=orgName%>&teamname=<%=tempTeamName%>"><%=tempTeamName%></a></h5>
                                        </div>
                                    </div>
                                    <%
                                }
                                %>
                                </div>
                            </div>
                            <div class="col-3 mx-auto offset-sm-3 " style="background-color:white">
                                <div class="text-center"><h3>Posts</h3>
                                <%
                                while (rsPosts.next()){
                                String postid = rsPosts.getString(1);
                                String postBody = rsPosts.getString(2);
                                String postOrgName = rsPosts.getString(3);
                                %>
                                <div class ="card">
                                    <div class="card-body">
                                        <h5 class="card-title">(<%=postid%>)</h5>
                                        <p class="card-text"><%=postBody%></p>
                                    </div>
                                </div>
                                <%
                                }  
                                %>
                                </div>
                            </div>
                            <div class="col-3 mx-auto" style="background-color:white">
                                <div class="text-center">Events</div>
                                <%
                                while (rsEvents.next()){
                                    String eventName = rsEvents.getString(1);
                                    String eventDate = rsEvents.getString(2);
                                    String eventOrg = rsEvents.getString(3);

                                    %>
                                        <div class ="card">
                                            <div class="card-body">
                                                <h5 class="card-title"><%=eventName%></h5>
                                                <p class="card-text"><%=eventDate%></p>
                                            </div>
                                        </div>
                                    <%
                                }  
                                %>
                            </div>
                        </div>
                    <%
                }
            ps.close();
            rs.close();
            rsTeams.close();
            rsPosts.close();
            rsEvents.close();
            rsMembers.close();

            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, request.getRequestURI());
            }

        } catch(SQLException e) {
            out.println(e.getMessage()); 
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    out.println(e.getMessage());
                }
            }
        }

        %>
        </div>
        </div>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>
