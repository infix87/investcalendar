<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="info.InfoDAO" %>
<%@ page import="info.InfoDTO" %>    
<!DOCTYPE html>
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
				<li><a href="weekCalendar.jsp">주간 일정</a>
				<li><a href="monthCalendar.jsp">월간 일정</a>
				<li class="active"><a href="sendInfo.jsp">일정 제보</a>
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
		<form method="post" action="./SendInfoWrite"> 
			<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"><h4>일정 제보</h4> </th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>제보자</h5></td>
						<td><h5><%= userID %><h5></td>
					</tr>				
					<tr>
						<td style="width: 110px;"><h5>종목(테마)명</h5></td>
						<td><input class="form-control" type="text" name="infoName" maxlength="20" placeholder="종목명을 입력하세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>제목</h5></td>
						<td><input class="form-control" type="text" name="infoTitle" maxlength="20" placeholder="제목을 입력하세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>일정</h5></td>
						<td><input class="form-control" type="text"  name="infoDate" maxlength="20" placeholder="일정을 입력하세요."></td>
					</tr>										
					<tr>
						<td style="width: 110px;"><h5>내용</h5></td>
						<td><textarea type="text" class="form-control" name="infoBody" maxlength="2048" style="height: 350px;" placeholder="내용을 입력하세요." ></textarea></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>참고기사</h5></td>
						<td><input class="form-control" type="text"  name="infoLink" maxlength="1024" placeholder="기사 링크를 입력하세요."></td>
					</tr>					
					<tr>	
						<td colspan="2"><input class="btn btn-primary pull-right" type="submit" value="등록"></td>
					</tr>	
				</tbody>
			</table>
		</form>
	</div>
	
</body>
</html>