<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_member.jsp" %>

<!DOCTYPE html> 
<html> 
<head>
<title>회원가입처리</title>
<meta charset="utf-8">

</head>
<body>
<div class="container">
<div class="well well-lg">
<c:choose>
<c:when test="${flag}">
회원가입을 했습니다.
</c:when>
<c:otherwise>
회원가입을 실패했습니다.
</c:otherwise>
</c:choose>
</div>
<c:choose>
<c:when test="${flag}">
<input type='button' value='로그인'
onclick="location.href='login.do'">
<input type='button' value='홈'
onclick="location.href='${root}/index.jsp'">
</c:when>
<c:otherwise>

<input type='button' value='다시시도'
onclick="history.back()">
<input type='button' value='홈'
onclick="location.href='${root}/index.jsp'">

</c:otherwise>
</c:choose>
</div>
</body>
</html> 