<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_bbs.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>게시판 삭제</title>
<meta charset="utf-8">

<style type="text/css">
#red {
	color: red;
}
</style>

</head>
<body>

	<div class="container">
<c:choose>
<c:when test="${flag}">
<div class="well well-lg">
<br><br>
부모글이므로 삭제할 수 없습니다.
<br><br>
<button onclick="history.back()">다시 시도</button>
</div>
</c:when>
<c:otherwise>

		<h1 class="col-sm-offset-2 col-sm-10">삭제</h1>
		<form class="form-horizontal" method="post" action="delete">

			<input type="hidden" name="bbsno" value="${param.bbsno}">
		  <input type="hidden" name="col" value="${param.col}">
      <input type="hidden" name="word" value="${param.word}">
      <input type="hidden" name="nowPage" value="${param.nowPage}">

			<div class="form-group">
				<label class="control-label col-sm-2" for="passwd">비밀번호</label>
				<div class="col-sm-6">
					<input type="password" name="passwd" id="passwd"
						class="form-control">
				</div>
			</div>

			<p id="red" class="col-sm-offset-2 col-sm-6">삭제하면 복구할 수 없습니다.</p>

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-5">
					<button class="btn" style=background-color:#F5D0A9>삭제</button>
					<button type="button" class="btn" onclick="location.href='./list'"
          style=background-color:#F2F5A9>목록</button>
				</div>
			</div>


		</form>
</c:otherwise>
		</c:choose>
	</div>
</body>
</html>
