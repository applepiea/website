<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String CONTENT_PAGE=(String)request.getAttribute("CONTENT_PAGE");
	
%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><tiles:getAsString name="title"/>Insert title here</title>
</head>

<!--상단 메뉴-->
<tiles:insertAttribute name="header" />
<!--상단 메뉴 끝-->

 
<!-- 내용 시작 -->

 <tiles:insertAttribute name="body" />
<!-- 내용 끝 -->
  

 
</body>
</html>

