<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_member.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>ID 찾기</title>
<meta charset="utf-8">
<!-- jquery ajax에 필요한 부분 start -->
<script type="text/javascript"
src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js" ></script>
<script src="<%=request.getContextPath() %>/js/ajaxssetup.js"></script>
<!-- jquery ajax에 필요한 부분 end -->
<script type="text/javascript">
function idfind(f){
  if (f.mname.value=="") {
    alert("이름을 입력 해주세요.");
    document.frm.mname.focus();
    
  } else if (f.email.value=="") {
    alert("이메일을 입력 해주세요.");
    document.frm.email.focus();
    
  } else {
    var url = "id_findproc";
    var param = "mname="+frm.mname.value+"&email="+frm.email.value;
    
    $.get(
        url,
        param,
        function(data, textStatus) {
          $("#idfind").text(data);
        }
    );
  }
}
</script>
<style type="text/css">
body  {
  color:black;
  text-align: center;
}
</style>

</head>
<body>

	<div class="container">

		<h1 class="col-sm-offset-2 col-sm-10" id="bbsg">ID 찾기</h1>
		<form class="form-horizontal" method="post" action="idfind" name="frm">

			<div class="form-group">
				<label class="control-label col-sm-2" for="mname" id="bbsg">이름</label>
				<div class="col-sm-6">
					<input type="text" name="mname" id="mname" class="form-control"
					value="개발자5">
				</div>
			</div>
<br>
			<div class="form-group">
				<label class="control-label col-sm-2" for="email" id="bbsg">이메일</label>
				<div class="col-sm-6">
					<input type="email" name="email" id="email" class="form-control"
					value="email5@mail.com">
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-5">
				<br>
					<button type="button" class="btn" onclick="idfind(document.frm)">찾기</button>
					<button type="button" class="btn" onclick="window.close()">취소</button>
				</div>
			</div>


		</form>
  <div id="idfind"></div>
	</div>
</body>
</html>
