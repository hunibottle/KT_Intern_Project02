<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery treeview</title>
    <style>
    @import url(//fonts.googleapis.com/earlyaccess/jejumyeongjo.css);
    @import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Jua&family=Noto+Sans+KR:wght@100&family=Noto+Serif+KR:wght@200;300;900&display=swap');
    .jm-font{
    	font-family: 'Do Hyeon', sans-serif;
    }
    .table{
    	font-family: 'Do Hyeon' sans-serif;
    }
    
    .hoverClass:hover{
    	background-color:#787878;
    }
    </style>

	<link href="/CRUDproject/resources/css/treeview.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="../../red-treeview.css" />
	

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
	
	<script src="../../../jquery.treeview.js" type="text/javascript"></script>

	<script>
	
	function showList(code){
		console.log(code);
		$("#browser li ul").empty();
		$.ajax({
			type:"post",
			url:"${contextPath}/board/secondLevel",
			data:{"gCode":code},
			dataType:"json",
			success: function(result){
				$("#browser > li:last > ul:last").remove();
				for(let pp of result){
					console.log(pp);
					var Group_name = pp.GROUP_NM;
					var Group_code = pp.GROUP_CODE;
					var inner ="";
					inner += '<ul id="folder_1">';
					inner += '<li><span id="'+Group_code+'" class="folder" onClick="showList_detail('+Group_code+')">'+Group_name+'</span>';
					inner += '</li>';
					inner += '</ul>';
					$('#browser > li:last').append(inner);
				}
			}
		});
	}
	
	function showList_detail(thirdCode){
		event.stopPropagation();
		/* $('#'+thirdCode+'').empty(); */
		console.log(thirdCode);
		$.ajax({
			type:"post",
			url:"${contextPath}/board/thirdLevel",
			data:{"pCode":thirdCode},
			dataType:"json",
			success: function(result){
				$('#'+thirdCode+' > li').remove();
				for(let pp of result){
					console.log(pp);
					var Group_name = pp.GROUP_NM;
					var Group_pcode = pp.GROUP_PCODE;
					var Group_code = pp.GROUP_CODE;
					var inner = "";
					inner += '<li><span id="'+Group_code+'" class="folder" onClick="showList_Last('+Group_code+')">'+Group_name+'</span>';
					inner += '<ul id="fold_Last_1">';
					inner += '</ul>';
					inner += '</li>';
					$('#'+thirdCode+'').append(inner);
				}
			}
		});
	}
	
	function showList_Last(lastLevel){
		event.stopPropagation();
		console.log(lastLevel);
		$.ajax({
			type:"post",
			url:"${contextPath}/board/lastLevel",
			data:{"lastLevel":lastLevel},
			dataType:"json",
			success: function(result){
				if(result == ""){
					console.log("null??? -> ?????? ???????????? ??????.");
					showMember(lastLevel);
				}else{
					showMember(lastLevel);
					$('#'+lastLevel+' > li').remove();
					for(let pp of result){
						console.log(pp);
						var Group_name = pp.GROUP_NM;
						var Group_pcode = pp.GROUP_PCODE;
						var Group_code = pp.GROUP_CODE;
						var inner = "";
						inner += '<li><span class="folder" onClick="showMember('+Group_code+')">'+Group_name+'</span>';
						inner += '</li>';
						$('#'+lastLevel+'').append(inner);
					}
				}
			}
		})
	}
	
	function showMember(memberCode){
		event.stopPropagation();
		console.log(memberCode+"?????? ??????");
		$.ajax({
			type:"post",
			url:"${contextPath}/board/showMember",
			data:{"memberCode":memberCode},
			dataType:"json",
			success: function(result){
				$('#userList tbody tr').empty();
            	$('#userList > tbody:last > tr:last').remove();
            	for(let pp of result){
					console.log(pp);
					var user_nm = pp.USER_NM;
					var user_num = pp.USER_NUM;
					var title_nm = pp.TITLE_NM;
					var grade_nm = pp.GRADE_NM;
					var group_nm = pp.GROUP_NM;
					var user_email = pp.USER_EMAIL;
					var user_office = pp.USER_OFFICE;
					var user_mobile = pp.USER_MOBILE;
					var inner ="";
					inner += '<tr onclick="detail(\''+user_nm+'\')">'
					inner += '<td style="text-align:center"><a href="${contextPath}/board/userUpdate/'+user_nm+'">??????</a></td>'
					inner += '<td style="text-align:center">'+user_nm+'</td>';
					inner += '<td style="text-align:center">'+user_num+'</td>';
					inner += '<td style="text-align:center">'+grade_nm+'</td>';
					inner += '<td style="text-align:center">'+group_nm+'</td>';
					inner += '<td style="text-align:center">'+user_email+'</td>';
					inner += '<td style="text-align:center">'+user_office+'</td>';
					inner += '<td style="text-align:center">'+user_mobile+'</td>';
					inner += '</tr>'
					$('#userList > tbody:last').append(inner);
				}
			},error: function(e){
				console.log(e);
			}
		})
	}
	
	function detail(user_nm){
		console.log(user_nm);
		$.ajax({
			type:"post",
			url:"${contextPath}/board/userUpdate",
			data:{"user_nm":user_nm},
			dataType:"json"
		})
	}
	</script>
</head>
<body>
<!--?????????????????????????????navbar??????????????,?????????????????????-->
<!--???????????????????????????????????????????fixed-top?????????????????????-->
<div id="main" style="width:100%">
	<div style="width:20%; float:left;">
	<c:forEach items="${list}" var="group">
		<ul id="browser" class="filetree treeview-famfamfam">
			<li><span class="folder" onClick='showList(<c:out value="${group.group_code}"/>)'><c:out value="${group.group_nm}"/></span>
			</li>
		</ul>
	</c:forEach>
	</div>
	
	
	<div style="margin-left:10%">
		<div class="panel-body">
                            <div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                            <form name="search_form" method="post" onsubmit="return false">
	                            <div class="row">
			                            <!-- <div class="dataTables_length" id="dataTables-example_length"> -->
			                            <!-- <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
			                            	<ul class="pagination" style="width:1000px;">
			                            		<li value="?????????????????????" class="paginate_button active" aria-controls="dataTables-example" tabindex="0" id="a1" onclick="sort('a1')"><a href="#">?????????????????????</a></li>
			                            		<li class="paginate_button" aria-controls="dataTables-example" tabindex="0" id="a2" onclick="sort('a2')"><a href="#">?????????????????????</a></li>
			                            		<li class="paginate_button" aria-controls="dataTables-example" tabindex="0" id="a3" onclick="sort('a3')"><a href="#">?????????????????????</a></li>
			                            		<li class="paginate_button" aria-controls="dataTables-example" tabindex="0" id="a4" onclick="sort('a4')"><a href="#">????????? ??????</a></li>
			                            		<li class="paginate_button" aria-controls="dataTables-example" tabindex="0" id="a5" onclick="sort('a5')"><a href="#">????????????</a></li>
			                            	</ul>
			                            </div> -->
			                            <script>
			                            	var gValue = '';
			                            	window.onload=function(){
			                            		gValue='?????????????????????';
			                            	}
			                            	function sort(st){
			                            		if(st === 'a1'){
			                            			$(".pagination li").removeClass("active");
				                            		document.getElementById('a1').classList.add("active");
				                            		var sortValue = "?????????????????????";
				                            		gValue = sortValue;
			                            		}
			                            		if(st === 'a2'){
			                            			$(".pagination li").removeClass("active");
				                            		document.getElementById('a2').classList.add("active");
				                            		var sortValue = "?????????????????????";
				                            		gValue = sortValue;
			                            		}
			                            		if(st === 'a3'){
			                            			$(".pagination li").removeClass("active");
				                            		document.getElementById('a3').classList.add("active");
				                            		var sortValue = "?????????????????????";
				                            		gValue = sortValue;
			                            		}
			                            		if(st === 'a4'){
			                            			$(".pagination li").removeClass("active");
				                            		document.getElementById('a4').classList.add("active");
				                            		var sortValue = "?????????/??????";
				                            		gValue = sortValue;
			                            		}
			                            		if(st === 'a5'){
			                            			$(".pagination li").removeClass("active");
				                            		document.getElementById('a5').classList.add("active");
				                            		var sortValue = "????????????";
				                            		gValue = sortValue;
			                            		}
			                            		
			                            		/* console.log(sortValue); */
			                            		 $.ajax({
			                            			type:"post",
			                            			url:"/memberProject/user/suser",
			                            			data:{"sortValue":sortValue},
			                            			dataType:"json",
			                                        success: function(result){
			                                        	$('#userList tbody tr').empty();
			                                        	$('#userList > tbody:last > tr:last').remove();
			                            				for(let pp of result){
			                            					console.log(pp);
			                            					var num = pp.USER_SEQ;
			                            					var ud = pp.USER_DEPARTMENT;
			                            					var uc = pp.USER_CATEGORY;
			                            					var uw = pp.USER_WORK;
			                            					var un = pp.USER_NAME;
			                            					var up = pp.USER_PHONE;
			                            					var position = pp.USER_POSITION;
			                            					var inner ="";
			                            					inner += '<tr onclick="detail('+num+')">'
			                            					inner += '<td style="text-align:center">'+ud+'</td>';
			                            					inner += '<td style="text-align:center">'+uc+'</td>';
			                            					inner += '<td style="text-align:center">'+uw+'</td>';
			                            					inner += '<td style="text-align:center">'+un+'</td>';
			                            					inner += '<td style="text-align:center">'+position+'</td>';
			                            					inner += '<td style="text-align:center">'+up+'</td>';
			                            					inner += '</tr>'
			                            					$('#userList > tbody:last').append(inner);
			                            				}
			                                        	console.log(result);
			                                        },error: function (e){
			                                            console.log('error', e);
			                                            console.log("?????????");
			                                        } 
			                            		}) 
			                            	}
			                            	var sortNum = 1;
			                            	var a = gValue;
			                            	function nameSort(){
			                            		console.log(a);
			                            		var keyword = $('.active').val();
			                            		sortNum = sortNum+1;
			                            		if(sortNum % 2 == 0){
			                            			var orderOption = "??????";
			                            			console.log("??????");
			                            		}else{
			                            			console.log("??????");
			                            			var orderOption = "??????";
			                            		}
			                            		console.log(gValue);
			                            		$.ajax({
			                            			type:"post",
			                            			url:"/memberProject/user/sortName",
			                            			data:{"orderOption":orderOption, "gValue":gValue},
			                            			dataType:"json",
			                                        success: function(result){
			                                        	$('#userList tbody tr').empty();
			                                        	$('#userList > tbody:last > tr:last').remove();
			                            				for(let pp of result){
			                            					console.log(pp);
			                            					var num = pp.USER_SEQ;
			                            					var ud = pp.USER_DEPARTMENT;
			                            					var uc = pp.USER_CATEGORY;
			                            					var uw = pp.USER_WORK;
			                            					var un = pp.USER_NAME;
			                            					var up = pp.USER_PHONE;
			                            					var position = pp.USER_POSITION;
			                            					var inner ="";
			                            					inner += '<tr onclick="detail('+num+')">'
			                            					inner += '<td style="text-align:center">'+ud+'</td>';
			                            					inner += '<td style="text-align:center">'+uc+'</td>';
			                            					inner += '<td style="text-align:center">'+uw+'</td>';
			                            					inner += '<td style="text-align:center">'+un+'</td>';
			                            					inner += '<td style="text-align:center">'+position+'</td>';
			                            					inner += '<td style="text-align:center">'+up+'</td>';
			                            					inner += '</tr>'
			                            					$('#userList > tbody:last').append(inner);
			                            				}
			                                        	console.log(result);
			                                        },error: function (e){
			                                            console.log('error', e);
			                                            console.log("?????????");
			                                        } 
			                            		}) 
			                            	}
			                            </script>
		                            <div class="col-sm-6">
		                            	<label style="float: left;">?????? ?????? 
				                          <select id="select_value" name="dataTables-example_length" aria-controls="dataTables-example" class="form-control input-sm" style="margin-left: 20px">
				                          		<option value="1">??????</option>
				                            	<option value="10">??????</option>
				                           	 	<option value="25">??????</option>
				                          </select>
				                    	</label>
		                            	<div id="dataTables-example_filter" class="dataTables_filter" style="margin-left:200px;">
		                           		<label>Search:
			                            	<input type="search" id="keyword" class="form-control input-sm ui-autocomplete-input" placeholder="?????????" aria-controls="dataTables-example" style="width:500px" onkeypress="if(window.event.keyCode==13){getSearchList()}" autocomplete="off">
			                            	<input type="button" class="paginate_button" value="??????" onclick="getSearchList()">
				                            <script>
				                            	function getSearchList(){
				                            		console.log("?????? ?????? ??????");
				                            		var keyword = document.getElementById('keyword').value;
				                            		var option = document.getElementById('select_value').value;
				                            		console.log(keyword);
				                            		console.log(option);
				                            		$.ajax({
				                            			type:"post",
				                            			url:"${contextPath}/board/getSearchList",
				                            			data:{"keyword":keyword, "option":option},
				                            			dataType:"json",
				                            			success: function(result){
				                            				$('#userList tbody tr').empty();
				                            				console.log("?????? ?????? ??????");
				                            				console.log(result);
				                            				$('#userList > tbody:last > tr:last').remove();
				                            				for(let pp of result){
				                            					console.log(pp);
				                            					var num = pp.USER_SEQ;
				                            					var userName = pp.USER_NM;
				                            					var userNum = pp.USER_NUM;
				                            					var userGrade = pp.GRADE_NM;
				                            					var userGroup = pp.GROUP_NM;
				                            					var userEmail = pp.USER_EMAIL;
				                            					var userOffice = pp.USER_OFFICE;
				                            					var userMobile =pp.USER_MOBILE;
				                            					//var position = pp.USER_POSITION;
				                            					var inner ="";
				                            					inner += '<tr onclick="detail('+num+')">'
				                            					inner += '<td style="text-align:center"><a href="${contextPath}/board/userUpdate/'+userName+'">??????</a></td>'
				                            					inner += '<td style="text-align:center">'+userName+'</td>';
				                            					inner += '<td style="text-align:center">'+userNum+'</td>';
				                            					inner += '<td style="text-align:center">'+userGrade+'</td>';
				                            					inner += '<td style="text-align:center">'+userGroup+'</td>';
				                            					inner += '<td style="text-align:center">'+userEmail+'</td>';
				                            					inner += '<td style="text-align:center">'+userOffice+'</td>';
				                            					inner += '<td style="text-align:center">'+userMobile+'</td>';
				                            					inner += '</tr>'
				                            					$('#userList > tbody:last').append(inner);
				                            				}
				                            			},error: function (e){
				                                            console.log('error', e);
				                                            console.log("?????????");
				                                        }
				                            		})
				                            	}
				                            	
				                            		$('#keyword').autocomplete({
					                            		source:function(request, response){
					                            			var value = document.getElementById('keyword').value;
					                            			var option = document.getElementById('select_value').value;
					                            			console.log(value);
					                            			$.ajax({
					                            				type:"post",
					                            				url:"${contextPath}/board/nameAutoComplete",
						                            			data:{"value":value, "option":option},
						                            			dataType:"json",
						                            			success:function(data){
						                            				if(option == 1){
							                            				response(
							                            						$.map(data.resultList, function(item){
							                            							return{
							                            									label:item.USER_NM,
								                            								value:item.USER_NM
							                            							};
							                            						})
							                            					);
							                            				}else if(option == 10){
								                            				response(
								                            						$.map(data.resultList, function(item){
								                            							return{
								                            									label:item.USER_NM,
									                            								value:item.USER_NM
								                            							};
								                            						})
								                            					);
						                            				}else if(option == 25){
						                            					response(
							                            						$.map(data.resultList, function(item){
							                            							return{
							                            									label:item.USER_NM,
								                            								value:item.USER_NM
							                            							};
							                            						})
							                            					);
						                            				}else if(option == 50){
						                            					response(
							                            						$.map(data.resultList, function(item){
							                            							return{
							                            									label:item.USER_NM,
								                            								value:item.USER_NM
							                            							};
							                            						})
							                            					);
						                            				}else if(option == 100){
						                            					response(
							                            						$.map(data.resultList, function(item){
							                            							return{
							                            									label:item.USER_NM,
								                            								value:item.USER_NM
							                            							};
							                            						})
							                            					);
						                            				}
						                            			},error: function(e){
						                            				console.log(e);
						                            			}
					                            			})
					                            		}
				                            		,focus : function(event, ui){
				                            			return false;
				                            		},
				                            		minLengh:1,
				                            		autoFocus:true,
				                            		delay:100,
				                            		autoFill: true,
				                            		select:function(evt, ui){
				                            			console.log(ui.item);
				                            			
				                            		}
					                            });
				                            </script>	
		                            	</label>
		                            	</div>
		                            </div>
	                            </div>
	                            </form>
	                            <div class="row">
	                            <div class="col-sm-12">
	                            <table id="userList" class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline" role="grid" aria-describedby="dataTables-example_info" style="width: 100%;">
                                <thead>
                                <tr role="row">
                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Rendering engine: activate to sort column descending" style="width: 10px; text-align:center"></th>
                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Rendering engine: activate to sort column descending" style="width: 40px; text-align:center">??????</th>
                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Rendering engine: activate to sort column descending" style="width: 40px; text-align:center">??????</th>
                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending" style="width: 30px; text-align:center">??????</th>
                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending" style="width: 60px; text-align:center">??????</th>
                                    <th class="list_class" onclick="nameSort()" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending" style="width: 80px; text-align:center">?????????</th>
                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending" style="width: 80px; text-align:center">????????????</th>
                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending" style="width: 80px; text-align:center">????????? ??????</th>
                                </tr>
                                </thead>
                                
	                            <tbody>
	                            	<c:forEach items="${list3}" var="user">
		                                <tr>
		                                	<td style="text-align:center"><a href="${contextPath}/board/userUpdate/${user.user_nm}">??????</a></td>
		                                	<td style="text-align:center">${user.user_nm}</td>
		                                	<td style="text-align:center">${user.user_num}</td>
		                                	<td style="text-align:center">${user.grade_nm}</td>
		                                	<td style="text-align:center">${user.group_nm}</td>
		                                	<td style="text-align:center">${user.user_email}</td>
		                                	<td style="text-align:center">${user.user_office}</td>
		                                	<td style="text-align:center">${user.user_mobile}</td>
		                                </tr>
	                                </c:forEach>
                            		</tbody>
                            	</table>
                            </div>
                         </div>
                        <div class="row">

                        <!-- Content Column -->
                        <div class="col-lg-6 mb-4">

                            <!-- Project Card Example -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">?????? ????????? 249 (???)</h6>
                                </div>
                                <div class="card-body">
                                    <h4 class="small font-weight-bold">???????????????????????????<span class="float-right">3???</span></h4>
                                    <div class="progress mb-4">
                                        <div class="progress-bar bg-danger" role="progressbar" style="width: 3%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <h4 class="small font-weight-bold">???????????????TF<span class="float-right">4???</span></h4>
                                    <div class="progress mb-4">
                                        <div class="progress-bar bg-warning" role="progressbar" style="width: 4%" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <h4 class="small font-weight-bold">??????????????????<span class="float-right">46???</span></h4>
                                    <div class="progress mb-4">
                                        <div class="progress-bar" role="progressbar" style="width: 46%" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <h4 class="small font-weight-bold">????????????<span class="float-right">100???</span></h4>
                                    <div class="progress mb-4">
                                        <div class="progress-bar bg-info" role="progressbar" style="width: 100%" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <h4 class="small font-weight-bold">??????IT?????????<span class="float-right">68???</span></h4>
                                    <div class="progress">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 68%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <h4 class="small font-weight-bold">?????????????????????(??????)<span class="float-right">28???</span></h4>
                                    <div class="progress">
                                        <div class="progress-bar bg-warning" role="progressbar" style="width: 28%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="col-lg-6 mb-4">

                            <!-- Illustrations -->
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">?????? ???????????? ??????</h6>
                                </div>
                                <div class="card-body" style="height: 394px">
                                    <table id="updateList" class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline" role="grid" aria-describedby="dataTables-example_info" style="width: 100%;">
	                                <thead>
	                                <tr role="row">
	                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Rendering engine: activate to sort column descending" style="width: 5px; text-align:center">??????</th>
	                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending" style="width: 20px; text-align:center">??????</th>
	                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending" style="width: 20px; text-align:center">??????</th>
	                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending" style="width: 150px; text-align:center">??????</th>
	                                </tr>
	                                </thead>
	                                <tbody>
	                                <c:forEach items="${list2}" var="update">
	                                <tr>
	                                	<td style="text-align:center">${update.update_seq}</td>
	                                	<td style="text-align:center">${update.update_name}</td>
	                                	<td style="text-align:center"><fmt:formatDate value="${update.update_time}" pattern="yyyy-MM-dd"/></td>
	                                	<td>${update.update_content}</td>
	                                </tr>
	                                </c:forEach>
	                                </tbody>
	                                </table>
                                </div>
                            </div>

                        </div>
                    </div>
                            <div class="row">
                          </div>
                        </div>
                        </div>
	</div>
</div>
</body>
</html>