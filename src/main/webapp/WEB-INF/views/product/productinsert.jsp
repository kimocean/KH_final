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
<script type="text/javascript">
	// 옵션 팝업창 띄우기
	function optionPopup() {
		const url = "/mall/product/optionpopup"
		const name = "OptionPopup"
		const option = "width=1000, height=500, top=100, left=200, location=no";
		window.open(url, name, option)
	}
	$(document).ready(function(){
	// 옵션 라디오 버튼 - 버튼 disabled 조정
	    $("input:radio[name=option_radio]").click(function(){
	        if($("input[name=option_radio]:checked").val() == "option_o"){
	        	console.log($("input[name=option_radio]:checked").val())
	            $("input:button[name=b_optionpopup]").attr("disabled",false);
	        }else if($("input[name=option_radio]:checked").val() == "option_x"){
	              $("input:button[name=b_optionpopup]").attr("disabled",true);
	        	console.log($("input[name=option_radio]:checked").val())
	        }
	    });
	// 
	    $('input[name="dlvyfee_radio"]').on('click', function(){
	    	  let dlvyfee_radio = $('input[name="dlvyfee_radio"]:checked').val();
	    	  if(dlvyfee_radio == "dlvyfee_s"){
	    	  console.log(dlvyfee_radio);
	    		  $('#tb_dlvyfee_o').css('display','none');
 	             $('#tb_dlvyfee_s').css('display','block');
	    	  }else if(dlvyfee_radio == "dlvyfee_o"){
	    	  console.log(dlvyfee_radio);
	    	             $('#tb_dlvyfee_o').css('display','block');
	    	             $('#tb_dlvyfee_s').css('display','none');
	    	  }else{
	    	  console.log(dlvyfee_radio);
	    		  $('#tb_dlvyfee_o').css('display','none');
 	             $('#tb_dlvyfee_s').css('display','none');
	    	  }
	    	});
//	let category_type_no = $("#category_type_no option:selected").val();
//	$("#testbutton").click(() => {
//		console.log("testbutton click");
//		console.log(category_type_no);
//		$("#category_type_no").val(category_type_no);
//		console.log(category_type_no);
//		console.log($("#product_name"))
//	})
	
	$("#b_submit").click(() => {
		if($(":radio[name='dlvyfee_radio'][value='dlvyfee_s']").attr('checked', true)) {
			document.getElementsByName("product_dlvyfee")[0].value *= -1;
		}
	})

	}); // end of document ready
	
	function changeCT(){
		let s_category_type_no  = document.getElementById("s_category_type_no");
		let CTvalue = (s_category_type_no.options[s_category_type_no.selectedIndex].value);
		$("#category_type_no").val(CTvalue);
		console.log($("#category_type_no").val())
	};
	
	function changeCL(){
		let s_category_local_no  = document.getElementById("s_category_local_no");
		let CLvalue = (s_category_local_no.options[s_category_local_no.selectedIndex].value);
		$("#category_local_no").val(CLvalue);
		console.log($("#category_local_no").val())
	};
	
</script>
<h1>상품 등록</h1>
<form action="./productinsert" method="post"> <br/>
product_no : <input type="text" name="product_no"> <br/>
상품명 : <input type="text" name="product_name" id="product_name"> <br/>
카테고리(지역) :  <input type="hidden" name="category_local_no" id="category_local_no" defaultValue="1">
<select name="category_local_no" id="s_category_local_no" onchange="changeCL()">
<option value="1" name="category_local_no">경기도</option>
<option value="2" name="category_local_no">강원도</option>
<option value="3" name="category_local_no">충청북도</option>
<option value="4" name="category_local_no">충청남도</option>
<option value="5" name="category_local_no">전라북도</option>
<option value="6" name="category_local_no">전라남도</option>
<option value="7" name="category_local_no">경상북도</option>
<option value="8" name="category_local_no">경상남도</option>
<option value="9" name="category_local_no">제주도</option>
</select> <br/>
카테고리(종류) : <input type="hidden" name="category_type_no" id="category_type_no"  defaultValue="1">
<select name="category_type" id="s_category_type_no" onchange="changeCT()">
	<option value="1" name="category_type_no">과일</option>
	<option value="2" name="category_type_no">채소</option>
	<option value="3" name="category_type_no">곡물</option>
	<option value="4" name="category_type_no">기타</option>
</select> <br/>
판매가격 : <input type="text" name="product_price"> <br/>
옵션 : 
<input type="radio" name="option_radio" value="option_x"> 설정 안 함 
<input type="radio" name="option_radio" value="option_o"> 설정함
<input type="button" id="b_optionpopup" name="b_optionpopup" value="옵션 설정" onclick="optionPopup()" disabled /> <br />
재고 : <input type="text" name="product_stock"> <br/>
대표이미지 : 첨부파일 <input type="text" name="product_img"> <br/>
배송비 :
<input type="radio" name="dlvyfee_radio" value="dlvyfee_x"> 무료
<input type="radio" name="dlvyfee_radio" value="dlvyfee_s"> 조건부 무료
<input type="radio" name="dlvyfee_radio" value="dlvyfee_o"> 유료 <br/>
<div id="tb_dlvyfee_s" style="display:none;">
	배송비 조건 <input type="text" name="product_dlvyfee"> 원 이상 무료
</div>
<div id="tb_dlvyfee_o" style="display:none;">
	기본 배송비 <input type="text" id="" name="product_dlvyfee"> 원
</div>
상세 설명 : <input type="textarea" name="product_detail"> <br/>
m_id : <input type="textarea" name="m_id"> <br/>
<button type="submit" id="b_submit">등록</button>
<button type="button" id="testbutton">테스트 버튼</button>

</form>
</body>
</html>