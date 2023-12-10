<%@ page import="java.sql.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  

<%
    String orgName = request.getParameter("orgname");
    String teamName = request.getParameter("teamDropdown");
    String projectIdStr = request.getParameter("projectid");

    int projectId = Integer.parseInt(projectIdStr);

    out.println(orgName);
    out.println(teamName);
    out.println(projectId);

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
Connection con = null;
Properties props = new Properties();
InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties");
props.load(input);
String user = props.getProperty("db.username");
String password = props.getProperty("db.password");
String url = props.getProperty("db.url");
con = DriverManager.getConnection(url, user, password);
input.close();
            
            String insertQuery = "INSERT INTO workson (orgname, teamname, projectid) VALUES (?,?,?)";
            PreparedStatement ps = con.prepareStatement(insertQuery);
            ps.setString(1, orgName);
            ps.setString(2, teamName);
            ps.setInt(3, projectId);
            int rowsAffected = ps.executeUpdate();

            if(rowsAffected > 0) {
                out.println("Record inserted successfully.");
            } else {
                out.println("Failed to insert");
            }

            ps.close();
            String redirectURL = "http://localhost:8080/SOT/projects.jsp";
            response.sendRedirect(redirectURL);

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