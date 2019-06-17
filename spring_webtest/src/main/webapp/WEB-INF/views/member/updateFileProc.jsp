<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_member.jsp" %>

<%
String id=(String)request.getAttribute("id");
boolean flag=(Boolean)request.getAttribute("flag");
%>


<!DOCTYPE html> 
<html> 
<head>
<title>회원가입처리</title>
<meta charset="utf-8">
</head>
<body>
<div class="container">
<h1 class="col-sm-offset-2 col-sm-10">사진 수정</h1>
<%
 if (flag){
 out.print("사진수정을 성공했습니다.");
 }else{
	 out.print("사진수정을 실패했습니다.");
 }
 %>

<button class="btn" onclick="location.href='read.do?id=<%=id%>'">나의 정보</button>
<button class="btn" onclick="history.back()">다시 시도</button>

</div>
</body>
</html> 