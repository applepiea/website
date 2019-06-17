<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_member.jsp" %>
<jsp:useBean id="dao" class="spring.model.member.MemberDAO"/>
<%
String id = request.getParameter("id");

boolean flag = dao.duplicateId(id);


if(flag){
	out.print(id + " : 중복되어 사용할 수 없습니다.");
}else{
	out.print(id + " : 중복아님, 사용 가능합니다.");
}
%>

