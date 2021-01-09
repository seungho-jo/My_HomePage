package page;

import java.io.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;


@WebServlet("/boardPost")
public class BoardPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		BoardMgr bMgr = new BoardMgr();
		bMgr.insertBoard(request);
		response.sendRedirect("work.jsp");
	}

}
