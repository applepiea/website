<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_bbs.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>답변 등록</title>
<meta charset="utf-8">
<script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
 <script type="text/JavaScript">
   window.onload=function(){
     CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  };
 </script>
</head>
<body>
	<div class="container">

		<h1 class="col-sm-offset-2 col-sm-10">게시판 답변</h1>
		<form class="form-horizontal" method="post" action="reply">

			<input type="hidden" name="bbsno" value="${dto.bbsno}">
			<input type="hidden" name="grpno" value="${dto.grpno}">
			<input type="hidden" name="indent" value="${dto.indent}">
			<input type="hidden" name="ansnum" value="${dto.ansnum}">

			<div class="form-group">
				<label class="control-label col-sm-2" for="wname">글쓴이</label>
				<div class="col-sm-6">
					<input type="text" name="wname" id="wname" class="form-control">
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="title">제목</label>
				<div class="col-sm-8">
					<input type="text" name="title" id="title" class="form-control" value="${dto.title}">
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="content">내용</label>
				<div class="col-sm-8">
					<textarea rows="12" cols="7" id="content" name="content"
						class="form-control"></textarea>
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="passwd">패스워드</label>
				<div class="col-sm-6">
					<input type="password" name="passwd" id="passwd"
						class="form-control">
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-5">
					<button class="btn" style="background-color: #F5A9A9">등록</button>
					<button type="reset" class="btn" style="background-color: #F5D0A9">취소</button>
					<button type="button" class="btn"
						onclick="location.href='./list.do'"
						style="background-color: #F2F5A9">목록</button>
				</div>
			</div>
		</form>

	</div>
</body>
</html>
