<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_member.jsp" %>


<!DOCTYPE html>

<html>

<head>

<title>Login 처리</title>

<meta charset="utf-8">

<script type="text/javascript">

function id_find(){

var url = "id_findform";

 

wr = window.open(url,"아이디 찾기","width=500,height=500");

wr.moveTo((window.screen.width-500)/2,(window.screen.height-500)/2);

 }


function passwd_find(){

var url = "passwd_find";

 

wr = window.open(url,"비밀번호 찾기","width=500,height=500");

wr.moveTo((window.screen.width-500)/2,(window.screen.height-500)/2);

}

</script>

</head>

<body>


	<div class="container">



		<h1 class="col-sm-offset-2 col-sm-10">Login</h1>

		<form class="form-horizontal" method="post"
			action="${root}/member/login">

<input type="hidden" name="rurl" value="${param.rurl}">
  <input type="hidden" name="bbsno" value="${param.bbsno}">
  <input type="hidden" name="nowPage" value="${param.nowPage}">
  <input type="hidden" name="nPage" value="${param.nPage}">
  <input type="hidden" name="col" value="${param.col}">
  <input type="hidden" name="word" value="${param.word}">
 

			<div class="form-group">

				<label class="control-label col-sm-2" for="id">ID</label>

				<div class="col-sm-4">

					<input type="text" name="id" id="id" class="form-control"
						required="required" value='${c_id_val}'>
				<c:choose>
						<c:when test="${c_id=='Y'}">
							<input type='checkbox' name='c_id' value='Y' checked='checked'>
					ID 저장
						</c:when>
						<c:otherwise>
							<input type='checkbox' name='c_id' value='Y'> ID 저장
						</c:otherwise>
					</c:choose>
				</div>

			</div>
			<div class="form-group">

				<label class="control-label col-sm-2" for="passwd">Password</label>

				<div class="col-sm-4">

					<input type="password" name="passwd" id="passwd"
						class="form-control" required="required">

				</div>

			</div>
			<div class="form-group">

				<div class="col-sm-offset-2 col-sm-7">

					<button type="submit" class="btn">로그인</button>

					<button type="button" class="btn"
						onclick="location.href='${root}/member/agreement'">회원가입</button>

					<button type="button" class="btn" onclick="id_find()">ID
						찾기</button>

					<button type="button" class="btn" onclick="passwd_find()">Password
						찾기</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>