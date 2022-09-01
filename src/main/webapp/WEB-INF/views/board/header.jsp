<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Bootstrap Admin Theme</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.1/css/bootstrap.min.css">
	<script src="/CRUDproject/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="/CRUDproject/resources/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <!-- Bootstrap Core CSS -->
    <link href="/CRUDproject/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- MetisMenu CSS -->
    <link href="/CRUDproject/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="/CRUDproject/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">
    <!-- DataTables Responsive CSS -->
    <link href="/CRUDproject/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="/CRUDproject/resources/dist/css/sb-admin-2.css?aa" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="/CRUDproject/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
</head>
<body>
    <div id="wrapper">
        <!-- Navigation -->
	<div id="page-wrapper">
      <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
            	<a href="${ContextPath}/CRUDproject/board/tree">
                <img src="/CRUDproject/resources/img/logo.png" style="height:60px; float:left; margin-top:15px; padding-right:20px">
                </a>
                <h1 class="jm-font" style="color:#FFFFFF">IT팀 메신저 관리 시스템</h1> 
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0" style="float:right">
                        <li class="nav-item"><a class="nav-link active" href="${contextPath}/board/departmentMenu">조직 관리</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
</body>
</html>