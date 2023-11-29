<%@ page import="java.sql.*"%>
<%@ page import="java.util.Properties"%>
<%@ page import="java.io.InputStream"%>  

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

            int projectId = Integer.parseInt(request.getParameter("projectId"));

            String deleteQuery = "DELETE FROM project WHERE projectid = ?";

            PreparedStatement ps = con.prepareStatement(deleteQuery);
            ps.setInt(1, projectId);
            int rowsAffected = ps.executeUpdate();

            if(rowsAffected > 0) {
                out.println("Project successfully deleted");
            } else {
                out.println("Failed to delete");
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