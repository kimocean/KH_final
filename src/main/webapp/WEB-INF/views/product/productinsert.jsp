<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
</head>
<body>
<%@ include file="../../../common/common.jsp" %>
<h1>상품 등록</h1>
<form action="./productinsert" method="post" id="f_product"> <br/>
product_no : <input type="text" name="product_no"> <br/>
상품명 : <input type="text" name="product_name" id="product_name"> <br/>
카테고리(지역) :
	<select id="s_category_local_no" name="category_local_no">
		<option selected value="">선택</option>
	</select><br/>
카테고리(종류) :
	<select id="s_category_type_no" name="category_type_no">
		<option selected value="">선택</option>
	</select><br/>

판매가격 : <input type="text" name="product_price"> <br/>
재고 : <input type="text" name="product_stock"> <br/>
대표이미지 : <input type="file" name="product_img" id="product_img" multiple> <br/>
배송비 :
<input type="radio" name="dlvyfee_radio" value="dlvyfee_x"> 무료
<input type="radio" name="dlvyfee_radio" value="dlvyfee_s"> 조건부 무료
<input type="radio" name="dlvyfee_radio" value="dlvyfee_o"> 유료 <br/>
<div id="tb_dlvyfee_s" style="display:none;">
	배송비 조건 <input type="text" name="product_dlvylimit"> 원 이상 무료 <br/>
	기본 배송비 <input type="text" id="" name="product_dlvyfee"> 원
</div>
<div id="tb_dlvyfee_o" style="display:none;">
	기본 배송비 <input type="text" id="" name="product_dlvyfee"> 원
</div>
상세 설명 : <input type="textarea" name="product_detail"> <br/>
m_id : <input type="textarea" name="m_id"> <br/>
</form>
<button id="b_submit">등록</button>

<script type="text/javascript">
$(document).ready(function() {
	// 배송비 라디오버튼 클릭하면 텍스트박스 뜨는 코드 시작
	$('input[name="dlvyfee_radio"]').on('click', function(){
		let dlvyfee_radio = $('input[name="dlvyfee_radio"]:checked').val();
		if(dlvyfee_radio == "dlvyfee_s"){
			$('#tb_dlvyfee_o').css('display','none');
			$('#tb_dlvyfee_s').css('display','block');
		}else if(dlvyfee_radio == "dlvyfee_o"){
			$('#tb_dlvyfee_o').css('display','block');
			$('#tb_dlvyfee_s').css('display','none');
		}else{
			$('#tb_dlvyfee_o').css('display','none');
			$('#tb_dlvyfee_s').css('display','none');
		}
	});
	// 배송비 라디오버튼 클릭하면 텍스트박스 뜨는 코드 끝
	
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
	}
	// 카테고리-로컬 끝
	
}); // end of document ready

$("input[type='file']").on("change", function(e) {
	let formData = new FormData();
	let img = $("input[name='product_img']");
	let imgList = img[0].files;
	let imgObj = imgList[0];
	
	if(!imgCheck(imgObj.name, imgObj.size)) {
		console.log(imgObj.name, imgObj.size)
		return false;
	}
	alert("통과");
	
//	for(let i=0;i<imgList.length;i++) {
		formData.append("uploadImg", imgObj);
//	}
	
	$.ajax({
		url: 'insertimg',
		processData: false,
		contentType: false,
		data: formData,
		type: 'POST',
		dataType: 'json'
	});
	
}) // end of input type file change

	let regex = new RegExp("(.*?)\.(jpg|png|gif|JPG|PNG|GIF)$"); // 파일 형식 제한
	let maxSize = 10485760000; // 파일 용량 제한
	
	function imgCheck(imgName, imgSize) {
		if(imgSize >= maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}
		if(!regex.test(imgName)) {
			alert("업로드할 수 없는 파일 형식");
			return false;
		}
		return true;
	}

$("#b_submit").on("click", function(e) {
	e.preventDefault();
	$("#f_product").submit();
})
</script>
</body>
</html>