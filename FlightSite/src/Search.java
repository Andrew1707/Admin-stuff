

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Search
 */
@WebServlet("/Search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Search() {
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
		String tripType = request.getParameter("tripType");
		String classE = request.getParameter("classE");
		String dAirport = request.getParameter("dAirport");
		String aAirport = request.getParameter("aAirport");
		String dDate = request.getParameter("dDate");
		String aDate = request.getParameter("aDate");
		String flexible = request.getParameter("flex");

		
		//if exists in DB, then 
		if (tripType.isEmpty() || classE.isEmpty() || dAirport.isEmpty() || aAirport.isEmpty() || dDate.isEmpty() || aDate.isEmpty() || flexible.isEmpty()) {
			response.sendRedirect("search.jsp?faults=empty");
		} 
		

		ConnectDB db = new ConnectDB();
		Connection conn = db.getConnection();
		//fly from and fly to airports are same and times match up 


		
	}

}
