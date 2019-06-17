<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_bbs.jsp"%>
<%@ taglib prefix="util" uri="/ELFunctions"%>

<!DOCTYPE html>
<html>
<head>
<title>게시판 목록</title>
<meta charset="utf-8">

<script type="text/javascript">
	$(document).ready(function() {
		var modal = '${msg}'; //Controller에서 가져온 데이터
		checkModal(modal); //modal생성

		//history back일때는 modal 안보여주는 코드 1
		history.replaceState({}, null, null);

		function checkModal(modal) { //modal 생성함수 선언
			if (history.state)
				return; //코드2
			if (modal) {
				$(".modal-body").html(modal);
				$("#myModal").modal("show");
			}
		}
	});

	function read(bbsno) {
		var url = "read";
		url = url + "?bbsno=" + bbsno;

		url += "&col=${col}";
		url += "&word=${word}";
		url += "&nowPage=${nowPage}";

		location.href = url;
	}
</script>

<!--  javascript 변수 : url = url + "?bbsno=" + bbsno; -->
<!-- jsp변수 : url += "&col=${col}; -->


</head>
<body>

	<div class="container">
		<h2>게시판 목록</h2>

		<br>
		<form class="form-inline" action="./list">
			<div class="form-group">
				<select class="form-control" name="col">
					<option value="wname" <c:if test="${col=='wname'}">selected</c:if>>성명</option>
					<option value="title" <c:if test="${col=='title'}">selected</c:if>>제목</option>
					<option value="content"
						<c:if test="${col=='content'}">selected</c:if>>내용</option>
					<option value="title_content"
						<c:if test="${col=='title_content'}">selected</c:if>>제목+내용</option>
					<option value="total" <c:if test="${col=='total'}">selected</c:if>>전체
						출력</option>
				</select>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Enter 검색어"
					name="word" value="${word}">
			</div>
			<button type="submit" class="btn btn-default"
				style="background-color: #A9BCF5">검색</button>
			<button class="btn" type="button" onclick="location.href='./create'"
				style="background-color: #F5A9A9">등록</button>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>grpno</th>
						<th>indent</th>
						<th>ansnum</th>
						<th>날짜</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty list}">
등록된 게시글이 없습니다.
</c:when>
						<c:otherwise>
							<c:forEach var="dto" items="${list}">
								<tr>
									<td>${dto.bbsno}</td>
									<td><c:forEach begin="1" end="${dto.indent}">	
									&nbsp;&nbsp;
									</c:forEach> <c:if test="${dto.indent>0}">
											<img src='${root}/images/re.jpg'>
										</c:if> <c:set var="rcount" value="${util:rcount(dto.bbsno,rinter) }" />
										<a href="javascript:read('${dto.bbsno}')">${dto.title}</a>
										<c:if test="${rcount>0 }">
											<span class="badge">${rcount}</span>
										</c:if> <c:if test="util:newImg(dto.wdate)">
											<img src="${root}/images/new.gif">
										</c:if></td>
									<td>${dto.wname}</td>
									<td>${dto.grpno}</td>
									<td>${dto.indent}</td>
									<td>${dto.ansnum}</td>
									<td>${dto.wdate}</td>
									<td>${dto.viewcnt}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<div>${paging}</div>
		</form>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">알림 메세지!</h4>
				</div>
				<div class="modal-body">
					<p>This is a small modal.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
