<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="info.InfoDAO" %>
<%@ page import="info.InfoDTO" %>
<%@ page import="java.util.Calendar" %>    
<!DOCTYPE html>
<%
	Calendar now = Calendar.getInstance();
	int year = now.get(Calendar.YEAR);
	int month = now.get(Calendar.MONTH)+1;
	
	int end = now.getActualMaximum(Calendar.DAY_OF_MONTH);    //해당월의 마지막 날짜
	int w = now.get(Calendar.DAY_OF_WEEK);    //1~7(일~토)
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/custom.css">
	<title>투자의 혜안</title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>	
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		
		int infoID = 1;
		if (request.getParameter("infoID") != null) {
			infoID = Integer.parseInt(request.getParameter("info"));
		}
		infoID = 1;
		if (infoID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		
		InfoDAO infoDAO = new InfoDAO();
		
		String val = "17-07";
		ArrayList<InfoDTO> list = infoDAO.getMonthList(val);
		
		out.println(list.size());

	%>
	
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp">투자의 혜안</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="index.jsp">메인</a>
				<li><a href="weekCalendar.jsp">주간 일정</a>
				<li class="active"><a href="monthCalendar.jsp">월간 일정</a>
				<li><a href="sendInfo.jsp">일정 제보</a>				
			</ul>
			<%
				if(userID == null) {
			%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">접속하기<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul>							

					</li>
				</ul>
			<%
				} else {
				//회원 로그인시
			%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">회원관리<span class="caret"></span>
						</a>			
						<ul class="dropdown-menu">
							<li><a href="userUpdate.jsp">정보수정</a></li>
							<li><a href="./logoutAction.jsp">로그아웃</a></li>
						</ul>									
					</li>
				</ul>
			<%
				}
			%>
		</div>
	</nav>
	
	<div class="container">
		<div class="continer" style="text-align: center;">
			<h2><%= month %>월 캘린더</h2>
		</div>
		<table class="table table-bordered" style="text-align: left; border: 1px solid #dddddd">
			<thead>
                <tr height="25">
                    <th style="text-align: center;">일</td>
                    <th style="text-align: center;">월</td>
                    <th style="text-align: center;">화</td>
                    <th style="text-align: center;">수</td>
                    <th style="text-align: center;">목</td>
                    <th style="text-align: center;">금</td>
                    <th style="text-align: center;">토</td>
                </tr>
            </thead>
            <tbody>
                <%
                    int newLine = 0;
                    //1일이 어느 요일에서 시작하느냐에 따른 빈칸 삽입
                    out.println("<tr>");
                    for(int i=1; i<w; i++)
                    {
                        out.println("<td bgcolor='#ffffff'>&nbsp;</td>");
                        newLine++;
                    }
                    
                    //실제 날짜 데이터 입력 
                    String fc, bg;
                    for(int i=1; i<=end; i++)
                    {
                        
                        fc = (newLine == 0)?"red":(newLine==6?"blue":"#000000");
                        bg = "#ffffff";
                        
                        
                        out.println("<td valign='top' bgcolor=" + bg + "><font color=" + fc + ">" + i +"</font>" );
                        out.println("<br><br>");
                       	//데이터 입력 부분
                       	//종목명만 나오게 
                       	
                       	out.println("<b>");
/*                        	rs.first();
						while(rs.next()){
							String name = rs.getString(1);
							String dday = rs.getString(2);
							String note = rs.getString(3);
							
														
//							if(dday.equals(String.valueOf(i))){
							if(dday.equals(String.format("%02d", i))){								
								//out.println("&nbsp; * " + name);
//								out.println("<p onmouseover=\"this.className='mouseover'\" onmouseout=\"this.className=''\" style=\"cursor:pointer\" title='" + note + "'> &nbsp; * " + name + "</p>");
								out.println("<p class='tooltip' rel='" + note + "'> &nbsp; * " + name + "</p>");
//								out.println("<span data-tooltip-text='THIS IS TOOLTIP!!'>" + name + "</span> <br>");							
								
//								out.println("");
							} 
														
						}*/
                       	out.println("</b>");		                                   
                        
                        out.println("<br></td>");
                        newLine++;
                       	
                        
                        if(newLine == 7 && i != end)
                        {
                            out.println("</tr>");
                            out.println("<tr>");
                            newLine = 0;
                        }
                        
                    }
					
                    
                     //마지막행 공백 처리
                    while(newLine>0 && newLine<7)
                    {
                        out.println("<td bgcolor='ffffff'>&nbsp;</td>");
                        newLine++;    
                    }
                    out.println("</tr>");
                    out.println("<tr><td colspan=7 bgcolor=#ffffff><center><h3> 일정 미정  </h3></center><br><br>");

                    /* rs.first();
                    while(rs.next()){
						String name = rs.getString(1);
						String dday = rs.getString(2);
						String note = rs.getString(3);
						
						if(dday.equals("99")){								
							out.println("&nbsp;<b> * " + name + "</b> - " + note);
							out.println("<br>");
						}  
                    } */
                   out.println("<br></td></tr>");
                %>
             </tbody>
		</table>
	</div>

	
</body>
</html>