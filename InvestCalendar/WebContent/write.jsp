<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<script tyep="text.javascript">	
		function registerCheckFunction() {
			var userID = $('#userID').val();
			$.ajax({
				type: 'POST',
				url: './UserRegisterCheckServlet',
				data: {userID: userID},
				success: function(result) {
					if(result == 1) {
						$('#checkMessage').html('사용할 수 있는 아이디입니다.');
						$('#checkType').attr('class', 'modal-content panel-success');
					} else {
						$('#checkMessage').html('사용할 수 없는 아이디입니다.');
						$('#checkType').attr('class', 'modal-content panel-warning');						
					}
					$('#checkModal').modal("show");
				}
			});
		}	
		function passwordCheckFunction() {
			var userPassword1 = $('#userPassword1').val();
			var userPassword2 = $('#userPassword2').val();
			if(userPassword1 != userPassword2) {
				$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
			} else {
				$('#passwordCheckMessage').html('');				
			}
		}		
	</script>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
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
				<li><a href="index.jsp">메인</a>
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
							<li><a href="logout.jsp">로그아웃</a></li>
						</ul>					
					</li>
				</ul>
			<%
				}
			%>
		</div>
	</nav>
	
	<div class="container">
		<form method="post" action="./infoWrite"> 
			<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"><h4>일정 등록</h4> </th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>종목명</h5></td>
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
	

	<%
		String messageContent = null;
		if (session.getAttribute("messageContent") != null) {
			messageContent = (String) session.getAttribute("messageContent");
		}
		String messageType = null;
		if (session.getAttribute("messageType") != null) {
			messageType = (String) session.getAttribute("messageType");
		}		
		if (messageContent != null) {
	%>
		<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="vertical-alignment-helper">
				<div class="modal-dialog vertical-align-center">
					<div class="modal-content panel-success" >
							<div class="modal-header panel-heading">
								<button type="button" class="close" data-dismiss="modal">
									<span aria-hidden="true">&times</span>
									<span class="sr-only">Close</span>
								</button>
								<h4 class="modal-title">
									<%= messageType %>
								</h4>
							</div>
						<div class="modal-body">
							<%= messageContent %>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			$('#messageModal').modal("show");
		</script>
	<%
			session.removeAttribute("messageContent");
			session.removeAttribute("messageType");
		}
	%>

</body>
</html>