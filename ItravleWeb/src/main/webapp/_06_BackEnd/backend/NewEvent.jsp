<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ page import="_00_Misc.model.*"%>
<%@ page import="_01_Sight.model.*"%>
<%@ page import="java.util.*"%>
<%
	CodeService service = new CodeService();
	List<CodeVO> region = service.select("region");
	pageContext.setAttribute("region", region);
	List<CodeVO> county = service.select("county");
	pageContext.setAttribute("county", county);
	SightService sightService=new SightService();
	List<SightVO> sightVOTaipei=sightService.selectByCounty("county01");
	pageContext.setAttribute("sightVOTaipei", sightVOTaipei);
%>
<jsp:useBean id="SightService" scope="page" class="_01_Sight.model.SightService" />
<title>I-Travel後台:新增活動</title>
<link rel="stylesheet" type="text/css" href="<c:url value="/css/_00_Misc/main.css"/>"/>
<!-- 最新編譯和最佳化的 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<!-- 選擇性佈景主題 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
<link href="	<c:url value="/css/_00_Misc/alertify.core.css"/>" rel="stylesheet">
<link href="	<c:url value="/css/_00_Misc/alertify.default.css"/>" rel="stylesheet">
<!-- jQuery ui -->
<link rel="stylesheet" type="text/css" href="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.css"/>" />
<!-- jQuery -->
<script type="text/javascript" src="<c:url value="/js/jquery-2.2.1.min.js"/>"></script>
<!-- 最新編譯和最佳化的 JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<!-- jQuery ui -->
<script type="text/javascript" src="<c:url value="/jquery-ui-1.11.4.custom/jquery-ui.min.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function() {
		//景點select選單
		$("#selRegion").change(function(){
			  switch ($(this).val()){
					case "region00": 
			      $("#selCounty option").remove();
			      break;
					case "region01": 
			      $("#selCounty option").remove();
			      var array = [ "請選擇","臺北市","新北市","基隆市","宜蘭縣","桃園縣","新竹市","新竹縣"];
			      var arrayId=["","county01","county02","county07","county17","county03","county08","county10"];
			      //利用each遍歷array中的值並將每個值新增到Select中
			      $.each(array, function(i, val) {
			        $("#selCounty").append($("<option value='" + arrayId[i] + "'>" + array[i] + "</option>"));
			      });      
			      break;
					case "region02": 
			      $("#selCounty option").remove();
			      var array = [ "臺中市","彰化縣","南投縣","苗栗縣","雲林縣"];
			      var arrayId=["county04","county12","county13","county11","county14"];
			      $.each(array, function(i, val) {
			        $("#selCounty").append($("<option value='" + arrayId[i] + "'>" + array[i] + "</option>"));
			      });      
			      break;
					case "region03": 
					      $("#selCounty option").remove();
					      var array = [ "嘉義市","嘉義縣","臺南市","高雄市","屏東縣","澎湖縣"];
					      var arrayId=["county09","county15","county05","county06","county16","county20"];
					      $.each(array, function(i, val) {
					        $("#selCounty").append($("<option value='" + arrayId[i] + "'>" + array[i] + "</option>"));
					      });      
					      break;
					case "region04": 
					      $("#selCounty option").remove();
					      var array = [ "花蓮縣","臺東縣","金門縣","連江縣"];
					      var arrayId=["county18","county19","county21","county22"];
					      $.each(array, function(i, val) {
					        $("#selCounty").append($("<option value='" + arrayId[i] + "'>" + array[i] + "</option>"));
					      });      
					      break;
				}
			});
		//動態顯示各縣市景點
		$('#selCounty').change(function(){
			$("#selSight option").remove();
					var url='<c:url value="/_06_BackEnd/backEnd/SightCountyServlet.view" />';
					var countyId=$('#selCounty').val();
					var settings = new Object();
					settings.method  = "GET";
					settings.contentType = "application/x-www-form-urlencoded; charset=UTF-8";
					settings.url = url;
					settings.data = "countyId="+countyId;
					settings.async = true;
					settings.cache = false;
					settings.success = processText;
					$.ajax(settings);
 			});
		//起始日期用jQuery UI
		$('input[name="eventStartDate"]').datepicker({
			appendText : "格式：YYYY-MM-DD",
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			changeYear : true,
			showButtonPanel : true,
		}).attr("readonly", "readonly");
		//結束日期用jQuery UI
		$('input[name="eventEndDate"]').datepicker({
			appendText : "格式：YYYY-MM-DD",
			dateFormat : "yy-mm-dd",
			changeMonth : true,
			changeYear : true,
			showButtonPanel : true,
		}).attr("readonly", "readonly");
		//選時間的要再加上其他自己寫的jQuery UI plugin
	});
	//動態顯示各縣市景點處理傳回資料
	function processText(data){
				var array = data.split(",");
				var sightIds=[];
				var sightNames=[];
				//景點ID 1,5,7...
				for (var i = 0; i < (array.length/2-1); i++) {
					  sightIds[i]=array[(2*i)];
					}
				//景點名稱 2,4,6
				for (var j = 0; j < (array.length/2-1); j++) {
					sightNames[j]=array[(2*j+1)];
					}
				//塞入sel3
				for (var k = 1; k < sightIds.length; k++) {
					console.log(sightIds[k]);
					$('#selSight').append('<option value="'+sightIds[k]+'">'+sightNames[k]+'</option>');
				}
	}
	//預覽圖片功能
 var openFile = function(event) {
	    var input = event.target;

	    var reader = new FileReader();
	    reader.onload = function(){
	      var dataURL = reader.result;
	      var output = document.getElementById('output');
	      output.src = dataURL;
	    };
	    reader.readAsDataURL(input.files[0]);
	  }; 
