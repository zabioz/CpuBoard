<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page import="java.util.Calendar" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>検索結果</title>
<style type="text/css">
	table,td{
	 border: 1px solid #ccc;
	 border-collapse: collapse;
	 padding: 6px;
	 margin: auto;
	 text-align: center;	
	}
</style>

</head>
<body>
	<!-- list.jsp 에서 애트리뷰터에 데이터를 저장해서 listView.jsp로 -->
	<h3 style="text-align:center">検索結果</h3><p>
	<div style="text-align:right; width:700px; margin:auto;">
	合 ${searchplist.totalCount} 回 文/
	現在 ${searchplist.currentPage}  ページ/
	合 ${searchplist.totalPage} ページ/
	</div>
<table>
	<tr><td width ="50">idx</td>
		<td width ="250">題目</td>
		<td width ="150">作成者</td>
		<td width ="150">作成日</td>
		<td width ="50">照会数</td>
	</tr>
<!--  -->
<c:forEach var="vo" items="${BoardList}">
		<tr>
			<td>${vo.idx}</td>
			<td style="text-align: left;">
			<a href="myapp/board/view?idx=${vo.idx }&page=${searchplist.currentPage}">${vo.subject }</a>
			<jsp:useBean id="now" class="java.util.Date" />
			<c:if test="${vo.wdate.year == now.year && vo.wdate.month == now.month && vo.wdate.date == now.date}" >
			<img src='./image/new.png' width=30 height=30>
			</c:if>
			</td>
		<td>${vo.name }</td>
		<td>
			<!-- 오늘 입력된 새글 이면 시간, 아니면 날짜 출력 -->
			<!--  -->
	 		<c:choose>
	 		<c:when test="${vo.wdate.year == now.year && vo.wdate.month == now.month && vo.wdate.date == now.date}" >
			<fmt:formatDate value="${vo.wdate }" type="time"/>
			</c:when>
			<c:otherwise>
			<fmt:formatDate value="${vo.wdate}" type="date"/>
			</c:otherwise>
			</c:choose>
			</td>
			<td>${vo.readCount }</td>	
		</tr>
</c:forEach>
</table>
<div style="text-align: right;width:700px;margin:auto;">
<br>
<input type="button" value="作成" onclick="location.href='insert.do'">
</div>
<div style="text-align: center;">
<c:if test="${searchsearchplist.currentPage > 10 }">
<input type="button" value="&lt;&lt" onclick="location.href='?page=${searchsearchplist.currentPage -10}'">
</c:if>
<c:choose>
<c:when test="${searchsearchplist.currentPage ==1 }">
	<input type="button" value="&lt;" disabled>
</c:when>
<c:otherwise>
	<input type="button" value="&lt;" onclick="location.href='?page=${searchplist.currentPage-1 }'">
</c:otherwise>
</c:choose>
<!-- -////////////////////////////////////////////////////////////-->
<!-- -////////////////////////////////////////////////////////////-->
<!-- -////////////////////////////////////////////////////////////-->
<c:forEach var="i" begin="${searchplist.startPage }" end="${searchplist.endPage}">
<c:choose>
<c:when test="test=${i == searchplist.currentPage} ">
	<input type="button" value="${i }" style="color:green;" disabled>
</c:when>
<c:otherwise>
	<input type="button" value="${i }" onclick="location.href='?page=${i }'">
</c:otherwise>
</c:choose>
</c:forEach>
<!-- -////////////////////////////////////////////////////////////-->
<!-- -////////////////////////////////////////////////////////////-->
<c:choose>
	<c:when test="${searchplist.currentPage > searchplist.totalPage }">
		<input type="button" value="&gt;" disabled>
	</c:when>
	<c:otherwise>
		<input type="button" value="&gt;" onclick="location.href='?page=${searchplist.currentPage + 1 }'">
	</c:otherwise>
</c:choose>
<!-- -////////////////////////////////////////////////////////////-->
<c:if test="${searchplist.endPage < searchplist.totalPage }">
	<input type="button" value="&gt;&gt;" onclick="location.href='?page=${searchplist.endPage +1 }'">
</c:if>
</div>






</body>
</html>