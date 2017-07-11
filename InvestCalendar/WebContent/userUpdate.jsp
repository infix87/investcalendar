<%@page import="user.UserDAO"%>
<%@page import="user.UserDTO"%>
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
		}else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		
		UserDTO user = new UserDAO().getUser(userID);
		
		
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
							<li class="active"><a href="join.jsp">회원가입</a></li>
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
		<form method="post" action="./userUpdate"> 
			<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"><h4>회원 등록 양식</h4> </th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>아이디</h5></td>
						<td colspan="2"><h5><%= user.getUserID() %></h5>
							<input type="hidden" name="userID" id="userID" value="<%= user.getUserID() %>" > 
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>기존 비밀번호</h5></td>
						<td colspan="2"><input class="form-control" type="password" id="userPassword" name="userPassword" maxlength="20" placeholder="현재 비밀번호를 입력하세요."></td>
					</tr>					
					<tr>
						<td style="width: 110px;"><h5>변경 비밀번호</h5></td>
						<td colspan="2"><input onkeyup="passwordCheckFunction();" class="form-control" type="password" id="userPassword1" name="userPassword1" maxlength="20" placeholder="변경할 비밀번호를 입력하세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>변경 비밀번호 확인</h5></td>
						<td colspan="2"><input onkeyup="passwordCheckFunction();" class="form-control" type="password" id="userPassword2"  name="userPassword2" maxlength="20" placeholder="변경할 비밀번호 확인을 입력하세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이름</h5></td>
						<td colspan="2"><input class="form-control" type="text" name="userName" maxlength="20" placeholder="이름을 입력하세요." value="<%= user.getUserName() %>"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>생년</h5></td>
						<td colspan="2"><input class="form-control" type="text" name="userAge" maxlength="4" placeholder="태어난년도를 입력하세요 ex)1980" value="<%= user.getUserAge() %>"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>성별</h5></td>
						<td colspan="2">
							<div class="form-group" style="text-align: center; margin: 0 auto;">
								<div class="btn-group" data-toggle="buttons">
									<% 
										if(user.getUserGender().equals("남자")) { 
									%>
										<label class="btn btn-primary active">
											<input type="radio" name="userGender" autocomplete="off" value="남자" checked> 남자
										</label>
										<label class="btn btn-primary">
											<input type="radio" name="userGender" autocomplete="off" value="여자"> 여자
										</label>																	
									<%
										} else {

									%>
										<label class="btn btn-primary">
											<input type="radio" name="userGender" autocomplete="off" value="남자"> 남자
										</label>
										<label class="btn btn-primary active">
											<input type="radio" name="userGender" autocomplete="off" value="여자" checked> 여자
										</label>																			
									<%
										}
									%>
									
								</div>
							</div>
						</td>
					</tr>					
					<tr>
						<td style="width: 110px;"><h5>이메일</h5></td>
						<td colspan="2"><input class="form-control" type="email" name="userEmail" maxlength="50" placeholder="이메일을 입력하세요."  value="<%= user.getUserEmail() %>"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>거주지역</h5></td>
						<td colspan="2"><input class="form-control" type="text" name="userArea" maxlength="20" placeholder="거주지역을 입력하세요."  value="<%= user.getUserArea() %>"></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>휴대전화</h5></td>
						<td colspan="2"><input class="form-control" type="text" name="userTel" maxlength="20" placeholder="전화번호를 입력하세요."  value="<%= user.getUserTEL() %>"></td>
					</tr>																											
					<tr>
						<td style="text-align: left;" colspan="3"><h5 style="color: red;" id="passwordCheckMessage"></h5>
						<input class="btn btn-primary pull-right" type="submit" value="변경"></td>
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
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>		
</body>
</html>