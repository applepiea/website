<%@ page contentType="text/html; charset=UTF-8" %> 

<!DOCTYPE html> 
<html>
<head>

<title>사진수정</title>
<meta charset="utf-8">
</head>
<div class="container">
<h1 class="col-sm-offset-22 col-sm-10">사진수정</h1>
<form class="form-horizontal"
action="updateFile"
method="post"
enctype="multipart/form-data">


<input type="hidden" name="id" value="${param.id}">
<input type="hidden" name="oldfile" value="${param.oldfile}">
<div class="form-group">
        <label class="control-label col-sm-2" for="oldfile" >원본 파일</label>
        <div class="col-sm-6">
        <img src="/member/storage/${param.oldfile}"
        class="img-rounded" width="200px" height="200px">
        </div>
      </div>

      <div class="form-group">
        <label class="control-label col-sm-2" for="fname">변경파일</label>
        <div class="col-sm-6">
          <input type="file" name="fnameMF" class="form-control" accept=".png,.jpg,.gif"
          required="required">
        </div>
      </div>
      
      <div class="form-group">
        <div class="col-sm-offset-4 col-sm-8">
          <button class="btn">수정</button>
          <button type="reset" class="btn" onclick="history.back()">취소</button>
<!--           <button type="button" class="btn" onclick="location.href='./list.jsp'">목록으로</button> -->
        </div>
      </div>
      
      
    </form>
    </div>
    </html>