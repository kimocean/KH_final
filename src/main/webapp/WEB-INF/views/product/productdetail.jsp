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
<script type="text/javascript">
	// 옵션 팝업창 띄우기
	function optionPopup() {
		const url = "./optionpopup"
		const name = "OptionPopup"
		const option = "width=800, height=500, top=100, left=200, location=no";
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

	    let productForm = $("form[name='f_product']");
		// 수정 
//		$("#b_update").on("click", function(){
//			productForm.attr("action", "/product/productdetail");
//			productForm.attr("method", "post");
//			productForm.submit();				
//		})
		// 삭제
		$("#b_delete").on("click", function(){
			productForm.attr("action", "./productdelete");
			productForm.attr("method", "post");
			productForm.submit();
		})
		// 옵션 라디오박스 체크
		const option_no = document.getElementById("option_no").value;
		if(option_no == 0) {
			$(":radio[name='option_radio'][value='option_x']").attr('checked', true);
		} else {
			$(":radio[name='option_radio'][value='option_o']").attr('checked', true);
		}
		
		// 배송비 라디오 버튼 적용
		const product_dlvyfee = document.getElementsByName("product_dlvyfee")[0].value;
		console.log(product_dlvyfee);
		
		if(product_dlvyfee == 0) {
			$(":radio[name='dlvyfee_radio'][value='dlvyfee_x']").attr('checked', true);
		} else if (product_dlvyfee < 0) {
			$(":radio[name='dlvyfee_radio'][value='dlvyfee_s']").attr('checked', true);
		} else {
			$(":radio[name='dlvyfee_radio'][value='dlvyfee_o']").attr('checked', true);
		}
		
		// 배송비 텍스트박스 띄우기
	    	  let dlvyfee_radio = $('input[name="dlvyfee_radio"]:checked').val();
	    	  if(dlvyfee_radio == "dlvyfee_s"){
	    	  console.log(dlvyfee_radio);
	    		  $('#tb_dlvyfee_o').css('display','none');
	             $('#tb_dlvyfee_s').css('display','block');
	             $("[name='product_dlvyfee']").val($("[name='product_dlvyfee']").val() * -1)
	    	  }else if(dlvyfee_radio == "dlvyfee_o"){
	    	  console.log(dlvyfee_radio);
	    	             $('#tb_dlvyfee_o').css('display','block');
	    	             $('#tb_dlvyfee_s').css('display','none');
	    	  }else{
	    	  console.log(dlvyfee_radio);
	    		  $('#tb_dlvyfee_o').css('display','none');
	             $('#tb_dlvyfee_s').css('display','none');
	    	  }
	    	 
	    	  // 배송비 박스 선택하는 대로 변경
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
	    	  
	    	  
			if($(":radio[name='dlvyfee_radio'][value='dlvyfee_s']").attr('checked', true)) {
				document.getElementsByName("product_dlvyfee")[0].value *= -1;
			}
	    // 배송비 음수 체크
		
	}); // end of document ready
</script>
<h1>상품 상세</h1>
<form action="/mall/product/productdetail?product_no=${productSelectOne.product_no}" method="post" name="f_product"> <br/>
product_no : <input type="text" name="product_no" value="${productSelectOne.product_no}"> <br/>
상품명 : <input type="text" name="product_name" value="${productSelectOne.product_name}"> <br/>
카테고리(지역) :  <input type="text" name="category_local_no" value="${productSelectOne.category_local_no}">
<select name="category_name">
<option value=""></option>
</select> <br/>
카테고리(종류) :  <input type="text" name="category_type_no" value="${productSelectOne.category_type_no}"> <br/>
판매가격 : <input type="text" name="product_price" value="${productSelectOne.product_price}"> <br/>
옵션 : 
<input type="radio" name="option_radio" value="option_x"> 설정 안 함 
<input type="radio" name="option_radio" value="option_o"> 설정함
<input type="button" id="b_optionpopup" name="b_optionpopup" value="옵션 설정" onclick="optionPopup()" disabled /> 
<input type="hidden" name="option_no" id="option_no" value="${productSelectOne.option_no}"><br/>
재고 : <input type="text" name="product_stock"  value="${productSelectOne.product_stock}"> <br/>
대표이미지 : 첨부파일 <input type="text" name="product_img"  value="${productSelectOne.product_img}"> <br/>
배송비 :
<input type="radio" name="dlvyfee_radio" value="dlvyfee_x"> 무료
<input type="radio" name="dlvyfee_radio" value="dlvyfee_s"> 조건부 무료
<input type="radio" name="dlvyfee_radio" value="dlvyfee_o"> 유료 <br/>
<div id="tb_dlvyfee_s" style="display:none;">
	배송비 조건 <input type="text" name="product_dlvyfee"  value="${productSelectOne.product_dlvyfee}"> 원 이상 무료
</div>
<div id="tb_dlvyfee_o" style="display:none;">
	기본 배송비 <input type="text" id="" name="product_dlvyfee" value="${productSelectOne.product_dlvyfee}"> 원
</div>
상세 설명 : <input type="textarea" name="product_detail"  value="${productSelectOne.product_detail}"> <br/>
m_id : <input type="textarea" name="m_id"  value="${productSelectOne.m_id}"> <br/>
<button type="submit" id="b_update">수정</button>
<button type="submit" id="b_delete">삭제</button>

</form>
</body>
</html>