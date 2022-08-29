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

	<link rel="stylesheet" href="../treeview.css" />
    <link rel="stylesheet" href="../red-treeview.css" />
	<link rel="stylesheet" href="screen.css" />

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
	<script src="cookie.js"></script>
	<script src="../jquery.treeview.js" type="text/javascript"></script>

	<script type="text/javascript">
	$(document).ready(function(){
		$("#browser").treeview({
			toggle: function() {
				console.log("%s was toggled.", $(this).find(">span").text());
			}
		});

		$("#add").click(function() {
			var branches = $("<li><span class='folder'>New Sublist</span><ul>" +
				"<li><span class='file'>Item1</span></li>" +
				"<li><span class='file'>Item2</span></li></ul></li>").appendTo("#browser");
			$("#browser").treeview({
				add: branches
			});
		});
	});
	</script>
	<script>
	function showList(){
		console.log("클릭됨 !");
		const folder_1 = document.getElementById('folder_1');
		if(folder_1.style.display !== 'none'){
			folder_1.style.display = 'none';
		}else{
			folder_1.style.display = 'block';
		}
	}
	function showList_detail(st){
		console.log(st);
		const folder_detail = document.getElementById('folder_detail_'+st);
		if(folder_detail.style.display !== 'none'){
			folder_detail.style.display ='none'
		}else{
			folder_detail.style.display ='block';
		}
	}
	
	function showList_Last(st){
		console.log(st);
		
		const folder_Last = document.getElementById('fold_Last_'+st);
		if(folder_Last.style.display !=='none'){
			folder_Last.style.display ='none';
		}else{
			folder_Last.style.display = 'block';
		}
	}
	</script>
