﻿<%@page import="com.exe.dto.GymDTO"%>
<%@page import="com.exe.dto.CustomInfo"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();

GymDTO dto = (GymDTO)request.getAttribute("dto");






%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Favicon -->
<link rel="icon" href="/gyp/resources/img/core-img/favicon.ico">
<!-- Core Stylesheet -->
<link rel="stylesheet" href="/gyp/resources/css/createCustomer.css">
<link rel="stylesheet" href="/gyp/resources/css/member.css">
<!-- 플로팅 -->
<link rel="stylesheet" href="/gyp/resources/css/floating.css">
<!-- font -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap"
	rel="stylesheet">






<title>GYP</title>

<!--  버전 문제 때문에 제이쿼리 이버전으로 사용  -->

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<!-- 다음 카카오 주소API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>



<script type="text/javascript">
	
$(function() {
    //아이디 중복체크
    $('#checkbutton2').click(function() {
       $.ajax({
          type : "POST",
          url : "gymIdck",
          data : {
             "gymId" : $('#gymId').val()
          },
          success : function(data) { //data : checkSignup에서 넘겨준 결과값
             if ($.trim(data) == "YES") {
                if ($('#gymId').val() != '') {
                   alert("사용가능한 아이디입니다.");
                   var ff = $('#gymId').val();
                   $('#checkgymId').val(ff);

                }
             } else {
                if ($('#gymId').val() != '') {
                   alert("중복된 아이디입니다.");
                   $('#gymId').val('');
                   $('#gymId').focus();
                }
             }
          }
       })
    })

 });


	$(function() {
		//전화번호 중복체크
		$('#telckbutton').click(function() {
			
			f = document.myForm;
			
			$.ajax({
				type : "POST",
				url : "gymTelck",
				data : {
					"gymTel" : $('#gymTel').val()
				},

				success : function(data) { //data : cusidck에서 넘겨준 결과값
					if ($.trim(data) == "YES") {
						if ($('#gymTel').val() != '') {
							alert("사용가능한 전화번호입니다.");
							var ff = $('#gymTel').val();
							$('#checkgymTel').val(ff);
						}

					} else {			
					  if (f.mode.value != 'updated') {	
						if ($('#gymTel').val() != '') {
							
								alert("중복된 전화번호입니다.");
								$('#gymTel').val('');
								$('#gymTel').focus();	
							}
					  }
						 if (f.mode.value == 'updated') {	
								if ($('#gymTel').val() != '') {
									
									alert("중복된 전화번호입니다.");
										
							}
						}
					}
				}
			})
		})

	});

	//주소 찾기 버튼(Daum카카오 주소API 기반)
	function sample6_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.roadAddress;
					addr = data.jibunAddress;
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById("sample6_address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				//  document.getElementById("sample6_detailAddress").focus();
			}
		}).open();
	}

	//실행 함수 
	function sendIt() {

		f = document.myForm;

		//아이디 제약조건
		var cc1 = /^[a-z0-9]{4,16}$/;

		//패스워드 제약조건
		var cc2 = /^[A-Za-z0-9]{4,16}$/;

		//전화번호 제약조건
		var cc3 = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-[0-9]{3,4}-[0-9]{4}$/;

		//이메일 제약조건
		var cc4 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

		//4개의 인풋 트레이너사진을 한곳에 담기 , uploads[0]이런식으로 배열에 조건걸기 위해서..
		var uploads = f.upload;

		//4개의 인풋 체육관 시설등록을 한곳에 담기 , 
		var uploads2 = f.upload2;

		//약관 동의 제약조건
		if (f.mode.value != 'updated')
			var chk = f.check.checked;

		/*
		for(var i=0;i<uploads.length;i++){
		   if(uploads[i].value!=""&&gymTrainer[i].value==""){
		      alert((i+1)+"번째 트레이너 정보가 부족합니다");
		      gymTrainer[i].focus();
		      return;
		   }else if(uploads[i].value==""&&gymTrainer[i].value!=""){
		      alert((i+1)+"번째 트레이너 정보가 부족합니다");
		      uploads[i].focus();
		      return;
		   }else if(uploads[i].value!=""&&gymTrainer[i].value!=""){
		      f.tot.value=+1;
		      return;
		   }
		}
		
		
		if(f.tot.value<1){
		   alert("한명 이상의 트레이너 정보를 넣어야 합니다.");
		   return;
		}
		
		
		
		 */

		if (!cc1.test(f.gymId.value)) {

			alert('아이디 영문소문자/숫자 4~16자 이내로 입력하세요.');

			f.gymId.focus();

			return false;
		}

		if (f.mode.value != 'updated') {
			if ($('#gymId').val() != $('#checkgymId').val()) {

				alert('아이디 중복체크 버튼을 눌러주세요');

				f.checkbutton2.focus();

				return false;

			}

		}

		if (!f.gymName.value) {
			alert("체육관 이름을 입력하세요.");
			f.gymName.focus();
			return;
		}

		if (!cc2.test(f.gymPwd.value)) {

			alert('패스워드 영문 대소문자/숫자 4~16자 이내로 입력하세요.');

			f.gymPwd.focus();

			return false;
		}

		if (!f.gymPwd2.value) {
			alert("비밀번호를 한번 더 입력하세요.");
			f.gymPwd2.value.focus();
		}

		if (f.gymPwd.value != f.gymPwd2.value) {
			alert('비밀번호가 일치하지 않습니다.');

			f.gymPwd.value = "";
			f.gymPwd2.value = "";
			f.gymPwd.focus();
		}

		if (!cc4.test(f.gymEmail.value)) {

			alert('이메일을 바르게 입력하세요');

			f.gymEmail.focus();

			return false;
		}
		if (f.mode.value != "updated") {
		if ($('#gymTel').val() != $('#checkgymTel').val()) {
			alert('전화번호 중복체크 버튼을 눌러주세요');
			f.telckbutton.focus();
			return false;
		 }
		}
		if (!cc3.test(f.gymTel.value)) {

			alert('전화번호를 바르게 입력하세요');

			f.gymTel.focus();

			return false;
		}

		if (!f.gymAddr.value) {
			alert("주소를 입력하세요.");
			f.gymAddr.focus();
			return;
		}

		if (!f.gymType.value) {
			alert("체육관 유형을 선택해주세요.");
			f.gymType.focus();
			return;
		}

		//트레이너명,트레이너사진 업로드 유효성 검사! , 최소 1명이상 등록하라고 alert띄움
		if (f.gymTrainer1.value != "" && uploads[0].value == "") {
			alert("1번째 트레이너 사진을 입력해주세요!");
			f.gymTrainer1.focus();
			return;
		}
		if (f.gymTrainer1.value == "" && uploads[0].value != "") {
			alert("1번째 트레이너명을 입력하세요 (최소1명 이상).");
			f.gymTrainer1.focus();
			return;
		}
		if (f.gymTrainer2.value != "" && uploads[1].value == "") {
			alert("2번째 트레이너 사진을 입력해주세요!");
			f.gymTrainer2.focus();
			return;
		}
		if (f.gymTrainer2.value == "" && uploads[1].value != "") {
			alert("2번째 트레이너명을 입력하세요 (최소1명 이상).");
			f.gymTrainer2.focus();
			return;
		}
		if (f.gymTrainer3.value != "" && uploads[2].value == "") {
			alert("3번째 트레이너 사진을 입력해주세요!");
			f.gymTrainer3.focus();
			return;
		}
		if (f.gymTrainer3.value == "" && uploads[2].value != "") {
			alert("3번째트레이너명을 입력하세요 (최소1명 이상).");
			f.gymTrainer3.focus();
			return;
		}
		if (f.gymTrainer4.value != "" && uploads[3].value == "") {
			alert("4번째 트레이너 사진을 입력해주세요!");
			f.gymTrainer4.focus();
			return;
		}
		if (f.gymTrainer4.value == "" && uploads[3].value != "") {
			alert("4번째 트레이너명을 입력하세요 (최소1명 이상).");
			f.gymTrainer4.focus();
			return;
		}

		if (!f.gymTrainer1.value) {
			alert("1번째 트레이너명을 입력하세요 (최소1명 이상).");
			f.gymTrainer1.focus();
			return;
		}

		//체육관 사진등록 제약조건 (최소1장이상)
		if (uploads2[0].value == "") {
			alert("첫번째 체육관 사진등록을 해주세요 (최소 1장이상)");
			f.uploads2[0].focus();
			return;
		}

		if (!f.gymProgram.value) {
			alert("프로그램 내용을 입력하세요 .");
			f.gymProgram.focus();
			return;
		}

		if (f.gymFacility[0].checked == false
				&& f.gymFacility[1].checked == false
				&& f.gymFacility[2].checked == false) {
			alert("이용가능시설을 체크해주세요");
			return false;

		}
		if (f.mode.value != 'updated') {
			if (!f.check.checked) {
				alert('약관에 동의해주세요');
				return false;
			}
		}

		if (f.mode.value == "updated") {
			alert("체육관 회원수정이 성공적으로 완료되었습니다.");
			f.action = "/gyp/gymUpdate_ok.action";

		} else {
			alert("체육관 회원가입이 성공적으로 완료되었습니다.");
			f.action = "/gyp/createGym_ok.action";

		}

		f.submit();

	}
