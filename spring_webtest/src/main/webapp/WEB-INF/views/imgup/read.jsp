<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="/ssi/ssi_imgup.jsp" %>
 
<style type="text/css">
	*{ font-family: gulim; font-size: 15px; }
	.curImg{ margin-right:0; border:3px solid red !important; }
	.td_padding{ padding:5px 5px;}
	.td_padding img{ width:88px; height:88px;}
	.tt{margin-top:5px;}
	.tt td, .tt th{border:1px solid #efefef;}
	.glyphicon-chevron-left{color:#FF5675; float:left; left:0; margin-left:10px; border-radius:50px; padding:20px; position:absolute; top:45%; cursor:pointer; transition:all 0.5s;}
	.glyphicon-chevron-right{color:#FF5675; float:right; right:0; margin-right:10px; border-radius:50px; padding:20px; position:absolute; top:45%; cursor:pointer; transition:all 0.5s;}
	.glyphicon-chevron-left:hover, .glyphicon-chevron-right:hover{opacity: 0.3; background-color:#ededed} 
</style>

<script type="text/javascript">
	function readGo(imgno){
		var url = "./read";
		url = url +"?imgno="+imgno;
		
		location.href=url;
	}
	function updateGo(){
		var url = "./update";
		url += "?imgno=${dto.imgno}";
		url += "&oldfile=${dto.fname}";
		
		location.href= url;
	}
	
	function deleteGo(){
		var url = "./delete";
		url += "?imgno=${dto.imgno}";
		url += "&oldfile=${dto.fname}";
		
		location.href= url;
	}
</script>
  
<br/><br/>
<div class="container" style="text-align:center;">
	<div style="display:inline-block;">
		<div style="position:relative; display:block; width:500px;">
			<c:if test="${currentLeftId > 0}">
				<span class="glyphicon glyphicon-chevron-left" onclick="readGo('${currentLeftId}');"></span>
			</c:if>
			<c:if test="${currentRightId > 0}">
				<span class="glyphicon glyphicon-chevron-right" onclick="readGo('${currentRightId}');"></span>
			</c:if>
			<img src="./storage/${dto.fname}" width="100%" class="img-thumbnail">
		</div>
		
		<div style="display:block; width:500px;">
			<table class="tt" style="width: 100%;">
				<tr>
				<c:forEach var="i" begin="0" end="4">
					<c:choose>
						<c:when test="${files[i] == null}">
							<td class="td_padding">
								<img style="opacity: 0.5;" src="./storage/default.jpg" width="100%">
							</td>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${noArr[i] == imgno}">
									<td class="td_padding">
										<a href="javascript:readGo('${noArr[i]}')">
											<img class="curImg" src="./storage/${files[i]}" width="100%" border="0">
										</a>
									</td>
								</c:when>
								<c:otherwise>
									<td class="td_padding">
										<a href="javascript:readGo('${noArr[i]}')">
											<img src="./storage/${files[i]}" width="100%" border="0">
										</a>
									</td>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				</tr>
			</table>
		</div>
		
		<div style="display:block; width:500px;">
			<table class="table tt" style="width: 100%;">
				<tr>
					<th>성명</th>
					<td>${dto.name}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${dto.title}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${content}</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td>${dto.viewcnt}</td>
				</tr>
			</table>
		</div>
	</div>
	
  	<br><br>
	<div>
		<input type='button' class='btn btn-default' value='등록' onclick="location.href='./create';">
		<input type='button' class='btn btn-default' value='목록' onclick="location.href='./list';">
		<input type='button' class='btn btn-default' value='수정' onclick="updateGo();">
		<input type='button' class='btn btn-default' value='삭제' onclick="deleteGo();">
		<!-- <input type='button' class='btn btn-default' value='답변'> -->
	</div>
	<br><br><br><br><br><br>
		
</div> 

