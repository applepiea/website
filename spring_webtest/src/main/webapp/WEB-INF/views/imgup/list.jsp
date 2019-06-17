<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_imgup.jsp" %>

<style type="text/css">
	th{text-align:center;}
	td{vertical-align: middle !important;}
</style>

<script type="text/javascript">
	$(document).ready(function(){
	 var modal = '${msg}'; //Controller에서 가져온 데이터
	 checkModal(modal); //modal생성
	 
	 //history back일때는 modal 안보여주는 코드 1
	 history.replaceState({},null,null);
	 
	 function checkModal(modal){ //modal 생성함수 선언
	     if(history.state) return; //코드2
	     if('${msg}'){
	         $(".modal-body").html(modal);
	         $("#myModal").modal("show");
	     }
	   }
	});
</script>

<script type="text/javascript">
	function newCreate(){
		var url = "create";
		location.href = url;
	}
	
	function downImg(fname){
		var url = "${root}/download?dir=/imgup/storage&filename=" + fname;
		location.href=url;
	}
	function read(imgno){
		var url = "read";
		url += "?imgno="+imgno;
		
		location.href = url;
	}
</script>


<br/><br/>
<div class="container">
	<table class='table'>
		<thead>
			<tr>
				<th>이미지</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>등록일시</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${empty list}">
					<tr>
						<td colspan='6' align='center'>등록된 데이터가 존재하지 않습니다</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="dto" items="${list}">
						<tr>
							<td align='center'><img src="./storage/${dto.fname}" class="img-thumbnail" style="width:80px; height:80px;"></td>
							<td><a href="javascript:read('${dto.imgno}');">${dto.title}</a></td>
							<td align='center'>${dto.name}</td>
							<td align='center'>${dto.viewcnt}</td>
							<td align='center'>${dto.regdate}</td>
							<td align='center'>
							
							<c:if test="${(fn:length(fn:trim(dto.fname)) > 0) && (fn:trim(dto.fname)!='default.jpg')}">
								<span class="glyphicon glyphicon-download-alt" style="cursor:pointer;" onclick="downImg('${dto.fname}')"></span>
							</c:if>
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			
		</tbody>
	</table>
	
	<form class="form-inline" name="searchForm" method="post" action="./list">
		<div class="form-group">
			<select class="form-control" name="col">
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="title_content">제목+내용</option>
				<option value="name">작성자</option>
				<option value="total">전체출력</option>
			</select>
			<script>
				if("${col}" != ""){
					document.searchForm.col.value="${col}";
				}
			</script>
		</div>
		<div class="form-group">
			<input type="text" class="form-control" placeholder="검색어" name="word" value="${word }" />
		</div>
		<button type="submit" class="btn btn-default">검색</button>
		<button type="button" class="btn btn-primary" style="float:right;" onclick="newCreate();">새로만들기</button>
	</form>
	
	<div>
		${paging}
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">

					<h4 class="modal-title">알려드립니다</h4>
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
	
</div>