</script>

</head>

<body style="font-family: 'Noto Sans KR', sans-serif;" >

	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />
	
	<c:if test="${mode!='updated' }">
		<div class="section-heading">
		<h6>Fitness Gym</h6>
		<h4>체육관 회원가입창★</h4>
		</div>
	</c:if>

	<c:if test="${mode=='updated' }">
		<div class="section-heading">
		<h6>Fitness Gym</h6>
		<h4>체육관 정보 수정창★</h4>
		</div>
	</c:if>
	
		<form action="" name="myForm" method="post" enctype="multipart/form-data">
			
			<div class="form-group">	
					<dl>
						<dt class= "">체육관 아이디</dt>
							
							<c:if test="${mode=='updated' }">	
								<input type="text"  size="74" maxlength="100" class="boxTF"  value="${sessionScope.customInfo.sessionId }"
								 disabled/>
								<input type="hidden"  name="gymId" id="gymId" value="${sessionScope.customInfo.sessionId }"/>
							</c:if>
						
							<c:if test="${mode!='updated' }">
								<input type="text" name="gymId" id="gymId" size="10" maxlength="30" 
								class="form-control" value="${sessionScope.customInfo.sessionId }"/> 
								<input type="button" id="checkbutton2" 
								value="체크" />
								<input type="hidden" id="checkgymId" name="checkgymId" 
								value="" />
							</c:if>
					</dl>
				</div>

				<div class="bbsCreated_bottomLine">
					<dl>
						<dt>체육관 이름</dt>
						<dd>
							<input type="text" name="gymName" size="35" maxlength="20"
								class="boxTF" value = "${dto.gymName }"/>
						</dd>
					</dl>
				</div>

				<div class="bbsCreated_bottomLine">
					<dl>
						<dt>비밀번호</dt>
						<dd>
							<input type="password" name="gymPwd" size="35" maxlength="20"
								class="boxTF" value = "${dto.gymPwd }" />
						</dd>
					</dl>
				</div>

				<div class="bbsCreated_bottomLine">
					<dl>
						<dt>비밀번호 확인</dt>
						<dd>
							<input type="password" name="gymPwd2" size="35" maxlength="20"
								class="boxTF" value="${dto.gymPwd }" />
						</dd>
					</dl>
				</div>


				<div class="bbsCreated_bottomLine">
					<dl>
						<dt>e-mail</dt>
						<dd>
							<input type="text" name="gymEmail" size="35" maxlength="50"
								class="boxTF" value="${dto.gymEmail }" />
						</dd>
					</dl>
				</div>


				<div class="bbsCreated_bottomLine">
					<dl>
						<dt>전화번호</dt>
						<dd>
							<input type="text" name="gymTel" id="gymTel" size="35" maxlength="50"
								class="boxTF" value="${dto.gymTel }"/>
							<input type="button" id = "telckbutton" name = "telckbutton" value ="중복체크"/>
							<input type="hidden" id = "checkgymTel" name = "checkgymTel" value =""/>	
						</dd>
					</dl>
				</div>

				<div class="bbsCreated_bottomLine">
					<dl>
						<dt>주소</dt>
						<dd>
							<input type="text" name="gymAddr" size="35" maxlength="50"
								class="boxTF" value="${dto.gymAddr }" id="sample6_address" placeholder="주소" />
							<input type="button" size="35" maxlength="50"
								class="boxTF" onclick = "sample6_execDaumPostcode();" value="주소 찾기"/>
						</dd>
					</dl>
					 <dl>
						<dd class="bokyung_td_left"></td>
							<input type="text" name="gymAddrDetail" value="${dto.gymAddrDetail }" 
							style="width : 540px; maxlength="50" 
							class="bokyung_member_text"  placeholder="상세주소를 입력해주세요" />
						</dd>
					</dl>
		 
				</div>
				
				<c:if test="${mode=='updated' }">	
				<div class="bbsCreated_bottomLine">
					<dl>
						<dt>체육관 유형</dt>
						<dd>
							 <c:if test="${dto.gymType =='헬스' }">
							 <input type="radio" value="헬스"  name="gymType" checked="checked">헬스</input>
							 </c:if>
							 
							  <c:if test="${dto.gymType !='헬스' }">
							 <input type="radio" value="헬스"  name="gymType" >헬스</input>
							 </c:if>
							 
							  <c:if test="${dto.gymType =='요가' }">
							 <input type="radio" value="요가"  name="gymType" checked="checked">요가</input>
							 </c:if>
							 
							  <c:if test="${dto.gymType !='요가' }">
							 <input type="radio" value="요가"  name="gymType">요가</input>
							 </c:if>
							
							 <c:if test="${dto.gymType =='필라테스' }">
							 <input type="radio" value="필라테스"  name="gymType" checked="checked">필라테스</input>
							 </c:if>
							 
							  <c:if test="${dto.gymType !='필라테스' }">
							 <input type="radio" value="필라테스"  name="gymType" >필라테스</input>
							 </c:if>
							 
							 <%-- <% if(dto.gymType.equals("필라테스")){%>checked<%}%>>필라테스</input> --%>
						 	 
							<%-- <input type="radio" value="필라테스" name="gymType"  <c:if test="${'dto.gymType ' eq '필라테스'}">checked</c:if>>
							필라테스</input> --%>
						</dd>
					</dl>
				</div>
				</c:if>
				
				
				<c:if test="${mode!='updated' }">	
				<div class="bbsCreated_bottomLine">
					<dl>
						<dt>체육관 유형</dt>
						<dd>
							<input type="radio" value="헬스" name="gymType" />헬스
							<input type="radio" value="요가" name="gymType" />요가 
							<input type="radio" value="필라테스" name="gymType" />필라테스
						</dd>
					</dl>
				</div>
				</c:if>
				<div class="bbsCreated_bottomLine">
					<dl>
						<dt>
							<c:if test="${mode!='updated' }">
								트레이너 등록&nbsp;<font size='1'>(최소1명 이상)</font>
							</c:if>	
							
							<c:if test="${mode=='updated' }">
								트레이너 수정&nbsp;<font size='1'>(최소1명 이상)</font>	
							</c:if>
						</dt>
						
						<!-- 회원가입일때 -->
						<c:if test="${mode!='updated' }">
						<dd>
							*트레이너 이름 : <input type="text" name="gymTrainer1" class="boxTF" size="10"> &nbsp;&nbsp;&nbsp;
							*트레이너 사진 : <input type="file" name="upload"/>
						</dd>
						<dd>
							*트레이너 이름 : <input type="text" name="gymTrainer2" class="boxTF" size="10"> &nbsp;&nbsp;&nbsp;
							*트레이너 사진 : <input type="file" name="upload"/>
						</dd>
						<dd>
							*트레이너 이름 : <input type="text" name="gymTrainer3" class="boxTF" size="10"> &nbsp;&nbsp;&nbsp;
							*트레이너 사진 : <input type="file" name="upload"/>
						</dd>
						<dd>
							*트레이너 이름 : <input type="text" name="gymTrainer4" class="boxTF" size="10"> &nbsp;&nbsp;&nbsp;
							*트레이너 사진 : <input type="file" name="upload"/>
						</dd>
						</c:if>
							
						<!-- 수정일때, 기존 이미지들의 이름 출력 -->
						
						<c:if test="${mode=='updated' }">
							<c:forEach var="trainerName" items="${gymTrainerLists }" varStatus="status" >
								<dd>
									*트레이너 이름 수정 : <input type="text" name="trainerName${status.count }" value="${trainerName }"size="25" maxlength="7" />
								</dd>
							</c:forEach>
							<c:forEach var="i" begin="${startNumberForTrainer }" end="4" step="1" varStatus="status" >
								<dd>
									*추가할 트레이너 이름(${i }) : <input type="text" name="trainerName${i }" class="boxTF" />
								</dd>
							</c:forEach>
							<dd style="height: 10px;"></dd>
							<c:forEach var="oldTrainerImage" items="${gymTrainerPicLists }" varStatus="status" >
								<dd>
									*기존 트레이너 사진 : <input type="text" name="oldTrainerImage${status.count }" value="${oldTrainerImage }"
											size="25" maxlength="7"/>
									<input type="button" value=" 삭제 " 
									onclick="javascript:location.href='/gyp/gymImageDelete.action?whatToDelete=oldTrainerImage${status.count }'">
									<br>수정할 사진 : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="file" name="newTrainerImage${status.count }" class="boxTF" /><br><br>
								</dd>
							</c:forEach>
							<!-- 4개보다 적으면 -->
							<c:forEach var="i" begin="${startNumberForTrainer }" end="4" step="1" varStatus="status" >
								<dd>
									*추가할 사진(${i }) :  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="file" name="newTrainerImage${i }" class="boxTF" />
								</dd>
							</c:forEach>
						</c:if>
					</dl>
				</div>

				<div class="bbsCreated_bottomLine">
					
					<!-- 회원가입일때 -->
					<div style="height: 10px;"></div>
					<c:if test="${mode!='updated' }">
						<dl>
							<dt>체육관 사진 등록&nbsp;<font size='1'>(최소1장 이상)</font></dt>
							<dd>
								<input type="file" name="upload2" class="boxTF" />
							</dd>
							<dd>
								<input type="file" name="upload2" class="boxTF" />
							</dd>
							<dd>
								<input type="file" name="upload2" class="boxTF" />
							</dd>
							<dd>
								<input type="file" name="upload2" class="boxTF" />
							</dd>
						</dl>
					</c:if>
					
					<!-- 수정일때 -->
					<div style="height: 10px;"></div>
					<c:if test="${mode=='updated' }">
						<dt>체육관 사진 등록&nbsp;<font size='1'>(최소1장 이상)</font></dt>
						<c:forEach var="oldGymImage" items="${gymPicLists }" varStatus="status" >
								<dd>
								기존 체육관 사진 : <input type="text" name="oldGymImage${status.count }" value="${oldGymImage}" size="25" maxlength="20" 
									class="boxTF"/>
								<input type="button" name="deleteTrainer" value=" 삭제 " 
								onclick="javascript:location.href='/gyp/gymImageDelete.action?whatToDelete=oldGymImage${status.count }'">
								<br>수정할 사진 : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="file" name="newGymImage${status.count }" class="boxTF" /><br><br>
							</dd>
						</c:forEach>
						<!-- 4개보다 적으면 -->
						<c:forEach var="i" begin="${startNumberForGymPic }" end="4" step="1" varStatus="status" >
							<dd>
								*추가할 사진(${i }) :  &nbsp;
								<input type="file" name="newGymImage${i }" class="boxTF" />
							</dd>
						</c:forEach>
					</c:if>
					
					
					
				</div>
				<div style="height: 15px;"></div>
				<div class="bbsCreated_bottomLine">
					<dl>
						<dt>프로그램 설명</dt>
						<dd>
							<textarea name="gymProgram" rows="10" cols="30" class="boxTF" >${dto.gymProgram }</textarea>
						</dd>
					</dl>
				</div>
				
				<c:if test="${mode=='updated' }">	
				<div class="bbsCreated_bottomLine">
					<dl>
					

						<dt>이용가능 시설</dt>
						<dd>
						<c:if test="${fn:contains(dto.gymFacility,'주차')}">
							<input type="checkbox" name="gymFacility" value="주차" checked="checked">주차
						</c:if>	
						
						<c:if test="${!fn:contains(dto.gymFacility,'주차')}">
							<input type="checkbox" name="gymFacility" value="주차" >주차
						</c:if>	
						
						<c:if test="${fn:contains(dto.gymFacility,'샤워실')}">
							<input type="checkbox" name="gymFacility" value="샤워실" checked="checked">샤워실
						</c:if>	
						
						<c:if test="${!fn:contains(dto.gymFacility,'샤워실')}">
							<input type="checkbox" name="gymFacility" value="샤워실">샤워실
						</c:if>	
						
						<c:if test="${fn:contains(dto.gymFacility, '타올')}">
							<input type="checkbox" name="gymFacility" value="타올" checked="checked">타올
						</c:if>
						
						<c:if test="${!fn:contains(dto.gymFacility, '타올')}">
							<input type="checkbox" name="gymFacility" value="타올">타올
						</c:if>
						
						<!-- 이 코드 이해되면 좀 알려주.. -->
						<c:if test="${fn:contains(dto.gymFacility, '운동복') != '운동복' }">
							<input type="checkbox" name="gymFacility" value="운동복" checked="checked">운동복
						</c:if>
						
						<c:if test="${fn:contains(dto.gymFacility, '운동복') == '운동복' }">
							<input type="checkbox" name="gymFacility" value="운동복">운동복
						</c:if>
						
						
					
						<%-- 
						<c:if test="${fn:split(dto.gymFacility,',') != '주차' }">
							<input type="checkbox" name="gymFacility" value="주차" >주차
						</c:if>	
						 --%>
						<%-- 
						<c:if test="${dto.gymFacility == '샤워실' }">
							<input type="checkbox" name="gymFacility" value="샤워실" checked="checked">샤워실
						</c:if>	
						
						<c:if test="${dto.gymFacility != '샤워실' }">
							<input type="checkbox" name="gymFacility" value="샤워실">샤워실
						</c:if>	
					
							 --%>
						
						</dd>
					</dl>
				</div>
				
				
				</c:if>
				
				<c:if test="${mode!='updated' }">	
				<div class="bbsCreated_bottomLine">
					<dl>
						<dt>이용가능 시설</dt>
						<dd>
							<input type="checkbox" name="gymFacility" value="주차" >주차
							<input type="checkbox" name="gymFacility" value="샤워실">샤워실
							<input type="checkbox" name="gymFacility" value="타올">타올
							<input type="checkbox" name="gymFacility" value="운동복">운동복
						</dd>
					</dl>
				</div>
				</c:if>
				
				<c:if test="${mode=='updated' }">
				<div>
					<dl>
						<dt>이용가능 시간</dt>
						<dd>평일
							<select name="gymHour1_1">
							<!-- 선택이전 시간 -->
							<c:if test="${beforeAfter[0]!=0 }">
								<c:forEach var="a" begin="1" end="${beforeAfter[0] }" step="1">
									<c:if test="${a<10 }">
									<option value="0${a }:00">0${a }:00</option></c:if>
									<c:if test="${a>=10 }">
									<option value="${a }:00">${a }:00</option></c:if>
								</c:forEach>
							</c:if>
							<!-- 선택 시간 -->
								<c:if test="${gymHourListsInt[0]<10 }">
								<option value="0${gymHourListsInt[0] }:00" selected="selected">0${gymHourListsInt[0] }:00</option></c:if>
								<c:if test="${gymHourListsInt[0]>=10 }">
								<option value="${gymHourListsInt[0] }:00" selected="selected">${gymHourListsInt[0] }:00</option></c:if>
							<!-- 선택 이후 시간 -->
							<c:forEach var="b" begin="${beforeAfter[1] }" end="24" step="1">
								<c:if test="${b<10 }">
								<option value="0${b }:00">0${b }:00</option></c:if>
								<c:if test="${b>=10 }">
								<option value="${b }:00">${b }:00</option></c:if>
							</c:forEach>
							</select>
							
							
							<select name="gymHour1_2">
							<!-- 선택이전 시간 -->
							<c:if test="${beforeAfter[2]!=0 }">
								<c:forEach var="c" begin="1" end="${beforeAfter[2] }" step="1">
									<c:if test="${c<10 }">
									<option value="0${c }:00">0${c }:00</option></c:if>
									<c:if test="${c>=10 }">
									<option value="0${c }:00">${c }:00</option></c:if>
								</c:forEach>
							</c:if>
							<!-- 선택 시간 -->
								<c:if test="${gymHourListsInt[1]<10 }">
								<option value="0${gymHourListsInt[1] }:00" selected="selected">0${gymHourListsInt[1] }:00</option></c:if>
								<c:if test="${gymHourListsInt[1]>=10 }">
								<option value="${gymHourListsInt[1] }:00" selected="selected">${gymHourListsInt[1] }:00</option></c:if>
							<!-- 선택 이후 시간 -->
							<c:forEach var="d" begin="${beforeAfter[3] }" end="24" step="1">
								<c:if test="${d<10 }">
								<option value="0${d }:00">0${d }:00</option></c:if>
								<c:if test="${d>=10 }">
								<option value="${d }:00">${d }:00</option></c:if>
							</c:forEach>
							</select>
							
							
						</dd>
						<dd>토요일
							<select name="gymHour2_1">
							<!-- 선택이전 시간 -->
							<c:if test="${beforeAfter[4]!=0 }">
								<c:forEach var="e" begin="1" end="${beforeAfter[4] }">
									<c:if test="${e<10 }">
									<option value="0${e }:00">0${e }:00</option></c:if>
									<c:if test="${e>=10 }">
									<option value="${e }:00">${e }:00</option></c:if>
								</c:forEach>
							</c:if>
							<!-- 선택 시간 -->
								<c:if test="${gymHourListsInt[2]<10 }">
								<option value="0${gymHourListsInt[2] }:00" selected="selected">0${gymHourListsInt[2] }:00</option></c:if>
								<c:if test="${gymHourListsInt[2]>=10 }">
								<option value="${gymHourListsInt[2] }:00" selected="selected">${gymHourListsInt[2] }:00</option></c:if>
							<!-- 선택 이후 시간 -->
							<c:forEach var="f" begin="${beforeAfter[5] }" end="24">
								<c:if test="${f<10 }">
								<option value="0${f }:00">0${f }:00</option></c:if>
								<c:if test="${f>=10 }">
								<option value="${f }:00">${f }:00</option></c:if>
							</c:forEach>
							</select>
							
							
							<select name="gymHour2_2">
							<!-- 선택이전 시간 -->
							<c:if test="${beforeAfter[6]!=0 }">
								<c:forEach var="g" begin="1" end="${beforeAfter[6] }">
									<c:if test="${g<10 }">
									<option value="0${g }:00">0${g }:00</option></c:if>
									<c:if test="${g>=10 }">
									<option value="${g }:00">${g }:00</option></c:if>
								</c:forEach>
							</c:if>
							<!-- 선택 시간 -->
								<c:if test="${gymHourListsInt[3]<10 }">
								<option value="0${gymHourListsInt[3] }:00" selected="selected">0${gymHourListsInt[3] }:00</option></c:if>
								<c:if test="${gymHourListsInt[3]>=10 }">
								<option value="${gymHourListsInt[3] }:00" selected="selected">${gymHourListsInt[3] }:00</option></c:if>
							<!-- 선택 이후 시간 -->
							<c:forEach var="h" begin="${beforeAfter[7] }" end="24">
								<c:if test="${h<10 }">
								<option value="0${h }:00">0${h }:00</option></c:if>
								<c:if test="${h>=10 }">
								<option value="${h }:00">${h }:00</option></c:if>
							</c:forEach>
							</select>
							
						</dd>
						<dd>일요일
							<select name="gymHour3_1">
							<!-- 선택이전 시간 -->
							<c:if test="${beforeAfter[8]!=0 }">
								<c:forEach var="i" begin="1" end="${beforeAfter[8] }">
									<c:if test="${i<10 }">
									<option value="0${i }:00">0${i }:00</option></c:if>
									<c:if test="${i>=10 }">
									<option value="${i }:00">${i }:00</option></c:if>
								</c:forEach>
							</c:if>
							<!-- 선택 시간 -->
								<c:if test="${gymHourListsInt[4]<10 }">
								<option value="0${gymHourListsInt[4] }:00" selected="selected">0${gymHourListsInt[4] }:00</option></c:if>
								<c:if test="${gymHourListsInt[4]>=10 }">
								<option value="${gymHourListsInt[4] }:00" selected="selected">${gymHourListsInt[4] }:00</option></c:if>
							<!-- 선택 이후 시간 -->
							<c:forEach var="j" begin="${beforeAfter[9] }" end="24">
								<c:if test="${j<10 }">
								<option value="0${j }:00">0${j }:00</option></c:if>
								<c:if test="${j>=10 }">
								<option value="${j }:00">${j }:00</option></c:if>
							</c:forEach>
							</select>
							
							
							<select name="gymHour3_2">
							<!-- 선택이전 시간 -->
							<c:if test="${beforeAfter[10]!=0 }">
								<c:forEach var="k" begin="1" end="${beforeAfter[10] }">
									<c:if test="${k<10 }">
									<option value="0${k }:00">0${k }:00</option></c:if>
									<c:if test="${k>=10 }">
									<option value="${k }:00">${k }:00</option></c:if>
								</c:forEach>
							</c:if>
							<!-- 선택 시간 -->
								<c:if test="${gymHourListsInt[5]<10 }">
								<option value="0${gymHourListsInt[5] }:00" selected="selected">0${gymHourListsInt[5] }:00</option></c:if>
								<c:if test="${gymHourListsInt[5]>=10 }">
								<option value="${gymHourListsInt[5] }:00" selected="selected">${gymHourListsInt[5] }:00</option></c:if>
							<!-- 선택 이후 시간 -->
							<c:forEach var="l" begin="${beforeAfter[11] }" end="24">
								<c:if test="${l<10 }">
								<option value="0${l }:00">0${l }:00</option></c:if>
								<c:if test="${l>=10 }">
								<option value="${l }:00">${l }:00</option></c:if>
							</c:forEach>
							</select>
						</dd>
					</dl>
				</div>
				</c:if>	
				
				<!--<c:if test="${mode!='updated' }">-->	
				<div class="bbsCreated_bottomLine">
					<dl>
						<dt>이용가능 시간</dt>
						<dd>
							평일<select name="gymHour1_1">
								<option value="01:00 ">01:00</option>
								<option value="02:00 ">02:00</option>
								<option value="03:00 ">03:00</option>
								<option value="04:00 ">04:00</option>
								<option value="05:00 ">05:00</option>
								<option value="06:00 ">06:00</option>
								<option value="07:00 ">07:00</option>
								<option value="08:00 ">08:00</option>
								<option value="09:00 ">09:00</option>
								<option value="10:00 ">10:00</option>
								<option value="11:00 ">11:00</option>
								<option value="12:00 ">12:00</option>
								<option value="13:00 ">13:00</option>
								<option value="14:00 ">14:00</option>
								<option value="15:00 ">15:00</option>
								<option value="16:00 ">16:00</option>
								<option value="17:00 ">17:00</option>
								<option value="18:00 ">18:00</option>
								<option value="19:00 ">19:00</option>
								<option value="20:00 ">20:00</option>
								<option value="21:00 ">21:00</option>
								<option value="22:00 ">22:00</option>
								<option value="23:00 ">23:00</option>
								<option value="24:00 ">24:00</option>
							</select> ~ <select name="gymHour1_2">

								<option value="~ 01:00">01:00</option>
								<option value="~ 02:00">02:00</option>
								<option value="~ 03:00">03:00</option>
								<option value="~ 04:00">04:00</option>
								<option value="~ 05:00">05:00</option>
								<option value="~ 06:00">06:00</option>
								<option value="~ 07:00">07:00</option>
								<option value="~ 08:00">08:00</option>
								<option value="~ 09:00">09:00</option>
								<option value="~ 10:00">10:00</option>
								<option value="~ 11:00">11:00</option>
								<option value="~ 12:00">12:00</option>
								<option value="~ 13:00">13:00</option>
								<option value="~ 14:00">14:00</option>
								<option value="~ 16:00">16:00</option>
								<option value="~ 17:00">17:00</option>
								<option value="~ 18:00">18:00</option>
								<option value="~ 19:00">19:00</option>
								<option value="~ 20:00">20:00</option>
								<option value="~ 21:00">21:00</option>
								<option value="~ 22:00">22:00</option>
								<option value="~ 23:00">23:00</option>
								<option value="~ 24:00">24:00</option>
							</select>
						</dd>
						<dd>
							토요일<select name="gymHour2_1">

								<option value="01:00 ">01:00</option>
								<option value="02:00 ">02:00</option>
								<option value="03:00 ">03:00</option>
								<option value="04:00 ">04:00</option>
								<option value="05:00 ">05:00</option>
								<option value="06:00 ">06:00</option>
								<option value="07:00 ">07:00</option>
								<option value="08:00 ">08:00</option>
								<option value="09:00 ">09:00</option>
								<option value="10:00 ">10:00</option>
								<option value="11:00 ">11:00</option>
								<option value="12:00 ">12:00</option>
								<option value="13:00 ">13:00</option>
								<option value="14:00 ">14:00</option>
								<option value="15:00 ">15:00</option>
								<option value="16:00 ">16:00</option>
								<option value="17:00 ">17:00</option>
								<option value="18:00 ">18:00</option>
								<option value="19:00 ">19:00</option>
								<option value="20:00 ">20:00</option>
								<option value="21:00 ">21:00</option>
								<option value="22:00 ">22:00</option>
								<option value="23:00 ">23:00</option>
								<option value="24:00 ">24:00</option>
							</select> ~ <select name="gymHour2_2">

								<option value="~ 01:00">01:00</option>
								<option value="~ 02:00">02:00</option>
								<option value="~ 03:00">03:00</option>
								<option value="~ 04:00">04:00</option>
								<option value="~ 05:00">05:00</option>
								<option value="~ 06:00">06:00</option>
								<option value="~ 07:00">07:00</option>
								<option value="~ 08:00">08:00</option>
								<option value="~ 09:00">09:00</option>
								<option value="~ 10:00">10:00</option>
								<option value="~ 11:00">11:00</option>
								<option value="~ 12:00">12:00</option>
								<option value="~ 13:00">13:00</option>
								<option value="~ 14:00">14:00</option>
								<option value="~ 16:00">16:00</option>
								<option value="~ 17:00">17:00</option>
								<option value="~ 18:00">18:00</option>
								<option value="~ 19:00">19:00</option>
								<option value="~ 20:00">20:00</option>
								<option value="~ 21:00">21:00</option>
								<option value="~ 22:00">22:00</option>
								<option value="~ 23:00">23:00</option>
								<option value="~ 24:00">24:00</option>
							</select>

						</dd>
						<dd>
							일요일<select name="gymHour3_1">

								<option value="01:00 ">01:00</option>
								<option value="02:00 ">02:00</option>
								<option value="03:00 ">03:00</option>
								<option value="04:00 ">04:00</option>
								<option value="05:00 ">05:00</option>
								<option value="06:00 ">06:00</option>
								<option value="07:00 ">07:00</option>
								<option value="08:00 ">08:00</option>
								<option value="09:00 ">09:00</option>
								<option value="10:00 ">10:00</option>
								<option value="11:00 ">11:00</option>
								<option value="12:00 ">12:00</option>
								<option value="13:00 ">13:00</option>
								<option value="14:00 ">14:00</option>
								<option value="15:00 ">15:00</option>
								<option value="16:00 ">16:00</option>
								<option value="17:00 ">17:00</option>
								<option value="18:00 ">18:00</option>
								<option value="19:00 ">19:00</option>
								<option value="20:00 ">20:00</option>
								<option value="21:00 ">21:00</option>
								<option value="22:00 ">22:00</option>
								<option value="23:00 ">23:00</option>
								<option value="24:00 ">24:00</option>
							</select> ~ <select name="gymHour3_2">

								<option value="~ 01:00">01:00</option>
								<option value="~ 02:00">02:00</option>
								<option value="~ 03:00">03:00</option>
								<option value="~ 04:00">04:00</option>
								<option value="~ 05:00">05:00</option>
								<option value="~ 06:00">06:00</option>
								<option value="~ 07:00">07:00</option>
								<option value="~ 08:00">08:00</option>
								<option value="~ 09:00">09:00</option>
								<option value="~ 10:00">10:00</option>
								<option value="~ 11:00">11:00</option>
								<option value="~ 12:00">12:00</option>
								<option value="~ 13:00">13:00</option>
								<option value="~ 14:00">14:00</option>
								<option value="~ 16:00">16:00</option>
								<option value="~ 17:00">17:00</option>
								<option value="~ 18:00">18:00</option>
								<option value="~ 19:00">19:00</option>
								<option value="~ 20:00">20:00</option>
								<option value="~ 21:00">21:00</option>
								<option value="~ 22:00">22:00</option>
								<option value="~ 23:00">23:00</option>
								<option value="~ 24:00">24:00</option>
							</select>

						</dd>
					</dl>
				</div>
			<!--</c:if>-->
			
			<c:if test="${mode!='updated' }">
				<tr>
					<td width="100%" height="50%" align="center" />
					<p align="left">
						<span style="padding-left: 160px"> 약관동의</span>
					</p>
					<br>
					<textarea rows="20" cols="150" readonly="readonly">1장 총칙