</head>
<body>
<!-- 화면 변경 크기와 navbar의 배경색, 글자색 변경 -->
<!-- 화면 위쪽에 고정하기 위해 fixed-top 클래스 추가 -->
<div id="main" style="width:100%">
	<div style="width:20%; float:left;">
	<ul id="browser" class="filetree treeview-famfamfam">
		<li><span class="folder" onClick='showList()'>Folder 1</span>
			<ul id="folder_1">
				<li><span class="folder" onClick='showList_detail(1)'>Item 1</span>
					<ul id="folder_detail_1">
						<li><span class="file">Item 1.1.1</span></li>
					</ul>
				</li>
				<li><span class="folder" onClick='showList_detail(2)'>기술IT지원실</span>
					<ul id="folder_detail_2">
						<li><span class="folder" onClick='showList_Last(1)'>서비스개발팀</span>
							<ul id="fold_Last_1">
								<li><span class="file">File 2.1.1</span></li>
								<li><span class="file">File 2.1.2</span></li>
							</ul>
						</li>
						<li><span class="folder" onClick='showList_Last(2)'>IT팀</span>
							<ul id="fold_Last_2">
								<li><span class="file">정보보호파트</span></li>
								
							</ul>
						</li>
						<li><span class="folder" onClick='showList_Last(3)'>네트웍관리팀</span>
							<ul id="fold_Last_3">
								<li><span class="file">File 2.3.1</span></li>
								<li><span class="file">File 2.3.2</span></li>
							</ul>
						</li>
					</ul>
				</li>
				<li class="closed"><span class="folder" onClick='showList_detail(3)'>Item 3</span>
					<ul id="folder_detail_3">
						<li><span class="file">File 3.1</span></li>
					</ul>
				</li>
				<li class="closed"><span class="folder" onClick='showList_detail(4)'>Item 4</span>
					<ul id="folder_detail_4">
						<li><span class="file">File 4.1</span></li>
					</ul>
				</li>
			</ul>
		</li>
	</ul>
	</div>
	<div style="margin-left:10%">
		<div class="panel-body">
                            <div id="dataTables-example_wrapper" class="dataTables_wrapper form-inline dt-bootstrap no-footer">
                            <form name="search_form" method="post" onsubmit="return false">
	                            <div class="row">
			                            <!-- <div class="dataTables_length" id="dataTables-example_length"> -->
			                            <!-- <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate">
			                            	<ul class="pagination" style="width:1000px;">
			                            		<li value="고객관리시스템" class="paginate_button active" aria-controls="dataTables-example" tabindex="0" id="a1" onclick="sort('a1')"><a href="#">고객관리시스템</a></li>
			                            		<li class="paginate_button" aria-controls="dataTables-example" tabindex="0" id="a2" onclick="sort('a2')"><a href="#">내부지원시스템</a></li>
			                            		<li class="paginate_button" aria-controls="dataTables-example" tabindex="0" id="a3" onclick="sort('a3')"><a href="#">대외지원시스템</a></li>
			                            		<li class="paginate_button" aria-controls="dataTables-example" tabindex="0" id="a4" onclick="sort('a4')"><a href="#">인프라 기획</a></li>
			                            		<li class="paginate_button" aria-controls="dataTables-example" tabindex="0" id="a5" onclick="sort('a5')"><a href="#">정보보호</a></li>
			                            	</ul>
			                            </div> -->
			                            <script>
			                            	var gValue = '';
			                            	window.onload=function(){
			                            		gValue='고객관리시스템';
			                            	}
			                            	function sort(st){
			                            		if(st === 'a1'){
			                            			$(".pagination li").removeClass("active");
				                            		document.getElementById('a1').classList.add("active");
				                            		var sortValue = "고객관리시스템";
				                            		gValue = sortValue;
			                            		}
			                            		if(st === 'a2'){
			                            			$(".pagination li").removeClass("active");
				                            		document.getElementById('a2').classList.add("active");
				                            		var sortValue = "내부지원시스템";
				                            		gValue = sortValue;
			                            		}
			                            		if(st === 'a3'){
			                            			$(".pagination li").removeClass("active");
				                            		document.getElementById('a3').classList.add("active");
				                            		var sortValue = "대외지원시스템";
				                            		gValue = sortValue;
			                            		}
			                            		if(st === 'a4'){
			                            			$(".pagination li").removeClass("active");
				                            		document.getElementById('a4').classList.add("active");
				                            		var sortValue = "인프라/기획";
				                            		gValue = sortValue;
			                            		}
			                            		if(st === 'a5'){
			                            			$(".pagination li").removeClass("active");
				                            		document.getElementById('a5').classList.add("active");
				                            		var sortValue = "정보보호";
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
			                                            console.log("에러다");
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
			                            			var orderOption = "올림";
			                            			console.log("올림");
			                            		}else{
			                            			console.log("내림");
			                            			var orderOption = "내림";
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
			                                            console.log("에러다");
			                                        } 
			                            		}) 
			                            	}
			                            </script>
		                            <div class="col-sm-6">
		                            	<label style="float: left;">검색 조건 
				                          <select id="select_value" name="dataTables-example_length" aria-controls="dataTables-example" class="form-control input-sm">
				                          		<option value="1">담당업무</option>
				                            	<option value="10">대분류</option>
				                           	 	<option value="25">중분류</option>
				                            	<option value="50">시스템</option>
				                            	<option value="100">담당자</option>
				                          </select>
				                    	</label>
		                            	<div id="dataTables-example_filter" class="dataTables_filter" style="margin-left:200px;">
		                           		<label>Search:
			                            	<input type="search" id="keyword" class="form-control input-sm ui-autocomplete-input" placeholder="검색어" aria-controls="dataTables-example" style="width:500px" onkeypress="if(window.event.keyCode==13){getSearchList()}" autocomplete="off">
			                            	<input type="button" class="paginate_button" value="검색" onclick="getSearchList()">
				                            <script>
				                            	function getSearchList(){
				                            		console.log("검색 버튼 클릭");
				                            		var keyword = document.getElementById('keyword').value;
				                            		var option = document.getElementById('select_value').value;
				                            		console.log(keyword);
				                            		console.log(option);
				                            		$.ajax({
				                            			type:"post",
				                            			url:"/memberProject/user/getSearchList",
				                            			data:{"keyword":keyword, "option":option},
				                            			dataType:"json",
				                            			success: function(result){
				                            				$('#userList tbody tr').empty();
				                            				console.log("검색 매핑 성공");
				                            				console.log(result);
				                            				$('#userList > tbody:last > tr:last').remove();
				                            				for(let pp of result){
				                            					console.log(pp);
				                            					var num = pp.USER_SEQ;
				                            					var ud = pp.USER_DEPARTMENT;
				                            					var uc = pp.USER_CATEGORY;
				                            					var uw = pp.USER_WORK;
				                            					var un = pp.USER_NAME;
				                            					var us = pp.USER_STATE;
				                            					var up = pp.USER_PHONE;
				                            					var content =pp.WORK_CONTENT;
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
				                            			},error: function (e){
				                                            console.log('error', e);
				                                            console.log("에러다");
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
						                            			url:"/memberProject/user/autoComplete",
						                            			data:{"value":value, "option":option},
						                            			dataType:"json",
						                            			success:function(data){
						                            				if(option == 1){
							                            				response(
							                            						$.map(data.resultList, function(item){
							                            							return{
							                            									label:item.WORK_CONTENT,
								                            								value:item.WORK_CONTENT
							                            							};
							                            						})
							                            					);
							                            				}else if(option == 10){
								                            				response(
								                            						$.map(data.resultList, function(item){
								                            							return{
								                            									label:item.USER_DEPARTMENT,
									                            								value:item.USER_DEPARTMENT
								                            							};
								                            						})
								                            					);
						                            				}else if(option == 25){
						                            					response(
							                            						$.map(data.resultList, function(item){
							                            							return{
							                            									label:item.USER_CATEGORY,
								                            								value:item.USER_CATEGORY
							                            							};
							                            						})
							                            					);
						                            				}else if(option == 50){
						                            					response(
							                            						$.map(data.resultList, function(item){
							                            							return{
							                            									label:item.USER_WORK,
								                            								value:item.USER_WORK
							                            							};
							                            						})
							                            					);
						                            				}else if(option == 100){
						                            					response(
							                            						$.map(data.resultList, function(item){
							                            							return{
							                            									label:item.USER_NAME,
								                            								value:item.USER_NAME
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
	                            <table id="userList" width="100%" class="table table-striped table-bordered table-hover dataTable no-footer dtr-inline" role="grid" aria-describedby="dataTables-example_info" style="width: 100%;">
                                <thead>
                                    <tr role="row">
                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Rendering engine: activate to sort column descending" style="width: 65px; text-align:center">대분류</th>
                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Browser: activate to sort column ascending" style="width: 55px; text-align:center">중분류</th>
                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Platform(s): activate to sort column ascending" style="width: 100px; text-align:center">시스템(업무)</th>
                                    <th class="sorting" onclick="nameSort()" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending" style="width: 40px; text-align:center">담당자</th>
                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending" style="width: 40px; text-align:center">직책</th>
                                    <th class="list_class" tabindex="0" aria-controls="dataTables-example" rowspan="1" colspan="1" aria-label="Engine version: activate to sort column ascending" style="width: 60px; text-align:center">전화번호</th>
                                </tr></thead>
                                
	                                <tbody><tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">가입자관리</td>
	                                	<td style="text-align:center">개인전화</td>
	                                	<td style="text-align:center">이주형</td>
	                                	<td style="text-align:center">주임</td>
	                                	<td style="text-align:center">070-8109-1280</td>
	                                </tr>
                                
	                                <tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">현장지원</td>
	                                	<td style="text-align:center">Hy-Any</td>
	                                	<td style="text-align:center">이주형</td>
	                                	<td style="text-align:center">주임</td>
	                                	<td style="text-align:center">070-8109-1280</td>
	                                </tr>
                                
	                                <tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">가입자관리</td>
	                                	<td style="text-align:center">청구</td>
	                                	<td style="text-align:center">김성민</td>
	                                	<td style="text-align:center">과장</td>
	                                	<td style="text-align:center">070-8109-1272</td>
	                                </tr>
                                
	                                <tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">가입자관리</td>
	                                	<td style="text-align:center">고객관리</td>
	                                	<td style="text-align:center">김성민</td>
	                                	<td style="text-align:center">과장</td>
	                                	<td style="text-align:center">070-8109-1272</td>
	                                </tr>
                                
	                                <tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">가입자관리</td>
	                                	<td style="text-align:center">재고관리</td>
	                                	<td style="text-align:center">박진석</td>
	                                	<td style="text-align:center">대리</td>
	                                	<td style="text-align:center">070-8109-1282</td>
	                                </tr>
                                
	                                <tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">가입자관리</td>
	                                	<td style="text-align:center">수수료관리</td>
	                                	<td style="text-align:center">박진석</td>
	                                	<td style="text-align:center">대리</td>
	                                	<td style="text-align:center">070-8109-1282</td>
	                                </tr>
                                
	                                <tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">가입자관리</td>
	                                	<td style="text-align:center">CLOUD UI</td>
	                                	<td style="text-align:center">박진석</td>
	                                	<td style="text-align:center">대리</td>
	                                	<td style="text-align:center">070-8109-1282</td>
	                                </tr>
                                
	                                <tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">가입자관리</td>
	                                	<td style="text-align:center">렌탈 시스템</td>
	                                	<td style="text-align:center">정세민</td>
	                                	<td style="text-align:center">대리</td>
	                                	<td style="text-align:center">070-8109-1283</td>
	                                </tr>
                                
	                                <tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">현장지원</td>
	                                	<td style="text-align:center">작업처리시스템(Hy-Work)</td>
	                                	<td style="text-align:center">정세민</td>
	                                	<td style="text-align:center">대리</td>
	                                	<td style="text-align:center">070-8109-1283</td>
	                                </tr>
                                
	                                <tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">현장지원</td>
	                                	<td style="text-align:center">사진검수 시스템(Hy-Check)</td>
	                                	<td style="text-align:center">정세민</td>
	                                	<td style="text-align:center">대리</td>
	                                	<td style="text-align:center">070-8109-1283</td>
	                                </tr>
                                
	                                <tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">현장지원</td>
	                                	<td style="text-align:center">전자계약시스템(Hy-Sign)</td>
	                                	<td style="text-align:center">이종기</td>
	                                	<td style="text-align:center">과장</td>
	                                	<td style="text-align:center">070-8109-1290</td>
	                                </tr>
                                
	                                <tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">현장지원</td>
	                                	<td style="text-align:center">Hy-Helper</td>
	                                	<td style="text-align:center">정세민</td>
	                                	<td style="text-align:center">대리</td>
	                                	<td style="text-align:center">070-8109-1283</td>
	                                </tr>
                                
	                                <tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">가입자관리</td>
	                                	<td style="text-align:center">KAIT 연동</td>
	                                	<td style="text-align:center">김성민</td>
	                                	<td style="text-align:center">과장</td>
	                                	<td style="text-align:center">070-8109-1272</td>
	                                </tr>
                                
	                                <tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">가입자관리</td>
	                                	<td style="text-align:center">통신사 동등결합</td>
	                                	<td style="text-align:center">이주형</td>
	                                	<td style="text-align:center">주임</td>
	                                	<td style="text-align:center">070-8109-1280</td>
	                                </tr>
                                
	                                <tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">가입자관리</td>
	                                	<td style="text-align:center">기업전화</td>
	                                	<td style="text-align:center">이주형</td>
	                                	<td style="text-align:center">주임</td>
	                                	<td style="text-align:center">070-8109-1280</td>
	                                </tr>
                                
	                                <tr>
	                                	<td style="text-align:center">고객관리시스템</td>
	                                	<td style="text-align:center">채권추심</td>
	                                	<td style="text-align:center">채권추심사이트</td>
	                                	<td style="text-align:center">유일수</td>
	                                	<td style="text-align:center">과장</td>
	                                	<td style="text-align:center">010-8109-1287</td>
	                                </tr>
                                
                            </tbody></table>
                            </div></div>
                            <div class="row">
                          </div>
                        </div>
                        </div>
	</div>
</div>
</body>
</html>