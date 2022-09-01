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
<title>마이페이지</title>
</head>
<body>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>부서 추가</h3>
			</div>
			<div>
				<p class="w3-center">
					<button type="submit" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" onClick="funcLevel2(10,20)">HCN</button>
				</p>
				<br />
				<div class="level2" id="level2">
				
				</div>
				<div class="level3" id="level3">
				
				</div>
				<p>
					<label>부서명</label>
					<input class="w3-input" id="grade_nm" name="grade_nm" type="text" value="${list[0].GROUP_NM}" required>
				</p>
				<p class="w3-center">
					<button type="submit" id="updateGroup" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">부서 추가</button>
				</p>
			</div>
		</div>
	</div>
</body>
<script>
/* Level2 버튼 생성 스크립트 */
	function funcLevel2(Lv2Pcode, Gcode){
	$('#level2').empty();
	console.log(Lv2Pcode+"1번");
	console.log(Gcode+"2번");
	$.ajax({
		type:"post",
		url:"${contextPath}/board/level2Group",
		data:{"Lv2Pcode":Lv2Pcode, "Gcode":Gcode},
		dataType:"json",
		success: function(result){
			var i = result.length;
			for(let pp of result){
				var group_name = pp.GROUP_NM;
				var group_code = pp.GROUP_CODE;
				var html_btn = '<button type="button" class="btn btn-success m-1" style="width:175px" onClick="funcLevel3('+group_code+')">'+group_name+'</button>'
				$('#level2').append(html_btn);
				}
			}
		})
	}
	
	function funcLevel3(Lv3Pcode){
		console.log(Lv3Pcode);
		$('#level3').empty();
		$.ajax({
			type:"post",
			url:"${contextPath}/board/level3Group",
			data:{"Lv3Pcode":Lv3Pcode},
			dataType:"json",
			success: function(result){
				console.log(result);
				for(let pp of result){
					var group_name = pp.GROUP_NM;
					var group_code = pp.GROUP_CODE;
					var html_btn = '<button type="button" class="btn btn-success m-1" style="width:175px">'+group_name+'</button>'
					$('#level3').append(html_btn);
				}
			}
		})
	}
	
</script>
</html>