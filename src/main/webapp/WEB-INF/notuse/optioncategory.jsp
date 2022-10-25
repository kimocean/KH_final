<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>옵션 카테고리 테스트</title>
<%@ include file="../../../common/common.jsp" %>
<script>
	$(document).ready(function() {
//		console.log('${optionSelectAll}');
	})
	
	let cateList = JSON.parse('${optionSelectAll}'); // ${optionSelectAll}은 json
	let cateListS = JSON.stringify('${optionSelectAll}'); // ${optionSelectAll}은 json
	let cateArray = new Array();
	let cateObj = new Object();
	let cateSelect = $(".cate1");
	
	let cateListName = ${optionSelectAll}; // json 객체
	console.log(cateListS)
//	console.log(cateListName['0'].option_name)
//	console.log(cateList['1'].option_name)
	let cateSet = new Set();
	for(let i=0;i<Object.keys(cateList).length;i++) {
		cateSet.add(cateList[i].option_name)
	}
	console.log(cateSet)
	
//	for(let i=0;i<cateList.length;i++) {
//		if(cateList[i].option_name === )
//	}
</script>
</head>
<body>
<div class="cate_wrap">
	<span>카테고리</span>
	<select class="cate1">
		<option selected>선택</option>
	</select>
</div>
</body>
</html>