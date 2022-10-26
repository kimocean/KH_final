<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail</title>
</head>
<body>
<%@ include file="../../../common/common.jsp" %>

<h1>상품 상세</h1>
<form action="/mall/product/productdetail?product_no=${productSelectOne.product_no}" method="post" name="f_product"> <br/>
product_no : <input type="text" name="product_no" value="${productSelectOne.product_no}"> <br/>
상품명 : <input type="text" name="product_name" value="${productSelectOne.product_name}"> <br/>
카테고리(지역) :
	<select id="s_category_local_no" name="category_local_no" value="${productSelectOne.category_local_no}">
		<option selected value="">선택</option>
	</select><br/>
카테고리(종류) :
	<select id="s_category_type_no" name="category_type_no" value="${productSelectOne.category_type_no}">
		<option selected value="">선택</option>
	</select><br/>

판매가격 : <input type="text" name="product_price" value="${productSelectOne.product_price}"> <br/>
재고 : <input type="text" name="product_stock"  value="${productSelectOne.product_stock}"> <br/>
대표이미지 : 첨부파일 <input type="text" name="product_img"  value="${productSelectOne.product_img}"> <br/>
배송비 :
<input type="radio" name="dlvyfee_radio" value="dlvyfee_x"> 무료
<input type="radio" name="dlvyfee_radio" value="dlvyfee_s"> 조건부 무료
<input type="radio" name="dlvyfee_radio" value="dlvyfee_o"> 유료 <br/>
<div id="tb_dlvyfee_s" style="display:none;">
	배송비 조건 <input type="text" name="product_dlvylimit"  value="${productSelectOne.product_dlvylimit}"> 원 이상 무료 <br/>
	기본 배송비 <input type="text" id="" name="product_dlvyfee" value="${productSelectOne.product_dlvyfee}"> 원
</div>
<div id="tb_dlvyfee_o" style="display:none;">
	기본 배송비 <input type="text" id="" name="product_dlvyfee" value="${productSelectOne.product_dlvyfee}"> 원
</div>
상세 설명 : <input type="textarea" name="product_detail"  value="${productSelectOne.product_detail}"> <br/>
m_id : <input type="textarea" name="m_id"  value="${productSelectOne.m_id}"> <br/>
<button id="b_update">수정</button>
<button id="b_delete">삭제</button>
</form>

<script type="text/javascript">
$(document).ready(function(){

let productForm = $("form[name='f_product']");
	// 삭제
	$("#b_delete").on("click", function(){
		productForm.attr("action", "./productdelete");
		productForm.attr("method", "post");
		productForm.submit();
	})

	// 켰을 때 자동으로 라디오버튼 체크되는 조건 시작
	let product_dlvyfee = document.getElementsByName("product_dlvyfee")[0].value;
	let product_dlvylimit = document.getElementsByName("product_dlvylimit")[0].value;
	console.log(document.getElementsByName("product_dlvyfee")[0].value)
	console.log(document.getElementsByName("product_dlvyfee")[1].value)
	if(product_dlvylimit > 0 && product_dlvylimit != null) {
		$(":radio[name='dlvyfee_radio'][value='dlvyfee_s']").attr('checked', true);
	} else if(product_dlvyfee == 0) {
		$(":radio[name='dlvyfee_radio'][value='dlvyfee_x']").attr('checked', true);
	} else {
		$(":radio[name='dlvyfee_radio'][value='dlvyfee_o']").attr('checked', true);
	}
	// 켰을 때 자동으로 라디오버튼 체크되는 조건 끝
		
	// 배송비 텍스트박스 띄우기 시작
	let dlvyfee_radio = $('input[name="dlvyfee_radio"]:checked').val();
	if(dlvyfee_radio == "dlvyfee_s"){
		$('#tb_dlvyfee_o').css('display','none');
		$('#tb_dlvyfee_s').css('display','block');
	} else if(dlvyfee_radio == "dlvyfee_o"){
		$('#tb_dlvyfee_o').css('display','block');
		$('#tb_dlvyfee_s').css('display','none');
	}else{
		$('#tb_dlvyfee_o').css('display','none');
		$('#tb_dlvyfee_s').css('display','none');
	}
	// 배송비 텍스트박스 띄우기 끝
	    	 
	// 배송비 박스 선택하는 대로 변경 시작
	$('input[name="dlvyfee_radio"]').on('click', function(){
		let dlvyfee_radio = $('input[name="dlvyfee_radio"]:checked').val();
		console.log(dlvyfee_radio)
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
	// 배송비 박스 선택하는 대로 변경 끝
	
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
	
	let selectedCT = '${productSelectOne.category_type_no}';
	
	for(let i=0;i<CTArr.length;i++) {
		CTSelect.append("<option value='" + CTArr[i].category_type_no + "' name='category_type_no' >" + CTArr[i].category_type_name + "</option>");
	}
	
	$("#s_category_type_no option").each(function(i, obj) {
		if(selectedCT == obj.value) {
			$(obj).attr("selected", "selected");
		}
	})
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
	
	let selectedCL = '${productSelectOne.category_local_no}';
	
	for(let i=0;i<CLArr.length;i++) {
		CLSelect.append("<option value='" + CLArr[i].category_local_no + "' name='category_type_no' >" + CLArr[i].category_local_name + "</option>");
	}
	
	$("#s_category_local_no option").each(function(i, obj) {
		if(selectedCL == obj.value) {
			$(obj).attr("selected", "selected");
		}
	})
	// 카테고리-로컬 끝
	
}); // end of document ready

//$("#b_update").on("click", function(e) {
//	e.preventDefault();
//	console.log("되는건지...")
//	$("#f_product").submit();
//})

$("#b_update").on("click", function(e) {
	// dlvyfee_x나 o면 배송비조건 0원으로 초기화 시작
	if($('input[name="dlvyfee_radio"]:checked').val() == "dlvyfee_x") {
		$('input[name="product_dlvylimit"]').val(0);
		$('input[name="product_dlvyfee"]').val(0);
	} else if($('input[name="dlvyfee_radio"]:checked').val() == "dlvyfee_o") {
		$('input[name="product_dlvylimit"]').val(0);
		document.getElementsByName("product_dlvyfee")[0].value = document.getElementsByName("product_dlvyfee")[1].value
	}
})
</script>
</body>
</html>