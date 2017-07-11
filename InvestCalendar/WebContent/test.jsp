<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>투자의 혜안</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"> </span>
				<span class="icon-bar"> </span>
				<span class="icon-bar"> </span>	
			</button>
			<a class="navbar-brand" href="main.jsp">기요니 웹싸이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active" ><a href="main.jsp">메인</a>
				<li><a href="bbs.jsp">게시판</a>
			</ul>
			<%
				if(userID == null) {
			%>			
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" 
							aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul> 
					</li>
				</ul>
			<%
				} else {
			%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" 
							aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul> 
					</li>
				</ul>				
			<%
				}
			%>
		</div>
	</nav>
	
	<div class="container">
		<table class="table table-bordered" style="text-align: left; border: 1px solid #dddddd; table-layout: fixed;">
			<thead>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th>토</th>
				<th>일</th>
			</thead>
			<tbody>
				<tr>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">
					123123<br>
					가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
				</tr>
				<tr>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
				</tr>
				<tr>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
					<td style="overflow:hidden; text-overflow: ellipsis; white-space:nowrap;">가나다라마바사</td>
				</tr>										
			</tbody>
		</table>
	
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>