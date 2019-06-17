<%@ page contentType="text/html; charset=UTF-8"%>

<%
	String root = request.getContextPath();

	String id = (String) session.getAttribute("id");

	String grade = (String) session.getAttribute("grade");

	String str = "기본페이지 입니다.";

	if (id != null && !grade.equals("A")) {

		str = "안녕하세요 " + id + "님!!";

	} else if (id != null && grade.equals("A")) {

		str = "관리자 페이지 입니다.";

	}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta name="viewport" content="width=device-width, initial-scale=1"
	charset="utf-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<!-- jquery ajax에 필요한 부분 start -->

<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>

<script src="<%=root%>/js/ajaxerror.js"></script>

<!-- jquery ajax에 필요한 부분 end -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<style>
body {
	background-image: url("<%=root%>/images/cherry.jpg");
	background-repeat: no-repeat;
}
</style>
</head>
<body>

	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">MENU</a>
			</div>

			<ul class="nav navbar-nav">
				<li class="active"><a href="<%=root%>">HOME</a></li>

				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> Board<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="<%=root%>/bbs/create">Create</a></li>
						<li><a href="<%=root%>/bbs/list">List</a></li>
					</ul></li>

				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">memo<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="<%=root%>/memo/create">Create</a></li>
						<li><a href="<%=root%>/memo/list">List</a></li>
					</ul></li>

				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">team<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="<%=root%>/team/create">Create</a></li>
						<li><a href="<%=root%>/team/list">List</a></li>
					</ul></li>

				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">Imgup<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="<%=root%>/imgup/create">Create</a></li>
						<li><a href="<%=root%>/imgup/list">List</a></li>
					</ul></li>
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">guestbook<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="<%=root%>/guestbook/create">Create</a></li>
						<li><a href="<%=root%>/guestbook/list">List</a></li>
					</ul></li>
		</div>
	</nav>

	<%
		if (id == null) {
	%>

	<ul class="nav navbar-right">
		<li><a href="<%=root%>/member/agreement"><span
				class="glyphicon glyphicon-user"></span>Sign up</a></li>
		<li><a href="<%=root%>/member/login"><span
				class="glyphicon glyphicon-log-in"></span> Login</a></li>
	</ul>
	<%
		} else {
	%>



	<ul class="nav navbar-nav navbar-right">

		<li><a href="<%=root%>/member/read"><span
				class="glyphicon glyphicon-user"></span> 나의정보 </a></li>



		<li><a href="<%=root%>/member/update"><span
				class="glyphicon glyphicon-log-in"></span> 회원수정 </a></li>



		<li><a href="<%=root%>/member/logout"><span
				class="glyphicon glyphicon-log-in"></span> Logout </a></li>
		<%
			}
		%>
		<%
			if (id != null && grade.equals("A")) {
		%>
		<li><a href="<%=root%>/admin/list">회원목록</a></li>
		<%
		}
		%>
	</ul>
</body>
</html>