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

<title>조직관리페이지</title>
</head>
<body>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>조직 관리 메뉴</h3>
			</div>
			<div>
					<p class="w3-center">
						<button type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" onclick="location.href='${contextPath}/board/groupPlus'">부서 추가</button>
					</p>
					<br />
					<p class="w3-center">
						<button type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" onclick="location.href='${contextPath}/board/groupUpdate'">부서 정보 변경</button>
					</p>
					<br />
					<p class="w3-center">
						<button type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" onclick="location.href='${contextPath}/board/groupDelete'">부서 삭제</button>
					</p>
					<br />
					<p class="w3-center">
						<button type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" onclick="location.href='${contextPath}/board/groupSum'">부서 병합</button>
					</p>
					<br />
			</div>
		</div>
	</div>
</body>
</html>