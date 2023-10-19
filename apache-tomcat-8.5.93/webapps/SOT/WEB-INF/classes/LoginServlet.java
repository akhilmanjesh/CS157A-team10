
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response){
        try{
            HttpSession session=request.getSession(false);  
            String n=(String)session.getAttribute("uname"); 

        }catch(Exception e){System.out.println(e);}  
    }
}
