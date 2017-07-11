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
	int day = now.get(Calendar.DATE);
	
	String date = request.getParameter("date");
	
	now.set(year, month-1, 1);    //출력할 년도, 월로 설정
	year = now.get(Calendar.YEAR);    //변화된 년, 월
	month = now.get(Calendar.MONTH) + 1;
	
	
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
		}else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
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
		InfoDTO info = new InfoDAO().getInfo(infoID);
		
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
				<li class="active"><a href="weekCalendar.jsp">주간 일정</a>
				<li><a href="monthCalendar.jsp">월간 일정</a>
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
	
	<%

		Calendar calendar = Calendar.getInstance();
		Calendar calsDate = Calendar.getInstance();
		Calendar caleDate = Calendar.getInstance();
		Calendar calprevDate = Calendar.getInstance();
		Calendar calnextDate = Calendar.getInstance();
		Calendar calcurrDate = Calendar.getInstance();
	
		int maxDay = now.getActualMaximum(now.DATE);
		String sDate = date;
		if(date == null) { 
//			out.println("date 값이 없어 오늘 날짜를 대입합니다.");
			sDate = String.format("%d", year) + "-" + String.format("%02d", month) + "-" + String.format("%02d",(day));
		} else {
			
			year = Integer.parseInt(date.substring(0,4));
			month = Integer.parseInt(date.substring(5,7));
			day = Integer.parseInt(date.substring(8,10));	
		}
				
 		calsDate.set(year, month, day);
		caleDate.set(year, month, day);
		calprevDate.set(year, month, day);
		calnextDate.set(year, month, day);
		calcurrDate.set(year, month, day); 
		
		caleDate.add(Calendar.DATE, +6);
		calprevDate.add(Calendar.DATE, -7);
		calnextDate.add(Calendar.DATE, +7);
		
/* 		out.println("<br>calsDate : " + calsDate.get(Calendar.YEAR) + "-" + calsDate.get(Calendar.MONTH) + "-" + calsDate.get(Calendar.DATE));
		out.println("<br>caleDate : " + caleDate.get(Calendar.YEAR) + "-" + caleDate.get(Calendar.MONTH) + "-" + caleDate.get(Calendar.DATE));
		out.println("<br>calprevDate : " + calprevDate.get(Calendar.YEAR) + "-" + calprevDate.get(Calendar.MONTH) + "-" + calprevDate.get(Calendar.DATE));
		out.println("<br>calnextDate : " + calnextDate.get(Calendar.YEAR) + "-" + calnextDate.get(Calendar.MONTH) + "-" + calnextDate.get(Calendar.DATE));
		out.println("<br>");
	 */	
 		//마지막 날짜	
		String eDate = String.format("%d", caleDate.get(Calendar.YEAR)) + "-"+ 
					   String.format("%02d", caleDate.get(Calendar.MONTH)) +"-"+
					   String.format("%02d", caleDate.get(Calendar.DATE));

		//다음페이지 시작 날짜
		String nextDate = String.format("%d", calnextDate.get(Calendar.YEAR)) + "-"+ 
				   		  String.format("%02d", calnextDate.get(Calendar.MONTH)) +"-"+
				   		  String.format("%02d", calnextDate.get(Calendar.DATE));
		//이전페이지 시작 날짜
		String prevDate = String.format("%d", calprevDate.get(Calendar.YEAR)) + "-"+ 
				   		  String.format("%02d", calprevDate.get(Calendar.MONTH)) +"-"+
				   		  String.format("%02d", calprevDate.get(Calendar.DATE));
	 	
		//표를 그리기 위한 현재 날짜 위치
		String currentDate = null;
		
/* 		for(int i = 0; i < 7; i++){
			if( day+i > maxDay ) {
				day = 1-i;
				if(month == 12) {
					month = 1;
					year += 1;
				} else {
					month += 1;	
				}
			} 
		} */
		
		InfoDAO infoDAO = new InfoDAO();
		ArrayList<InfoDTO> list = infoDAO.getList(sDate.substring(2), eDate.substring(2));
		
		
/* 		out.println("<br>sDate : " + sDate);
		out.println("<br>eDate : " + eDate);
		out.println("<br>prev Date : " + prevDate);
		out.println("<br>next Date : " + nextDate);
		out.println("<br>List count : " + list.size());
 */		
	%>

	<div class="container">
		<div class="row">	
					<a href="weekCalendar.jsp?date=<%= prevDate %>" class="btn btn-success pull-left">이전</a> 
					<a href="weekCalendar.jsp?date=<%= nextDate %>" class="btn btn-success pull-right">다음</a> 
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="text-align: center;"><h3> 증시 일정 </h3> </th>
						</tr>
					</thead>
						<tbody>
							<tr>
								<td style="text-align: center;"><h5>일정</h5></td>
								<td style="text-align: center;"><h5>내용</h5></td>
								<td style="text-align: center;"><h5>추천수</h5></td>
							</tr>
							<%
								//행을 그리는 루핑 (월 ~ 일)
								for(int i = 0; i < 7; i++) {
									currentDate =String.format("%d", calcurrDate.get(Calendar.YEAR)).substring(2,4) + "-"+ 
									   		  	String.format("%02d", calcurrDate.get(Calendar.MONTH)) +"-"+
									   		  	String.format("%02d", calcurrDate.get(Calendar.DATE));
									calcurrDate.add(Calendar.DATE, +1);									
							%>
								<tr>
									<td style="width: 130px; height: 100px; display: table-cell; vertical-align: middle;"><h5><%= currentDate %></h5></td>
									<td style="text-align: left; display: table-cell; vertical-align: middle;">
										<%
											for(int j = 0; j < list.size(); j++) {
												if(list.get(j).getInfoDate().equals(currentDate)) {
										%>
												<p style="font-family: 'noto Sans KR';"><a href="./view.jsp?infoID=<%= list.get(j).getInfoID() %>">
												<h5><%= list.get(j).getInfoName() %> - <%=list.get(j).getInfoTitle() %></h5>
											</a></p>
										<%
												}
											}
										%>
									</td>
									<td style="width: 70px; display: table-cell; vertical-align: middle;"><span class="label label-success">10</span></td>
								</tr>
							<%
								}
							%>
							
<%-- 								<%
									InfoDAO infoDAO = new InfoDAO();
									ArrayList<InfoDTO> list = infoDAO.getList("17-07-03");
							
									for(int i = 0; i < list.size(); i++) {
								%>
									<tr>
										<td style="width: 20%;"><%= list.get(i).getInfoDate() %></td>
										<td style="text-align: left;">
											<a href="./view.jsp?infoID=<%= list.get(i).getInfoID() %>">
												<%=list.get(i).getInfoName() %> - <%=list.get(i).getInfoTitle() %>
											</a>
										</td>
										<td style="width: 70px"><span class="label label-success">10</span></td>
									</tr>								
								<%
									}
								%>
 --%>
															
						</tbody>
				</table>
		</div>
	</div>
	
</body>
</html>