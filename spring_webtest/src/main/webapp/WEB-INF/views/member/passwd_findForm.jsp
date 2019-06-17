<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_member.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Passwd 찾기</title>
<meta charset="utf-8">
<!-- jquery ajax에 필요한 부분 start -->
<script type="text/javascript"
src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js" ></script>
<script src="<%=request.getContextPath() %>/js/ajaxssetup.js"></script>
<!-- jquery ajax에 필요한 부분 end -->
<script type="text/javascript">
function passwdfind(f){
  if (f.id.value=="") {
    alert("아이디를 입력 해주세요.");
    document.frm.id.focus();
    
  } else if (f.mname.value=="") {
    alert("성함을 입력 해주세요.");
    document.frm.mname.focus();
    
  } else {
    var url = "passproc";
    var param = "id="+encodeURIComponent(frm.id.value)+"&mname="+encodeURIComponent(frm.mname.value);

    $.get(
        url,
        param,
        function(data, textStatus) {
          $("#passwdfind").text(data);
        }
    );
  }
}
</script>
<style type="text/css">
body  {
  text-align: center;
}
</style>
</head>
<body>

	<div class="container">

		<h1 class="col-sm-offset-2 col-sm-10" id="bbsg">Passwd 찾기</h1>
		<form class="form-horizontal" method="post" action="passproc" name="frm">

			<div class="form-group">
				<label class="control-label col-sm-2" for="id" id="bbsg">ID</label>
				<div class="col-sm-6">
					<input type="text" name="id" id="id" class="form-control"
					value="user5">
				</div>
			</div>
<br>
			<div class="form-group">
				<label class="control-label col-sm-2" for="mname" id="bbsg">이름</label>
				<div class="col-sm-6">
					<input type="text" name="mname" id="mname" value="개발자5">
				</div>
			</div>


			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-5">
          <br>
          <button type="button" class="btn" onclick="passwdfind(document.frm)">찾기</button>
          <button type="button" class="btn" onclick="window.close()">취소</button>
        </div>
			</div>

		</form>
  <div id="passwdfind"></div>
	</div>
</body>
</html>
