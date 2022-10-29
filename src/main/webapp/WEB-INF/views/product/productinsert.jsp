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
<form action="./productinsert" method="post" id="f_product" enctype="multipart/form-data"> <br/>
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
이미지 첨부 : 
<div class="form_section">
	<div class="form_section_title">
		<label>상품 이미지</label>
	</div>
	<div class="form_section_content">
		<input type="file" name="product_img" id="product_img" multiple> <br/>
	</div>
</div>

<div id="uploadResult">
</div>
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

// 이미지 업로드
	$("input[type='file']").on("change", function(e){
		
//		for(let i=0;i<)
		let formData = new FormData();
		let fileInput = $('input[name="product_img"]');
		let fileList = fileInput[0].files;
		let fileObj = fileList[0];
		
		console.log(formData);
		console.log(fileInput);
		console.log(fileList);
		console.log(fileObj);
		console.log("fileName : " + fileObj.name);
		console.log("fileSize : " + fileObj.size);
		console.log("fileType(MimeType) : " + fileObj.type);
		
		if(!fileCheck(fileObj.name, fileObj.size)) {
			return false;
		}
//		alert("통과");
		console.log("fileList length " + fileList.length);
		for(let i=0;i<fileList.length;i++) {
			formData.append("uploadImg", fileList[i]);
		}
		
		$.ajax({
			url: 'productfileinsert',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType: 'json'
		})
	});
		
	/* var, method related with attachFile */
	let regex = new RegExp("(.*?)\.(jpg|png|JPG|PNG)$");
	let maxSize = 1048576; //1MB	
	
	function fileCheck(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;		
	}	
	
	
	/* 이미지 출력 */
	function showUploadImage(uploadResultArr){
		
		/* 전달받은 데이터 검증 */
		if(!uploadResultArr || uploadResultArr.length == 0){return}
		
		let uploadResult = $("#uploadResult");
		
		let obj = uploadResultArr[0];
		
		let str = "";
		
		let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
		//replace 적용 하지 않아도 가능
		//let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
		
		str += "<div id='result_card'>";
		str += "<img src='/display?fileName=" + fileCallPath +"'>";
		str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
		str += "<input type='hidden' name='fileList[0].productfile_name' value='"+ obj.productfile_name +"'>";
		str += "<input type='hidden' name='fileList[0].productfile_sname' value='"+ obj.productfile_sname +"'>";
		str += "<input type='hidden' name='fileList[0].productfile_path' value='"+ obj.productfile_path +"'>";		
		str += "</div>";		
   		uploadResult.append(str);     
	}	
	
	/* 이미지 삭제 버튼 동작 */
	$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
		deleteFile();
	});
	
	/* 파일 삭제 메서드 */
	function deleteFile(){
		
		let targetFile = $(".imgDeleteBtn").data("file");
		
		let targetDiv = $("#result_card");
		
		$.ajax({
			url: 'productfiledelete',
			data : {fileName : targetFile},
			dataType : 'text',
			type : 'POST',
			success : function(result){
				console.log(result);
				
				targetDiv.remove();
				$("input[type='file']").val("");
				
			},
			error : function(result){
				console.log(result);
				
				alert("파일을 삭제하지 못하였습니다.")
			}
		});
	}

$("#b_submit").on("click", function(e) {
	e.preventDefault();
	$("#f_product").submit();
})
</script>
</body>
</html>