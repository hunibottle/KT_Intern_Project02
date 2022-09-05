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
				<h3>부서 병합</h3>
			</div>
			<div>
				<h4>부서 1</h4>
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
				<hr />
				<h4>부서 2</h4>
				<p class="w3-center">
					<button type="submit" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" onClick="funcLevel2_2(10,20)">HCN</button>
				</p>
				<br />
				<div class="level2_2" id="level2_2">
				
				</div>
				<div class="level3_2" id="level3_2">
				
				</div>
				<div class="level4_2" id="level4_2">
				
				</div>
				<hr />
				<div class="check_box">
					<div class="form-check" style="float:left;">
						<input class="form-check-input" type="checkbox" name="checkGroup" id="flexCheckDefault" value="team" onclick='checkOption(this)'>
						<label class="form-check-lable" style="margin-left:20px">팀 전환</label>
					</div>
					<div class="form-check" style="margin-left:200px">
						<input class="form-check-input" type="checkbox" name="checkGroup" id="flexCheckDefault" value="part" onclick='checkOption(this)'>
						<label class="form-check-lable" style="margin-left:20px">파트 유지</label>
					</div>
				</div>
				<hr />
				<p>
					<label>부서명</label>
					<input class="w3-input" id="group_nm" name="group_nm" type="text" value="${list[0].GROUP_NM}" required>
				</p>
				<p class="w3-center">
					<button type="submit" id="updateGroup" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" onClick="groupSum()">부서 병합</button>
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
	var level_4_code1;
	var level_4_code2;
	
	var option; //팀으로 합칠 것 인지, 파트로 합칠 것 인지 판단하는 변수
	
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
		level_4_code1 = fcode;
		console.log("최종 선택"+level_2_id+" "+level_3_id+" "+level_4_id)
		//document.getElementById(level_2_id).style = "background-color:#25C5F7; width:140px";
		//document.getElementById(level_3_id).style = "background-color:#25C5F7; width:140px";
		document.getElementById(level_4_id).style = "background-color:#1B57E3; width:140px";
	}

	
	//두번째 부서 자바 스크립트
	
	function funcLevel2_2(Lv2Pcode, Gcode){
		status = 0;
		$('#level2_2').empty();
		$('#level3_2').empty();
		$('#level4_2').empty();
		console.log(status);
	if(status == 0){
		$('#level2_2').empty();
		$('#level3_2').empty();
		$('#level4_2').empty();
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
					var html_btn = '<button id="btn_level2_'+group_name+'_2" type="button" class="btn btn-success m-1" style="width:140px" onClick="funcLevel3_2('+group_code+',this.id)">'+group_name+'</button>'
					$('#level2_2').append(html_btn);
					}
				var html_btn = '<button id="btn_level2_2" type="button" class="btn btn-success m-1" style="width:125px; background-color:#949794">선택</button>'
				$('#level2_2').append(html_btn);
				}
			})	
		}
	}

	
	function funcLevel3_2(Lv3Pcode,id){
		status = 1;
		console.log(status);
		if(status == 1){
			const btn2 = document.getElementById('btn_level2_2');
			if(btn2.style.display !== 'none'){
				btn2.style.display = 'none';
			}else{
				//btn2.style.display = 'block';
			}
			
			//색상 변경
			
			level_2_id = id;
			level_2_code = Lv3Pcode;

			console.log(Lv3Pcode);
			$('#level3_2').empty();
			$('#level4_2').empty();
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
						var html_btn = '<button id="btn_level3_'+group_name+'_2" type="button" class="btn btn-success m-1 level3" style="width:140px" onClick="funcLast_2('+group_code+',this.id)">'+group_name+'</button>'
						$('#level3_2').append(html_btn);
					}
					var html_btn = '<button id="btn_level3_2" type="button" class="btn btn-success m-1" style="width:125px; background-color:#949794">선택</button>'
					$('#level3_2').append(html_btn);
				}
			})
			var i, k;
			k=document.getElementById(level_2_id).id;
			console.log(k);
			document.getElementById(level_2_id).style = "background-color:green; width:140px";
			document.getElementById(level_2_id).style = "background-color:#25C5F7; width:140px";	

		}
	}
	
	
	function funcLast_2(Lvlast, id){
		const btn3 = document.getElementById('btn_level3_2');
		if(btn3.style.display !== 'none'){
			btn3.style.display = 'none';
		}else{
			//btn3.style.display = 'block';
		}
		console.log(Lvlast);
		$('#level4_2').empty();
		
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
					var html_btn = '<button id="btn_level4_'+group_name+'_2" type="button" class="btn btn-success m-1" style="width:140px" onClick="final_2('+group_code+',this.id)">'+group_name+'</button>'
					$('#level4_2').append(html_btn);
				}
				var html_btn = '<button id="btn_level4_2" type="button" class="btn btn-success m-1" style="width:125px; background-color:#949794" onClick="plusGroup('+level_2_code+','+level_3_code+')_2">선택</button>'
				$('#level4_2').append(html_btn);
			}
		})
		document.getElementById(level_3_id).style = "background-color:#25C5F7; width:140px";
	}
	
	function final_2(fcode, id){
		level_4_id = id;
		level_4_code2 = fcode;
		console.log("최종 선택"+level_2_id+" "+level_3_id+" "+level_4_id)
		//document.getElementById(level_2_id).style = "background-color:#25C5F7; width:140px";
		//document.getElementById(level_3_id).style = "background-color:#25C5F7; width:140px";
		document.getElementById(level_4_id).style = "background-color:#1B57E3; width:140px";
	}
	
	
	//최종 부서 합치는 함수
	function groupSum(){
		var groupNewName = document.getElementById('group_nm').value;
		var groupOneCode = level_4_code1;
		var groupTwoCode = level_4_code2;
		console.log("상위p코드넘버: "+level_2_code);
		console.log("상위코드넘버: "+level_3_code);
		console.log(groupNewName+" "+groupOneCode+" "+groupTwoCode);
		console.log("옵션은 :"+option);
		
		if(option == 'team'){
			console.log("팀병합");
			$.ajax({
				type:"post",
				url:"${contextPath}/board/sumGroup",
				data:{"option": option, "groupOneCode": groupOneCode, "groupTwoCode": groupTwoCode, "groupNewName": groupNewName, "level_3_code":level_3_code, "level_2_code":level_2_code},
				dataType: "json",
				success:function(result){
					if(result=="0"){
						window.location.href="/CRUDproject/board/tree";
					}else{
						console.log("error");
					}
				}
			})
		}else{
			$.ajax({
				type:"post",
				url:"${contextPath}/board/sumGroup",
				data:{"option": option, "groupOneCode": groupOneCode, "groupTwoCode": groupTwoCode, "groupNewName": groupNewName, "level_3_code":level_3_code, "level_2_code":level_2_code},
				dataType: "json",
				success: function(result){
					if(result == "0"){
						window.location.href="/CRUDproject/board/tree";
					}else{
						console.log("error");
					}
				}
			})
		}
	}
	
	function checkOption(element){
		var optionLength = document.getElementsByName('checkGroup').length;
		console.log(optionLength);
		
		const checkboxes = document.getElementsByName('checkGroup');
		
		for(var i = 0 ; i < optionLength ; i++){
			if(document.getElementsByName('checkGroup')[i].checked==true){
				option = document.getElementsByName('checkGroup')[i].value;
			}
		}
		
		checkboxes.forEach((cb) => {
			cb.checked = false;
		})
		
		element.checked = true;
		
		console.log("옵션은 :"+option);
	}
	
</script>
</html>