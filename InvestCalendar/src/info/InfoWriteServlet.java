package info;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/InfoWriteServlet")
public class InfoWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF=8");
		String infoName = request.getParameter("infoName");
		String infoTitle = request.getParameter("infoTitle");
		String infoDate = request.getParameter("infoDate");
		String infoBody = request.getParameter("infoBody");
		String infoLink = request.getParameter("infoLink");
		
		System.out.println("종목명 : " + infoName);
		System.out.println("제목 : " + infoTitle);
		System.out.println("일정 : " + infoDate);
		System.out.println("내용 : " + infoBody);
		System.out.println("기사 : " + infoLink);
		
		if(infoName == null || infoName.equals("") || infoTitle == null || infoTitle.equals("") || infoDate == null || infoDate.equals("") ||
				infoBody == null || infoBody.equals("") || infoLink == null || infoLink.equals("")) {
			request.getSession().setAttribute("messageType", "오류 메시지");
			request.getSession().setAttribute("messageContent", "모든 내용을 입력하세요.");
			response.sendRedirect("write.jsp");
			return;
		}
		
		int result = new InfoDAO().write(infoName, infoTitle, infoBody, infoLink, infoDate);
		if(result == 1) {
			request.getSession().setAttribute("messageType", "성공 메시지");
			request.getSession().setAttribute("messageContent", "일정이 등록되었습니다.");
			response.sendRedirect("write.jsp");	
			return;
		} else {
			request.getSession().setAttribute("messageType", "오류 메시지");
			request.getSession().setAttribute("messageContent", "오류가 발생하였습니다.");
			response.sendRedirect("write.jsp");
			return;
		}
		
	}

}
