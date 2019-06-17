<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_imgup.jsp" %>

<br/><br/>
<div class="container">

	<h1 class="col-sm-offset-2">게시글삭제</h1>
	
	<form class="form-horizontal" action="delete" method="post">
		<input type="hidden" name="imgno" value="${imgno}">
		<input type="hidden" name="oldfile" value="${oldfile}">
		<div class="form-group">
			<label class="col-sm-offset-2">삭제를 원하시면 비밀번호를 입력 후 아래 삭제버튼을 클릭하세요</label>
		</div>
		
		
		<div class="form-group">
			<label class="control-label col-sm-2" for="passwd">비밀번호</label>
			<div class="col-sm-4">
				<input type="password" class="form-control" id="passwd" name="passwd" />
			</div>
		</div>
		
		<br>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-5">
				<button type="submit" class="btn btn-default">삭제</button>
				<button type="reset" class="btn btn-default" onclick="history.back();">이전으로</button>
			</div>
		</div>
	</form>

</div>