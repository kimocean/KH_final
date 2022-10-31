<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail</title>
<%@ include file="../../../common/common.jsp" %>
</head>
<body>
<style>
.scontainer {
	float: left;
	margin-top: -40px;
	margin-left: 100px;
}
#pdContainer {
	width: 70%;
	margin: 0 auto;
	float: right;
	margin-right: 120px;
	margin-bottom: 50px;
}
#ffooter {
	clear: both;
}
a {
	text-decoration: none;
	color: black;
}
table {
	text-align: center;
}
</style>
<%@ include file="../../../layout/header.jsp" %>
<%@ include file="../../../layout/nav.jsp" %>
<%@ include file="../../../layout/sidebar.jsp" %>
<div id="pdContainer">
<h1>상품 상세</h1>
<form action="/mall/product/productdetail?product_no=${productSelectOne.product_no}" method="post" id="f_product"> <br/>
<input type="hidden" name="product_no" value="${productSelectOne.product_no}">
<input type="text" class="form-control" name="product_name" value="${productSelectOne.product_name}" placeholder="상품명"> <br/>
<select class="form-select" id="s_category_local_no" name="category_local_no" value="${productSelectOne.category_local_no}">
	<option selected value="">카테고리-지역</option>
</select><br/>
<select class="form-select" id="s_category_type_no" name="category_type_no" value="${productSelectOne.category_type_no}">
	<option selected value="">카테고리-종류</option>
</select><br/>
<input type="text" class="form-control" name="product_price" value="${productSelectOne.product_price}" placeholder="상품 가격"> <br/>
<input type="text" class="form-control" name="product_stock"  value="${productSelectOne.product_stock}" placeholder="상품 재고"> <br/>
<div class="form_section">
	<div class="form_section_content">
		<input type="file" class="form-control" name="product_img" id="product_img" accept="image/*" multiple>
		<div id="uploadResult">
			<ul class="imgUL"></ul>
		</div>
	</div>
</div>
<br/>
<input type="radio" class="form-check-input" name="dlvyfee_radio" value="dlvyfee_x"> 무료
<input type="radio" class="form-check-input" name="dlvyfee_radio" value="dlvyfee_s"> 조건부 무료
<input type="radio" class="form-check-input" name="dlvyfee_radio" value="dlvyfee_o"> 유료 <br/>
<div id="tb_dlvyfee_s" style="display:none;">
	배송비 조건 <input type="text" class="form-control" name="product_dlvylimit"  value="${productSelectOne.product_dlvylimit}"> 원 이상 무료 <br/>
	기본 배송비 <input type="text" class="form-control" id="" name="product_dlvyfee" value="${productSelectOne.product_dlvyfee}"> 원
</div>
<div id="tb_dlvyfee_o" style="display:none;">
	기본 배송비 <input type="text" class="form-control" id="" name="product_dlvyfee" value="${productSelectOne.product_dlvyfee}"> 원
</div>
<input type="textarea" class="form-control" name="product_detail" value="${productSelectOne.product_detail}" placeholder="상세 설명"> <br/>
<input type="hidden" name="m_id"  value="${productSelectOne.m_id}">
<button id="b_update" class="btn btn-warning" data-oper="modify">수정</button>
<button id="b_delete" class="btn btn-dark" data-oper="remove">삭제</button>
</form>

