package user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserUpdateServlet")
public class UserUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF=8");
		
		System.out.println("UserUpdateServlet Start ");
		
		String userID = request.getParameter("userID");
		String userPassword = request.getParameter("userPassword");
		String userPassword1 = request.getParameter("userPassword1");
		String userPassword2 = request.getParameter("userPassword2");
		String userName = request.getParameter("userName");
		String userAge = request.getParameter("userAge");
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");
		String userArea = request.getParameter("userArea");
		String userTel = request.getParameter("userTel");
		
		System.out.println("userID : " + userID);
		System.out.println("userPW : " + userPassword);
		System.out.println("userPW1 : " + userPassword1);
		System.out.println("userPW2 : " + userPassword2);
		System.out.println("userName : " + userName);
		System.out.println("userAge : " + userAge);
		System.out.println("userGender : " + userGender);
		System.out.println("userEmail : " + userEmail);
		System.out.println("userArea : " + userArea);
		System.out.println("userTel : " + userTel);
		
		if(userID == null || userID.equals("") || userPassword == null || userPassword.equals("") || userPassword1 == null || userPassword1.equals("") ||
				userPassword2 == null || userPassword2.equals("") ||userName == null || userName.equals("") 
				|| userAge == null || userAge.equals("") || userGender == null || userGender.equals("") || userEmail == null || userEmail.equals("")
				|| userArea == null || userArea.equals("") || userTel == null || userTel.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메시지");
			request.getSession().setAttribute("messageContent", "모든 내용을 입력하세요.");
			response.sendRedirect("index.jsp");
			return;
		}

		int result = new UserDAO().passwordCheck(userID, userPassword);
		if(result == 1) {
			result = new UserDAO().update(userID, userPassword2, userName, userAge, userGender, userEmail, userArea, userTel);
			if(result == 1) {
				request.getSession().setAttribute("messageType", "성공 메시지");
				request.getSession().setAttribute("messageContent", "회원정보 수정에 성공했습니다.");
				response.sendRedirect("index.jsp");
			}
			return;
		} else {
			request.getSession().setAttribute("messageType", "오류 메시지");
			request.getSession().setAttribute("messageContent", "패스워드가 다릅니다.");
			response.sendRedirect("userUpdate.jsp");				
		}
	}

}
