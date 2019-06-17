<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_member.jsp"%>

<!DOCTYPE html>
<html>
<title>회원탈퇴</title>
<meta charset="utf-8">
</head>
<body>

	<div class="container">
		<h2 class="col-sm-offset-2 col-sm-10">회원탈퇴</h2>
		<div class="well well-lg">
			<c:choose>
				<c:when test="${flag}">
    회원탈퇴를 성공했습니다. 자동 로그아웃됩니다.
    </c:when>
				<c:otherwise>
회원탈퇴를 실패했습니다.
    </c:otherwise>

			</c:choose>
		</div>

		<button class="btn" onclick="location.href='${root}/index.jsp'">홈</button>
		<button type="button" class="btn" onclick="history.back()">취소</button>
		<button type="button" class="btn btn-defulat"
			onclick="location.href='${root}/index.jsp'">목록으로</button>

	</div>
</body>
</html>