</div>
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
	
	// 기존 이미지 출력 시작
	let product_no = '<c:out value="${productSelectOne.product_no}"/>';
	let uploadResult = $("#uploadResult");
	
	let formData0 = new FormData();
	
	$.getJSON("productfilelist", {product_no : product_no}, function(obj) {
		for(let i=0;i<obj.length;i++) {
			formData0.append("uploadImg", obj[i]);
		}
		if(obj.length === 0) {
			let str = "";
			str += "<div id='result_card'>";
			str += "<img src='/resources/image/logo.png'>";
			str += "</div>";
			
			uploadResult.html(str);
			return;
		}
		
		let str = "";
		
//		for(let i=0;i<obj.length;i++) {
//			let fileCallPath = encodeURIComponent(obj[i].productfile_sname);
//			str += "<div id='result_card[" + i + "]'";
//			str += "data-path='" + obj[i].productfile_path + "' data-filename='" + obj[i].productfile_name + "'>";
//			str += "<img src='productfiledetail?imgName=" + fileCallPath + "'>";
//			str += "<div class='imgDeleteBtn[" + i + "]' data-file='" + fileCallPath + "'>x</div>";
//			str += "<input type='hidden' name='productfileVO[" + i + "].productfile_name' value='"+ obj.productfile_name +"'>";
//			str += "<input type='hidden' name='productfileVO[" + i + "].productfile_sname' value='"+ obj.productfile_sname +"'>";
//			str += "<input type='hidden' name='productfileVO[" + i + "].productfile_path' value='"+ obj.productfile_path +"'>";
//			str += "</div>"
//			
//			uploadResult.html(str);
//		}

		$(obj).each(function(i,obj) {
			let fileCallPath = encodeURIComponent(obj.productfile_sname);
			str += "<li style='cursor:pointer' class='imgLI' data-path='"+obj.productfile_path+"' data-name='"+obj.productfile_name+"'>";
			str += "<span> " + obj.productfile_name + " </span>";
			str += " <button type='button' class='imgDeleteBtn' data-no='"+obj.productfile_no
					+ "' data-name='"+obj.productfile_name+"' data-type='image'>x</button>"
			str += " <div>";
			str += "<img src='productfiledetail?imgName=" + fileCallPath + "'>";
			str += "</div>";
			str += "</li>";
		});
		$("#uploadResult ul").html(str);
	
	}) // end of getJSON
	// 기존 이미지 출력 끝
	
	//이미지 업로드
	let formData = new FormData();
	$("input[type='file']").on("change", function(e) {
		let img = $("input[name='product_img']");
		let imgList = img[0].files;
		let imgObj = imgList[0];
		
		if(!imgCheck(imgObj.name, imgObj.size)) {
			console.log(imgObj.name, imgObj.size)
			return false;
		}
		alert("통과");
		
		for(let i=0;i<imgList.length;i++) {
			formData.append("uploadImg", imgList[i]);
		}
	
		$.ajax({
			url: 'productfileinsert',
			enctype: 'multipart/form-data',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json',
			success: function(result) {
				console.log(result);
				console.log("성공")
				showUploadImage(result);
			},
			error: function(error) {
				alert("이미지 파일이 아닙니다.")
			}
		});
		console.log(imgList);
		console.log(imgObj);
	}) // end of input type file change
	
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); // 파일 형식 제한
	let maxSize = 10485760000; // 파일 용량 제한
	
	function imgCheck(imgName, imgSize) {
		if(imgSize >= maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}
		if(regex.test(imgName)) {
			alert("업로드할 수 없는 파일 형식");
			return false;
		}
		return true;
	}
	
	// 이미지 출력
	function showUploadImage(uploadResultArr) {
		if(!uploadResultArr || uploadResultArr.length == 0) { alert("showUploadImage 오류"); return }
		let uploadUL = $("#uploadResult UL");
		let imsi = "";
//		uploadResult.html(imsi);
		let str = "";

		$(uploadResultArr).each(function(i, obj) {
//			if(obj.image) {
				let fileCallPath = encodeURIComponent(obj.productfile_name);
				str += "<li data-name='" + obj.productfile_name + "'>";
				str += "<span>" + obj.productfile_name + "</span>";
				str += "<button type='button' data-name='" + obj.productfile_name + "'>x</button><br>";
				str += "<div>";
				str += "<img src='productfiledetail?imgName=" + fileCallPath + "'>";
				str += "</div> </li>";
//			} else {
//				console.log("여기인가?")
//				let fileCallPath = encodeURIComponent(obj.productfile_name);
//				let fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
//				str += "<li style='cursor:pointer' data-name='" + obj.productfile_name+"'>";
//				str += "<span>" + obj.productfile_name + "</span>";
//				str += "<button type='button' data-name='" + obj.productfile_name + "'>x</button><br>";
//				str += "<div>";
//				str += "<img src='/resources/image/logo.png'>";
//				str += "</div> </li>";
//			}
		})
		
		uploadUL.append(str);

	} // end of showUpImage
	
	// 이미지 화면에서 삭제 시작
	$("#uploadResult").on("click", "button", function(e) {
		console.log("delete button");
		let targetLi = $(this).closest("li");
		let targetImg = targetLi.data("name");
		
		$.ajax({
			url: 'productfiledelete',
			data: { imgName : targetImg },
			dataType: 'text',
			type: 'POST',
			success: function(result) {
				console.log(result);
				targetLi.remove();
			},
			error: function(result) {
				console.log(result);
				console.log("파일 삭제 불가");
			}
		})
	})
	// 이미지 화면에서 삭제 끝
	
	
}); // end of document ready

let formObj = $("form");

$("#b_update").on("click", function(e) {
	e.preventDefault();
	// dlvyfee_x나 o면 배송비조건 0원으로 초기화 시작
	if($('input[name="dlvyfee_radio"]:checked').val() == "dlvyfee_x") {
		$('input[name="product_dlvylimit"]').val(0);
		$('input[name="product_dlvyfee"]').val(0);
	} else if($('input[name="dlvyfee_radio"]:checked').val() == "dlvyfee_o") {
		$('input[name="product_dlvylimit"]').val(0);
		document.getElementsByName("product_dlvyfee")[0].value = document.getElementsByName("product_dlvyfee")[1].value
	}
	// dlvyfee_x나 o면 배송비조건 0원으로 초기화 끝
	
	$("#f_product").submit();
})
</script>
</body>
</html>