<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_member.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>회원 목록</title>
<meta charset="utf-8">

<script type="text/javascript">
	function read(id) {
		var url = "${root}/member/read";
		url += "?id=" + id;

		location.href = url;

	}
</script>
</head>
<body>
	<div class="container">
		<h1 class="col-sm-offset-2 col-sm-10">회원정보</h1>


		<form class="form-inline" method="post" action="./list">
			<div class="form-group">
				<select class="form-control" name="col">
					<option value="mname" <c:if test="${col=='mname'}">selected</c:if>>이름</option>
					<option value="id" <c:if test="${col=='id'}">selected</c:if>>아이디</option>
					<option value="email" <c:if test="${col=='email'}">selected</c:if>>이름+아이디</option>
					<option value="total" <c:if test="${col=='total'}">selected</c:if>>전체출력</option>
				</select>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="enter 검색"
					name="word" value="${word}">
			</div>
			<button class="btn btn-default">검색</button>
			<button type="button" class="btn btn-default"
				onclick="location.href='${root}/member/create'">등록</button>
		</form>
		<c:forEach var="dto" items="${list}">
			<br>
			<table class="table table-bordered">
				<tr>
					<td rowspan="5" class="col-sm-5"><img
						src="${root}/member/storage/${dto.fname}" class="img-rounded"
						width="200" height="200"></td>
					<th class="col-sm-2">아이디</th>
					<td class="col-sm-8"><a href="javascript:read('${dto.id}')">${dto.id}</a></td>
				</tr>
				<tr>
					<th class="col-sm-2">성명</th>
					<td>${dto.mname}</td>
				</tr>
				<tr>
					<th class="col-sm-2">전화번호</th>
					<td>${dto.tel}</td>
				<tr>
					<th class="col-sm-2">이메일</th>
					<td>${dto.email}</td>
				</tr>
				<tr>
					<th class="col-sm-2">주소</th>
					<td>(${dto.zipcode})${dto.address1} ${dto.address2}</td>
				</tr>
			</table>
		</c:forEach>
		${paging}
	</div>
</body>
</html>