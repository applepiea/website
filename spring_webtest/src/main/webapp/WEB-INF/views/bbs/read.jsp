<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_bbs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Homepage</title>
<meta charset="utf-8">

<script type="text/javascript">
	function listM() {
		var url = "list";
		url = url + "?col=${param.col}";
		url = url + "&word=${param.word}";
		url = url + "&nowPage=${param.nowPage}";

		location.href = url;
	}

	function updateM() {
		var url = "update";
		url = url + "?bbsno=${dto.bbsno}";
		url = url + "&col=${param.col}";
		url = url + "&word=${param.word}";
		url = url + "&nowPage=${param.nowPage}";

		location.href = url;
	}

	function deleteM(bbsno) {
		var url = "delete";
		url = url + "?bbsno=${dto.bbsno}";
		url = url + "&col=${param.col}";
		url = url + "&word=${param.word}";
		url = url + "&nowPage=${param.nowPage}";

		location.href = url;
	}

	function replyM() {
		var url = "reply";
		url = url + "?bbsno=${dto.bbsno}";

		location.href = url;
	}
</script>

</head>
<body>

	<div class="container">
		<h2>작성글</h2>
		<div class="panel panel-default">
			<div class="panel-heading">이름</div>
			<div class="panel-body">${dto.wname}</div>

			<div class="panel-heading">제목</div>
			<div class="panel-body">${dto.title}</div>

			<div class="panel-heading">내용</div>
			<div class="panel-body">${dto.content}</div>

			<div class="panel-heading">조회수</div>
			<div class="panel-body">${dto.viewcnt}</div>

			<div class="panel-heading">등록일</div>
			<div class="panel-body">${dto.wdate}</div>
		</div>

		<div>
			<button type="button" class="btn" onclick="updateM()"
				style="background-color: #F5A9A9">수정</button>
			<button type="button" class="btn" onclick="deleteM()"
				style="background-color: #F5D0A9">삭제</button>
			<button type="button" class="btn" onclick="replyM()"
				style="background-color: #CCEEFF">답변</button>
			<button type="button" class="btn" onclick="listM()"
				style="background-color: #F2F5A9">목록</button>
		</div>

		:
		<div class='row'>

			<div class="col-lg-12">

				<!-- /.panel -->
				<div class="panel panel-default">

					<div class="panel-heading">
						<i class="fa fa-comments fa-fw"></i> 댓글
						<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New
							Reply</button>
					</div>


					<!-- /.panel-heading -->
					<div class="panel-body">

						<ul class="chat list-group">
							<li class="left clearfix" data-rno="12">
								<div>
									<div class="header">
										<strong class="primary-font">user1</strong> <small
											class="pull-right text-muted">2019-05-12</small>
									</div>
									<p>Good job!</p>

								</div>
							</li>
						</ul>
						<!-- ./ end ul -->
					</div>
					<!-- /.panel .chat-panel -->

					<div class="panel-footer"></div>

				</div>
			</div>
			<!-- ./ end row -->
		</div>

	</div>

	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>내용</label>
						<textarea cols="10" rows="3" class="form-control" name='content'>New Reply!!!!</textarea>
					</div>
					<div class="form-group">
						<label>아이디</label> <input class="form-control" name='id'
							value='${sessionScope.id}'>
					</div>
					<div class="form-group">
						<label>등록날짜</label> <input class="form-control" name='regdate'
							value='2018-01-01 13:13'>
					</div>

				</div>
				<div class="modal-footer">
					<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
					<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
					<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
					<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

	<script type="text/javascript" src="${root}/js/breply.js"></script>
	<script type="text/javascript">$(document).ready(function () {
	  
	  var bbsno = '<c:out value="${bbsno}"/>';
	  var sno = '<c:out value="${sno}"/>';
	  var eno = '<c:out value="${eno}"/>';
	  var replyUL = $(".chat");
	  
	  showList();
	  
	  function showList(){
		    replyService.getList({bbsno:bbsno,sno:sno,eno:eno}, function(list) {           
		     var str="";
		     
		     if(list == null || list.length == 0){
		       return;
		     }
		     
		     for (var i = 0, len = list.length || 0; i < len; i++) {
		       str +="<li class='list-group-item' data-rnum='"+list[i].rnum+"'>";
		       str +="<div><div class='header'><strong class='primary-font'>"+list[i].id+"</strong>"; 
		       str +="<small class='pull-right text-muted'>"+list[i].regdate+"</small></div>";
		       str +=replaceAll(list[i].content,'\n','<br>')+"</div></li>";
		     }
		     replyUL.html(str);
		     showReplyPage();
		  });//end function
		 }//end showList
		 
		 function replaceAll(str, searchStr, replaceStr) {
		 	return str.split(searchStr).join(replaceStr);
		 }
		 
		 var nPage = '<c:out value="${nPage}"/>';
		 var nowPage = '<c:out value="${nowPage}"/>';
		 var colx = '<c:out value="${col}"/>';
		 var wordx = '<c:out value="${word}"/>';
		 var replyPageFooter = $(".panel-footer");
		 var param = "nPage="+nPage;
		 param += "&nowPage="+nowPage;
		 param += "&bbsno="+bbsno;
		 param += "&col="+colx;
		 param += "&word="+wordx;
		  
		 function showReplyPage(){		  
			 replyService.getPage(param, function(paging) {
			     console.log(paging);
			     var str ="<div><small class='text-muted'>"+paging+"</small></div>";
			     replyPageFooter.html(str);
			 });
		 }//end showReplyPage
		 
		var modal = $(".modal");
		var modalInputContent = modal.find("textarea[name='content']");
		var modalInputId = modal.find("input[name='id']");
		var modalInputRegDate = modal.find("input[name='regdate']");
		 
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");

		$("#modalCloseBtn").on("click", function(e){
			modal.modal('hide');
		});
	     
	     //댓글 조회 클릭 이벤트 처리 
	     $(".chat").on("click", "li", function(e){
	       
	       var rnum = $(this).data("rnum");
	       
	       //alert(rnum)
	       replyService.get(rnum, function(reply){
	       
	         modalInputContent.val(reply.content);
	         modalInputId.closest("div").hide();
	         modalInputRegDate.closest("div").hide();
	         modal.data("rnum", reply.rnum);
	         
	         modal.find("button[id !='modalCloseBtn']").hide();
	         
	         if('${sessionScope.id}'==reply.id){
	             modalModBtn.show();
	           modalRemoveBtn.show();
	         }
	         $(".modal").modal("show");
	             
	       });
	     });
	     modalModBtn.on("click", function(e){
	    	  
	    	    var reply = {rnum:modal.data("rnum"), content: modalInputContent.val()};
	    	    //alert(reply.rnum);
	    	    replyService.update(reply, function(result){
	    	          
	    	      alert(result);
	    	      modal.modal("hide");
	    	      showList(); //갱신된 댓글 목록 가져오기
	    	      
	    	    });
	    	    
	    	  });//modify 
	    	 
	    	 
	    	  modalRemoveBtn.on("click", function (e){
	    	    
	    	    var rnum = modal.data("rnum");
	    	    
	    	    replyService.remove(rnum, function(result){
	    	          
	    	        alert(result);
	    	        modal.modal("hide");
	    	        showList(); //갱신된 댓글 목록 가져오기
	    	        
	    	    });
	    	    
	    	  });//remove
	    	  
	    	  $("#addReplyBtn").on("click", function(e){
	    		  
	    		  if('${sessionScope.id}'==''){
	    		   if(confirm("로그인을 해야 댓글을 쓸수 있습니다.")) {
	    		        var url = "../member/login";
	    		        url += "?col=${col}";
	    		        url += "&word=${word}";
	    		        url += "&nowPage=${nowPage}";
	    		        url += "&nPage=${nPage}";
	    		        url += "&bbsno=${bbsno}";
	    		        url += "&rurl=../bbs/read";
	    		   location.href = url;
	    		   
	    		   }
	    		  }else{
	    		 
	    		  modalInputContent.val("");
	    		  modalInputId.closest("div").hide();
	    		  modalInputRegDate.closest("div").hide();
	    		  modal.find("button[id !='modalCloseBtn']").hide();
	    		  
	    		  modalRegisterBtn.show();
	    		  
	    		  $(".modal").modal("show");
	    		  
	    		  
	    		  }
	    		});
	    		 
	    		 
	    		modalRegisterBtn.on("click",function(e){
	    		  
	    		  if(modalInputContent.val()==''){
	    		  alert("댓글을 입력하세요")
	    		  return ;
	    		  }
	    		 
	    		  var reply = {
	    		        content: modalInputContent.val(),
	    		        id:'<c:out value="${sessionScope.id}"/>',
	    		        bbsno:'<c:out value="${bbsno}"/>'
	    		      };
	    		  //alert(reply.content);
	    		  replyService.add(reply, function(result){
	    		    
	    		    alert(result);
	    		    
	    		    modal.find("input").val("");
	    		    modal.modal("hide");
	    		    
	    		    //showList(1);
	    		    showList();
	    		    
	    		  }); //end add
	    		  
	    		}); //end modalRegisterBtn.on	    	 
	    	 
	    	}); //end $(document).ready
	
	</script>
</body>
</html>
