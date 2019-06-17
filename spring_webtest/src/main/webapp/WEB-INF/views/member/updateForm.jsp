<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/ssi/ssi_member.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>회원정보 수정</title>
<meta charset="utf-8">
<style type="text/css">
#need {
	color: red
}
.need{
color:blackblue
}
</style>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                   // document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } //else {
                    //document.getElementById("sample6_extraAddress").value = '';
                //}

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<script type="text/javascript">

function emailCheck(email){
 
   var url="emailcheck";
	var param= "email="+email;
	
	$.get(
			url,
			param,
			function(data, textStatus){
				data = data.trim();
				$("#emailcheck").text(data);
			}
			);
			}
			
   </script>
<script type="text/javascript">
function incheck(f){

              if(f.tel.value==""){
              alert("전화번호를 입력하세요");
              f.tel.focus();
              return false;
              }   
            if(f.email.value==""){
              alert("이메일을 입력하세요");
              f.email.focus();
              return false;
            }
               if(f.job.selectedIndex==0){
              alert("직업을 입력하세요");
              f.job.focus();
              return false;
  }
}
</script>

</head>
<body>

	<div class="container">

		<h1 class="col-sm-offset-2 col-sm-10">회원수정</h1>
		<label class="col-sm-offset-2 col-sm-10"> (<span id="need">*</span>필수입력)
		</label>
		<form class="form-horizontal" action="update" method="post"
			name="frm" onsubmit="return incheck(this)">

			<br> <input type="hidden" name="id" value="${dto.id}" />
			<br> <input type="hidden" name="xemail" value="${dto.email}" />
			
			
			
			<div class="form-group">
				<label class="control-label col-sm-2" for="id"><span
					id="need">*</span>아이디</label>
				<div class="col-sm-3">
					${dto.id}
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="mname"><span
					id="need">*</span>이름</label>
				<div class="col-sm-3">
					${dto.mname}
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="tel"><span
					id="need">*</span>연락처</label>
				<div class="col-sm-3">
					<input type="text" class="form-control" name="tel" id="tel"
						value="${dto.tel}">
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="email"><span
					id="need">*</span>이메일</label>
				<div class="col-sm-3">
					<input type="email" name="email" id="email" class="form-control"
						required="required" value="${dto.email}"><button type="button" onclick="emailCheck(this.form.email.value)" 
						class="btn col-sm-6">Email 변경</button>
				</div><div id="emailcheck" class="need"></div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="sample6_postcode">우편번호</label>
				<div class="col-sm-2">
					<input type="text" name="zipcode" id="sample6_postcode"
						class="form-control" value="${dto.zipcode}">
				</div>
				<button class="btn col-sm-1" type="button"
					onclick="sample6_execDaumPostcode()">주소검색</button>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="sample6_address">주소</label>

				<div class="col-sm-6">
					<input type="text" name="address1" id="sample6_address"
						class="form-control" value="${dto.address1}"> <input
						type="text" name="address2" id="sample6_detailaddress"
						class="form-control" value="${dto.address2}">
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="job"><span
					id="need">*</span>직업</label>
				<div class="col-sm-2"> 
					<select name="job" class="form-control">
						<option value="0">선택하세요</option>
						<option value="A01"
						<c:if test="${dto=='A01'}" ></c:if>>회사원</option>
						<option value="A02"<c:if test="${dto=='A02'}" ></c:if>>전산관련직</option>
						<option value="A03"<c:if test="${dto=='A03'}" ></c:if>>연구전문직</option>
						<option value="A04"<c:if test="${dto=='A04'}" ></c:if>>각종학교학생</option>
						<option value="A05"<c:if test="${dto=='A05'}" ></c:if>>일반자영업</option>
						<option value="A06"<c:if test="${dto=='A06'}" ></c:if>>공무원</option>
						<option value="A07"<c:if test="${dto=='A07'}" ></c:if>>의료인</option>
						<option value="A08"<c:if test="${dto=='A08'}" ></c:if>>법조인</option>
						<option value="A09"<c:if test="${dto=='A09'}" ></c:if>>종교/언론/예술인</option>
						<option value="A10"<c:if test="${dto=='A10'}" ></c:if>>기타</option>
					</select>
				</div>
			</div>


			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-5">
					<button type="submit" class="btn btn-default">수정</button>
					<button type="reset" class="btn btn-default"
						onclick="history.back()">취소</button>

				</div>
			</div>
		</form>
	</div>
</body>
</html>