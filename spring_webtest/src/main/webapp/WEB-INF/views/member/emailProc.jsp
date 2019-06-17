<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); %> 
<%@ include file="/ssi/ssi_member.jsp" %>
<!DOCTYPE html> 
<html> 
<head>
<title>이메일 중복확인</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
function use(){
  opener.email.value='${param.email}';
  self.close();  
}

</script>

</head>
<body>

<div class="container">
<div class="well well-lg col-sm-7">
<br><br>

입력된 Email : ${param.email} <br><br>

<c:choose>
<c:when test="${flag}">
${param.email} 은 중복되어 사용할 수 없습니다.
</c:when>
<c:otherwise>
else {
${param.email} 은 사용 가능한 이메일입니다.
<button class='btn' type='button' onclick='use()'>사용</button>
</c:otherwise>
</c:choose>
</div>

<div class="col-sm-offset-2 col-sm-5">
<button type="button" class="btn" onclick="location.href='email_form.jsp'">다시시도</button>
<button type="button" class="btn" onclick="window.close()">닫기</button>
</div>
</div>
</body>
    </html>