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
		
		System.out.println("����� : " + infoName);
		System.out.println("���� : " + infoTitle);
		System.out.println("���� : " + infoDate);
		System.out.println("���� : " + infoBody);
		System.out.println("��� : " + infoLink);
		
		if(infoName == null || infoName.equals("") || infoTitle == null || infoTitle.equals("") || infoDate == null || infoDate.equals("") ||
				infoBody == null || infoBody.equals("") || infoLink == null || infoLink.equals("")) {
			request.getSession().setAttribute("messageType", "���� �޽���");
			request.getSession().setAttribute("messageContent", "��� ������ �Է��ϼ���.");
			response.sendRedirect("write.jsp");
			return;
		}
		
		int result = new InfoDAO().write(infoName, infoTitle, infoBody, infoLink, infoDate);
		if(result == 1) {
			request.getSession().setAttribute("messageType", "���� �޽���");
			request.getSession().setAttribute("messageContent", "������ ��ϵǾ����ϴ�.");
			response.sendRedirect("write.jsp");	
			return;
		} else {
			request.getSession().setAttribute("messageType", "���� �޽���");
			request.getSession().setAttribute("messageContent", "������ �߻��Ͽ����ϴ�.");
			response.sendRedirect("write.jsp");
			return;
		}
		
	}

}
