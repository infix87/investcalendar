package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF=8");
		
		String userID = request.getParameter("userID");
		String userPassword = request.getParameter("userPassword");
		
		if(userID == null || userID.equals("") || userPassword == null || userPassword.equals("")) {
			System.out.println("입력되지 않은 내용이 있습니다.");
			request.getSession().setAttribute("messageType", "오류 메시지");
			request.getSession().setAttribute("messageContent", "모든 내용을 입력하세요.");
			response.sendRedirect("login.jsp");	
			return;
		} 
		
		int result = new UserDAO().login(userID, userPassword);
		System.out.println("login Result : " + result);
		if(result == 1) {
			HttpSession session = request.getSession(true);
			if(session != null) {
				session.setAttribute("userID", userID);				
			}
			response.sendRedirect("index.jsp");
			return;			
		} else {
			request.getSession().setAttribute("messageType", "오류 메시지");
			request.getSession().setAttribute("messageContent", "아이디 및 비밀번호가 다릅니다.");
			response.sendRedirect("login.jsp");			
			return;
		}
		
	}

}
