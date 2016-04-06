<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/_04_Forum/Forum.css" />
<script type="text/javascript" src="">
	
</script>
<title>討論區的頭</title>
</head>
<body>
	<div><form action=""></form>
		<table id="t1">
			<tr id="tr1">
				<td><a href="">全部</a>&nbsp;&nbsp;</td>
				<td><a href="">行程</a>&nbsp;&nbsp;</td>
				<td><a href="">遊記</a>&nbsp;&nbsp;</td>
				<td><a href="">住宿</a>&nbsp;&nbsp;</td>
				<td><a href="">交通</a>&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td><a href="">飲食</a>&nbsp;&nbsp;</td>
				<td><a href="">景點</a>&nbsp;&nbsp;</td>
				<td><a href="">金錢</a>&nbsp;&nbsp;</td>
				<td><a href="">消費</a>&nbsp;&nbsp;</td>
				<td><a href="">其他</a>&nbsp;&nbsp;</td>
			</tr>
		</table>
	</div>
	<div id="d1">
		排序方式<br> <select>
			<option value="time">時間</option>
			<option value="view">瀏覽數</option>
		</select>
	</div>
	<div id="d2">
		關鍵字搜尋<br> <input type="text" value="請輸入關鍵字" />
	</div>
	<div id="d3">
		<input type="submit" name="forumAction" value="發表文章" />
	</div>

</body>
</html>