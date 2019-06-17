<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_member.jsp"%>

<!DOCTYPE html>
<html>
<head>

<title></title>
<meta charset="utf-8">
</head>
<body>
	<div class="container">

		<h2 class="col-sm-offset-2 col-sm-10">비밀번호 변경확인</h2>
		<div class="well well-lg">
			<c:choose>
			</c:choose>
			<c:when test="${flag}">
비밀번호를 변경했습니다.
</c:when>
			<c:otherwise>
비밀번호 변경을 실패했습니다.
</c:otherwise>


		</div>
		<button class="btn" onclick="location.href='login.do'">로그인 화면</button>
		<button class="btn" onclick="location.href='read.do?id=${param.id}'">나의
			정보</button>
		<button class="btn" onclick="history.back()">다시 시도</button>
		<!--           <button type="button" class="btn btn-defulat" onclick="location.href='./list.jsp'">목록으로</button> -->
	</div>
</body>
</html>