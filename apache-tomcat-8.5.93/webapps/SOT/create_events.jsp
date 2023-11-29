<%@ page import="java.sql.*"%>

<html>
  <head>
    <title></title>
  </head>
  <body>
    <h3>Create Event</h3>
    <form action="view_student_organization.jsp?orgname=<%=orgName%>" method="post">
        <label for="eventName"><b>Event Name</b></label>
        <input type="text" placeholder="Enter Event Name" name="eventName" id="eventName" required>

        <label for="eventDate"><b>Event Date</b></label>
        <input type="date" name="eventDate" id="eventDate" required>

        <button type="submit" class="createEventBtn">Create Event</button>
    </form>
   <%
        sso = request.getSession(false);
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(dbURL, user, password);
            String eventName = request.getParameter("eventName");
            String eventDate = request.getParameter("eventDate");   


            if(eventName != null && eventDate != null && !eventName.trim().isEmpty() && !eventDate.trim().isEmpty()) {
                String sql = "SELECT * FROM events WHERE eventname = ? AND eventdate = ? AND orgname = ?";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, eventName);
                pstmt.setString(2, eventDate);
                pstmt.setString(3, orgName);
                ResultSet rsCheck = pstmt.executeQuery();
                if (!rsCheck.next()){

                    sql = "INSERT INTO events (eventname, eventdate, orgname) VALUES (?, ?, ?)";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, eventName);
                    pstmt.setDate(2, java.sql.Date.valueOf(eventDate));
                    pstmt.setString(3, orgName); 
            
                    int rowsAffected = pstmt.executeUpdate();
                    if(rowsAffected > 0) {
                        out.println("<p>Event created successfully</p>");
                    } else {
                        out.println("<p>Error occurred while creating the event</p>");
                    }
                    String redirectURL = "http://localhost:8080/SOT/view_student_organization.jsp?orgname="+orgName;
                    response.sendRedirect(redirectURL);
                } else {
                    throw new SQLException("Event already exists.");
                }

            }

            
        } catch(SQLException e) {
            out.println("<p>"+e.getMessage() + "</p>");
        } catch(ClassNotFoundException e) {
            out.println("<p>ClassNotFoundException caught: " + e.getMessage() + "</p>");
        } finally {
            if(pstmt != null) {
                try {
                    pstmt.close();
                } catch(SQLException e) {
                    out.println("<p>Error closing PreparedStatement: " + e.getMessage() + "</p>");
                }
            }
            if(con != null) {
                try {
                    con.close();
                } catch(SQLException e) {
                    out.println("<p>Error closing Connection: " + e.getMessage() + "</p>");
                }
            }
        }
    %>
  </body>
</html>
