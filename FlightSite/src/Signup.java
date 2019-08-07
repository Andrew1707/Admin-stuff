

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Signup
 */
@WebServlet("/Signup")
public class Signup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Signup() {
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

		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String email = request.getParameter("email");
		String uname = request.getParameter("uname");
		String pass = request.getParameter("pass");
		
		
		if ( fname.isEmpty()|| lname.isEmpty() || email.isEmpty() || uname.isEmpty() || pass.isEmpty()) {
			response.sendRedirect("signup.jsp?faults=empty");
			return;
		}

		try {
			ConnectDB db = new ConnectDB();
			Connection conn = db.getConnection();
			
			String qry = "select email from Account where Email=?";
			PreparedStatement stmt = conn.prepareStatement(qry);
			stmt.setString(1, email); 
			ResultSet rs = stmt.executeQuery();
			
			String qry1 = "select * from Account where Username=?";
			PreparedStatement stmt1 = conn.prepareStatement(qry1);
			stmt1.setString(1, uname); 
			ResultSet rs1 = stmt1.executeQuery();
			
			
			if (rs.next()) {
				//check if email exists
				response.sendRedirect("signup.jsp?faults=email");
			} else if (rs1.next()) {
				//check if uname exists
				response.sendRedirect("signup.jsp?faults=username");
			} else {
				qry = "insert into Account values (?,?,?,?,?)";
				stmt = conn.prepareStatement(qry);
				stmt.setString(1, uname);
				stmt.setString(2, pass); 
				stmt.setString(3, email); 
				String name = fname+" "+lname;
				stmt.setString(4, name); 
				stmt.setString(5, "Customer"); 
				stmt.executeUpdate();
				
				qry = "insert into Customer values (?)";
				stmt = conn.prepareStatement(qry);
				stmt.setString(1, uname);
				stmt.executeUpdate();
				HttpSession session = request.getSession();
				session.setAttribute("type", "Customer");
				session.setAttribute("username", uname);
				response.sendRedirect("home.jsp?account=on");
		}
			rs.close();
			rs1.close();
			stmt1.close();
			stmt.close();
			db.closeConnection(conn);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
