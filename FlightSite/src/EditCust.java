
import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EditCust
 */
@WebServlet("/EditCust")
public class EditCust extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditCust() {
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
		// TODO Auto-generated method stub
		doGet(request, response);

		String user = request.getParameter("oldUser");
		String newUser = request.getParameter("newUser");
		String pass = request.getParameter("newPass");
		String email = request.getParameter("newEmail");
		String name = request.getParameter("newName");
		String qryResult="";
		if (user.isEmpty() || newUser.isEmpty() || pass.isEmpty() || email.isEmpty() || name.isEmpty()) {
			response.sendRedirect("WelcomeAdmin.jsp?try=One or more boxes left blank, please fill all boxes");
			return;
		} 
		int hi=0;
		try {

			ConnectDB db = new ConnectDB();	
			Connection con = db.getConnection();	
			
		
			
			String str = "UPDATE Account SET Username = ?,Password = ?,Email = ?,Name = ? WHERE Username = ?";
			PreparedStatement stmt = con.prepareStatement(str);
			stmt.setString(1,newUser);
			stmt.setString(2,pass);
			stmt.setString(3,email);
			stmt.setString(4,name);
			stmt.setString(5,user);
			qryResult = stmt.toString();
			hi = stmt.executeUpdate();
			
			stmt.close();
			con.close();
			db.closeConnection(con);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		if(hi==0)
			response.sendRedirect("WelcomeAdmin.jsp?try=fail"+qryResult);
		else
			response.sendRedirect("WelcomeAdmin.jsp?try=worked");
	}

}