제1조 (목적)
본 약관은 (주)GYP(이하 “당사”라 함)가 제공하는 TLX PASS 서비스 이용과 관련하여 당사와 회원의 제반 권리, 의무, 책임사항, 관련 절차, 기타 필요한 사항을 규정하는데 그 목적이 있습니다.

제2조 (용어)
본 약관에서 사용하는 주요 용어의 정의는 다음과 같습니다.
1.“서비스”라 함은 구현되는 단말기(PC, TV, 휴대형 단말기 등의 각종 유무선 장치를 포함)와 상관없이 당사와 제휴시설이 “회원”에게 제공하는 TLX PASS 관련 제반 서비스 모두를 의미합니다.
2."회원"이라 함은 당사의 약관 제5조에 정해진 가입 절차에 따라 가입하여 정상적으로 당사의 제휴시설과 GYP 서비스를 이용할 수 있는 권한을 부여 받은 고객을 말합니다.


제2장 회원가입과 멤버십

제3조 (회원가입과 멤버십 구매)
1.회원 가입은 서비스 홈페이지, 어플리케이션을 통해 가능합니다.
회원으로 가입하고자 하는 고객은 당사에서 정한 서비스 홈페이지의 회원 가입 신청서에 정해진 사항을 기입한 후 본 약관과 ‘개인정보처리방침(‘개인정보 수집 제공 및 활용 동의’ 등)'에 동의함으로써 회원가입을 신청합니다.
2.고객으로부터 회원가입 신청이 있는 경우 당사는 자체 기준에 따른 심사를 거친 후 고객에게 회원 자격을 부여 할 수 있으며 회원 자격이 부여된 고객은 당사로부터 가입 완료 공지를 받은 시점부터 회원으로서 지위를 취득하고, 멤버십을 구매/이용할 수 있습니다.
3.회원은 회원자격을 타인에게 양도하거나 대여 또는 담보의 목적으로 이용할 수 없습니다.

