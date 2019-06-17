<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<title>Home</title>
 <div class="modal fade" id="myModal" role="dialog">

    <div class="modal-dialog modal-sm">

      <div class="modal-content">

        <div class="modal-header">

      

          <h4 class="modal-title">오류 메세지!</h4>

        </div>

        <div class="modal-body">

          <p>This is a small modal.</p>

        </div>

        <div class="modal-footer">

          <button type="button" class="btn btn-default" data-dismiss="modal" >Close</button>

        </div>

      </div>

    </div>

	</div>

</div>

</head>
<body>
	<div class="container">
		<h1>Hello world!</h1>

		<P>The time on the server is ${serverTime}.</P>
	</div>
</body>

</html>

