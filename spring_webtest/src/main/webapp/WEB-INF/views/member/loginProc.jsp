<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_member.jsp"%>

<!DOCTYPE html>

<html>
<head>
<title>Login 처리 확인</title>
<meta charset="utf-8">
</head>
<body>

	<div class="container">
		<h1 class="col-sm-offset-2 col-sm-10">Login 처리</h1>
		<div class="well well-lg">
			<c:choose>
				<c:when test="${flag}">
   로그인이 되었습니다.
   </c:when>
				<c:otherwise>
   아이디 또는 비밀번호를 잘못 입력하셨거나,<br>
  회원이 아닙니다. 회원가입을 진행해주세요.
    </c:otherwise>
			</c:choose>

		</div>

		<button class="btn" onclick="location.href='${root}/index.jsp'">홈</button>

		<button class="btn" onclick="history.back()">다시시도</button>



	</div>

</body>

</html>