제4조 (멤버십 이용 및 관리)
1.회원이 GYP 서비스를 당사와 제휴시설에서 이용하고자 할 경우, 어플리케이션/모바일웹/RFID카드를 이용해야 하며, 당사와 제휴시설은 미성년자 여부나 본인 확인 등 합리적인 이유가 있을 때 회원에게 신분증 제시를 요청할 수 있습니다. 회원은 이러한 요청을 있을 경우 요청에 응해야 정상적이고 원활한 GYP 서비스를 제공 받을 수 있습니다.
2.회원에게 등록된 멤버십은 회원 본인만 사용 가능합니다. 회원 아이디 및 멤버십을 제3자에게 임의적으로 대여 사용하게 하거나 양도 또는 담보의 목적으로 사용 할 수 없으며, 해당 불법 행위로 인해 발생하는 모든 책임은 사용자가 부담합니다.
   </textarea>
					<br>
					<input type="checkbox" name="check"> 동의합니다.
					</td>
				</tr>
			</c:if>

			<c:if test="${mode!='updated' }">
				<div id="bbsCreated_footer">
					<input type="button" value=" 등록하기 " class="btn2" id="sendItBtn"
						onclick="sendIt();" /> <input type="reset" value=" 다시입력 "
						class="btn2" onclick="document.myForm.cusId.focus();" /> <input
						type="button" value=" 작성취소 " class="btn2"
						onclick="javascript:location.href='/gyp/create.action';" />
				</div>
			</c:if>


			<c:if test="${mode=='updated' }">
				<div id="bbsCreated_footer">
					<input type="button" value=" 수정하기 " class="btn2"
						onclick="sendIt();" /> <input type="button" value=" 작성취소 "
						class="btn2"
						onclick="javascript:location.href='/gyp/create.action';" />
				</div>
			</c:if>



			<!-- 숨겨놓은 모드 -->
			<input type="hidden" name="mode" value="${mode }" />

		</form>

	</div>




	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	<!-- ##### All Javascript Script ##### -->
	<!-- jQuery-2.2.4 js -->
	<script src="/gyp/resources/js/jquery/jquery-2.2.4.min.js"></script>
	<!-- Popper js -->
	<script src="/gyp/resources/js/bootstrap/popper.min.js"></script>
	<!-- Bootstrap js -->
	<script src="/gyp/resources/js/bootstrap/bootstrap.min.js"></script>
	<!-- All Plugins js -->
	<script src="/gyp/resources/js/plugins/plugins.js"></script>
	<!-- Active js -->
	<script src="/gyp/resources/js/active.js"></script>

</body>
</html>




































