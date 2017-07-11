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
	int month = now.get(Calendar.MONTH);
	

	String date = request.getParameter("date");	
	Calendar calprevDate = Calendar.getInstance();
	Calendar calnextDate = Calendar.getInstance();
	Calendar calcurrDate = Calendar.getInstance();	

	
	if(date == null){
		date = String.format("%d", year) + "-" + String.format("%02d", month);
	} else {
		year = Integer.parseInt(date.substring(0,4));
		month = Integer.parseInt(date.substring(5,7))-1;	
		calcurrDate.set(year, month, 1);
	}

//	out.println("<br>month : " + date + "( " + calcurrDate.getTime().getMonth() + " )");
	
	calprevDate.set(year, month, 1);
	calnextDate.set(year, month, 1);
	
	calprevDate.add(Calendar.MONTH, -1);
	calnextDate.add(Calendar.MONTH, +1);
	
	
	int end = calcurrDate.getActualMaximum(Calendar.DAY_OF_MONTH);    //해당월의 마지막 날짜
	int w = calcurrDate.get(Calendar.DAY_OF_WEEK);    //1~7(일~토)	
	
	//다음페이지 시작 날짜
	String nextMonth = String.format("%d", calnextDate.get(Calendar.YEAR)) + "-"+ 
			   		  String.format("%02d", calnextDate.get(Calendar.MONTH)+1);
	//이전페이지 시작 날짜
	String prevMonth = String.format("%d", calprevDate.get(Calendar.YEAR)) + "-"+ 
			   		  String.format("%02d", calprevDate.get(Calendar.MONTH)+1);
	
//	out.println("<br>PrevDate : " + prevMonth);
//	out.println("<br>nextDate : " + nextMonth);
	
	InfoDAO infoDAO = new InfoDAO();
	
	ArrayList<InfoDTO> list = infoDAO.getMonthList(date.substring(2));
	
	
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
	
 	<!-- <div class="row"> --> 
		<div class="continer" style="text-align: center;">
					<h2><%= month+1 %>월 캘린더</h2>
					<a href="monthCalendar.jsp?date=<%= prevMonth %>" class="btn btn-success pull-left">이전</a> 
					<a href="monthCalendar.jsp?date=<%= nextMonth %>" class="btn btn-success pull-right">다음</a> 		
			
		</div>
		<table class="table table-bordered" style="text-align: left; border: 1px solid #dddddd; table-layout: fixed;">
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
                    out.println("<tr height='100'>");
                    for(int i=1; i<w; i++)
                    {
						out.println("<td>&nbsp;</td>");
                        newLine++;
                    }
                    //실제 날짜 데이터 입력 
                    for(int i=1; i<=end; i++)
                    {
                 %>   
                 		<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;"> <%= i %>
                 			<%
                 				for(int j = 0; j < list.size(); j++) {
                 					//out.println("list " + j + " : " + list.get(j).getInfoDate().substring(6));
									if(list.get(j).getInfoDate().substring(6).equals(String.format("%02d", i))){
                 			%>
                 			
                 					<br>&nbsp;<%= list.get(j).getInfoName() %> - <%= list.get(j).getInfoTitle() %>
                 			<%
									}
                 				}
                 			%>
                 		</td>
                 <%
                        //out.println("<td valign='top'>" );
                        //out.println("<br><br>");
                       	//데이터 입력 부분
                       	//종목명만 나오게 

                       	/*                       	
                       	out.println("<b>");
                        	rs.first();
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
														
						}
                       	out.println("</b>");		                                   
                        
                        out.println("<br></td>");
*/
                        newLine++;
                       	
                        
                        if(newLine == 7 && i != end)
                        {
                            out.println("</tr>");
                            out.println("<tr height='100'>");
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
                    out.println("<tr><td colspan=7 bgcolor=#ffffff><center><h3> 일정 미정  </h3></center>");
			
                    for(int i = 0 ; i < list.size(); i++) {
                    	if(list.get(i).getInfoDate().substring(6).equals("99")){
                    	
					%>
                    		● <%= list.get(i).getInfoName() %> - <%= list.get(i).getInfoTitle() %>
                   	<%
                    	}
                    }
                   out.println("<br></td></tr>");
                %>
             </tbody>
		</table>
<!-- </div> -->

	
</body>
</html>