<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_imgup.jsp" %>

<script type="text/javascript">
	function inCheck(f){
		if(f.title.value == ""){
			alert('제목을 입력하세요');
			f.title.focus();
			return false;  			
		}else if(f.content.value == ""){
			alert('내용을 입력하세요');
			f.content.focus();
			return false;  			
		}else if(f.passwd.value == ""){
			alert('비밀번호를 입력하세요');
			f.passwd.focus();
			return false;  			
		}
	}
</script>

<br/><br/>
<div class="container">
	<h1 class="col-sm-offset-2">수정하기</h1>
	<form class="form-horizontal" method="post" action="update" enctype="multipart/form-data" onsubmit="return inCheck(this);">

		<input type="hidden" name="imgno" value="${param.imgno}" />
		<input type="hidden" name="oldfile" value="${param.oldfile}" />
		
		<div class="form-group">
			<label class="control-label col-sm-2" for="oldfile">원본파일</label>
			<div class="col-sm-6">
				<img src='./storage/${param.oldfile}' />
			</div>
		</div>

		<div class="form-group">
			<label class="control-label col-sm-2" for="fname">변경파일</label>
			<div class="col-sm-6">
				<input type="file" class="form-control" id="fname" name="fnameMF" accept=".png,.jpg,.gif" />
			</div>
		</div>

		<div class="form-group">
			<label class="control-label col-sm-2" for="name">작성자</label>
			<div class="col-sm-4">
				${dto.name}
			</div>
		</div>

		<div class="form-group">
			<label class="control-label col-sm-2" for="title">제목</label>
			<div class="col-sm-6">
				<input type="text" class="form-control" id="title" name="title"  value="${dto.title}" />
			</div>
		</div>

		<div class="form-group">
			<label class="control-label col-sm-2" for="content">내용</label>
			<div class="col-sm-6">
				<textarea class="form-control" id="content" name="content" rows="10">${dto.content}</textarea>
			</div>
		</div>

		<div class="form-group">
			<label class="control-label col-sm-2" for="passwd">비밀번호확인</label>
			<div class="col-sm-4">
				<input type="password" class="form-control" id="passwd" name="passwd" />
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" class="btn btn-primary">등록</button>
				<button type="button" class="btn btn-default" onclick="location.href='./list'">리스트</button>
			</div>
		</div>
		
	</form>

</div>