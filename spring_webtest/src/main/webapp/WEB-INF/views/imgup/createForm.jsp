<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>

<html>
<head>
<title>게시글 등록</title>
<meta charset="utf-8">
</head>
<body>
	<div class="container">
		<h1 class="col-sm-offset-2 col-sm-10">게시글 작성</h1>
		<label class="col-sm-offset-2 col-sm-10"> </label>
		<form class="form-horizontal" action="create" method="post"
			name="frm" onsubmit="return incheck(this)"
			enctype="multipart/form-data">

			<br>

			<div class="form-group">
				<label class="control-label col-sm-2" for="fname">사진</label>
				<div class="col-sm-8">
					<input type="file" class="form-control" accept=".jpg, .gif, .png"
						id="fname" name="fnameMF" />
				</div>
			</div>
			
			<div class="form-group">
        <label class="control-label col-sm-2" for="name">이름</label>
        <div class="col-sm-3">
          <input type="text" class="form-control" name="name" id="name">
        </div>
      </div>
      
      <div class="form-group">
        <label class="control-label col-sm-2" for="title">제목</label>
        <div class="col-sm-3">
          <input type="text" class="form-control" name="title" id="title">
        </div>
      </div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="content">내용</label>
				<div class="col-sm-6">
					<textarea rows="5" cols="5" id="content" name="content"
						class="form-control"></textarea>
				</div>
			</div>
			
			 <div class="form-group">
        <label class="control-label col-sm-2" for="passwd">비밀번호</label>
        <div class="col-sm-4">
          <input type="password" class="form-control" id="passwd"
            name="passwd">
        </div>
      </div>


			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-5">
					<button class="btn btn-default">등록</button>
					<button type="reset" class="btn btn-default">취소</button>
				</div>
			</div>





		</form>

	</div>

</body>

</html>