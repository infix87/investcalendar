<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="info.InfoDAO" %>
<%@ page import="info.InfoDTO" %>    
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale='1'">
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
		InfoDTO info = new InfoDAO().getInfo(infoID);
		
	%>
	
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapsed" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="index.jsp">투자의 혜안</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="index.jsp">메인</a>
				<li><a href="week_calendar.jsp">주간 일정</a>
				<li><a href="month_calendar.jsp">월간 일정</a>
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
							<li><a href="userupdate.jsp">정보수정</a></li>
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
		<div class="row">			
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="4" style="background-color: #eeeeee; text-align: center;"><h3> 상세 일정 </h3> </th>
						</tr>
						<tbody>
							<tr>
								<td style="width: 20%;">종목(테마)명</td>
								<td colspan="3"><%= info.getInfoName().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
							</tr>
							<tr>
								<td>제목</td>
								<td colspan="3"><%= info.getInfoTitle().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
							</tr>
							<tr>
								<td>일정</td>
								<td colspan="3"><%= info.getInfoDate().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
							</tr>
							<tr>
								<td>최초 등록일</td>
								<td><%= info.getInfoUploadDate() %></td>
								<td>수정일</td>
								<td><%= info.getInfoUpdateDate() %></td>
							</tr>
							<tr>
								<td>상세 내용 </td>
								<td colspan="3" style="min-height: 200px; text-align: left;">
									<%= info.getInfoBody().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
								</td>
							</tr>
							<tr>
								<td>관련 기사</td>
								<td colspan="3">
									<a href="<%= info.getInfoLink().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>" target="_blank">
										<%= info.getInfoLink().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
									</a>
								</td>
							</tr>															
						</tbody>
					</thead>
				</table>
				<a href="bbs.jsp" class="btn btn-primary">목록</a>
				<input type="submit" href="wrtie.jsp" class="btn btn-primary pull-right" value="글쓰기">
		</div>
	</div>
	
</body>
</html>