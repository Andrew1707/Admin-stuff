

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);

		String uname = request.getParameter("uname");
		String pass = request.getParameter("pass");
		
		if (uname.isEmpty() || pass.isEmpty()) {
			response.sendRedirect("login.jsp?login=empty");
		}
		
		try {
			ConnectDB db = new ConnectDB();
			Connection conn = db.getConnection();
			
			String qry = "select Username,Password,AccountType,Name from Account where Username=? and Password=?";
		
			PreparedStatement stmt = conn.prepareStatement(qry);
			stmt.setString(1, uname); 
			stmt.setString(2, pass); 
			ResultSet rs = stmt.executeQuery();
			
			if (rs.next()) {
				String nm = rs.getString("Name");
				HttpSession session = request.getSession();
				if (rs.getString("AccountType").contentEquals("Customer")) {
					session.setAttribute("type", "Customer");
	
				}
				else if (rs.getString("AccountType").contentEquals("SiteAdmin")) {
					session.setAttribute("type", "SiteAdmin");
					response.sendRedirect("WelcomeAdmin.jsp");

				} else {
					session.setAttribute("type", "Employee");
					
				}
	
				session.setAttribute("username", uname);
				//response.sendRedirect("home.jsp?account=on");
	
			} else {
				response.sendRedirect("login.jsp?login=fail");
			}
			
			
			rs.close();
			stmt.close();
			db.closeConnection(conn);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
