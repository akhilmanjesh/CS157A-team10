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
        <a href="http://localhost:8080/SOT/index.jsp"><H1>Home</H1></a>
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
            HttpSession sso = request.getSession(false);
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?autoReconnect=true&useSSL=false", user, password);
           
            String username = (String) sso.getAttribute("username");

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM studentorg");
                
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
                                    <a href="join_organization.jsp?orgname=<%=studentOrgName%>"><button>Join Org</button></a>
                                    <%
                                } else {
                                    %>
                                    <a href="leave_organization.jsp?orgname=<%=studentOrgName%>"><button>Leave Org</button></a>
                                    <%
                                }
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
                                    %>
                                    <a href="leave_organization.jsp?orgname=<%=compOrgName%>"><button>Leave Org</button></a>
                                    <%
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
