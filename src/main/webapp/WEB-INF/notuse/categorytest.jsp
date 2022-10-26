<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../../../common/common.jsp" %>

</head>
<body>
<form id="testform">
	<select id="s_category_type_no">
		<option selected value="">선택</option>
	</select>
	<select id="s_category_local_no">
		<option selected value="">선택</option>
	</select>
</form>
<button id="testbutton">등록</button>
<script type="text/javascript">
$(document).ready(function() {
	let jsonData = JSON.parse('${selectCategoryLocal}');
	
	let cateArr = new Array();
	let cateObj = new Object();
	for(let i=0;i<jsonData.length;i++) {
		cateObj = new Object();
		cateObj.category_local_no = jsonData[i].category_local_no;
		cateObj.category_local_name = jsonData[i].category_local_name;
		cateArr.push(cateObj)
	}
	
	console.log(cateArr)
	
//	let cateSelect = $("#s_category_local_no");
	
	for(let i=0;i<cateArr.length;i++) {
//		cateSelect.append("<option value='" + cateArr[i].category_local_no + "' >" + cateArr[i].category_local_name + "</option>");
		console.log(cateArr[i].category_local_no)
		console.log(cateArr[i].category_local_name)
	}
	
	$("#testbutton").on("click", function(e) {
		e.preventDefault();
		console.log("찍히는지?")
		$("#testform").submit();
	})
	
	
	
	
		//카테고리-타입 시작
	let CTList = JSON.parse('${selectCategoryType}');
	let CTArr = new Array();
	let CTObj = new Object();
	let CTSelect = $("#s_category_type_no");

	for(let i=0;i<CTList.length;i++) {
		CTObj = new Object();
		CTObj.category_type_no = CTList[i].category_type_no;
		CTObj.category_type_name = CTList[i].category_type_name;
		CTArr.push(CTObj)
	}
	for(let i=0;i<CTArr.length;i++) {
		CTSelect.append("<option value='" + CTArr[i].category_type_no + "' name='category_type_no' >" + CTArr[i].category_type_name + "</option>");
		console.log(CTArr[i].category_type_no)
		console.log(CTArr[i].category_type_name)
	}
	// 카테고리-타입 끝
	
	//카테고리-로컬 시작
	let CLList = JSON.parse('${selectCategoryLocal}');
	let CLArr = new Array();
	let CLObj = new Object();
	let CLSelect = $("#s_category_local_no");

	for(let i=0;i<CLList.length;i++) {
		CLObj = new Object();
		CLObj.category_local_no = CLList[i].category_local_no;
		CLObj.category_local_name = CLList[i].category_local_name;
		CLArr.push(CLObj)
	}
	for(let i=0;i<CLArr.length;i++) {
		CLSelect.append("<option value='" + CLArr[i].category_local_no + "' name='category_type_no' >" + CLArr[i].category_local_name + "</option>");
		console.log(CLArr[i].category_local_no)
		console.log(CLArr[i].category_local_name)
	}
	// 카테고리-로컬 끝
})
</script>
</body>
</html>