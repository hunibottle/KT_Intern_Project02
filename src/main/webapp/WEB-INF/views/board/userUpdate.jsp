<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script>
	$(function(){
		if(${msg ne null}){
			alert('${msg}');
		};
		
		if($("#pwForm").submit(function(){
			if($("#pw").val() !== $("#pw2").val()){
				alert("비밀번호가 다릅니다.");
				$("#pw").val("").focus();
				$("#pw2").val("");
				return false;
			}else if ($("#pw").val().length < 8) {
				alert("비밀번호는 8자 이상으로 설정해야 합니다.");
				$("#pw").val("").focus();
				return false;
			}else if($.trim($("#pw").val()) !== $("#pw").val()){
				alert("공백은 입력이 불가능합니다.");
				return false;
			}
		}));
	})
</script>
<title>마이페이지</title>
</head>
<body>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>직원 정보 수정</h3>
			</div>
			<div>
				<form id="updateForm" action="${contextPath}/board/upDate" method="post">
					<p>
						<label>Name</label> 
						<input class="w3-input" type="text" id="user_nm" name="user_nm" value="${list[0].USER_NM}" required> 
					</p>
					<p>
						<label>ID</label> 
						<input class="w3-input" type="text" id="user_id" name="user_id" readonly value="${list[0].USER_ID}"> 
					</p>
					<p>
						<label>Email</label> 
						<input class="w3-input" type="text" id="user_email" name="user_email" value="${list[0].USER_EMAIL}" required> 
					</p>
					<p>
						<label>Office</label> 
						<input class="w3-input" type="text" id="user_office" name="user_office" value="${list[0].USER_OFFICE}" required> 
					</p>
					<p>
						<label>Mobile</label> 
						<input class="w3-input" type="text" id="user_mobile" name="user_mobile" value="${list[0].USER_MOBILE}" required> 
					</p>
					<p class="w3-center">
						<button type="submit" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">직원정보 변경</button>
					</p>
				</form>
				<br />
				<form id="updateGroup" action="${contextPath}/board/updateGroup" method="post">	
					<input type="hidden" id="user_id" name="user_id" value="${list[0].USER_ID}">
					<input type="hidden" id="user_nm" name="user_nm" value="${list[0].USER_NM}">
					<input type="hidden" id="group_code" name="group_code" value="${list[0].GROUP_CODE}">
					<p>
						<label>현재 부서</label>
						<input class="w3-input" id="grade_nm" name="grade_nm" type="text" value="${list[0].GROUP_NM}" required>
					</p>
					<p>
						<label>이동 부서</label> 
						<input class="w3-input" id="new_group" name="new_group" type="search" required>
					</p>
					<p class="w3-center">
						<button type="submit" id="updateGroup" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">부서 이동</button>
					</p>
				</form>
				
					<p class="w3-center">
						<button type="submit" id="deleteUser" class="w3-button w3-red w3-red w3-ripple w3-margin-top w3-round" onClick="deleteUser()">직원 삭제</button>
					</p>
			</div>
		</div>
	</div>
</body>
<!-- 회원 CRUD관련 스크립트 -->
<script>
$('#new_group').autocomplete({
	source:function(request, response){
		var value = document.getElementById('new_group').value;
		console.log(value);
		$.ajax({
			type:"post",
			url:"${contextPath}/board/autoComplete",
			data:{"value":value},
			dataType:"json",
			success: function(data){
				console.log("성공");
				response(
						$.map(data.resultList, function(item){
							return{
								label:item.GROUP_NM,
								value:item.GROUP_NM
							};
						})
				);
			}, error: function(e){
				console.log(e);
			}
		})
	}
})

function deleteUser(){
	var user_id = document.getElementById('user_id').value;
	console.log(user_id+"삭제")
	$.ajax({
			type:"post",
			url:"${contextPath}/board/userDelete",
			data:{"user_id":user_id},
			dataType:"json",
			success: function(result){
				if(result == '1'){
					alert("삭제 성공");
					window.location.href="/CRUDproject/board/tree";
				}else{
					alert("삭제 실패");
				}
			}
	})
}
</script>
</html>