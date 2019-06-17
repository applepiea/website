<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_member.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>회원정보</title>
<meta charset="utf-8">

<script type="text/javascript">
	function filedown() {

		var url = "${root}/download";

		url += "?dir=/member/storage";
		url += "&filename=${dto.fname}";

		location.href = url;

	}

	function update() {
		var url = "update";
		url += "?id=${dto.id}";

		location.href = url;

	}
	function updateFile() {
		var url = "updateFile";
		url += "?id=${dto.id}";
		url += "&oldfile=${dto.fname}"

		location.href = url;

	}

	function updatePw() {
		var url = "updatePw";
		url += "?id=${dto.id}";

		location.href = url;

	}

	function listM() {
		var url = "/mvc_webtest/admin/list";

		location.href = url;
	}

	function del() {
		var url = "delete";
		url += "?id=${dto.id}";
		url += "&oldfile=${dto.fname}";

		location.href = url;
	}
</script>

</head>
<body>
	<div class="container">
		<h2 class="col-sm-offset-2 col-sm-10">${dto.mname}의회원정보</h2>
		<table class="table table-bordered">
			<tr>
				<td colspan="2" style="text-align: center"><img
					src="./storage/${dto.fname}" class="img-rounded" width="200"
					height="200"></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td>${dto.id}</td>
			</tr>
			<tr>
				<th>성명</th>
				<td>${dto.mname}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${dto.tel}</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${dto.email}</td>
			</tr>
			<tr>
				<th>우편번호</th>
				<td>${dto.zipcode}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>${dto.address1}{dto.address2}</td>
			</tr>
			<tr>
				<th>직업</th>
				<td>직업코드 : ${dto.job}(${util:jobName(dto.job)})
				</td>
			</tr>
			<tr>
				<th>날짜</th>
				<td>${dto.mdate}</td>
			</tr>



		</table>

		<div style="text-align: center">
			<button class="btn" onclick="update()">정보 수정</button>
			<button class="btn" onclick="del()">회원 탈퇴</button>
				<button class="btn" onclick="listM()">목록</button>
			<c:if test="${not empty dto.id && grade !='A' }">
				<button class="btn" onclick="updateFile()">사진 수정</button>
				<button class="btn" onclick="updatePw()">패스워드 수정</button>
				<button class="btn" onclick="filedown()">다운로드</button>
			</c:if>
<%-- 			<c:if test="${not empty dto.id&& grade=='A' }"> --%>
<%-- 			</c:if> --%>
		</div>
	</div>
</body>
</html>