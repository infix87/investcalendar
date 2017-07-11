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
	
	<script tyep="text.javascript">	
		function voteFunction() {
			var userID = "admin";
			var infoID = "2";
			$.ajax({
				type: 'POST',
				url: './InfoVoteServlet',
				data: {userID: userID, infoID: infoID},
				success: function(result) {
					if(result == 1) {
						$('#checkMessage').html('추천하였습니다.');
						$('#checkType').attr('class', 'modal-content panel-success');
					} else {
						$('#checkMessage').html('추천을 취소하였습니다.');
						$('#checkType').attr('class', 'modal-content panel-warning');						
					}
					$('#checkModal').modal("show");
				}
			});
		}	
	</script>		
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
		
		int infoID = 0;
		if (request.getParameter("infoID") != null) {
			infoID = Integer.parseInt(request.getParameter("infoID"));
		}
//		infoID= 2;
		if (infoID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'history.back()'");
			script.println("</script>");
		}
		InfoDTO info = new InfoDAO().getInfo(infoID);
		String code = new InfoDAO().getCode(info.getInfoName());
		
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
		<div class="row">			
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="4" style="text-align: center;"><h3> 상세 일정 </h3> </th>
						</tr>
						<tbody>
							<tr>
								<td style="width: 20%;">종목(테마)명</td>
								<td colspan="3" style="text-align: center;"><%= info.getInfoName().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
							</tr>
							<tr>
								<td>제목</td>
								<td colspan="3" style="text-align: center;"><%= info.getInfoTitle().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
							</tr>
							<tr>
								<td>일정</td>
								<td><%= info.getInfoDate().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
								<td>추천수</td>
								<td>10</td>
							</tr>
							<tr>
								<td>최초 등록일</td>
								<td><%= info.getInfoUploadDate() %></td>
								<td>수정일</td>
								<td><%= info.getInfoUpdateDate() %></td>
							</tr>
							<tr>
								<td style="display: table-cell; vertical-align: middle;">상세 내용 </td>
								<td colspan="3" style="height: 200px; text-align: left; display: table-cell; vertical-align: middle; " >
									<%= info.getInfoBody().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
								</td>
							</tr>
							<tr>
								<td>관련 기사</td>
								<td colspan="3" style="text-align: left;">
									<a href="<%= info.getInfoLink().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>" target="_blank">
										<%= info.getInfoLink().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
									</a>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									<a href="#" onclick="history.back()" class="btn btn-primary pull-left">목록</a>
									<a href="#" onclick="voteFunction();" class="btn btn-primary pull-right">추천</a>
								</td>
							</tr>															
						</tbody>
					</thead>
				</table>

		</div>
	</div>
	<%
		if(code != null){

	%>
	<div class="container">
		<h3><%=info.getInfoName() %> 일봉 차트</h3>
		<table>
			<tr>
				<img width="100%" src="http://imgfinance.naver.net/chart/mobile/candle/day/<%= code %>_end.png" class="img-thumbnail">
			</tr>
		</table>
	</div>
	<%
		}
	%>
	
	<div class="container">
		<div class="row">
			<h3>사용자 의견</h3>
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thaed>
					<th style="text-align: center;">사용자</th>
					<th style="text-align: center;">내용</th>
					<th style="text-align: center;">등록일시</th>
				</thaed>
				<tbody>
					<tr>
						<td>김개똥</td>
						<td style="text-align: left;">이효리 최고</td>
						<td>2017-07-03</td>
					</tr>
					<tr>
						<td>이효리</td>
						<td style="text-align: left;">많은 응원부탁드려요</td>
						<td>2017-07-04</td>
					</tr>					
				</tbody>
			</table>
		</div>
	</div>

	<!-- 아이디 체크 확인 모달 -->
	<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<div id="checkType" class="modal-content panel-info">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							확인 메시지
						</h4>
					</div>
					<div id="checkMessage" class="modal-body">
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>	
	</div>
	
</body>
</html>