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
<style>
button.on{
	background-color:red;
}
</style>
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
				<div class="level4" id="level4">
				
				</div>
				<p>
					<label>부서명</label>
					<input class="w3-input" id="grade_nm" name="grade_nm" type="text" value="${list[0].GROUP_NM}" required>
				</p>
				<p class="w3-center">
					<button type="submit" id="updateGroup" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" onClick="groupPlus()">부서 추가</button>
				</p>
			</div>
		</div>
	</div>
</body>
<script>
/* Level2 버튼 생성 스크립트 */
	
	var status = 0;
	var level_2_id;
	var level_3_id;
	var level_4_id;
	
	var level_2_code;
	var level_3_code;
	
	function funcLevel2(Lv2Pcode, Gcode){
		status = 0;
		$('#level2').empty();
		$('#level3').empty();
		$('#level4').empty();
		console.log(status);
	if(status == 0){
		$('#level2').empty();
		$('#level3').empty();
		$('#level4').empty();
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
					var html_btn = '<button id="btn_level2_'+group_name+'" type="button" class="btn btn-success m-1" style="width:140px" onClick="funcLevel3('+group_code+',this.id)">'+group_name+'</button>'
					$('#level2').append(html_btn);
					}
				var html_btn = '<button id="btn_level2" type="button" class="btn btn-success m-1" style="width:125px; background-color:#949794">선택</button>'
				$('#level2').append(html_btn);
				}
			})	
		}
	}

	
	function funcLevel3(Lv3Pcode,id){
		status = 1;
		console.log(status);
		if(status == 1){
			const btn2 = document.getElementById('btn_level2');
			if(btn2.style.display !== 'none'){
				btn2.style.display = 'none';
			}else{
				//btn2.style.display = 'block';
			}
			
			//색상 변경
			
			level_2_id = id;
			level_2_code = Lv3Pcode;

			console.log(Lv3Pcode);
			$('#level3').empty();
			$('#level4').empty();
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
						var html_btn = '<button id="btn_level3_'+group_name+'" type="button" class="btn btn-success m-1 level3" style="width:140px" onClick="funcLast('+group_code+',this.id)">'+group_name+'</button>'
						$('#level3').append(html_btn);
					}
					var html_btn = '<button id="btn_level3" type="button" class="btn btn-success m-1" style="width:125px; background-color:#949794">선택</button>'
					$('#level3').append(html_btn);
				}
			})
			var i, k;
			k=document.getElementById(level_2_id).id;
			console.log(k);
			document.getElementById(level_2_id).style = "background-color:green; width:140px";
			document.getElementById(level_2_id).style = "background-color:#25C5F7; width:140px";	

		}
	}
	
	
	function funcLast(Lvlast, id){
		const btn3 = document.getElementById('btn_level3');
		if(btn3.style.display !== 'none'){
			btn3.style.display = 'none';
		}else{
			//btn3.style.display = 'block';
		}
		console.log(Lvlast);
		$('#level4').empty();
		
		level_3_id = id;
		level_3_code = Lvlast;
		
		$.ajax({
			type:"post",
			url:"${contextPath}/board/levelLastGroup",
			data:{"Lvlast": Lvlast},
			dataType: "json",
			success: function(result){
				console.log(result);
				for(let pp of result){
					var group_name = pp.GROUP_NM;
					var group_code = pp.GROUP_CODE;
					var html_btn = '<button id="btn_level4_'+group_name+'" type="button" class="btn btn-success m-1" style="width:140px" onClick="final('+group_code+',this.id)">'+group_name+'</button>'
					$('#level4').append(html_btn);
				}
				var html_btn = '<button id="btn_level4" type="button" class="btn btn-success m-1" style="width:125px; background-color:#949794" onClick="plusGroup('+level_2_code+','+level_3_code+')">선택</button>'
				$('#level4').append(html_btn);
			}
		})
		document.getElementById(level_3_id).style = "background-color:#25C5F7; width:140px";
	}
	
	function final(fcode, id){
		level_4_id = id;
		console.log("최종 선택"+level_2_id+" "+level_3_id+" "+level_4_id)
		//document.getElementById(level_2_id).style = "background-color:#25C5F7; width:140px";
		//document.getElementById(level_3_id).style = "background-color:#25C5F7; width:140px";
		document.getElementById(level_4_id).style = "background-color:#25C5F7; width:140px";
	}

	
	function groupPlus(){
		const groupName = document.getElementById('grade_nm').value;
		console.log(level_2_code+" "+level_3_code+" "+groupName);
		if(level_3_code !== undefined){
			$.ajax({
				type:"post",
				url:"${contextPath}/board/groupPlus",
				data:{"level_2_code": level_2_code, "level_3_code":level_3_code, "groupName":groupName},
				dataType: "text",
				success: function(result){
					console.log(result);
					if(result == "0"){
						window.location.href="/CRUDproject/board/tree";
					}else{
						console.log("error");
					}
				}
				,error: function(e){
					console.log(e);
				}
			})	
		}else{
			$.ajax({
				type:"post",
				url:"${contextPath}/board/bigGroupPlus",
				data:{"level_2_code": level_2_code, "groupName":groupName},
				dataType: "text",
				success: function(result){
					console.log(result);
					if(result == "0"){
						window.location.href="/CRUDproject/board/tree";
					}else{
						console.log("error");
					}
				}
				,error: function(e){
					console.log(e);
				}
			})
		}
	}
	
</script>
</html>