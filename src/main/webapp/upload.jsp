<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-07-17
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>文件上传下载</title>
</head>
<body>
<form action="http://localhost:8080/uploadDemo/rest/file/upload" method="post" enctype="multipart/form-data">
    选择文件:<input type="file" name="file" width="120px">
    <input type="submit" value="上传">
</form>
<hr>
<form action="http://localhost:8080/sanvo/file/down" method="post">
    文件地址：<input type="text" name="file_url">
    <input type="submit" value="下载">
</form>
</body>
</html>