</script>
<style type="text/css">
.backendtable tr td:FIRST-CHILD{
text-align: right;
}
.table.backendtable{
width: 700px;
}
nav {
	font-family: "Microsoft JhengHei", "Helvetica Neue", Helvetica, Arial,
		sans-serif;
	font-size: 18px;
	line-height: 20px;
}

.navbar-brand {
	color: white;
	font-weight: 500;
	font-size: 24px;
	line-height: 30px;
}

#bs-example-navbar-collapse-1 .whiteNav a {
	color: white;
	font-weight: 500;
	font-size: 24px;
	height: 60px;
	line-height: 30px;
}
/* .dropdown a { */
/* 	color: white;  */
/* 	font-weight: 500; */
/* 	font-size: 24px; */
/* 	height: 60px; */
/* 	line-height: 30px; */
/* } */
</style>
</head>
<body>
	<header>
	<!-- import共同的 -->
	</header>
	<!-- import共同的 -->
	<nav class="navbar navbar-inverse" role="navigation">
		<!-- import共同的 -->
<%-- 		<jsp:include page="/_00_Misc/top.jsp" /> --%>
<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="<c:url value="/index.jsp"/>">ITravel</a>
		</div>
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<!--  正在被選取的物件-->
				<!-- 	<li class="active"><a href="#">看景點<span class="sr-only">(current)</span></a></li> -->
				<li class="whiteNav"><a href="<c:url value="/_01_Sight/SightIndex.jsp"/>">看景點</a></li>
				<li class="whiteNav"><a href="<c:url value="/_02_TripAndJournal/TripIndex.jsp"/>">看行程</a></li>
				<li class="whiteNav"><a href="<c:url value="/_02_TripAndJournal/JournalIndex.jsp"/>">看遊記</a></li>
				<li class="whiteNav"><a href="<c:url value="/_04_Forum/ForumIndex.jsp" />">討論區</a></li>
				<li class="whiteNav">
				<c:choose>
				<c:when test="${empty user}"><a onclick="doAlertMessage()" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">會員功能<span class="caret"></span></a></c:when>
				<c:when test="${not empty user}"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">會員功能<span class="caret"></span></a></c:when>
				</c:choose>
					<ul class="dropdown-menu navbar-nav" role="menu">
						<li class="whiteNav"><a href="<c:url value="/_05_Member/member/MemberTrip.jsp" />">我的行程</a></li>
						<li class="whiteNav"><a href="<c:url value="/_05_Member/member/MemberJournal.jsp" />">我的遊記</a></li>
						<li class="whiteNav"><a href="<c:url value="/_05_Member/member/MemberForum.jsp" />">我的討論區</a></li>
						<li class="whiteNav"><a href="<c:url value="/_05_Member/member/MemberSight.jsp" />">我的收藏景點</a></li>
						<li class="whiteNav"><a href="<c:url value="/_05_Member/member/MemberCollectionTrip.jsp" />">我的收藏行程</a></li>
						<li class="whiteNav"><a href="<c:url value="/_05_Member/member/MemberCollectionJournal.jsp" />">我的收藏遊記</a></li>
						<li class="whiteNav"><a href="<c:url value="/_05_Member/member/MemberCollectionForum.jsp" />">我的收藏討論區</a></li>
						<li class="whiteNav"><a href="<c:url value="/_05_Member/member/MemberCollectionMember.jsp" />">我的追蹤作者</a></li>
						<li class="whiteNav"><a href="<c:url value="/_05_Member/member/MemberModify.jsp " />">修改會員資料</a></li>
					</ul></li>
				<c:if test="${not empty admin}">
					<li class="whiteNav"><a
						href="<c:url value="/_06_BackEnd/backend/AllSight.jsp" />">後台</a></li>
				</c:if>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<!-- 視session是否登入登出顯示 login/註冊 或 logout -->
					<c:if test="${not empty user}">
						<li class="whiteNav" style="color: white; font-size: 24px;" > ${user.nickname}<img
							src="<c:url value="/_05_Member/ShowMemberPhoto.controller?memberId=${user.memberId}" />"
							width="50px" height="50px"></li >
					</c:if>
				
				<c:if test="${empty user}">
					<li class="whiteNav"><a id="myReg">註冊</a></li>
				</c:if>
				<c:if test="${empty user}">
					<li class="whiteNav"><a id="myBtn" style="cursor: pointer">Login</a></li>
					<!-- 					<li><button type="button"  class="btn btn-info btn-lg" id="myBtn3">Login</button></li> -->
				</c:if>
				<c:if test="${not empty user}">
					<li class="pull-right whiteNav"><a href="<c:url value="/_05_Member/Logout.jsp" />">Logout</a></li>
				</c:if>
			</ul>
		</div>
		</div>
	</nav>
	<article class="center-block">
	<h2>I-Travel後台:新增活動</h2>
		<form action="<c:url value="/_06_BackEnd/backend/NewEvent.controller" />" method="post" enctype="multipart/form-data">
			<table class="table backendtable">
				<tr>
					<td>活動名稱：</td>
					<td><input type="text" name="eventTopic" value="${param.eventTopic}"></td>
					<td><span class="error">${error.eventTopic}</span></td>
				</tr>
				<tr>
					<td>活動內容：</td>
					<td><textarea rows="5" cols="40" name="eventContent" style="resize: none">${param.eventContent}</textarea></td>
					<td><span class="error">${error.eventContent}</span></td>
				</tr>
				<tr>
					<td>活動開始時間：</td>
					<td><input type="text" id="eventStartDate" name="eventStartDate" value="${param.eventStartDate}"></td>
					<td><span class="error">${error.eventStartDate}</span></td>
				</tr>
				<tr>
					<td>活動結束時間：</td>
					<td><input type="text" id="eventEndDate" name="eventEndDate" value="${param.eventEndDate}"></td>
					<td><span class="error">${error.eventEndDate}</span></td>
				</tr>
				<tr>
					<td>對應景點：</td>
					<td>地區：
						<select name="regionId" id="selRegion">
								<option value="">請選擇</option>
							<c:forEach var="region" items="${region}">
								<option value="${region.codeId}" ${(param.regionId==region.codeId)?'selected':'' }>${region.codeName}</option>
							</c:forEach>
						</select>
							縣市：
						<select name="countyId" id="selCounty">
							<option value="">請選擇</option>
						</select>
						<select name="sightId" id="selSight">
							<option value="">請選擇</option>
						</select>
					</td>
				</tr>
	<%-- 			<tr>
					<td></td>
					<td>
				
					</td>
					<td><span>${error.sightId}</span></td>
				</tr> --%>
				<tr>
					<td>是否下架：</td>
					<td><input type="radio" name="eventRemoved" value="true" >是
					<input type="radio" name="eventRemoved" value="false" checked="checked">否</td>
				</tr>
				<tr>
					<td>活動圖片：</td>
					<td><input type='file' accept='image/*' onchange='openFile(event)' name="eventPhoto"><br>
					<img id='output' width="240" height="180"></td>
				</tr>
				<tr>
					<td><input type="hidden" name="action" value="insert"></td>
					<td><input type="submit" value="新增活動" /></td>
				</tr>
			</table>
		</form>
 	</article>
<footer>
		<div>
			<jsp:include page="/_00_Misc/footer.jsp" /></div>
	</footer>
</body>
</html>
