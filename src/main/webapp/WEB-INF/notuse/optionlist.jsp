<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>옵션 리스트</title>
<%@ include file="../../../common/common.jsp"%>
<script>
         // 체크박스 선택       
	$(function(){
		var cb_option = document.getElementsByName("cb_option");
		var cb_option_cnt = cb_option.length;
			
		$("input[name='cb_option_all']").click(function(){
			var chk_listArr = $("input[name='cb_option']");
			for (var i=0; i<chk_listArr.length; i++){
				chk_listArr[i].checked = this.checked;
			}
		});
		$("input[name='cb_option']").click(function(){
			if($("input[name='cb_option']:checked").length == cb_option_cnt){
				$("input[name='cb_option_all']")[0].checked = true;
			}
			else{
				$("input[name='cb_option_all']")[0].checked = false;
			}
		});
	});
	function remove() {
	    let obj = document.querySelectorAll("input[name='cb_option']"); //체크 박스 -> class가 check
	    let noList = new Array();
	    for (let i = 0; i< obj.length; i++) {
	        if (obj[i].checked == true) {
	            // 체크 박스 th:name="${member.id}"이다. 체크된 항목의 id만 idList에 넣기
	            noList.push(obj[i].value);
	            console.log(noList);
	        }
	    }
	    $.ajax({
	        type: 'POST',
	        url: 'optioncheckdelete',
	        traditional: true,
	        dataType: 'text',
	        // contentType: 'application/json; charset=utf-8',
	        data: {
	            'option_nos': noList
	        },
	    }).done(function(res) {
	            location.reload();
	        })
	    .fail(function (error) {
	        console.log(JSON.stringify(error));
	    })
	}
</script>
</head>

<body>
	<table id="t_optionList" border="1">
		<th><input type="checkbox" name="cb_option_all"></th>
		<th>옵션명</th>
		<th>옵션값</th>
		<th>옵션가</th>
		<th>재고수량</th>
		<c:forEach items="${optionSelectAll}" var="list">
			<tr>
				<td><input type="checkbox" name="cb_option" value="${list.option_no}" ></td>
				<td><a href="/mall/product/optiondetail?option_no=${list.option_no}"><c:out value="${list.option_name}" /></a></td>
				<td><c:out value="${list.option_value}" /></td>
				<td><c:out value="${list.option_price}" /></td>
				<td><c:out value="${list.option_stock}" /></td>
			</tr>
		</c:forEach>
	</table>
	<input type="button" value="삭제" onclick="remove()">
</body>

</html>